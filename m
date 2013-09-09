From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Mon, 09 Sep 2013 22:01:05 +0200
Message-ID: <114906795.XcxkLqsNxY@vostro.rjw.lan>
References: <522E1FEF.6080803@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:39646 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752978Ab3IITuJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Sep 2013 15:50:09 -0400
In-Reply-To: <522E1FEF.6080803@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Monday, September 09, 2013 01:22:23 PM Stephen Warren wrote:
> Viresh,
> 
> I'm seeing the crash below when suspending my system for the second time.
> 
> I can avoid this with the following patch, which adds a check which
> already exists in all-but-one other places that the same lookup is made:

Which kernel did you test?

> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > index 4cf0d28..d54f467 100644
> > --- a/drivers/cpufreq/cpufreq_stats.c
> > +++ b/drivers/cpufreq/cpufreq_stats.c
> > @@ -266,6 +266,9 @@ static void cpufreq_stats_update_policy_cpu(struct cpufreq_policy *policy)
> >         struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table,
> >                         policy->last_cpu);
> >  
> > +       if (!stat)
> > +               return;
> > +
> >         pr_debug("Updating stats_table for new_cpu %u from last_cpu %u\n",
> >                         policy->cpu, policy->last_cpu);
> >         per_cpu(cpufreq_stats_table, policy->cpu) = per_cpu(cpufreq_stats_table,
> 
> Is that a legitimate fix, or is there something more wrong here?
> 
> > [  76.065009] PM: suspend of devices complete after 452.313 msecs
> > [  76.073117] PM: late suspend of devices complete after 1.748 msecs
> > [  76.081832] PM: noirq suspend of devices complete after 2.091 msecs
> > [  76.088533] Disabling non-boot CPUs...
> > [  76.092779] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > [  76.101396] pgd = ece14000
> > [  76.104283] [00000000] *pgd=2d01e831, *pte=00000000, *ppte=00000000
> > [  76.111086] Internal error: Oops: 817 [#1] PREEMPT SMP ARM
> > [  76.116894] Modules linked in: brcmutil [last unloaded: brcmfmac]
> > [  76.123468] CPU: 0 PID: 1100 Comm: bash Not tainted 3.11.0-next-20130903-00021-g4af676e-dirty #40
> > [  76.132847] task: eda3c080 ti: ecd32000 task.ti: ecd32000
> > [  76.138590] PC is at cpufreq_stat_notifier_policy+0x248/0x2e4
> > [  76.144704] LR is at notifier_call_chain+0x44/0x84
> > [  76.149796] pc : [<c038eae0>]   lr : [<c004493c>]   psr: 60000113
> > [  76.149796] sp : ecd33d98 ip : 008c6000 fp : 00000002
> > [  76.161908] r10: c07c6018 r9 : c07d0f08 r8 : ee338bc0
> > [  76.167440] r7 : 00000004 r6 : 00000000 r5 : ee338bc0 r4 : 00000000
> > [  76.174342] r3 : 00000000 r2 : 008c6000 r1 : 00000000 r0 : c081db18
> > [  76.181249] Flags: nZCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment user
> > [  76.188798] Control: 10c5387d Table: 2ce1404a DAC: 00000015
> > [  76.194880] Process bash (pid: 1100, stack limit = 0xecd32240)
> > [  76.201057] Stack: (0xecd33d98 to 0xecd34000)
> > [  76.205679] 3d80:                                                      ee331e10 00000000
> > [  76.214336] 3da0: c07d0c74 ffffffff 00000000 00000000 00000004 ee338bc0 00000000 c07d0f08
> > [  76.234928] 3dc0: 00000002 c004493c c07fb60c ffffffff ee338bc0 00000004 c07c5ff0 c0044b10
> > [  76.255517] 3de0: 00000000 00200200 eda3c080 ee338bc0 00000001 c086e41c 00000001 c0044b40
> > [  76.276076] 3e00: 00000000 c038c43c ee338bc0 c038cb4c c00ab890 c1093d4c c1093d4c 00000001
> > [  76.296554] 3e20: 00000051 00000015 00000001 c0871064 00000015 00000001 ee089f00 c07d17cc
> > [  76.317063] 3e40: 000f03b8 c038e468 c038e400 ffffffdc ecd33e88 c004493c 00000001 c07d03d4
> > [  76.337592] 3e60: c07d0c74 00000010 00000001 c0025e10 ecd33e88 c07d03d4 c07d0c74 c0567cf0
> > [  76.358112] 3e80: 000f03b8 c056a994 00000023 ecd33ea4 00000010 00000001 00000001 c07d03d4
> > [  76.378755] 3ea0: c07d0c74 00000000 c0825300 c0026308 c0828a2c 00000000 00000003 c0828a2c
> > [  76.399498] 3ec0: c00407e0 c005f058 000f03b8 c056a994 c06d91b8 ecd33eec 00000003 ecd33eec
> > [  76.420368] 3ee0: 00000000 00000003 c08158c8 00000003 ed80f000 ee089f00 00000004 c005f39c
> > [  76.441354] 3f00: 00000003 c06abb5c c0575d2c c005e1e4 00000004 00000004 ecd3f7c0 ecd3f7d8
> > [  76.462347] 3f20: ecd33f80 c059128c ee0f2868 c01f3140 00000004 c0123630 ed829080 00000004
> > [  76.483335] 3f40: 000ac408 ecd33f80 00000000 ecd32000 00000004 c00cfc10 edb71900 00000001
> > [  76.504286] 3f60: 0000000a 00000000 00000000 ed829080 000ac408 00000000 00000004 c00cffe4
> > [  76.525208] 3f80: 00000000 00000000 edab98c0 b6f3aa78 00000004 000ac408 00000004 c000f1e4
> > [  76.546215] 3fa0: 00000000 c000f060 b6f3aa78 00000004 00000001 000ac408 00000004 00000000
> > [  76.567344] 3fc0: b6f3aa78 00000004 000ac408 00000004 bed9995c 000a6094 00000000 000f03b8
> > [  76.588609] 3fe0: 00000000 bed998dc b6eaab77 b6ee125c 40070010 00000001 656d5f70 7063006d
> > [  76.610137] [<c038eae0>] (cpufreq_stat_notifier_policy+0x248/0x2e4) from [<c004493c>] (notifier_call_chain+0x44/0x84)
> > [  76.634459] [<c004493c>] (notifier_call_chain+0x44/0x84) from [<c0044b10>] (__blocking_notifier_call_chain+0x48/0x60)
> > [  76.658877] [<c0044b10>] (__blocking_notifier_call_chain+0x48/0x60) from [<c0044b40>] (blocking_notifier_call_chain+0x18/0x20)
> > [  76.684322] [<c0044b40>] (blocking_notifier_call_chain+0x18/0x20) from [<c038cb4c>] (__cpufreq_remove_dev.isra.13+0x158/0x4a8)
> > [  76.709933] [<c038cb4c>] (__cpufreq_remove_dev.isra.13+0x158/0x4a8) from [<c038e468>] (cpufreq_cpu_callback+0x68/0x70)
> > [  76.734970] [<c038e468>] (cpufreq_cpu_callback+0x68/0x70) from [<c004493c>] (notifier_call_chain+0x44/0x84)
> > [  76.759131] [<c004493c>] (notifier_call_chain+0x44/0x84) from [<c0025e10>] (__cpu_notify+0x28/0x44)
> > [  76.782720] [<c0025e10>] (__cpu_notify+0x28/0x44) from [<c0567cf0>] (_cpu_down+0x80/0x238)
> > [  76.805598] [<c0567cf0>] (_cpu_down+0x80/0x238) from [<c0026308>] (disable_nonboot_cpus+0x68/0xe8)
> > [  76.829346] [<c0026308>] (disable_nonboot_cpus+0x68/0xe8) from [<c005f058>] (suspend_devices_and_enter+0x160/0x2f8)
> > [  76.854747] [<c005f058>] (suspend_devices_and_enter+0x160/0x2f8) from [<c005f39c>] (pm_suspend+0x1ac/0x260)
> > [  76.879489] [<c005f39c>] (pm_suspend+0x1ac/0x260) from [<c005e1e4>] (state_store+0x6c/0xbc)
> > [  76.902912] [<c005e1e4>] (state_store+0x6c/0xbc) from [<c01f3140>] (kobj_attr_store+0x14/0x20)
> > [  76.926666] [<c01f3140>] (kobj_attr_store+0x14/0x20) from [<c0123630>] (sysfs_write_file+0x168/0x198)
> > [  76.951174] [<c0123630>] (sysfs_write_file+0x168/0x198) from [<c00cfc10>] (vfs_write+0xb0/0x194)
> > [  76.975189] [<c00cfc10>] (vfs_write+0xb0/0x194) from [<c00cffe4>] (SyS_write+0x3c/0x70)
> > [  76.998360] [<c00cffe4>] (SyS_write+0x3c/0x70) from [<c000f060>] (ret_fast_syscall+0x0/0x30)
> > [  77.022001] Code: e5952010 e7992102 e78a3002 e595300c (e5863000)
> > [  77.044143] ---[ end trace faeaf1120c9722e9 ]--- 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
