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
	<div class="col-sm-2 col-xs-12 settings-header">
		[[admin/settings/general:site-settings]]
	</div>
	<div class="col-sm-10 col-xs-12">
		<form>
			<label>[[admin/settings/general:title]]</label>
			<input class="form-control" type="text" placeholder="[[admin/settings/general:title.name]]" data-field="title" />

			<div class="checkbox">
				<label for="showSiteTitle" class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
					<input type="checkbox" class="mdl-switch__input" id="showSiteTitle" data-field="showSiteTitle" name="showSiteTitle" />
					<span class="mdl-switch__label">[[admin/settings/general:title.show-in-header]]</span>
				</label>
			</div>

			<label>[[admin/settings/general:browser-title]]</label>
			<input class="form-control" type="text" placeholder="[[admin/settings/general:browser-title]]" data-field="browserTitle" />
			<p class="help-block">
				[[admin/settings/general:browser-title-help]]
			</p>

			<label>[[admin/settings/general:title-layout]]</label>
			<input class="form-control" type="text" placeholder="[[admin/settings/general:title-layout]]" data-field="titleLayout" />
			<p class="help-block">
				[[admin/settings/general:title-layout-help]]
			</p>

			<label>[[admin/settings/general:description]]</label>
			<input type="text" class="form-control" placeholder="[[admin/settings/general:description.placeholder]]" data-field="description" /><br />

			<label>[[admin/settings/general:keywords]]</label>
			<input type="text" class="form-control" placeholder="[[admin/settings/general:keywords-placeholder]]" data-field="keywords" /><br />
		</form>
	</div>
</div>

<div class="row">
	<div class="col-sm-2 col-xs-12 settings-header">[[admin/settings/general:logo]]</div>
	<div class="col-sm-10 col-xs-12">
		<div class="form-group">
			<label for="logoUrl">[[admin/settings/general:logo.image]]</label>
			<div class="input-group">
				<input id="logoUrl" type="text" class="form-control" placeholder="[[admin/settings/general:logo.image-placeholder]]" data-field="brand:logo" data-action="upload" data-target="logoUrl" data-route="{config.relative_path}/api/admin/uploadlogo" readonly />
				<span class="input-group-btn">
					<input data-action="upload" data-target="logoUrl" data-route="{config.relative_path}/api/admin/uploadlogo" type="button" class="btn btn-default" value="[[admin/settings/general:logo.upload]]"></input>
					<button data-action="removeLogo" type="button" class="btn btn-default btn-danger"><i class="fa fa-times"></i></button>
				</span>
			</div>
		</div>

		<div class="form-group">
			<label for="brand:logo:url">[[admin/settings/general:logo.url]]</label>
			<input id ="brand:logo:url" type="text" class="form-control" placeholder="[[admin/settings/general:logo.url-placeholder]]" data-field="brand:logo:url" />
			<p class="help-block">
				[[admin/settings/general:logo.url-help]]
			</p>
		</div>
		<div class="form-group">
			<label for="brand:logo:alt">[[admin/settings/general:logo.alt-text]]</label>
			<input id ="brand:logo:alt" type="text" class="form-control" placeholder="[[admin/settings/general:log.alt-text-placeholder]]" data-field="brand:logo:alt" />
		</div>

		<div class="form-group">
			<label for="og_image">og:image</label>
			<div class="input-group">
				<input id="og_image" type="text" class="form-control" placeholder="" data-field="og:image" data-action="upload" data-target="og_image" data-route="{config.relative_path}/api/admin/uploadOgImage" readonly />
				<span class="input-group-btn">
					<input data-action="upload" data-target="og_image" data-route="{config.relative_path}/api/admin/uploadOgImage" type="button" class="btn btn-default" value="[[admin/settings/general:logo.upload]]"></input>
					<button data-action="removeOgImage" type="button" class="btn btn-default btn-danger"><i class="fa fa-times"></i></button>
				</span>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-sm-2 col-xs-12 settings-header">
		[[admin/settings/general:favicon]]
	</div>
	<div class="col-sm-10 col-xs-12">
		<div class="form-group">
			<div class="input-group">
				<input id="faviconUrl" type="text" class="form-control" placeholder="favicon.ico" data-field="brand:favicon" data-action="upload" data-target="faviconUrl" data-route="{config.relative_path}/api/admin/uploadfavicon" readonly />
				<span class="input-group-btn">
					<input data-action="upload" data-target="faviconUrl" data-route="{config.relative_path}/api/admin/uploadfavicon" data-help="0" type="button" class="btn btn-default" value="[[admin/settings/general:favicon.upload]]"></input>
					<button data-action="removeFavicon" type="button" class="btn btn-default btn-danger"><i class="fa fa-times"></i></button>
				</span>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-sm-2 col-xs-12 settings-header">
		[[admin/settings/general:touch-icon]]
	</div>
	<div class="col-sm-10 col-xs-12">
		<div class="form-group">
			<div class="input-group">
				<input id="touchIconUrl" type="text" class="form-control" data-field="brand:touchIcon" data-action="upload" data-target="touchIconUrl" data-route="{config.relative_path}/api/admin/uploadTouchIcon" readonly />
				<span class="input-group-btn">
					<input data-action="upload" data-target="touchIconUrl" data-route="{config.relative_path}/api/admin/uploadTouchIcon" type="button" class="btn btn-default" value="[[admin/settings/general:touch-icon.upload]]"></input>
					<button data-action="removeTouchIcon" type="button" class="btn btn-default btn-danger"><i class="fa fa-times"></i></button>
				</span>
			</div>
			<p class="help-block">
				[[admin/settings/general:touch-icon.help]]
			</p>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-sm-2 col-xs-12 settings-header">[[admin/settings/general:outgoing-links]]</div>
	<div class="col-sm-10 col-xs-12">
		<form>
			<div class="checkbox">
				<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
					<input type="checkbox" class="mdl-switch__input" id="showSiteTitle" data-field="useOutgoingLinksPage">
					<span class="mdl-switch__label"><strong>[[admin/settings/general:outgoing-links.warning-page]]</strong></span>
				</label>
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
