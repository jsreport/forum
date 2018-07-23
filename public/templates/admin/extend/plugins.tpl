<ul class="nav nav-pills">
	<li class="active"><a href="#installed" data-toggle="tab">[[admin/extend/plugins:installed]]</a></li>
	<li><a href="#active" data-toggle="tab">[[admin/extend/plugins:active]]</a></li>
	<li><a href="#deactive" data-toggle="tab">[[admin/extend/plugins:inactive]]</a></li>
	<li><a href="#upgrade" data-toggle="tab">
		[[admin/extend/plugins:out-of-date]]
		<span class="badge">{upgradeCount}</span>
	</a></li>
	<li><a href="#download" data-toggle="tab">[[admin/extend/plugins:find-plugins]]</a></li>
</ul>
<br />

<div class="plugins row">
	<div class="col-lg-9">
		<div class="tab-content">
			<div class="tab-pane fade active in" id="installed">
				<ul class="installed">
					<!-- BEGIN installed -->
					<!-- IF !installed.error -->
					<li id="{installed.id}" data-plugin-id="{installed.id}" data-version="{installed.version}" class="clearfix <!-- IF installed.active -->active<!-- ENDIF installed.active -->">
						<div class="pull-right controls">
							<!-- IF installed.isTheme -->
							<a href="{config.relative_path}/admin/appearance/themes" class="btn btn-info">[[admin/extend/plugins:plugin-item.themes]]</a>
							<!-- ELSE -->
							<button data-action="toggleActive" class="btn <!-- IF installed.active --> btn-warning<!-- ELSE --> btn-success<!-- ENDIF installed.active -->">
							<i class="fa fa-power-off"></i> <!-- IF installed.active -->[[admin/extend/plugins:plugin-item.deactivate]]<!-- ELSE -->[[admin/extend/plugins:plugin-item.activate]]<!-- ENDIF installed.active --></button>
							<!-- ENDIF installed.isTheme -->

							<button data-action="toggleInstall" data-installed="1" class="btn btn-danger"><i class="fa fa-trash-o"></i> [[admin/extend/plugins:plugin-item.uninstall]]</button>

							<!-- IF installed.active -->
							<!-- IF installed.settingsRoute -->
							<a href="{config.relative_path}{installed.settingsRoute}" class="btn btn-primary"><i class="fa fa-wrench"></i> [[admin/extend/plugins:plugin-item.settings]]</a>
							<!-- ENDIF installed.settingsRoute -->
							<!-- ENDIF installed.active -->
						</div>

						<h2><strong>{installed.name}</strong></h2>

						<!-- IF installed.description -->
						<p>{installed.description}</p>
						<!-- ENDIF installed.description -->
						<!-- IF installed.outdated --><i class="fa fa-exclamation-triangle text-danger"></i> <!-- ENDIF installed.outdated -->
						<small>[[admin/extend/plugins:plugin-item.installed]] <strong class="currentVersion">{installed.version}</strong> | [[admin/extend/plugins:plugin-item.latest]] <strong class="latestVersion">{installed.latest}</strong></small>
						<!-- IF installed.outdated -->
							<button data-action="upgrade" class="btn btn-success btn-xs"><i class="fa fa-download"></i> [[admin/extend/plugins:plugin-item.upgrade]]</button>
						<!-- ENDIF installed.outdated -->
						<!-- IF installed.url -->
						<p>[[admin/extend/plugins:plugin-item.more-info]] <a target="_blank" href="{installed.url}">{installed.url}</a></p>
						<!-- ENDIF installed.url -->
					</li>
					<!-- ENDIF !installed.error -->
					<!-- IF installed.error -->
					<li data-plugin-id="{installed.id}" class="clearfix">
						<div class="pull-right">
							<button class="btn btn-default disabled"><i class="fa fa-exclamation-triangle"></i> [[admin/extend/plugins:plugin-item.unknown]]</button>

<<<<<<< HEAD
							<button data-action="toggleInstall" data-installed="1" class="btn btn-danger"><i class="fa fa-trash-o"></i> Uninstall</button>

=======
							<button data-action="toggleInstall" data-installed="1" class="btn btn-danger"><i class="fa fa-trash-o"></i> [[admin/extend/plugins:plugin-item.uninstall]]</button>
>>>>>>> `admin/extend` translations
						</div>

						<h2><strong>{installed.id}</strong></h2>
						<p>
							[[admin/extend/plugins:plugin-item.unknown-explanation]]
						</p>
					</li>
					<!-- ENDIF installed.error -->

					<!-- END installed -->
				</ul>
			</div>
			<div class="tab-pane fade" id="active">
				<ul class="active"></ul>
			</div>
			<div class="tab-pane fade" id="deactive">
				<ul class="deactive"></ul>
			</div>
			<div class="tab-pane fade" id="upgrade">
				<ul class="upgrade"></ul>
			</div>
			<div class="tab-pane fade" id="download">
				<ul class="download">
					<!-- BEGIN download -->
					<li id="{download.id}" data-plugin-id="{download.id}" class="clearfix">
						<div class="pull-right">
							<button data-action="toggleActive" class="btn btn-success hidden"><i class="fa fa-power-off"></i> [[admin/extend/plugins:plugin-item.activate]]</button>
							<button data-action="toggleInstall" data-installed="0" class="btn btn-success"><i class="fa fa-download"></i> [[admin/extend/plugins:plugin-item.install]]</button>
						</div>

						<h2><strong>{download.name}</strong></h2>

						<!-- IF download.description -->
						<p>{download.description}</p>
						<!-- ENDIF download.description -->

						<small>[[admin/extend/plugins:plugin-item.latest]] <strong class="latestVersion">{download.latest}</strong></small>

						<!-- IF download.url -->
						<p>[[admin/extend/plugins:plugin-item.more-info]] <a target="_blank" href="{download.url}">{download.url}</a></p>
						<!-- ENDIF download.url -->
					</li>

					<!-- END download -->
				</ul>
			</div>
		</div>
	</div>

	<div class="col-lg-3 acp-sidebar">
		<div class="panel panel-default">
			<div class="panel-heading">[[admin/extend/plugins:plugin-search]]</div>
			<div class="panel-body">
				<input autofocus class="form-control" type="text" id="plugin-search" placeholder="[[admin/extend/plugins:plugin-search-placeholder]]"/><br/>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">[[admin/extend/plugins:reorder-plugins]]</div>
			<div class="panel-body">
				<button class="btn btn-default btn-block" id="plugin-order"><i class="fa fa-exchange"></i> [[admin/extend/plugins:order-active]]</button>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">[[admin/extend/plugins:dev-interested]]</div>
			<div class="panel-body">
				<p>
					[[admin/extend/plugins:docs-info]]
				</p>
			</div>
		</div>
	</div>


	<div class="modal fade" id="order-active-plugins-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">[[admin/extend/plugins:order-active]]</h4>
				</div>
				<div class="modal-body">
					<p>
						[[admin/extend/plugins:order.description]]
					</p>
					<p>
						[[admin/extend/plugins:order.explanation]]
					</p>
					<ul class="plugin-list"></ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">[[global:buttons.close]]</button>
					<button type="button" class="btn btn-primary" id="save-plugin-order">[[global:save]]</button>
				</div>
			</div>
		</div>
	</div>


</div>


