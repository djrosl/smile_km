<?php 
$span = 12/$cols; 
$active = 'latest';
$id = rand(1,9)+substr(md5($heading_title),0,3);

$themeConfig 			= $this->config->get('themecontrol');
$categoryConfig 		= array( 		
	'category_pzoom' 	=> 1,
	'show_swap_image' 	=> 0,
	'quickview' 		=> 0,
); 
$categoryConfig 		= array_merge($categoryConfig, $themeConfig );
$categoryPzoom 	    	= $categoryConfig['category_pzoom'];
$quickview 				= $categoryConfig['quickview'];
$swapimg 				= ($categoryConfig['show_swap_image'])?'swap':'';
?>


<div class="<?php echo $prefix;?> box productcarousel orange nopadding">
	<div class="box-heading">
		<span class="title"><?php echo $heading_title; ?></span>
	</div>
	<div class="box-content">
		<div class="box-products slide" id="productcarousel<?php echo $id;?>">			
			<?php if( trim($message) ) { ?>
			<div class="module-desc wrapper"><?php echo $message;?></div>
			<?php } ?>
			
			<?php if( count($products) > $itemsperpage ) { ?>
			<div class="carousel-controls">
				<a class="carousel-control left" href="#productcarousel<?php echo $id;?>" data-slide="prev">
					<i class="fa fa-angle-left"></i>
				</a>
				<a class="carousel-control right" href="#productcarousel<?php echo $id;?>" data-slide="next">
					<i class="fa fa-angle-right"></i>
				</a>
			</div>
			<?php } ?>
			
			<div class="carousel-inner">		
				<?php
				$pages = array_chunk( $products, $itemsperpage);
				?>	
				<?php foreach ($pages as  $k => $tproducts ) {   ?>
				<div class="item <?php if($k==0) {?>active<?php } ?>">
					<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
					<?php if( $i%$cols == 1 ) { ?>
					<div class="row product-items">
						<?php } ?>
						<div class="col-sm-6 col-xs-12 product-cols pavcol-lg-5">
							<div class="product-block">	
				<?php if ($product['thumb']) { ?>
					<?php $product_images = $this->model_catalog_product->getProductImages( $product['product_id'] ); ?>
					<div class="image">
						<?php if( $product['special'] ) {   ?>
						<span class="product-label product-label-special"><span><?php echo $this->language->get( 'text_sale' ); ?></span></span>
						<?php } ?>
						<a class="img" href="<?php echo $product['href']; ?>"><img class="img-responsive" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>							
						<!-- zoom image-->
						<?php if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
							<a href="<?php echo $zimage;?>" class="info-view colorbox product-zoom" title="<?php echo $product['name']; ?>"><i class="fa fa-search-plus"></i></a>
						<?php } ?>


						<!-- Show Swap -->
						<?php
				  			if( $swapimg ){
				      		$product_images = $this->model_catalog_product->getProductImages( $product['product_id'] );
							if(isset($product_images) && !empty($product_images)) {
								$thumb2 = $this->model_tool_image->resize($product_images[0]['image'],  $this->config->get('config_image_product_width'),  $this->config->get('config_image_product_height') );
							?>
							<a class="hover-image" href="<?php echo $product['href']; ?>"><img class="img-responsive" src="<?php echo $thumb2; ?>" alt="<?php echo $product['name']; ?>"></a>
						<?php } } ?>
						<!-- Show Swap -->


						<?php //#2 Start fix quickview in fw?>
							<?php if ($quickview) { ?>
								<a class="pav-colorbox btn btn-theme-default" href="<?php echo $this->url->link("themecontrol/product",'product_id='.$product['product_id'] );?>"><em class="fa fa-eye"></em><span><?php echo $this->language->get('quick_view'); ?></span></a>
							<?php } ?>
						<?php //#2 End fix quickview in fw?>

					</div>
				<?php } ?>
								 
				<div class="product-meta">		  
					<div class="left">
						<h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>	
						<?php if ($product['price']) { ?>
						<div class="price">
							<?php if (!$product['special']) { ?>
								<span class="special-price"><?php echo $product['price']; ?></span>
							<?php } else { ?>
								<span class="price-old"><?php echo $product['price']; ?></span> 
								<span class="price-new"><?php echo $product['special']; ?></span>
							<?php } ?>
						</div>
						<?php } ?>	
					</div>
			  
					<div class="right">		
						<?php if ($product['rating']) { ?>
					    <div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['rating']; ?>"></div>
					    <?php } else { ?>
				        <div class="norating"><img alt="0" src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
				        <?php } ?>

						<p class="description"><?php echo utf8_substr( strip_tags($product['description']),0,220);?>...</p>

						<div class="action">							
							<div class="cart">						
        						
								<button onclick="addToCart('<?php echo $product['product_id']; ?>');" class="btn btn-shopping-cart">
									<i class="fa fa-shopping-cart"></i><span><?php echo $button_cart; ?></span>
								</button>
      						</div>
							
							<div class="button-group">
								<div class="wishlist">
									<a onclick="addToWishList('<?php echo $product['product_id']; ?>');" title="<?php echo $this->language->get("button_wishlist"); ?>" class="fa fa-heart product-icon">
										<span><?php echo $this->language->get("button_wishlist"); ?></span>
									</a>	
								</div>
								<div class="compare">			
									<a onclick="addToCompare('<?php echo $product['product_id']; ?>');" title="<?php echo $this->language->get("button_compare"); ?>" class="fa fa-refresh product-icon">
										<span><?php echo $this->language->get("button_compare"); ?></span>
									</a>	
								</div>
							</div>							
						</div>		 
					</div>	 
				</div>		 
			</div>
						</div>

						<?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
					</div>
					<?php } ?>

					<?php } //endforeach; ?>
				</div>
				<?php } ?>
			</div>  
		</div>
	</div> 
</div>

<script type="text/javascript">
$('#productcarousel<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});
</script>