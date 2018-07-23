<!-- IF rooms.length -->
<!-- BEGIN rooms -->
<li class="<!-- IF ../unread -->unread<!-- ENDIF ../unread -->" data-roomid="{rooms.roomId}">
	<strong class="room-name">
		<!-- IF !rooms.lastUser.uid -->
		<span>[[modules:chat.no-users-in-room]]</span>
		<!-- ELSE -->
		<!-- IF rooms.roomName -->{rooms.roomName}<!-- ELSE -->{rooms.usernames}<!-- ENDIF rooms.roomName -->
		<!-- ENDIF !rooms.lastUser.uid -->
	</strong>
	<div class="avatar-placeholder"></div>
	<!-- BEGIN rooms.users -->
	<!-- IF @first -->
	<div class="main-avatar">
<a href="{config.relative_path}/user/{rooms.users.userslug}">
	<!-- IF rooms.users.picture -->
	<img class="user-img avatar avatar-sm avatar-rounded" src="{rooms.users.picture}" title="{rooms.users.username}">
	<!-- ELSE -->
	<div class="user-img avatar avatar-sm avatar-rounded" title="{rooms.users.username}" style="background-color: {rooms.users.icon:bgColor};">{rooms.users.icon:text}</div>
	<!-- ENDIF rooms.users.picture -->
</a>
	</div>
	<!-- ENDIF @first -->
	<!-- END rooms.users -->

	<ul class="members">
		<!-- BEGIN rooms.users -->
		<li>
<a href="{config.relative_path}/user/{rooms.users.userslug}">
	<!-- IF rooms.users.picture -->
	<img class="user-img avatar avatar-sm avatar-rounded" src="{rooms.users.picture}" title="{rooms.users.username}">
	<!-- ELSE -->
	<div class="user-img avatar avatar-sm avatar-rounded" title="{rooms.users.username}" style="background-color: {rooms.users.icon:bgColor};">{rooms.users.icon:text}</div>
	<!-- ENDIF rooms.users.picture -->
</a>
		</li>
		<!-- END rooms.users -->
	</ul>

	<span class="teaser-content">{rooms.teaser.content}</span>
	<span class="teaser-timestamp timeago pull-right" title="{rooms.teaser.timestampISO}"></span>
</li>
<!-- END rooms -->
<!-- ELSE -->
<li class="no_active"><a href="#">No active chats</a></li>
<!-- ENDIF rooms.length -->