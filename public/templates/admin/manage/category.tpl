<div class="row">
	<form role="form" class="category" data-cid="{category.cid}">
		<ul class="nav nav-pills">
			<li class="active"><a href="#category-settings" data-toggle="tab">
				[[admin/manage/categories:settings]]
			</a></li>
			<li><a href="#privileges" data-toggle="tab">[[admin/manage/categories:privileges]]</a></li>
		</ul>
		<br />
		<div class="tab-content">
			<div class="tab-pane fade active in row" id="category-settings">
				<div class="col-md-9">
					<div class="category-settings-form">
						<fieldset>
							<label for="cid-{category.cid}-name">
								[[admin/manage/categories:name]]
							</label>
							<input id="cid-{category.cid}-name" type="text" class="form-control" placeholder="[[admin/manage/categories:name]]" data-name="name" value="{category.name}" /><br />

							<label for="cid-{category.cid}-description">
								[[admin/manage/categories:description]]
							</label>
							<input id="cid-{category.cid}-description" data-name="description" placeholder="[[admin/manage/categories:description]]" value="{category.description}" class="form-control category_description description" /><br />
						</fieldset>

						<fieldset class="row">
							<div class="col-sm-4 col-xs-12">
								<div class="form-group">
									<label for="cid-{category.cid}-bgColor">
										[[admin/manage/categories:bg-color]]
									</label>
									<input id="cid-{category.cid}-bgColor" placeholder="#0059b2" data-name="bgColor" value="{category.bgColor}" class="form-control category_bgColor" />
								</div>
							</div>
							<div class="col-sm-4 col-xs-12">
								<div class="form-group">
									<label for="cid-{category.cid}-color">
										[[admin/manage/categories:text-color]]
									</label>
									<input id="cid-{category.cid}-color" placeholder="#fff" data-name="color" value="{category.color}" class="form-control category_color" />
								</div>
							</div>
							<div class="col-sm-4 col-xs-12">
								<div class="form-group">
									<label for="cid-{category.cid}-imageClass">
										[[admin/manage/categories:bg-image-size]]
									</label>
									<select id="cid-{category.cid}-imageClass" class="form-control" data-name="imageClass" data-value="{category.imageClass}">
										<option value="auto">auto</option>
										<option value="cover">cover</option>
										<option value="contain">contain</option>
									</select>
								</div>
							</div><br />
							<div class="col-sm-4 col-xs-12">
								<div class="form-group">
									<label for="cid-{category.cid}-class">
										[[admin/manage/categories:custom-class]]
									</label>
									<input id="cid-{category.cid}-class" type="text" class="form-control" placeholder="col-md-6 col-xs-6" data-name="class" value="{category.class}" />
								</div>
							</div>
							<div class="col-sm-4 col-xs-12">
								<div class="form-group">
									<label for="cid-{category.cid}-numRecentReplies">
										[[admin/manage/categories:num-recent-replies]]
									</label>
									<input id="cid-{category.cid}-numRecentReplies" type="text" class="form-control" placeholder="2" data-name="numRecentReplies" value="{category.numRecentReplies}" />
								</div>
							</div>
							<div class="col-sm-4 col-xs-12">
								<div class="form-group">
									<label for="cid-{category.cid}-link">
										[[admin/manage/categories:ext-link]]
									</label>
									<input id="cid-{category.cid}-link" type="text" class="form-control" placeholder="http://domain.com" data-name="link" value="{category.link}" />
								</div>
							</div>
						</fieldset>
						<fieldset>
							<label for="tag-whitelist">Tag Whitelist</label><br />
							<input id="tag-whitelist" type="text" class="form-control" placeholder="Enter category tags here" data-name="tagWhitelist" value="" />
						</fieldset>
					</div>
				</div>

				<div class="col-md-3 options acp-sidebar">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="category-preview" style="
								<!-- IF category.backgroundImage -->background-image: url({category.backgroundImage});<!-- ENDIF category.backgroundImage -->
								<!-- IF category.bgColor -->background-color: {category.bgColor};<!-- ENDIF category.bgColor -->
								<!-- IF category.imageClass -->background-size: {category.imageClass};<!-- ENDIF category.imageClass -->
								color: {category.color};
							">
								<div class="icon">
									<i data-name="icon" value="{category.icon}" class="fa {category.icon} fa-2x"></i>
								</div>
							</div>
							<div class="btn-group btn-group-justified">
								<div class="btn-group">
									<button type="button" data-cid="{category.cid}" class="btn btn-default upload-button">
										<i class="fa fa-upload"></i> 
										[[admin/manage/categories:upload-image]]
									</button>
								</div>
								<!-- IF category.image -->
								<div class="btn-group">
									<button class="btn btn-warning delete-image">
										<i data-name="icon" value="fa-times" class="fa fa-times"></i> 
										[[admin/manage/categories:delete-image]]
									</button>
								</div>
								<!-- ENDIF category.image -->
							</div><br />

							<fieldset>
								<div class="form-group text-center">
									<label for="category-image">
										[[admin/manage/categories:category-image]]
									</label>
									<br/>
									<input id="category-image" type="text" class="form-control" placeholder="[[admin/manage/categories:category-image]]" data-name="image" value="{category.image}" />
								</div>
							</fieldset>

							<fieldset>
								<div class="form-group text-center">
									<label for="cid-{category.cid}-parentCid">[[admin/manage/categories:parent-category]]</label>
									<br/>
									<div class="btn-group <!-- IF !category.parent.name -->hide<!-- ENDIF !category.parent.name -->">
										<button type="button" class="btn btn-default" data-action="changeParent" data-parentCid="{category.parent.cid}"><i class="fa {category.parent.icon}"></i> {category.parent.name}</button>
										<button type="button" class="btn btn-warning" data-action="removeParent" data-parentCid="{category.parent.cid}"><i class="fa fa-times"></i></button>
									</div>
									<button type="button" class="btn btn-default btn-block <!-- IF category.parent.name -->hide<!-- ENDIF category.parent.name -->" data-action="setParent">
										<i class="fa fa-sitemap"></i> 
										[[admin/manage/categories:parent-category-none]]
									</button>
								</div>
							</fieldset>
							<hr/>
							<button class="btn btn-info btn-block copy-settings">
								<i class="fa fa-files-o"></i> [[admin/manage/categories:copy-settings]]
							</button>
							<hr />
							<button class="btn btn-danger btn-block purge">
								<i class="fa fa-eraser"></i> [[admin/manage/categories:purge]]
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="tab-pane fade col-xs-12" id="privileges">
				<p>
					[[admin/manage/categories:privileges.description]]
				</p>
				<p class="text-warning">
					[[admin/manage/categories:privileges.warning]]
				</p>
				<hr />
				<div class="privilege-table-container">
					<table class="table table-striped privilege-table">
						<tr class="privilege-table-header">
							<th colspan="2"></th>
							<th class="arrowed" colspan="3">
								[[admin/manage/categories:privileges.section-viewing]]
							</th>
							<th class="arrowed" colspan="7">
								[[admin/manage/categories:privileges.section-posting]]
							</th>
							<th class="arrowed" colspan="2">
								[[admin/manage/categories:privileges.section-moderation]]
							</th>
						</tr><tr><!-- zebrastripe reset --></tr>
						<tr>
							<th colspan="2">[[admin/manage/categories:privileges.section-user]]</th>
							<!-- BEGIN privileges.labels.users -->
							<th class="text-center">{privileges.labels.users.name}</th>
							<!-- END privileges.labels.users -->
						</tr>
						<!-- IF privileges.users.length -->
						<!-- BEGIN privileges.users -->
						<tr data-uid="{privileges.users.uid}">
							<td>
								<!-- IF ../picture -->
								<img class="avatar avatar-sm" src="{privileges.users.picture}" title="{privileges.users.username}" />
								<!-- ELSE -->
								<div class="avatar avatar-sm" style="background-color: {../icon:bgColor};">{../icon:text}</div>
								<!-- ENDIF ../picture -->
							</td>
							<td>{privileges.users.username}</td>
							{function.spawnPrivilegeStates, privileges.users.username, privileges}
						</tr>
						<!-- END privileges.users -->
						<tr>
							<td colspan="{privileges.columnCount}">
								<button type="button" class="btn btn-primary pull-right" data-ajaxify="false" data-action="search.user">
									[[admin/manage/categories:privileges.search-user]]
								</button>
							</td>
						</tr>
						<!-- ELSE -->
						<tr>
							<td colspan="{privileges.columnCount}">
								[[admin/manage/categories:privileges.no-users]]
								<button type="button" class="btn btn-primary pull-right" data-ajaxify="false" data-action="search.user">
									[[admin/manage/categories:privileges.search-user]]
								</button>
							</td>
						</tr>
						<!-- ENDIF privileges.users.length -->
					</table>

					<table class="table table-striped privilege-table">
						<tr class="privilege-table-header">
							<th colspan="2"></th>
							<th class="arrowed" colspan="3">
								[[admin/manage/categories:privileges.section-viewing]]
							</th>
							<th class="arrowed" colspan="7">
								[[admin/manage/categories:privileges.section-posting]]
							</th>
							<th class="arrowed" colspan="2">
								[[admin/manage/categories:privileges.section-moderation]]
							</th>
						</tr><tr><!-- zebrastripe reset --></tr>
						<tr>
							<th colspan="2">[[admin/manage/categories:privileges.section-group]]</th>
							<!-- BEGIN privileges.labels.groups -->
							<th class="text-center">{privileges.labels.groups.name}</th>
							<!-- END privileges.labels.groups -->
						</tr>
						<!-- BEGIN privileges.groups -->
						<tr data-group-name="{privileges.groups.name}" data-private="<!-- IF privileges.groups.isPrivate -->1<!-- ELSE -->0<!-- ENDIF privileges.groups.isPrivate -->">
							<td>
								<!-- IF privileges.groups.isPrivate -->
								<i class="fa fa-lock text-muted" title="[[admin/manage/categories:privileges.group-private]]"></i>
								<!-- ENDIF privileges.groups.isPrivate -->
								{privileges.groups.name}
							</td>
							<td></td>
							{function.spawnPrivilegeStates, name, privileges}
						</tr>
						<!-- END privileges.groups -->
						<tr>
							<td colspan="{privileges.columnCount}">
								<div class="btn-toolbar">
									<button type="button" class="btn btn-primary pull-right" data-ajaxify="false" data-action="search.group">
										[[admin/manage/categories:privileges.search-group]]
									</button>
									<button type="button" class="btn btn-info pull-right" data-ajaxify="false" data-action="copyToChildren">
										[[admin/manage/categories:privileges.copy-to-children]]
									</button>
									<button type="button" class="btn btn-info pull-right" data-ajaxify="false" data-action="copyPrivilegesFrom">
										[[admin/manage/categories:privileges.copy-from-category]]
									</button>
								</div>
							</td>
						</tr>
					</table>
					<div class="help-block">
						[[admin/manage/categories:privileges.inherit]]
					</div>

				</div>
			</div>
		</div>
	</form>
</div>

<button id="save" class="floating-button mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
    <i class="material-icons">save</i>
</button>
