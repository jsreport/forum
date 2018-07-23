<div class="row dashboard">
	<div class="col-lg-9">
		<div class="panel panel-default">
			<div class="panel-heading">[[admin/general/dashboard:forum-traffic]]</div>
			<div class="panel-body">
				<div class="graph-container">
					<ul class="graph-legend">
						<li><div class="page-views"></div><span>[[admin/general/dashboard:page-views]]</span></li>
						<li><div class="unique-visitors"></div><span>[[admin/general/dashboard:unique-visitors]]</span></li>
					</ul>
					<canvas id="analytics-traffic" width="100%" height="400"></canvas>
				</div>
				<hr/>
				<div class="text-center pull-left monthly-pageviews">
					<div><strong id="pageViewsLastMonth"></strong></div>
					<div><a href="#" data-action="updateGraph" data-units="days" data-until="last-month">[[admin/general/dashboard:page-views-last-month]]</a></div>
				</div>
				<div class="text-center pull-left monthly-pageviews">
					<div><strong id="pageViewsThisMonth"></strong></div>
					<div><a href="#" data-action="updateGraph" data-units="days">[[admin/general/dashboard:page-views-this-month]]</a></div>
				</div>
				<div class="text-center pull-left monthly-pageviews">
					<div><strong id="pageViewsPastDay"></strong></div>
					<div><a href="#" data-action="updateGraph" data-units="hours">[[admin/general/dashboard:page-views-last-day]]</a></div>
				</div>
			</div>
		</div>

		<div class="row">
			<!-- BEGIN stats -->
			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">{stats.name}</div>
					<div class="panel-body">
						<div id="unique-visitors">
							<div class="text-center pull-left">
								<span class="formatted-number">{stats.day}</span>
								<div>[[admin/general/dashboard:stats.day]]</div>
							</div>
							<div class="text-center pull-left">
								<span class="formatted-number">{stats.week}</span>
								<div>[[admin/general/dashboard:stats.week]]</div>
							</div>
							<div class="text-center pull-left">
								<span class="formatted-number">{stats.month}</span>
								<div>[[admin/general/dashboard:stats.month]]</div>
							</div>
							<div class="text-center pull-left">
								<span class="formatted-number">{stats.alltime}</span>
								<div>[[admin/general/dashboard:stats.all]]</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- END stats -->

			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">[[admin/general/dashboard:updates]]</div>
					<div class="panel-body">
						<div class="alert alert-info version-check">
							<p>[[admin/general/dashboard:running-version, {version}]]</p>
						</div>
						<p>
							[[admin/general/dashboard:keep-updated]]
						</p>
					</div>
				</div>
			</div>

			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-heading">[[admin/general/dashboard:notices]]</div>
					<div class="panel-body">
					<!-- BEGIN notices -->
						<div>
							<!-- IF notices.done -->
							<i class="fa fa-fw fa-check text-success"></i> {notices.doneText}
							<!-- ELSE -->
							<!-- IF notices.link --><a href="{notices.link}" data-toggle="tooltip" title="{notices.tooltip}"><!-- ENDIF notices.link -->
							<i class="fa fa-fw fa-times text-danger"></i> {notices.notDoneText}
							<!-- IF notices.link --></a><!-- ENDIF notices.link -->
							<!-- ENDIF notices.done -->
						</div>
					<!-- END notices -->
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-lg-3">
		<div class="panel panel-default">
			<div class="panel-heading">[[admin/general/dashboard:control-panel]]</div>
			<div class="panel-body text-center">
				<p>
					<div class="btn-group">
						<button class="btn btn-warning reload">[[admin/general/dashboard:reload]]</button>
						<button class="btn btn-danger restart">[[admin/general/dashboard:restart]]</button>
					</div>
				</p>
				<p class="help-block">
					[[admin/general/dashboard:restart-warning]]
				</p>
				<p>
					<a href="{config.relative_path}/admin/settings/advanced" class="btn btn-info btn-block" data-placement="bottom" data-toggle="tooltip" title="[[admin/general/dashboard:maintenance-mode-title]]">[[admin/general/dashboard:maintenance-mode]]</a>
				</p>

				<hr />
				<span id="toggle-realtime">[[admin/general/dashboard:realtime-chart-updates]] <strong>OFF</strong> <i class="fa fa fa-toggle-off pointer"></i></span>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">[[admin/general/dashboard:active-users]]</div>
			<div class="panel-body">
				<div id="active-users"></div>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">[[admin/general/dashboard:anonymous-registered-users]]</div>
			<div class="panel-body">
				<div class="graph-container pie-chart legend-up">
					<ul class="graph-legend">
						<li><div class="anonymous"></div><span>[[admin/general/dashboard:anonymous]]</span></li>
						<li><div class="registered"></div><span>[[admin/general/dashboard:registered]]</span></li>
					</ul>
					<canvas id="analytics-registered"></canvas>
				</div>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">[[admin/general/dashboard:user-presence]]</div>
			<div class="panel-body">
				<div class="graph-container pie-chart legend-up">
					<ul class="graph-legend">
						<li><div class="on-categories"></div><span>[[admin/general/dashboard:on-categories]]</span></li>
						<li><div class="reading-posts"></div><span>[[admin/general/dashboard:reading-posts]]</span></li>
						<li><div class="browsing-topics"></div><span>[[admin/general/dashboard:browsing-topics]]</span></li>
						<li><div class="recent"></div><span>[[admin/general/dashboard:recent]]</span></li>
						<li><div class="unread"></div><span>[[admin/general/dashboard:unread]]</span></li>
					</ul>
					<canvas id="analytics-presence"></canvas>
				</div>
			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">[[admin/general/dashboard:high-presence-topics]]</div>
			<div class="panel-body">
				<div class="graph-container pie-chart legend-down">
					<canvas id="analytics-topics"></canvas>
					<ul class="graph-legend" id="topics-legend"></ul>
				</div>
			</div>
		</div>

	</div>
</div>