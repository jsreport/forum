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
	<div class="col-sm-2 col-xs-12 settings-header">[[admin/settings/reputation:reputation]]</div>
	<div class="col-sm-10 col-xs-12">
		<form>
			<div class="checkbox">
				<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
					<input type="checkbox" class="mdl-switch__input" data-field="reputation:disabled">
					<span class="mdl-switch__label"><strong>[[admin/settings/reputation:disable]]</strong></span>
				</label>
			</div>
			<div class="checkbox">
				<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
					<input type="checkbox" class="mdl-switch__input" data-field="downvote:disabled">
					<span class="mdl-switch__label"><strong>[[admin/settings/reputation:disable-down-voting]]</trong></strong>
				</label>
			</div>
		</form>
	</div>
</div>


<div class="row">
	<div class="col-sm-2 col-xs-12 settings-header">[[admin/settings/reputation:thresholds]]</div>
	<div class="col-sm-10 col-xs-12">
		<form>
			<strong>[[admin/settings/reputation:min-rep-downvote]]</strong><br /> <input type="text" class="form-control" placeholder="0" data-field="privileges:downvote"><br />
			<strong>[[admin/settings/reputation:min-rep-flag]]</strong><br /> <input type="text" class="form-control" placeholder="0" data-field="privileges:flag"><br />
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
