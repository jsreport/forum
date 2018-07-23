
<div id="chat-modal" class="chat-modal hide" tabindex="-1" role="dialog" aria-labelledby="Chat" aria-hidden="true" data-backdrop="none">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button id="chat-close-btn" type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<button type="button" class="close hidden-xs hidden-sm" data-action="maximize"><span aria-hidden="true"><i class="fa fa-expand"></i></span><span class="sr-only">[[modules:chat.maximize]]</span></button>
				<button type="button" class="close hidden-xs hidden-sm" data-action="minimize"><span aria-hidden="true"><i class="fa fa-minus"></i></span><span class="sr-only">[[modules:chat.minimize]]</span></button>
				<button class="close" component="chat/controlsToggle"><i class="fa fa-gear"></i></button>

				<h4><!-- IF roomName -->{roomName}<!-- ELSE -->{usernames}<!-- ENDIF roomName --></h4>

				<form component="chat/controls" style="display: none;">
					<!-- IF showUserInput -->
					<div class="users-tag-container">
						<input class="users-tag-input" type="text" class="form-control" placeholder="enter users here" tabindex="4"/>
					</div>
					<!-- ENDIF showUserInput -->
					<input class="form-control" component="chat/room/name" value="{roomName}" <!-- IF !isOwner -->disabled<!-- ENDIF !isOwner -->/>
				</form>
			</div>

			<div class="modal-body">
				<ul class="chat-content" component="chat/messages">
<!-- BEGIN messages -->
<li component="chat/message" class="chat-message clear" data-index="{messages.index}" data-mid="{messages.messageId}" data-uid="{messages.fromuid}" data-self="{messages.self}" data-break="{messages.newSet}">
	<div class="message-header">
		<a href="{config.relative_path}/user/{messages.fromUser.userslug}">
			<!-- IF messages.fromUser.picture -->
			<img class="chat-user-image not-responsive" src="{messages.fromUser.picture}">
			<!-- ELSE -->
			<div class="user-icon chat-user-image" style="background-color: {messages.fromUser.icon:bgColor};">{messages.fromUser.icon:text}</div>
			<!-- ENDIF messages.fromUser.picture -->
		</a>
		<strong><span class="chat-user">{messages.fromUser.username}</span></strong>
		<span class="chat-timestamp timeago" title="{messages.timestampISO}"></span>
	</div>
	<div component="chat/message/body" class="message-body">
		<!-- IF messages.edited -->
		<small class="text-muted pull-right" title="[[global:edited]] {messages.editedISO}"><i class="fa fa-edit"></i></span></small>
		<!-- ENDIF messages.edited -->
		<!-- IF !config.disableChatMessageEditing -->
		<!-- IF messages.self -->
		<div class="pull-right btn-group controls">
			<button class="btn btn-xs btn-link" data-action="edit"><i class="fa fa-pencil"></i></button>
			<button class="btn btn-xs btn-link" data-action="delete"><i class="fa fa-times"></i></button>
		</div>
		<!-- ENDIF messages.self -->
		<!-- ENDIF !config.disableChatMessageEditing -->
		{messages.content}
	</div>
</li>
<!-- END messages -->
				</ul>

				<div class="input-group">
					<textarea component="chat/input" id="chat-message-input" rows="1" placeholder="[[modules:chat.placeholder]]" name="chat-message" class="form-control" <!-- IF !canReply -->readonly<!-- ENDIF !canReply -->></textarea>
					<span class="input-group-btn">
						<button id="chat-message-send-btn" class="btn btn-primary" href="#" type="button" <!-- IF !canReply -->disabled<!-- ENDIF !canReply -->>[[modules:chat.send]]</button>
					</span>
				</div>
			</div>
		</div>
	</div>
</div>