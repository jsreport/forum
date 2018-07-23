<div class="registration panel panel-primary">
	<div class="panel-heading">
		[[admin/manage/registration:queue]]
	</div>
	<!-- IF !users.length -->
	<p class="panel-body">
		[[admin/manage/registration:description, {config.relative_path}/admin/settings/user]]
	</p>
	<!-- ENDIF !users.length -->
	<div class="table-responsive">
		<table class="table table-striped users-list">
			<tr>
				<th>[[admin/manage/registration:list.name]]</th>
				<th>[[admin/manage/registration:list.email]]</th>
				<th class="hidden-xs">[[admin/manage/registration:list.ip]]</th>
				<th class="hidden-xs">[[admin/manage/registration:list.time]]</th>
				<!-- BEGIN customHeaders -->
				<th class="hidden-xs">{customHeaders.label}</th>
				<!-- END customHeaders -->
				<th></th>
			</tr>
			<!-- BEGIN users -->
			<tr data-username="{users.username}">
				<td>
					<!-- IF users.usernameSpam -->
					<i class="fa fa-times-circle text-danger" title="[[admin/manage/registration:list.username-spam, {users.spamData.username.frequency}, {users.spamData.username.appears}, {users.spamData.username.confidence}]]"></i>
					<!-- ELSE -->
					<i class="fa fa-check text-success"></i>
					<!-- ENDIF users.usernameSpam -->
					{users.username}
				</td>
				<td>
					<!-- IF users.emailSpam -->
					<i class="fa fa-times-circle text-danger" title="[[admin/manage/registration:list.email-spam, {users.spamData.email.frequency}, {users.spamData.email.appears}]]"></i>
					<!-- ELSE -->
					<i class="fa fa-check text-success"></i>
					<!-- ENDIF users.emailSpam -->
					{users.email}
				</td>
				<td class="hidden-xs">
					<!-- IF users.ipSpam -->
					<i class="fa fa-times-circle text-danger" title="[[admin/manage/registration:list.ip-spam, {users.spamData.ip.frequency}, {users.spamData.ip.appears}]]"></i>
					<!-- ELSE -->
					<i class="fa fa-check text-success"></i>
					<!-- ENDIF users.ipSpam -->
					{users.ip}
					<!-- BEGIN users.ipMatch -->
					<br>
					<!-- IF users.ipMatch.picture -->
					<img src="{users.ipMatch.picture}" class="user-img"/>
					<!-- ELSE -->
					<div class="user-img avatar avatar-sm" style="background-color: {users.ipMatch.icon:bgColor};">{users.ipMatch.icon:text}</div>
					<!-- ENDIF users.ipMatch.picture -->
					<a href="/uid/{users.ipMatch.uid}">{users.ipMatch.username}</a>
					<!-- END users.ipMatch -->
				</td>
				<td class="hidden-xs">
					<span class="timeago" title="{users.timestampISO}"></span>
				</td>
	
				<!-- BEGIN users.customRows -->
				<td class="hidden-xs">{users.customRows.value}</td>
				<!-- END users.customRows -->
	
				<td>
					<div class="btn-group pull-right">
						<button class="btn btn-success btn-xs" data-action="accept"><i class="fa fa-check"></i></button>
						<button class="btn btn-danger btn-xs" data-action="delete"><i class="fa fa-times"></i></button>
					</div>
				</td>
			</tr>
			<!-- END users -->
		</table>
	</div>

<div component="pagination" class="text-center pagination-container<!-- IF !pagination.pages.length --> hidden<!-- ENDIF !pagination.pages.length -->">
	<ul class="pagination hidden-xs">
		<li class="previous pull-left<!-- IF !pagination.prev.active --> disabled<!-- ENDIF !pagination.prev.active -->">
			<a href="?{pagination.prev.qs}" data-page="{pagination.prev.page}"><i class="fa fa-chevron-left"></i> </a>
		</li>

		<!-- BEGIN pages -->
			<!-- IF pagination.pages.separator -->
			<li component="pagination/select-page" class="page select-page">
				<a href="#"><i class="fa fa-ellipsis-h"></i></a>
			</li>
			<!-- ELSE -->
			<li class="page<!-- IF pagination.pages.active --> active<!-- ENDIF pagination.pages.active -->" >
				<a href="?{pagination.pages.qs}" data-page="{pagination.pages.page}">{pagination.pages.page}</a>
			</li>
			<!-- ENDIF pagination.pages.separator -->
		<!-- END pages -->

		<li class="next pull-right<!-- IF !pagination.next.active --> disabled<!-- ENDIF !pagination.next.active -->">
			<a href="?{pagination.next.qs}" data-page="{pagination.next.page}"> <i class="fa fa-chevron-right"></i></a>
		</li>
	</ul>

	<ul class="pagination hidden-sm hidden-md hidden-lg">
		<li class="first<!-- IF !pagination.prev.active --> disabled<!-- ENDIF !pagination.prev.active -->">
			<a href="?page=1" data-page="1"><i class="fa fa-fast-backward"></i> </a>
		</li>
		
		<li class="previous<!-- IF !pagination.prev.active --> disabled<!-- ENDIF !pagination.prev.active -->">
			<a href="?{pagination.prev.qs}" data-page="{pagination.prev.page}"><i class="fa fa-chevron-left"></i> </a>
		</li>

		<li component="pagination/select-page" class="page select-page">
			<a href="#">{pagination.currentPage} / {pagination.pageCount}</a>
		</li>
		
		<li class="next<!-- IF !pagination.next.active --> disabled<!-- ENDIF !pagination.next.active -->">
			<a href="?{pagination.next.qs}" data-page="{pagination.next.page}"> <i class="fa fa-chevron-right"></i></a>
		</li>
		
		<li class="last<!-- IF !pagination.next.active --> disabled<!-- ENDIF !pagination.next.active -->">
			<a href="?page={pagination.pageCount}" data-page="{pagination.pageCount}"><i class="fa fa-fast-forward"></i> </a>
		</li>
	</ul>
</div>
</div>

<div class="invitations panel panel-success">
	<div class="panel-heading">
		[[admin/manage/registration:invitations]]
	</div>
	<p class="panel-body">
		[[admin/manage/registration:invitations.description]]
	</p>
	<div class="table-responsive">
		<table class="table table-striped invites-list">
			<tr>
				<th>[[admin/manage/registration:invitations.inviter-username]]</th>
				<th>[[admin/manage/registration:invitations.invitee-email]]</th>
				<th>[[admin/manage/registration:invitations.invitee-username]]</th>
			</tr>
			<!-- BEGIN invites -->
			<!-- BEGIN invites.invitations -->
			<tr data-invitation-mail="{invites.invitations.email}"
					data-invited-by="{invites.username}">
				<td class ="invited-by"><!-- IF @first -->{invites.username}<!-- ENDIF @first --></td>
				<td>{invites.invitations.email}</td>
				<td>{invites.invitations.username}
					<div class="btn-group pull-right">
						<button class="btn btn-danger btn-xs" data-action="delete"><i class="fa fa-times"></i></button>
					</div>
				</td>
			</tr>
			<!-- END invites.invitations -->
			<!-- END invites -->
		</table>
	</div>
</div>
