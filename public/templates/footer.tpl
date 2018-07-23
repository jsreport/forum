		</div><!-- END container -->
	</main>

	<div class="hide">
<script type="text/tpl" data-template="500">
&#x3C;div class=&#x22;alert alert-danger&#x22;&#x3E;
&#x9;&#x3C;strong&#x3E;[[global:500.title]]&#x3C;/strong&#x3E;
&#x9;&#x3C;p&#x3E;[[global:500.message]]&#x3C;/p&#x3E;
&#x9;&#x3C;p&#x3E;{path}&#x3C;/p&#x3E;
&#x9;&#x3C;!-- IF error --&#x3E;&#x3C;p&#x3E;{error}&#x3C;/p&#x3E;&#x3C;!-- ENDIF error --&#x3E;
&#x3C;/div&#x3E;
</script>
	</div>

	<div class="topic-search hidden">
		<div class="btn-group">
			<button type="button" class="btn btn-default count"></button>
			<button type="button" class="btn btn-default prev"><i class="fa fa-fw fa-angle-up"></i></button>
			<button type="button" class="btn btn-default next"><i class="fa fa-fw fa-angle-down"></i></button>
		</div>
	</div>

	<div component="toaster/tray" class="alert-window">
		<div id="reconnect-alert" class="alert alert-dismissable alert-warning clearfix hide" component="toaster/toast">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
			<p>[[global:reconnecting-message, {config.siteTitle}]]</p>
		</div>
	</div>

	<script>
		require(['forum/footer']);
	</script>
</body>
</html>
