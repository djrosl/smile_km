<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/product/product_filter.tpl" );  ?>    
  
<div class="product-list"> 
	<div class="products-block">
		<?php
		$cols = $MAX_ITEM_ROW ;
		$span = floor(12/$cols);
		$small = floor(12/$MAX_ITEM_ROW_SMALL);
		$mini = floor(12/$MAX_ITEM_ROW_MINI);
		foreach ($products as $i => $product) { ?>
		<?php if( $i++%$cols == 0 ) { ?>
		<div class="row product-items">
		<?php } ?>

		<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-<?php echo $span;?> col-xs-<?php echo $mini;?> product-cols">			
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
							<?php if ($product['tax']) { ?>	        
								<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
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
		
		<?php if( $i%$cols == 0 || $i==count($products) ) { ?>
		</div>
		<?php } ?>				
		<?php } ?>
	</div>
</div>
<div class="pagination paging clearfix"><?php echo $pagination; ?></div>