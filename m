From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: bltk-game regressions on snb laptop
Date: Thu, 18 Apr 2013 09:56:33 +0530
Message-ID: <CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com>
References: <516CFA57.3060709@intel.com>
	<CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com>
	<516F42EE.6080802@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:38279 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab3DRE0e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 00:26:34 -0400
Received: by mail-ob0-f179.google.com with SMTP id x4so232267obh.24
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2013 21:26:34 -0700 (PDT)
In-Reply-To: <516F42EE.6080802@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 18 April 2013 06:18, Alex Shi <alex.shi@intel.com> wrote:
> On 04/18/2013 12:46 AM, Viresh Kumar wrote:
>> On 16 April 2013 12:44, Alex Shi <alex.shi@intel.com> wrote:

> Hi, Viresh, correct me if I am wrong. :)
>
> the affected_cpus value changed from 3.9-rc1, then we get the good performance,
> and dropped after this commit. I have reverted this patch, then the performance recovered.


What's the fps value you got with v3.8? Current values should be
similar to that.
In 3.8 related_cpus weren't used by any code path leaving:

        /* Set governor before ->init, so that driver could check it */
#ifdef CONFIG_HOTPLUG_CPU
        for_each_online_cpu(sibling) {
                struct cpufreq_policy *cp = per_cpu(cpufreq_cpu_data, sibling);
                if (cp && cp->governor &&
                    (cpumask_test_cpu(cpu, cp->related_cpus))) {
                        policy->governor = cp->governor;
                        found = 1;
                        break;
                }
        }
#endif


And this doesn't have any performance impact AFAICT.

Now starting 3.9-rc1 meaning and usage of affected/related cpus is
changed. I never understood why people actually introduced related_cpus
earlier? What's the difference b/w hardware and software coordinated cpus..

About your system: Can you give output of cpufreq-info for v3.8 and
v3.9-latestrc?
Your cpus share a clock line or not?

> this patch remove the unconditionally related_cpus set:
> @@ -730,7 +730,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>             policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
>                 cpumask_copy(policy->cpus, perf->shared_cpu_map);
>         }
> -       cpumask_copy(policy->related_cpus, perf->shared_cpu_map);

Because setting related cpus now didn't had a meaning and people were
facing regressions due to it.

> that cause path change in cpufreq_add_dev(),
>  #ifdef CONFIG_HOTPLUG_CPU
>  873         /* Check if this cpu was hot-unplugged earlier and has siblings */
>  874         spin_lock_irqsave(&cpufreq_driver_lock, flags);
>  875         for_each_online_cpu(sibling) {
>  876                 struct cpufreq_policy *cp = per_cpu(cpufreq_cpu_data, sibling);
>  877                 if (cp && cpumask_test_cpu(cpu, cp->related_cpus)) {
>  878                         spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  879                         return cpufreq_add_policy_cpu(cpu, sibling, dev);
>  880                 }
>  881         }
>
> cpufreq_add_policy_cpu() has no chance to run for other cpus, since they are not in
> cp->related_cpus, line 877.

This is new code added by one of my commits and wasn't there in v3.8.
Now we set related cpus from affected cpus at ->init() time and that is
used here in this code. This is for cpus sharing clock line.

> The bltk-game use cpu to decode video, it has 9 load varied threads.
> The following is the typical snapshot of asked cpufreq:
> with your patch
> [alexs@lkp-sb01 ~]$ cat /sys/.../cpu*/cpufreq/scaling_cur_freq
> 2201000
> 800000
> 800000
> 800000
> 800000
> 800000
> 2201000
> 800000
>
> Wihtout your patch
> [alexs@lkp-sb01 ~]$ cat /sys/.../cpu*/cpufreq/scaling_cur_freq
> 2201000
> 2201000
> 2201000
> 2201000
> 2201000
> 2201000
> 2201000
> 2201000

I think something wrong is happening without my patch as setting
related_cpus alone was wrong.

> Our p-state should be hardware coordinate, so affected_cpus is right on your patch.

Didn't get that.. Your cpus share clock line? If so, they should be set in
policy->cpus by your driver and same would be reflected in related_cpus
by cpufreq core.
