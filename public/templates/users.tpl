<div class="users">

<!-- IF breadcrumbs.length -->
<ol class="breadcrumb">
	<!-- BEGIN breadcrumbs -->
	<li<!-- IF @last --> component="breadcrumb/current"<!-- ENDIF @last --> itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb" <!-- IF @last -->class="active"<!-- ENDIF @last -->>
		<!-- IF !@last --><a href="{breadcrumbs.url}" itemprop="url"><!-- ENDIF !@last -->
			<span itemprop="title">
				{breadcrumbs.text}
				<!-- IF @last -->
				<!-- IF !feeds:disableRSS -->
				<!-- IF rssFeedUrl --><a target="_blank" href="{rssFeedUrl}"><i class="fa fa-rss-square"></i></a><!-- ENDIF rssFeedUrl --><!-- ENDIF !feeds:disableRSS -->
				<!-- ENDIF @last -->
			</span>
		<!-- IF !@last --></a><!-- ENDIF !@last -->
	</li>
	<!-- END breadcrumbs -->
</ol>
<!-- ENDIF breadcrumbs.length -->

	<div class="row">
		<div class="col-lg-6">
<ul class="nav nav-pills">
	<li><a href="{config.relative_path}/users?section=online">[[global:online]]</a></li>
	<li><a href="{config.relative_path}/users?section=sort-posts">[[users:top_posters]]</a></li>
	<!-- IF !reputation:disabled -->
	<li><a href="{config.relative_path}/users?section=sort-reputation">[[users:most_reputation]]</a></li>
	<!-- ENDIF !reputation:disabled -->
	<!-- IF isAdminOrGlobalMod -->
	<li><a href="{config.relative_path}/users?section=flagged">[[users:most_flags]]</a></li>
	<li><a href="{config.relative_path}/users?section=banned">[[user:banned]]</a></li>
	<!-- ENDIF isAdminOrGlobalMod -->
</ul>
		</div>
		<div class="col-xs-3 text-right">
			<!-- IF inviteOnly -->
			<!-- IF loggedIn -->
			<button component="user/invite" class="btn btn-success"><i class="fa fa-users"></i> [[users:invite]]</button>
			<!-- ENDIF loggedIn -->
			<!-- ENDIF inviteOnly -->
		</div>
		<!-- IF function.displayUserSearch, {config.allowGuestUserSearching} -->
		<div class="col-lg-3 col-xs-9">
			<div class="search">
				<div class="input-group">
					<input class="form-control" id="search-user" type="text" placeholder="[[users:enter_username]]"/>
					<span class="input-group-addon">
						<i component="user/search/icon" class="fa fa-search"></i>
					</span>
				</div>
			</div>
		</div>
		<!-- ENDIF function.displayUserSearch -->
	</div>

	<ul id="users-container" class="users-container">
<!-- BEGIN users -->
<li class="users-box registered-user" data-uid="{users.uid}">
	<a href="{config.relative_path}/user/{users.userslug}">
		<!-- IF users.picture -->
		<img src="{users.picture}" />
		<!-- ELSE -->
		<div class="user-icon" style="background-color: {users.icon:bgColor};">{users.icon:text}</div>
		<!-- ENDIF users.picture -->
	</a>
	<br/>
	<div class="user-info">
		<span>
			<i component="user/status" class="fa fa-circle status {users.status}" title="[[global:{users.status}]]"></i>
			<a href="{config.relative_path}/user/{users.userslug}">{users.username}</a>
		</span>
		<br/>

		<!-- IF section_joindate -->
		<div title="joindate" class="joindate">
			<span class="timeago" title="{users.joindateISO}"></span>
		</div>
		<!-- ENDIF section_joindate -->

		<!-- IF section_sort-reputation -->
		<div title="reputation" class="reputation">
			<i class="fa fa-star"></i>
			<span class="formatted-number">{users.reputation}</span>
		</div>
		<!-- ENDIF section_sort-reputation -->

		<!-- IF section_sort-posts -->
		<div title="post count" class="post-count">
			<i class="fa fa-pencil"></i>
			<span class="formatted-number">{users.postcount}</span>
		</div>
		<!-- ENDIF section_sort-posts -->

		<!-- IF section_flagged -->
		<div title="flag count" class="flag-count">
			<i class="fa fa-flag"></i>
			<span class="formatted-number"><a href="{config.relative_path}/posts/flags?byUsername={users.username}">{users.flags}</a></span>
		</div>
		<!-- ENDIF section_flagged -->
	</div>
</li>
<!-- END users -->
		<!-- IF anonymousUserCount -->
		<li class="users-box anon-user">
			<div class="user-icon">G</div>
			<br/>
			<div class="user-info">
				<span id="online_anon_count">{anonymousUserCount}</span>
				<span>[[global:guests]]</span>
			</div>
		</li>
		<!-- ENDIF anonymousUserCount -->
	</ul>

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
