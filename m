From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Fix crash during platform suspend when CPUs are related to each other
Date: Wed, 08 Jul 2015 02:12:32 +0200
Message-ID: <33434347.yW7WjymbKW@vostro.rjw.lan>
References: <1435741876-15388-1-git-send-email-sudarshan.n.ramachandra@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50303 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757168AbbGGXqH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 19:46:07 -0400
In-Reply-To: <1435741876-15388-1-git-send-email-sudarshan.n.ramachandra@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudarshan N Ramachandra <sudarshan.n.ramachandra@intel.com>
Cc: linux-acpi@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Pan Xinhui <xinhuix.pan@intel.com>

On Wednesday, July 01, 2015 02:41:16 PM Sudarshan N Ramachandra wrote:
> When CPUs are related to each other, The policy structure is shared among all
> related CPUs. Similarly we need to take care of sharing/initializing/freeing
> of data in acpi-cpufreq.c This patch addresses the same.
> 
> When acpi-cpufreq.c initializes CPUs specifying that they are related to each
> other (CPUFREQ_SHARED_TYPE_ALL), we will encounter a crash during suspend exit
> when acpi_processor_register_performance() is called. This is because
> acpi_processor_unregister_performance() would not have been called for that
> CPU during suspend entry
> 
> When CPU 0, CPU1 are related and CPU2, CPU3 are related, During suspend
> exit, CPU2 fails to initialize since acpi_processor_register_performance()
> returns error.  Finally when CPU3 is added, below crash is seen:

While this explains what's wrong, the changelog doesn't say anything about how
the problem is being fixed.  It should.

> [ 92.712008] BUG: unable to handle kernel paging request at 0000000677ac20e8
> [ 92.712035] IP:
> [ 92.712036] [<ffffffff8177da22>] cpufreq_frequency_table_update_policy_cpu+0x42/0x90
> [ 92.712049] PGD 58fed067 PUD 0
> [ 92.712067] Oops: 0000 1 PREEMPT SMP
> [ 92.712149] CPU: 0 PID: 2945 Comm: system_server Tainted: G WC O 3.14.37-x86_64-L1-R443-g9a60c52-dirty #18
> [ 92.712166] task: ffff8800594003d0 ti: ffff880059402000 task.ti: ffff880059402000
> [ 92.712184] RIP: 0010:[<ffffffff8177da22>]
> [ 92.712184] [<ffffffff8177da22>] cpufreq_frequency_table_update_policy_cpu+0x42/0x90
> [ 92.712191] RSP: 0018:ffff880059403b28 EFLAGS: 00010282
> [ 92.712196] RAX: 00000000dead4ead RBX: ffff8800729e9c00 RCX: 000000000000c3c2
> [ 92.712202] RDX: 0000000000000001 RSI: 0000000000000096 RDI: ffffffff81fc77e3
> [ 92.712207] RBP: ffff880059403b38 R08: 00000000000142d8 R09: 0000000000000000
> [ 92.712211] R10: 0000000000000000 R11: 0000000000040000 R12: 000000000000eae0
> [ 92.712217] R13: ffff8800729e9d18 R14: ffffffff82385818 R15: 0000000000000003
> [ 92.712225] FS: 00007fd57be09b60(0000) GS:ffff880076c00000(0000) knlGS:00007fd58fc24000
> [ 92.712230] CS: 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [ 92.712236] CR2: 0000000677ac20e8 CR3: 0000000067f24000 CR4: 00000000001007f0
> [ 92.712247] Last Branch Records:
> [ 92.712263] to: [<ffffffff819fff40>] page_fault+0x0/0x80
> [ 92.712276] from: [<ffffffff8177da22>] cpufreq_frequency_table_update_policy_cpu+0x42/0x90
> [ 92.712289] to: [<ffffffff8177da18>] cpufreq_frequency_table_update_policy_cpu+0x38/0x90
> [ 92.712301] from: [<ffffffff819ee551>] printk+0x55/0x56
> [ 92.712310] to: [<ffffffff819ee550>] printk+0x54/0x56
> [ 92.712327] from: [<ffffffff810d9144>] vprintk_emit+0x184/0x540
> [ 92.712337] to: [<ffffffff810d912f>] vprintk_emit+0x16f/0x540
> [ 92.712353] from: [<ffffffff81133569>] trace_hardirqs_on+0x9/0xf0
> [ 92.712364] to: [<ffffffff81133560>] trace_hardirqs_on+0x0/0xf0
> [ 92.712375] from: [<ffffffff810d912a>] vprintk_emit+0x16a/0x540
> [ 92.712386] to: [<ffffffff810d911c>] vprintk_emit+0x15c/0x540
> [ 92.712402] from: [<ffffffff819ff205>] _raw_spin_unlock+0x25/0x40
> [ 92.712413] to: [<ffffffff819ff1f8>] _raw_spin_unlock+0x18/0x40
> [ 92.712426] from: [<ffffffff81a034bc>] preempt_count_sub+0x3c/0xb0
> [ 92.712437] to: [<ffffffff81a034b1>] preempt_count_sub+0x31/0xb0
> [ 92.712447] from: [<ffffffff81a034f4>] preempt_count_sub+0x74/0xb0
> [ 92.712449] Stack:
> [ 92.712469] ffff8800729e9c00 0000000000000003 ffff880059403b60 ffffffff8177a8f0
> [ 92.712482] ffff8800729e9c00 0000000000000202 0000000000000003 ffff880059403bc0
> [ 92.712496] ffffffff8177c8fe ffffffff81025af0 ffff880059403ba0 0000000000000003
> [ 92.712499] Call Trace:
> [ 92.712521] [<ffffffff8177a8f0>] update_policy_cpu+0x50/0xa0
> [ 92.712535] [<ffffffff8177c8fe>] __cpufreq_add_dev.isra.22+0x31e/0xa70
> [ 92.712550] [<ffffffff81025af0>] ? mce_device_create+0x160/0x200
> [ 92.712564] [<ffffffff8177d0c2>] cpufreq_cpu_callback+0x72/0xc0
> [ 92.712576] [<ffffffff81a032e3>] notifier_call_chain+0x53/0xa0
> [ 92.712594] [<ffffffff810afffe>] __raw_notifier_call_chain+0xe/0x10
> [ 92.712609] [<ffffffff81088af3>] cpu_notify+0x23/0x50
> [ 92.712619] [<ffffffff81088d98>] _cpu_up+0x168/0x180
> [ 92.712636] [<ffffffff819e98f3>] enable_nonboot_cpus+0xa3/0x1b0
> [ 92.712650] [<ffffffff810d5afc>] suspend_enter+0x17c/0x490
> [ 92.712663] [<ffffffff819ee550>] ? printk+0x54/0x56
> [ 92.712682] [<ffffffff8157dc42>] ? dpm_show_time+0x92/0xc0
> [ 92.712696] [<ffffffff81580c4e>] ? dpm_suspend+0x1ce/0x390
> [ 92.712710] [<ffffffff810d5eaa>] suspend_devices_and_enter+0x9a/0x150
> [ 92.712721] [<ffffffff810d6236>] pm_suspend+0x2d6/0x3a0
> [ 92.712732] [<ffffffff810d4db7>] state_store+0x87/0xa0
> [ 92.712749] [<ffffffff8137e12f>] kobj_attr_store+0xf/0x20
> [ 92.712764] [<ffffffff8122861d>] sysfs_kf_write+0x3d/0x50
> [ 92.712778] [<ffffffff8122c622>] kernfs_fop_write+0xd2/0x140
> [ 92.712795] [<ffffffff811b2f1a>] vfs_write+0xba/0x1e0
> [ 92.712808] [<ffffffff811b3919>] SyS_write+0x49/0xb0
> [ 92.712828] [<ffffffff81a07632>] system_call_fastpath+0x16/0x1b
> [ 92.712959] Code: fb 8b 77 14 8b 57 18 48 c7 c7 a8 5a 06 82 e8 f2 0a 27 00 48 c7 c7 d7 77 fc 81 31 c0 e8 e4 0a 27 00 8b 43 18 48 c7 c7 e3 77 fc 81 <48> 8b 04 c5 80 ab 41 82 49 8b 14 04 8b 43 14 48 8b 04 c5 80 ab
> [ 92.712974] RIP
> [ 92.712976] [<ffffffff8177da22>] cpufreq_frequency_table_update_policy_cpu+0x42/0x90
> [ 92.712980] RSP <ffff880059403b28>
> [ 92.712984] CR2: 0000000677ac20e8
> [ 92.713050] --[ end trace b17e2a918293dc7c ]--
> [ 92.713059] Kernel panic - not syncing: Fatal exception
> [ 93.338306] Kernel Offset: 0x0 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffff9fffffff)
> [ 93.376633] ACPI MEMORY or I/O RESET_REG.
> 
> Signed-off-by: Sudarshan N Ramachandra <sudarshan.n.ramachandra@intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index b0c18ed..a479ece 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -70,6 +70,7 @@ struct acpi_cpufreq_data {
>  	unsigned int resume;
>  	unsigned int cpu_feature;
>  	cpumask_var_t freqdomain_cpus;
> +	unsigned int owner;
>  };
>  
>  static DEFINE_PER_CPU(struct acpi_cpufreq_data *, acfreq_data);
> @@ -673,6 +674,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  
>  	data->acpi_data = per_cpu_ptr(acpi_perf_data, cpu);
> +	data->owner = cpu;
>  	per_cpu(acfreq_data, cpu) = data;
>  
>  	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
> @@ -711,6 +713,10 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  #endif
>  
> +	/* All related CPUs will use same acfreq_data */
> +	for_each_cpu(i, policy->cpus)
> +		per_cpu(acfreq_data, i) = per_cpu(acfreq_data, cpu);
> +
>  	/* capability check */
>  	if (perf->state_count <= 1) {
>  		pr_debug("No P-States\n");
> @@ -850,13 +856,16 @@ err_free:
>  static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
> +	unsigned int i;
>  
>  	pr_debug("acpi_cpufreq_cpu_exit\n");
>  
>  	if (data) {
> -		per_cpu(acfreq_data, policy->cpu) = NULL;
> +		/* Set NULL for all related CPUs (online + offline) */
> +		for_each_cpu(i, policy->related_cpus)
> +			per_cpu(acfreq_data, i) = NULL;

You clear this for policy->related_cpus while you have set it for
policy->cpus.  Why is this OK?

>  		acpi_processor_unregister_performance(data->acpi_data,
> -						      policy->cpu);
> +								data->owner);
>  		free_cpumask_var(data->freqdomain_cpus);
>  		kfree(data->freq_table);
>  		kfree(data);

Besides, or maybe most importantly, your patch clashes with this patch
from Pan Xinhui:

https://patchwork.kernel.org/patch/6732431/

Can you both please coordinate somehow?

Thanks,
Rafael

