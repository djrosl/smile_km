<?php if ($products) { ?>	
<?php 	
$cols = 4;
$span = 12/$cols;

?>
<div class="box product-related clearfix">	
	<div class="box-heading heighlight"><span><?php echo $tab_related; ?> (<?php echo count($products); ?>)</span></div>
	<div id="related" class="slide row-fuild" data-interval="0">
		<?php if( count($products) > $cols ) { ?> 
	    <div class="carousel-controls">
	      <a class="carousel-control left fa fa-angle-left" href="#related" data-slide="prev"></a>
	      <a class="carousel-control right fa fa-angle-right" href="#related" data-slide="next"></a>
	    </div>
	    <?php } ?>
	<div class="box-content carousel-inner">
		<?php  $pages = array_chunk( $products, $cols);  ?>	
						  <?php foreach ($pages as  $k => $tproducts ) {   ?>
								<div class="item <?php if($k==0) {?>active<?php } ?>">
									<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
										<?php if( $i%$cols == 1 ) { ?>
										  <div class=" box-product">
										<?php } ?>
											  <div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-3 col-xs-12 product-cols">
											  	<div class="product-block">	
												<?php if ($product['thumb']) { ?>
													<div class="image">
														<?php if( $product['special'] ) {   ?>
														<span class="product-label product-label-special"><span><?php echo $this->language->get( 'text_sale' ); ?></span></span>
														<?php } ?>
						<a class="img" href="<?php echo $product['href']; ?>"><img class="img-responsive" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
														<!-- zoom image-->
														<?php if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
							<a href="<?php echo $zimage;?>" id="colorbox_<?php echo $product['product_id'];?>" class="product-zoom related-colorbox" title="<?php echo $product['name']; ?>"><i class="fa fa-search-plus"></i></a>
														<?php } ?>


														<!-- Show Swap -->
														<?php
												  			if( $swapimg ){
												      		$product_images = $this->model_catalog_product->getProductImages( $product['product_id'] );
															if(isset($product_images) && !empty($product_images)) {
																$thumb2 = $this->model_tool_image->resize($product_images[0]['image'],  $this->config->get('config_image_product_width'),  $this->config->get('config_image_product_height') );
															?>
							<a class="hover-image" href="<?php echo $product['href']; ?>"><img class="img-responsive" src="<?php echo $thumb2; ?>" alt="<?php echo $product['name']; ?>"></a>
							<script type="text/javascript">
						      $(document).ready(function() {
						        var id = <?php echo $product['product_id'];?>;
						        $('#colorbox_' + id).colorbox();
						      });
						    </script>
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
						<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
						<?php if (isset($product['description'])): ?>
						<div class="description">
							<?php echo utf8_substr( strip_tags($product['description']),0,58);?>...
						</div>
						<?php endif ?>
						<?php if ($product['price']) { ?>
						<div class="price">
						  <?php if (!$product['special']) { ?>
						  <?php echo $product['price']; ?>
						  <?php } else { ?>
						  <span class="price-old"><?php echo $product['price']; ?></span> 
						  <span class="price-new"><?php echo $product['special']; ?></span>
						  <?php } ?>
						</div>
						<?php } ?>
						<?php if ($product['rating']) { ?>
					    <div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['rating']; ?>"></div>
					    <?php } else { ?>
				        <div class="norating"><img alt="0" src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
				        <?php } ?>
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
										
									  
									  <?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
										 </div>
										<?php } ?>
									<?php } //endforeach; ?>
								</div>
						  <?php } ?>		  
	</div>
</div>
</div>	
<?php } ?>