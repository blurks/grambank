<%inherit file="../${context.get('request').registry.settings.get('clld.app_template', 'app.mako')}"/>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "parameters" %>
<%block name="title">Feature ${ctx.id}: ${ctx.name}</%block>

<%block name="head">
<link href="${request.static_url('clld:web/static/css/select2.css')}" rel="stylesheet">
<script src="${request.static_url('clld:web/static/js/select2.js')}"></script>
</%block>

<div class="span4" style="float: right; margin-top: 1em;">
<%util:well title="Values">
<table class="table table-condensed">
            % for de in ctx.domain:
<tr>
<td title="click to select a different map marker" id="iconselect${str(de.number)}" data-toggle="popover" data-placement="left">
${h.map_marker_img(req, de)}
</td>
<td>${de.name}</td>
<td>${de.description}</td>
<td class="right">${len(de.values)}</td>
</tr>
            % endfor
</table>
</%util:well>
</div>

<h2>Feature ${ctx.id}: ${ctx.name}</h2>
<div>${h.alt_representations(req, ctx, doc_position='right', exclude=['snippet.html'])|n}</div>

<dl>
<dt>Additional Information:</dt>
<dd>${ctx.doc}</dd>
<dt>French:</dt>
<dd>${ctx.name_french}</dd>
    % if ctx.patron:
        <dt>Patron:</dt>
        <dd>${ctx.patron}</dd>
    % endif
    % if ctx.designer:
        <dt>Designer:</dt>
        <dd>${ctx.designer}</dd>
    % endif
    % if ctx.legacy_status:
        <dt>Legacy Status:</dt>
        <dd>${ctx.legacy_status}</dd>
    % endif
    % if ctx.grambank_status:
        <dt>Grambank Status:</dt>
        <dd>${ctx.grambank_status}</dd>
    % endif
    % if ctx.old_feature:
        <dt>Old Formulation (shown for historical purposes only):</dt>
        <dd>${ctx.old_feature}</dd>
    % endif
    % if ctx.other_survey:
        <dt>Is there another Typological survey covering approximately the same domain as this feature:</dt>
        <dd>${ctx.other_survey}</dd>
    % endif
</dl>


<br style="clear: right"/>

% if request.map:
${request.map.render()}
% endif

${request.get_datatable('values', h.models.Value, parameter=ctx).render()}
