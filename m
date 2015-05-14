From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFCv4 PATCH 31/34] sched: Energy-aware wake-up task placement
Date: Thu, 14 May 2015 15:03:45 +0100
Message-ID: <5554AB41.8070602@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com> <1431459549-18343-32-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:31235 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965035AbbENODc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 May 2015 10:03:32 -0400
In-Reply-To: <1431459549-18343-32-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>
Cc: "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12/05/15 20:39, Morten Rasmussen wrote:
> Let available compute capacity and estimated energy impact select
> wake-up target cpu when energy-aware scheduling is enabled and the
> system in not over-utilized (above the tipping point).
> 
> energy_aware_wake_cpu() attempts to find group of cpus with sufficient
> compute capacity to accommodate the task and find a cpu with enough spare
> capacity to handle the task within that group. Preference is given to
> cpus with enough spare capacity at the current OPP. Finally, the energy
> impact of the new target and the previous task cpu is compared to select
> the wake-up target cpu.
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>

[...]

>  /*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
>   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> @@ -5446,7 +5526,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>  		prev_cpu = cpu;
>  
>  	if (sd_flag & SD_BALANCE_WAKE && want_sibling) {
> -		new_cpu = select_idle_sibling(p, prev_cpu);
> +		if (energy_aware() && !cpu_rq(cpu)->rd->overutilized)
> +			new_cpu = energy_aware_wake_cpu(p);

If you run RFCv4 on an X86 system w/o energy model, you get a
'BUG: unable to handle kernel paging request at ...' problem after you've enabled
energy awareness (echo ENERGY_AWARE > /sys/kernel/debug/sched_features). 
    
This is related to the fact that cpumask functions like cpumask_test_cpu
(e.g. later in select_task_rq) can't deal with cpu set to -1.
    
If you enable CONFIG_DEBUG_PER_CPU_MAPS you get the following warning in this case:
    
WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:117
cpumask_check.part.79+0x1f/0x30()
    
We also get the warning on ARM (w/o energy model) but my TC2 system is not crashing
like the X86 box.
    
Shouldn't we return prev_cpu in case sd_ea is NULL just as select_idle_sibling does
if prev_cpu is idle?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f5897a021f23..8a014fdd6e76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5394,7 +5394,7 @@ static int select_idle_sibling(struct task_struct *p, int target)
        return target;
 }
 
-static int energy_aware_wake_cpu(struct task_struct *p)
+static int energy_aware_wake_cpu(struct task_struct *p, int target)
 {
        struct sched_domain *sd;
        struct sched_group *sg, *sg_target;
@@ -5405,7 +5405,7 @@ static int energy_aware_wake_cpu(struct task_struct *p)
        sd = rcu_dereference(per_cpu(sd_ea, task_cpu(p)));
 
        if (!sd)
-               return -1;
+               return target;
 
        sg = sd->groups;
        sg_target = sg;
@@ -5527,7 +5527,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 
        if (sd_flag & SD_BALANCE_WAKE && want_sibling) {
                if (energy_aware() && !cpu_rq(cpu)->rd->overutilized)
-                       new_cpu = energy_aware_wake_cpu(p);
+                       new_cpu = energy_aware_wake_cpu(p, prev_cpu);
                else
                        new_cpu = select_idle_sibling(p, prev_cpu);
                goto unlock;

> +		else
> +			new_cpu = select_idle_sibling(p, prev_cpu);
>  		goto unlock;
>  	}

