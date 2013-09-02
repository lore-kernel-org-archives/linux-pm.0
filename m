From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: cpufreq warning with kernel 3.11
Date: Mon, 02 Sep 2013 13:49:58 +0200
Message-ID: <1501850.1zOhJXu0RL@vostro.rjw.lan>
References: <52234788.1090607@gmail.com> <9800169.8Do56q7MsY@vostro.rjw.lan> <CAKohpomaLCwVVeGY7HgXubngmod_8rSr6UVwwWxmthbq=k2ncQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:52123 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756086Ab3IBLjM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 07:39:12 -0400
In-Reply-To: <CAKohpomaLCwVVeGY7HgXubngmod_8rSr6UVwwWxmthbq=k2ncQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Alessandro Bono <alessandro.bono@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>

On Monday, September 02, 2013 11:01:34 AM Viresh Kumar wrote:
> On 2 September 2013 02:12, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Please don't call this a crash, especially not in a patch changelog.
> > That is confusing.  It's better to say "This triggers the following warning
> > sometimes:".
> 
> Same mistake for the second time :(
> Fixed in my log now..
> 
> > OK, so first, I think that this transition_ongoing thing needs to be modified
> > and checked under cpufreq_driver_lock.  Otherwise this code will be racy,
> > because someone may have updated policy->transition_ongoing after we've read
> > policy.
> 
> Hmm..
> 
> > Second, in my opinion the comment should say something like "The role of this
> > function is to make sure that the CPU frequency we use is the same as the
> > CPU is actually running at.  Therefore, if a CPU frequency change notification
> > is in progress, it will do the update anyway, so we have nothing to do here in
> > that case."  Or is it not correct?
> 
> Absolutely correct :)
> 
> Check this one (attached too), tested on my thinkpad:
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Sun, 1 Sep 2013 22:19:37 +0530
> Subject: [PATCH] cpufreq: fix serialization issues with freq change notifiers
> 
> This patch tried to serialize frequency transitions:
> commit 7c30ed532cf798a8d924562f2f44d03d7652f7a7
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Wed Jun 19 10:16:55 2013 +0530
> 
>    cpufreq: make sure frequency transitions are serialized
> 
> But there still are few scenarios where notifications can be done in parallel.
> These aren't originated from ->target() but from cpufreq_out_of_sync().
> 
> This triggers following warning sometimes:
> 
> WARNING: CPU: 0 PID: 14543 at drivers/cpufreq/cpufreq.c:317
> __cpufreq_notify_transition+0x238/0x260()
> In middle of another frequency transition
> 
> <snip>
> 
> all Trace:
> [<ffffffff81720daa>] dump_stack+0x46/0x58
> [<ffffffff8106534c>] warn_slowpath_common+0x8c/0xc0
> [<ffffffff815b8560>] ? acpi_cpufreq_target+0x320/0x320
> [<ffffffff81065436>] warn_slowpath_fmt+0x46/0x50
> [<ffffffff815b1ec8>] __cpufreq_notify_transition+0x238/0x260
> [<ffffffff815b33be>] cpufreq_notify_transition+0x3e/0x70
> [<ffffffff815b345d>] cpufreq_out_of_sync+0x6d/0xb0
> [<ffffffff815b370c>] cpufreq_update_policy+0x10c/0x160
> [<ffffffff815b3760>] ? cpufreq_update_policy+0x160/0x160
> [<ffffffff81413813>] cpufreq_set_cur_state+0x8c/0xb5
> [<ffffffff814138df>] processor_set_cur_state+0xa3/0xcf
> [<ffffffff8158e13c>] thermal_cdev_update+0x9c/0xb0
> [<ffffffff8159046a>] step_wise_throttle+0x5a/0x90
> [<ffffffff8158e21f>] handle_thermal_trip+0x4f/0x140
> [<ffffffff8158e377>] thermal_zone_device_update+0x57/0xa0
> [<ffffffff81415b36>] acpi_thermal_check+0x2e/0x30
> [<ffffffff81415ca0>] acpi_thermal_notify+0x40/0xdc
> [<ffffffff813e7dbd>] acpi_device_notify+0x19/0x1b
> [<ffffffff813f8241>] acpi_ev_notify_dispatch+0x41/0x5c
> [<ffffffff813e3fbe>] acpi_os_execute_deferred+0x25/0x32
> [<ffffffff81081060>] process_one_work+0x170/0x4a0
> [<ffffffff81082121>] worker_thread+0x121/0x390
> [<ffffffff81082000>] ? manage_workers.isra.20+0x170/0x170
> [<ffffffff81088fe0>] kthread+0xc0/0xd0
> [<ffffffff81088f20>] ? flush_kthread_worker+0xb0/0xb0
> [<ffffffff8173582c>] ret_from_fork+0x7c/0xb0
> [<ffffffff81088f20>] ? flush_kthread_worker+0xb0/0xb0
> 
> This patch modifies cpufreq_out_of_sync() and returns without sending
> notifications in case another transition is in progress. The role of this
> function is to make sure that the CPU frequency we use is the same as the CPU is
> actually running at. Therefore, if a CPU frequency change notification is in
> progress, it will do the update anyway, so we have nothing to do here in that
> case.
> 
> transition_ongoing is now accessed within cpufreq_driver_lock now to avoid any
> race conditions.
> 
> transition_ongoing is now first incremented from the callers of PRECHANGE
> notifier. And is last decremented from POSTCHANGE notifier to mark end of
> transfer because some drivers don't send POSTCHANGE notification from their
> ->target() but from some kind of bottom half, and so this is the only place
> which knows when a transition is over.
> 
> Reported-by: Alessandro Bono <alessandro.bono@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 54 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index be2e5f4..4aee299 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -274,6 +274,8 @@ static inline void adjust_jiffies(unsigned long
> val, struct cpufreq_freqs *ci)
>  static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
>   struct cpufreq_freqs *freqs, unsigned int state)
>  {
> + unsigned long flags;
> +
>   BUG_ON(irqs_disabled());
> 
>   if (cpufreq_disabled())
> @@ -286,12 +288,16 @@ static void __cpufreq_notify_transition(struct
> cpufreq_policy *policy,
>   switch (state) {
> 
>   case CPUFREQ_PRECHANGE:
> - if (WARN(policy->transition_ongoing ==
> + write_lock_irqsave(&cpufreq_driver_lock, flags);
> + if (WARN(policy->transition_ongoing >
>   cpumask_weight(policy->cpus),
> - "In middle of another frequency transition\n"))
> + "In middle of another frequency transition\n")) {
> + write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>   return;

Let me guess, you sent it with GMail?

If so, what about filing a bug against it about the tab removal?

> + }
> 
>   policy->transition_ongoing++;
> + write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
>   /* detect if the driver reported a value as "old frequency"
>   * which is not equal to what the cpufreq core thinks is
> @@ -312,11 +318,15 @@ static void __cpufreq_notify_transition(struct
> cpufreq_policy *policy,
>   break;
> 
>   case CPUFREQ_POSTCHANGE:
> - if (WARN(!policy->transition_ongoing,
> - "No frequency transition in progress\n"))
> + write_lock_irqsave(&cpufreq_driver_lock, flags);
> + if (WARN(policy->transition_ongoing < 2,
> + "No frequency transition in progress\n")) {
> + write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>   return;
> + }
> 
>   policy->transition_ongoing--;
> + write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
>   adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
>   pr_debug("FREQ: %lu - CPU: %lu", (unsigned long)freqs->new,
> @@ -343,6 +353,19 @@ void cpufreq_notify_transition(struct
> cpufreq_policy *policy,
>  {
>   for_each_cpu(freqs->cpu, policy->cpus)
>   __cpufreq_notify_transition(policy, freqs, state);
> +
> + if (state == CPUFREQ_POSTCHANGE) {
> + unsigned long flags;
> +
> + /*
> + * Some drivers don't send POSTCHANGE notification from their

For example?

> + * ->target() but from some kind of bottom half and so we are
> + * ending transaction here..
> + */
> + write_lock_irqsave(&cpufreq_driver_lock, flags);
> + policy->transition_ongoing--;
> + write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> + }
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_notify_transition);
> 
> @@ -1326,6 +1349,20 @@ static void cpufreq_out_of_sync(unsigned int
> cpu, unsigned int old_freq,
>   policy = per_cpu(cpufreq_cpu_data, cpu);
>   read_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
> + /*
> + * The role of this function is to make sure that the CPU frequency we
> + * use is the same as the CPU is actually running at. Therefore, if a
> + * CPU frequency change notification is in progress, it will do the
> + * update anyway, so we have nothing to do here in that case.
> + */
> + write_lock_irqsave(&cpufreq_driver_lock, flags);
> + if (policy->transition_ongoing) {
> + write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> + return;
> + }
> + policy->transition_ongoing++;
> + write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +
>   cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
>   cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
>  }
> @@ -1613,11 +1650,18 @@ int __cpufreq_driver_target(struct
> cpufreq_policy *policy,
>  {
>   int retval = -EINVAL;
>   unsigned int old_target_freq = target_freq;
> + unsigned long flags;
> 
>   if (cpufreq_disabled())
>   return -ENODEV;
> - if (policy->transition_ongoing)
> +
> + write_lock_irqsave(&cpufreq_driver_lock, flags);
> + if (policy->transition_ongoing) {
> + write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>   return -EBUSY;
> + }
> + policy->transition_ongoing++;
> + write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
>   /* Make sure that target_freq is within supported range */
>   if (target_freq > policy->max)

It looks like it will work.  I'll queue it up for 3.12.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
