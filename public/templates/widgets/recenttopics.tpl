<div class="recent-replies">
	<ul id="recent_topics" data-numtopics="{numTopics}">
<!-- BEGIN topics -->
<li class="clearfix widget-topics">
	<a href="<!-- IF topics.user.userslug -->{relative_path}/user/{topics.user.userslug}<!-- ELSE -->#<!-- ENDIF topics.user.userslug -->">
		<!-- IF topics.user.picture -->
		<img title="{topics.user.username}" class="avatar avatar-sm not-responsive" src="{topics.user.picture}" />
		<!-- ELSE -->
		<div class="avatar avatar-sm not-responsive" style="background-color: {topics.user.icon:bgColor};">{topics.user.icon:text}</div>
		<!-- ENDIF topics.user.picture -->
	</a>

	<p>
		<a href="{relative_path}/topic/{topics.slug}">{topics.title}</a>
	</p>
	<span class="pull-right post-preview-footer">
		<span class="timeago" title="{topics.lastposttimeISO}"></span>
	</span>
</li>
<!-- END topics -->
	</ul>
</div>

<script>
'use strict';
/* globals app, socket, translator, templates, utils*/

$(document).ready(function() {
	var	topics = $('#recent_topics');

	app.createUserTooltips();
	processHtml(topics);

	var recentTopicsWidget = app.widgets.recentTopics;

	var numTopics = parseInt(topics.attr('data-numtopics'), 10) || 8;

	if (!recentTopicsWidget) {
		recentTopicsWidget = {};
		recentTopicsWidget.onNewTopic = function(topic) {

			var recentTopics = $('#recent_topics');
			if (!recentTopics.length) {
				return;
			}

			parseAndTranslate([topic], function(html) {
				html.hide()
					.prependTo(recentTopics)
					.fadeIn();

				app.createUserTooltips();
				if (recentTopics.children().length > numTopics) {
					recentTopics.children().last().remove();
				}
			});
		};

		app.widgets.recentTopics = recentTopicsWidget;
		socket.on('event:new_topic', app.widgets.recentTopics.onNewTopic);
	}

	function parseAndTranslate(topics, callback) {
		templates.parse('partials/topics', 'topics', {topics: topics}, function(html) {
			translator.translate(html, function(translatedHtml) {
				translatedHtml = $(translatedHtml);
				processHtml(translatedHtml);
				callback(translatedHtml);
			});
		});
	}

	function processHtml(html) {
		html.find('span.timeago').timeago();
	}

});
</script>
