function STA_plots(STA_ps, D_ps, exp_ps)

line_thickness = 2;
estim_meanline = STA_ps.estim_mean * ones(2 * exp_ps.tKerLen, 1);
total_trial_time = exp_ps.trial_length_in_secs * length(exp_ps.trials_to_use);

mean_FR = STA_ps.nspikes / total_trial_time;

if exp_ps.Normalize == 1
    plt_ylim = [-1, 1];
else
	plt_ylim = [-1000, -600];
end
yaxis_line = zeros(length(plt_ylim(1):100:plt_ylim(2)));

fig_basename = sprintf('[%s]_%s_%dto%d_FR=%2.3fHz_leave_out=%0.2fs_cSOB=%d_WB=%d_SS=%d',...
    exp_ps.cell_id,exp_ps.year,exp_ps.first_trial,exp_ps.last_trial,mean_FR,exp_ps.leave_out,exp_ps.cardinal_STA_Only_Burst,exp_ps.weighted_burst,exp_ps.singleton_spikes);

%% Plot 1: STA_ps.STA
figure
set(gcf, 'PaperPosition', [0 0 20 10]); %x_width=10cm y_width=15cm
set(gcf, 'color', 'w');

plot(STA_ps.STA_t, STA_ps.STA,'LineWidth', line_thickness);hold on;
plot(STA_ps.STA_t, estim_meanline, 'k');

plot(yaxis_line, plt_ylim(1):100:plt_ylim(2), 'k');

title(fig_basename, 'Interpreter', 'none')
ylim([plt_ylim(1) plt_ylim(2)])

%saveas(gcf, [exp_ps.work_dir, fig_basename,'_STA.fig']);
saveas(gcf, [exp_ps.work_dir, fig_basename, '_STA.jpeg']);

%% Plot 2: STA_ps.STA with error bars - ToDo: write STA_ps.STA with errorbars again IMHO code was either extremely complex written or not correct for their intented purpose
% STA_error = std(STA_ps.STA(length(STA_ps.STA) / 2 + 1:end)) / sqrt(exp_ps.tKerLen);
% STA_error = STA_error * ones(length(STA_ps.STA), 1);
% errorbar(STA_ps.STA_t, estim_meanline, STA_error, 'k')7

%% Plot 3 - splined STA_ps.STA
figure
set(gcf, 'PaperPosition', [0 0 20 10]); %x_width=10cm y_width=15cm
set(gcf, 'color', 'w');

plot(STA_ps.splinedSTA_t, STA_ps.splinedSTA,'LineWidth', line_thickness);hold on;
plot(STA_ps.STA_t, estim_meanline, 'k');

plot(yaxis_line, plt_ylim(1):100:plt_ylim(2), 'k');

title(fig_basename, 'Interpreter', 'none')
ylim([plt_ylim(1) plt_ylim(2)])

%saveas(gcf, [exp_ps.work_dir, fig_basename,'_splinedSTA.fig']);
saveas(gcf, [exp_ps.work_dir, fig_basename, '_splinedSTA.jpeg']);

%% Plot 4 - significance plots
figure;
plot(STA_ps.splinedSTA_t,STA_ps.splinedSTA,'LineWidth', line_thickness);hold on;
plot(yaxis_line, plt_ylim(1):100:plt_ylim(2), 'k');

plot(STA_ps.splinedSTA_t,ones(length(STA_ps.splinedSTA))*STA_ps.estim_mean,'k--');

plot(STA_ps.splinedSTA_t(D_ps.D1_idx),D_ps.D1_val,'r*');
text(STA_ps.splinedSTA_t(D_ps.D1_idx),D_ps.D1_val,'D1');

plot(STA_ps.splinedSTA_t(D_ps.D1_cross_ids(1)),STA_ps.splinedSTA(D_ps.D1_cross_ids(1)),'k.','MarkerSize',12);
plot(STA_ps.splinedSTA_t(D_ps.D1_cross_ids(2)),STA_ps.splinedSTA(D_ps.D1_cross_ids(2)),'k.','MarkerSize',12);

plot(STA_ps.splinedSTA_t(D_ps.D1_finsig_ids(1)),STA_ps.splinedSTA(D_ps.D1_finsig_ids(1)),'go');
plot(STA_ps.splinedSTA_t(D_ps.D1_finsig_ids(2)),STA_ps.splinedSTA(D_ps.D1_finsig_ids(2)),'go');

plot(STA_ps.splinedSTA_t(D_ps.D2_idx),D_ps.D2_val,'r*');
text(STA_ps.splinedSTA_t(D_ps.D2_idx),D_ps.D2_val,'D2');

plot(STA_ps.splinedSTA_t(D_ps.D2_cross_ids(1)),STA_ps.splinedSTA(D_ps.D2_cross_ids(1)),'k.','MarkerSize',12);
plot(STA_ps.splinedSTA_t(D_ps.D2_cross_ids(2)),STA_ps.splinedSTA(D_ps.D2_cross_ids(2)),'k.','MarkerSize',12);

plot(STA_ps.splinedSTA_t(D_ps.D2_finsig_ids(1)),STA_ps.splinedSTA(D_ps.D2_finsig_ids(1)),'go');
plot(STA_ps.splinedSTA_t(D_ps.D2_finsig_ids(2)),STA_ps.splinedSTA(D_ps.D2_finsig_ids(2)),'go');

title(fig_basename, 'Interpreter', 'none')
ylim([plt_ylim(1) plt_ylim(2)]);

%saveas(gcf, [exp_ps.work_dir, fig_basename,'_STASignificance.fig']);
saveas(gcf, [exp_ps.work_dir, fig_basename, '_STASignificance.jpeg']);
end