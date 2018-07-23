<div class="modal fade" id="setParent" tabindex="-1" role="dialog" aria-labelledby="setParentLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
					<span class="sr-only">[[global:buttons.close]]</span>
				</button>
				<h4 class="modal-title" id="setParentLabel">
					[[admin/manage/categories:set-parent-category]]
				</h4>
			</div>
			<div class="modal-body">
<ul class="category-list">
	<!-- BEGIN categories -->
	<li style="
			<!-- IF categories.bgColor -->background-color: {categories.bgColor};<!-- ENDIF categories.bgColor -->
			<!-- IF categories.color -->color: {categories.color};<!-- ENDIF categories.color -->
		"
		class="<!-- IF categories.disabled -->disabled<!-- ENDIF categories.disabled -->"
		data-cid="{categories.cid}"
	><i class="fa fa-fw {categories.icon}"></i> {categories.name}</li>
	<!-- END categories -->
</ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					[[global:buttons.close]]
				</button>
			</div>
		</div>
	</div>
</div>