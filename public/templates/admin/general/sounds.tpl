<div class="sounds settings" class="row">
	<div class="col-xs-12">
		<form role="form">
			<div class="row">
				<div class="col-sm-2 col-xs-12 settings-header">[[admin/general/sounds:notifications]]</div>
				<div class="col-sm-10 col-xs-12">
					<label for="notification">[[admin/general/sounds:notifications]]</label>
					<div class="row">
						<div class="form-group col-xs-9">
							<select class="form-control" id="notification" name="notification">
								<option value="">[[user:no-sound]]</option>
								<!-- BEGIN sounds -->
								<option value="{sounds.name}">{sounds.name}</option>
								<!-- END sounds -->
							</select>
						</div>
						<div class="btn-group col-xs-3">
							<button type="button" class="form-control btn btn-sm btn-default" data-action="play"><span class="hidden-xs">[[admin/general/sounds:play-sound]] </span><i class="fa fa-play"></i></button>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-2 col-xs-12 settings-header">[[admin/general/sounds:chat-messages]]</div>
				<div class="col-sm-10 col-xs-12">
					<label for="chat-incoming">[[admin/general/sounds:incoming-message]]</label>
					<div class="row">
						<div class="form-group col-xs-9">
							<select class="form-control" id="chat-incoming" name="chat-incoming">
								<option value="">[[user:no-sound]]</option>
								<!-- BEGIN sounds -->
								<option value="{sounds.name}">{sounds.name}</option>
								<!-- END sounds -->
							</select>
						</div>
						<div class="btn-group col-xs-3">
							<button type="button" class="form-control btn btn-sm btn-default" data-action="play"><span class="hidden-xs">[[admin/general/sounds:play-sound]] </span><i class="fa fa-play"></i></button>
						</div>
					</div>

					<label for="chat-outgoing">[[admin/general/sounds:outgoing-message]]</label>
					<div class="row">
						<div class="form-group col-xs-9">
							<select class="form-control" id="chat-outgoing" name="chat-outgoing">
								<option value="">[[user:no-sound]]</option>
								<!-- BEGIN sounds -->
								<option value="{sounds.name}">{sounds.name}</option>
								<!-- END sounds -->
							</select>
						</div>
						<div class="btn-group col-xs-3">
							<button type="button" class="form-control btn btn-sm btn-default" data-action="play"><span class="hidden-xs">[[admin/general/sounds:play-sound]] </span><i class="fa fa-play"></i></button>
						</div>
					</div>

					<div class="input-group">
						<span class="input-group-btn">
							<input data-action="upload" data-title="Upload Sound" data-route="{config.relative_path}/api/admin/upload/sound" type="button" class="btn btn-primary" value="[[admin/general/sounds:upload-new-sound]]"></input>
						</span>
					</div>
				</div>
			</div>
		</form>
	</div>

</div>

<button id="save" class="floating-button mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
	<i class="material-icons">save</i>
</button>