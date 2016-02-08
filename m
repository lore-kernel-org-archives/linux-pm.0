From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 12/13] cpufreq: ondemand: Traverse list of policy_dbs
 in update_sampling_rate()
Date: Mon, 8 Feb 2016 14:32:13 +0100
Message-ID: <CAJZ5v0iVbzuPdNLyTcih5-U7c7AJOZ_zqmHkLN0AckCPzZpDFw@mail.gmail.com>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
	<bb6f1b48f09cfe1f0322b1718bf797f8cf5e108c.1454931189.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35098 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbcBHNcP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 08:32:15 -0500
In-Reply-To: <bb6f1b48f09cfe1f0322b1718bf797f8cf5e108c.1454931189.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Feb 8, 2016 at 12:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Now that we maintain a list of all 'struct policy_dbs_info' for an
> instance of 'struct dbs_data', we can traverse that instead of
> traversing the loop for all online CPUs.
>
> This also solves the circular dependency lockdep reported by Juri
> (and verified by Shilpa) earlier:
>
>  ======================================================
>  [ INFO: possible circular locking dependency detected ]
>  4.4.0+ #445 Not tainted
>  -------------------------------------------------------
>  trace.sh/1723 is trying to acquire lock:
>   (s_active#48){++++.+}, at: [<c01f78c8>] kernfs_remove_by_name_ns+0x4c/0x94
>
>  but task is already holding lock:
>   (od_dbs_cdata.mutex){+.+.+.}, at: [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4
>
>  which lock already depends on the new lock.
>
>  the existing dependency chain (in reverse order) is:
>
> -> #2 (od_dbs_cdata.mutex){+.+.+.}:
>         [<c075b040>] mutex_lock_nested+0x7c/0x434
>         [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4
>         [<c0017c10>] return_to_handler+0x0/0x18
>
> -> #1 (&policy->rwsem){+++++.}:
>         [<c075ca8c>] down_read+0x58/0x94
>         [<c057c244>] show+0x30/0x60
>         [<c01f934c>] sysfs_kf_seq_show+0x90/0xfc
>         [<c01f7ad8>] kernfs_seq_show+0x34/0x38
>         [<c01a22ec>] seq_read+0x1e4/0x4e4
>         [<c01f8694>] kernfs_fop_read+0x120/0x1a0
>         [<c01794b4>] __vfs_read+0x3c/0xe0
>         [<c017a378>] vfs_read+0x98/0x104
>         [<c017a434>] SyS_read+0x50/0x90
>         [<c000fd40>] ret_fast_syscall+0x0/0x1c
>
> -> #0 (s_active#48){++++.+}:
>         [<c008238c>] lock_acquire+0xd4/0x20c
>         [<c01f6ae4>] __kernfs_remove+0x288/0x328
>         [<c01f78c8>] kernfs_remove_by_name_ns+0x4c/0x94
>         [<c01fa024>] remove_files+0x44/0x88
>         [<c01fa5a4>] sysfs_remove_group+0x50/0xa4
>         [<c058285c>] cpufreq_governor_dbs+0x3f0/0x5d4
>         [<c0017c10>] return_to_handler+0x0/0x18
>
>  other info that might help us debug this:
>
>  Chain exists of:
>   s_active#48 --> &policy->rwsem --> od_dbs_cdata.mutex
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(od_dbs_cdata.mutex);
>                                 lock(&policy->rwsem);
>                                 lock(od_dbs_cdata.mutex);
>    lock(s_active#48);
>
>   *** DEADLOCK ***
>
>  5 locks held by trace.sh/1723:
>   #0:  (sb_writers#6){.+.+.+}, at: [<c017beb8>] __sb_start_write+0xb4/0xc0
>   #1:  (&of->mutex){+.+.+.}, at: [<c01f8418>] kernfs_fop_write+0x6c/0x1c8
>   #2:  (s_active#35){.+.+.+}, at: [<c01f8420>] kernfs_fop_write+0x74/0x1c8
>   #3:  (cpu_hotplug.lock){++++++}, at: [<c0029e6c>] get_online_cpus+0x48/0xb8
>   #4:  (od_dbs_cdata.mutex){+.+.+.}, at: [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4
>
>  stack backtrace:
>  CPU: 2 PID: 1723 Comm: trace.sh Not tainted 4.4.0+ #445
>  Hardware name: ARM-Versatile Express
>  [<c001883c>] (unwind_backtrace) from [<c0013f50>] (show_stack+0x20/0x24)
>  [<c0013f50>] (show_stack) from [<c044ad90>] (dump_stack+0x80/0xb4)
>  [<c044ad90>] (dump_stack) from [<c0128edc>] (print_circular_bug+0x29c/0x2f0)
>  [<c0128edc>] (print_circular_bug) from [<c0081708>] (__lock_acquire+0x163c/0x1d74)
>  [<c0081708>] (__lock_acquire) from [<c008238c>] (lock_acquire+0xd4/0x20c)
>  [<c008238c>] (lock_acquire) from [<c01f6ae4>] (__kernfs_remove+0x288/0x328)
>  [<c01f6ae4>] (__kernfs_remove) from [<c01f78c8>] (kernfs_remove_by_name_ns+0x4c/0x94)
>  [<c01f78c8>] (kernfs_remove_by_name_ns) from [<c01fa024>] (remove_files+0x44/0x88)
>  [<c01fa024>] (remove_files) from [<c01fa5a4>] (sysfs_remove_group+0x50/0xa4)
>  [<c01fa5a4>] (sysfs_remove_group) from [<c058285c>] (cpufreq_governor_dbs+0x3f0/0x5d4)
>  [<c058285c>] (cpufreq_governor_dbs) from [<c0017c10>] (return_to_handler+0x0/0x18)
>
> Reported-by: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 89 ++++++++++----------------------------
>  1 file changed, 22 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 745290d7f6a2..f72087bc8302 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -224,83 +224,38 @@ static struct dbs_governor od_dbs_gov;
>  /**
>   * update_sampling_rate - update sampling rate effective immediately if needed.
>   * @new_rate: new sampling rate
> - *
> - * If new rate is smaller than the old, simply updating
> - * dbs_tuners_int.sampling_rate might not be appropriate. For example, if the
> - * original sampling_rate was 1 second and the requested new sampling rate is 10
> - * ms because the user needs immediate reaction from ondemand governor, but not
> - * sure if higher frequency will be required or not, then, the governor may
> - * change the sampling rate too late; up to 1 second later. Thus, if we are
> - * reducing the sampling rate, we need to make the new value effective
> - * immediately.

The comment still applies.

Moreover, please extend it to say that this must be called with
dbs_data->mutex held (or it looks racy otherwise).

Thanks,
Rafael


On Mon, Feb 8, 2016 at 12:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Now that we maintain a list of all 'struct policy_dbs_info' for an
> instance of 'struct dbs_data', we can traverse that instead of
> traversing the loop for all online CPUs.
>
> This also solves the circular dependency lockdep reported by Juri
> (and verified by Shilpa) earlier:
>
>  ======================================================
>  [ INFO: possible circular locking dependency detected ]
>  4.4.0+ #445 Not tainted
>  -------------------------------------------------------
>  trace.sh/1723 is trying to acquire lock:
>   (s_active#48){++++.+}, at: [<c01f78c8>] kernfs_remove_by_name_ns+0x4c/0x94
>
>  but task is already holding lock:
>   (od_dbs_cdata.mutex){+.+.+.}, at: [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4
>
>  which lock already depends on the new lock.
>
>  the existing dependency chain (in reverse order) is:
>
> -> #2 (od_dbs_cdata.mutex){+.+.+.}:
>         [<c075b040>] mutex_lock_nested+0x7c/0x434
>         [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4
>         [<c0017c10>] return_to_handler+0x0/0x18
>
> -> #1 (&policy->rwsem){+++++.}:
>         [<c075ca8c>] down_read+0x58/0x94
>         [<c057c244>] show+0x30/0x60
>         [<c01f934c>] sysfs_kf_seq_show+0x90/0xfc
>         [<c01f7ad8>] kernfs_seq_show+0x34/0x38
>         [<c01a22ec>] seq_read+0x1e4/0x4e4
>         [<c01f8694>] kernfs_fop_read+0x120/0x1a0
>         [<c01794b4>] __vfs_read+0x3c/0xe0
>         [<c017a378>] vfs_read+0x98/0x104
>         [<c017a434>] SyS_read+0x50/0x90
>         [<c000fd40>] ret_fast_syscall+0x0/0x1c
>
> -> #0 (s_active#48){++++.+}:
>         [<c008238c>] lock_acquire+0xd4/0x20c
>         [<c01f6ae4>] __kernfs_remove+0x288/0x328
>         [<c01f78c8>] kernfs_remove_by_name_ns+0x4c/0x94
>         [<c01fa024>] remove_files+0x44/0x88
>         [<c01fa5a4>] sysfs_remove_group+0x50/0xa4
>         [<c058285c>] cpufreq_governor_dbs+0x3f0/0x5d4
>         [<c0017c10>] return_to_handler+0x0/0x18
>
>  other info that might help us debug this:
>
>  Chain exists of:
>   s_active#48 --> &policy->rwsem --> od_dbs_cdata.mutex
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(od_dbs_cdata.mutex);
>                                 lock(&policy->rwsem);
>                                 lock(od_dbs_cdata.mutex);
>    lock(s_active#48);
>
>   *** DEADLOCK ***
>
>  5 locks held by trace.sh/1723:
>   #0:  (sb_writers#6){.+.+.+}, at: [<c017beb8>] __sb_start_write+0xb4/0xc0
>   #1:  (&of->mutex){+.+.+.}, at: [<c01f8418>] kernfs_fop_write+0x6c/0x1c8
>   #2:  (s_active#35){.+.+.+}, at: [<c01f8420>] kernfs_fop_write+0x74/0x1c8
>   #3:  (cpu_hotplug.lock){++++++}, at: [<c0029e6c>] get_online_cpus+0x48/0xb8
>   #4:  (od_dbs_cdata.mutex){+.+.+.}, at: [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4
>
>  stack backtrace:
>  CPU: 2 PID: 1723 Comm: trace.sh Not tainted 4.4.0+ #445
>  Hardware name: ARM-Versatile Express
>  [<c001883c>] (unwind_backtrace) from [<c0013f50>] (show_stack+0x20/0x24)
>  [<c0013f50>] (show_stack) from [<c044ad90>] (dump_stack+0x80/0xb4)
>  [<c044ad90>] (dump_stack) from [<c0128edc>] (print_circular_bug+0x29c/0x2f0)
>  [<c0128edc>] (print_circular_bug) from [<c0081708>] (__lock_acquire+0x163c/0x1d74)
>  [<c0081708>] (__lock_acquire) from [<c008238c>] (lock_acquire+0xd4/0x20c)
>  [<c008238c>] (lock_acquire) from [<c01f6ae4>] (__kernfs_remove+0x288/0x328)
>  [<c01f6ae4>] (__kernfs_remove) from [<c01f78c8>] (kernfs_remove_by_name_ns+0x4c/0x94)
>  [<c01f78c8>] (kernfs_remove_by_name_ns) from [<c01fa024>] (remove_files+0x44/0x88)
>  [<c01fa024>] (remove_files) from [<c01fa5a4>] (sysfs_remove_group+0x50/0xa4)
>  [<c01fa5a4>] (sysfs_remove_group) from [<c058285c>] (cpufreq_governor_dbs+0x3f0/0x5d4)
>  [<c058285c>] (cpufreq_governor_dbs) from [<c0017c10>] (return_to_handler+0x0/0x18)
>
> Reported-by: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 89 ++++++++++----------------------------
>  1 file changed, 22 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 745290d7f6a2..f72087bc8302 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -224,83 +224,38 @@ static struct dbs_governor od_dbs_gov;
>  /**
>   * update_sampling_rate - update sampling rate effective immediately if needed.
>   * @new_rate: new sampling rate
> - *
> - * If new rate is smaller than the old, simply updating
> - * dbs_tuners_int.sampling_rate might not be appropriate. For example, if the
> - * original sampling_rate was 1 second and the requested new sampling rate is 10
> - * ms because the user needs immediate reaction from ondemand governor, but not
> - * sure if higher frequency will be required or not, then, the governor may
> - * change the sampling rate too late; up to 1 second later. Thus, if we are
> - * reducing the sampling rate, we need to make the new value effective
> - * immediately.
>   */
>  static void update_sampling_rate(struct dbs_data *dbs_data)
>  {
> -       struct cpumask cpumask;
> +       struct policy_dbs_info *policy_dbs;
>         unsigned int new_rate = dbs_data->sampling_rate;
> -       int cpu;
>
>         /*
> -        * Lock governor so that governor start/stop can't execute in parallel.
> +        * We are operating under dbs_data->mutex and so the list and its
> +        * entries can't be freed concurrently.
>          */
> -       mutex_lock(&dbs_data_mutex);
> -
> -       cpumask_copy(&cpumask, cpu_online_mask);
> -
> -       for_each_cpu(cpu, &cpumask) {
> -               struct cpufreq_policy *policy;
> -               struct od_cpu_dbs_info_s *dbs_info;
> -               struct cpu_dbs_info *cdbs;
> -               struct policy_dbs_info *policy_dbs;
> -
> -               dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
> -               cdbs = &dbs_info->cdbs;
> -               policy_dbs = cdbs->policy_dbs;
> -
> +       list_for_each_entry(policy_dbs, &dbs_data->policy_dbs_list, list) {
> +               mutex_lock(&policy_dbs->timer_mutex);
>                 /*
> -                * A valid policy_dbs means governor hasn't stopped or exited
> -                * yet.
> +                * On 32-bit architectures this may race with the
> +                * sample_delay_ns read in dbs_update_util_handler(), but that
> +                * really doesn't matter.  If the read returns a value that's
> +                * too big, the sample will be skipped, but the next invocation
> +                * of dbs_update_util_handler() (when the update has been
> +                * completed) will take a sample.  If the returned value is too
> +                * small, the sample will be taken immediately, but that isn't a
> +                * problem, as we want the new rate to take effect immediately
> +                * anyway.
> +                *
> +                * If this runs in parallel with dbs_work_handler(), we may end
> +                * up overwriting the sample_delay_ns value that it has just
> +                * written, but the difference should not be too big and it will
> +                * be corrected next time a sample is taken, so it shouldn't be
> +                * significant.
>                  */
> -               if (!policy_dbs)
> -                       continue;
> -
> -               policy = policy_dbs->policy;
> -
> -               /* clear all CPUs of this policy */
> -               cpumask_andnot(&cpumask, &cpumask, policy->cpus);
> -
> -               /*
> -                * Update sampling rate for CPUs whose policy is governed by
> -                * dbs_data. In case of governor_per_policy, only a single
> -                * policy will be governed by dbs_data, otherwise there can be
> -                * multiple policies that are governed by the same dbs_data.
> -                */
> -               if (dbs_data == policy_dbs->dbs_data) {
> -                       mutex_lock(&policy_dbs->timer_mutex);
> -                       /*
> -                        * On 32-bit architectures this may race with the
> -                        * sample_delay_ns read in dbs_update_util_handler(),
> -                        * but that really doesn't matter.  If the read returns
> -                        * a value that's too big, the sample will be skipped,
> -                        * but the next invocation of dbs_update_util_handler()
> -                        * (when the update has been completed) will take a
> -                        * sample.  If the returned value is too small, the
> -                        * sample will be taken immediately, but that isn't a
> -                        * problem, as we want the new rate to take effect
> -                        * immediately anyway.
> -                        *
> -                        * If this runs in parallel with dbs_work_handler(), we
> -                        * may end up overwriting the sample_delay_ns value that
> -                        * it has just written, but the difference should not be
> -                        * too big and it will be corrected next time a sample
> -                        * is taken, so it shouldn't be significant.
> -                        */
> -                       gov_update_sample_delay(policy_dbs, new_rate);
> -                       mutex_unlock(&policy_dbs->timer_mutex);
> -               }
> +               gov_update_sample_delay(policy_dbs, new_rate);
> +               mutex_unlock(&policy_dbs->timer_mutex);
>         }
> -
> -       mutex_unlock(&dbs_data_mutex);
>  }
>
>  static bool invalid_up_threshold(struct dbs_data *dbs_data,
> --
> 2.7.1.370.gb2aa7f8
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
