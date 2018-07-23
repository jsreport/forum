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
	<div class="col-sm-2 col-xs-12 settings-header">[[admin/settings/sockets:reconnection]]</div>
	<div class="col-sm-10 col-xs-12">
		<form>
			<div class="form-group">
				<label for="maxReconnectionAttempts">[[admin/settings/sockets:max-attempts]]</label>
				<input class="form-control" id="maxReconnectionAttempts" type="text" value="5" placeholder="[[admin/settings/sockets:default-placeholder, 5]]" data-field="maxReconnectionAttempts" />
			</div>
			<div class="form-group">
				<label for="reconnectionDelay">[[admin/settings/sockets:delay]]</label>
				<input class="form-control" id="reconnectionDelay" type="text" value="1500" placeholder="[[admin/settings/sockets:default-placeholder, 1500]]" data-field="reconnectionDelay" />
			</div>
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
