<div class="groups">
	<div class="col-lg-9">
		<div class="panel panel-default">
			<div class="panel-body">
				<table class="table table-striped groups-list">
					<tr>
						<th>[[admin/manage/groups:name]]</th>
						<th>[[admin/manage/groups:description]]</th>
					</tr>
					<!-- BEGIN groups -->
					<tr data-groupname="{groups.displayName}">
						<td>
							{groups.displayName}
							<!-- IF groups.system -->
							<span class="badge">[[admin/manage/groups:system]]</span>
							<!-- ENDIF groups.system -->
						</td>
						<td>
							<div class="btn-group pull-right">
								<a href="{config.relative_path}/admin/manage/groups/{groups.nameEncoded}" class="btn btn-default btn-xs">
									<i class="fa fa-edit"></i> [[admin/manage/groups:edit]]
								</a>
								<!-- IF !groups.system -->
								<button class="btn btn-danger btn-xs" data-action="delete"><i class="fa fa-times"></i></button>
								<!-- ENDIF !groups.system -->
							</div>
							<p class="description">{groups.description}</p>
						</td>
					</tr>
					<!-- END groups -->
				</table>
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

	<div class="col-lg-3 acp-sidebar">
		<div class="panel panel-default">
			<div class="panel-body">
				<div>
					<input id="group-search" type="text" class="form-control" placeholder="[[admin/manage/groups:search-placeholder]]" />
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="create-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">[[admin/manage/groups:create]]</h4>
				</div>
				<div class="modal-body">
					<div class="alert alert-danger hide" id="create-modal-error"></div>
					<form>
						<div class="form-group">
							<label for="group-name">[[admin/manage/groups:name]]</label>
							<input type="text" class="form-control" id="create-group-name" placeholder="[[admin/manage/groups:name]]" />
						</div>
						<div class="form-group">
							<label for="group-name">[[admin/manage/groups:name]]</label>
							<input type="text" class="form-control" id="create-group-desc" placeholder="[[admin/manage/groups:description-placeholder]]" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">
						[[global:close]]
					</button>
					<button type="button" class="btn btn-primary" id="create-modal-go">
						[[admin/manage/groups:create-button]]
					</button>
				</div>
			</div>
		</div>
	</div>

</div>


<button id="create" class="floating-button mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
    <i class="material-icons">add</i>
</button>
