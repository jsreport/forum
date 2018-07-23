<div class="settings">
	<div class="row">
		<div class="col-sm-2 col-xs-12 content-header">
			[[admin/admin:settings-header-contents]]
		</div>
		<div class="col-sm-10 col-xs-12">
			<nav class="section-content">
				<ul></ul>
			</nav>
		</div>
	</div>

<div class="row">
	<div class="col-sm-2 col-xs-12 settings-header">[[admin/settings/notifications:notifications]]</div>
	<div class="col-sm-10 col-xs-12">
		<form>
			<strong>[[admin/settings/notifications:welcome-notification]]</strong><br /> <textarea class="form-control" data-field="welcomeNotification"></textarea><br />
			<strong>[[admin/settings/notifications:welcome-notification-link]]</strong><br /> <input type="text" class="form-control" data-field="welcomeLink"><br />
		</form>
	</div>
</div>

</div>

<button id="save" class="floating-button mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
	<i class="material-icons">save</i>
</button>

<script>
	require(['admin/settings'], function(Settings) {
		Settings.prepare();
		Settings.populateTOC();
	});
</script>
