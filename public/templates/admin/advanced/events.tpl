<div class="events">
	<div class="col-lg-9">
		<div class="panel panel-default">
			<div class="panel-heading"><i class="fa fa-calendar-o"></i> [[admin/advanced/events:events]]</div>
			<div class="panel-body" data-next="{next}">
				<!-- IF !events.length -->
				<div class="alert alert-info">[[admin/advanced/events:no-events]]</div>
				<!-- ENDIF !events.length -->
				<div class="events-list">
				<!-- BEGIN events -->
				<div>
					<span>#{events.eid} </span><span class="label label-info">{events.type}</span>
					<a href="{config.relative_path}/user/{events.user.userslug}" target="_blank">
						<!-- IF events.user.picture -->
						<img class="avatar avatar-sm" src="{events.user.picture}" />
						<!-- ELSE -->
						<div class="avatar avatar-sm" style="background-color: {events.user.icon:bgColor};">{events.user.icon:text}</div>
						<!-- ENDIF events.user.picture -->
					</a>
					<a href="{config.relative_path}/user/{events.user.userslug}" target="_blank">{events.user.username}</a> (uid {events.uid}) (IP {events.ip})
					<span class="pull-right">{events.timestampISO}</span>
					<br /><br />
					<pre>{events.jsonString}</pre>
				</div>
				<!-- END events -->
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
			</div>
		</div>
	</div>
	<div class="col-lg-3 acp-sidebar">
		<div class="panel panel-default">
			<div class="panel-heading"></div>
			<div class="panel-body">
				<button class="btn btn-warning" data-action="clear">
					<i class="fa fa-eraser"></i> [[admin/advanced/events:delete-events]]
				</button>
			</div>
		</div>
	</div>
</div>
