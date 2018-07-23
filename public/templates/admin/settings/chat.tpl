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
	<div class="col-sm-2 col-xs-12 settings-header">[[admin/settings/chat:chat-settings]]</div>
	<div class="col-sm-10 col-xs-12">
		<div class="form-group">
			<div class="checkbox">
				<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
					<input type="checkbox" class="mdl-switch__input" id="disableChat" data-field="disableChat">
					<span class="mdl-switch__label"><strong>[[admin/settings/chat:disable]]</strong></span>
				</label>
			</div>
		</div>

		<div class="form-group">
			<div class="checkbox">
				<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
					<input type="checkbox" class="mdl-switch__input" id="disableChatMessageEditing" data-field="disableChatMessageEditing">
					<span class="mdl-switch__label"><strong>[[admin/settings/chat:disable-editing]]</strong></span>
				</label>
			</div>
			<p class="help-block">[[admin/settings/chat:disable-editing-help]]</p>
		</div>

		<div class="form-group">
			<label>[[admin/settings/chat:max-length]]</label>
			<input type="text" class="form-control" value="1000" data-field="maximumChatMessageLength">
		</div>

		<div class="form-group">
			<label>[[admin/settings/chat:max-room-size]]</label>
			<input type="text" class="form-control" value="0" data-field="maximumUsersInChatRoom">
		</div>


		<div class="form-group">
			<label>[[admin/settings/chat:delay]]</label>
			<input type="text" class="form-control" value="200" data-field="chatMessageDelay">
		</div>
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
