From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Wed, 15 May 2013 22:50:25 +0200
Message-ID: <48891656.zvgiBQ9eul@vostro.rjw.lan>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com> <2396135.fo7RrTTQCl@vostro.rjw.lan> <51924221.2080707@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:49580 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295Ab3EOUlu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 May 2013 16:41:50 -0400
In-Reply-To: <51924221.2080707@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Jarzmik, Robert" <robert.jarzmik@intel.com>, "R, Durgadoss" <durgadoss.r@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, May 14, 2013 07:24:41 PM Srivatsa S. Bhat wrote:
> On 05/14/2013 06:30 PM, Rafael J. Wysocki wrote:
> > On Tuesday, May 14, 2013 06:04:48 PM Srivatsa S. Bhat wrote:
> >> On 05/14/2013 05:24 PM, Jarzmik, Robert wrote:
> >>>> Okay, agreed after looking at this discussion ;) I am fine with the approach of kernel preserving permissions too.
> >>>
> >>> Ok, that's great, yet I don't see a clean solution here.  This is
> >>> the path I see and that bothers me in the S3 suspend path:
> >>> cpufreq_sysfs_release
> >>>   kobject_cleanup
> >>>     kobject_release
> >>>       kobject_put
> >>>         __cpufreq_remove_dev
> >>>           cpufreq_cpu_callback
> >>>             notifier_call_chain
> >>>               __raw_notifier_call_chain
> >>>                 __cpu_notify
> >>>                   _cpu_down
> >>>
> >>> Here the sysfs attributes are destroyed. Cpu onlining will
> >>> recreate them with root permissions. I don't see a good clean way
> >>> to preserve permissions in sysfs across suspend/resume for
> >>> deleted nodes. Do you ?
> >>>
> >>> And here we come to my actual worry : what is the technical clean
> >>> way to solve this problem ?
> >>>
> >>> So far I have no idea (the cpufreq example is only a subset of
> >>> the cases where it could happen). So if someone comes up with a
> >>> good idea I'll volunteer to implement it :)
> >>>
> >>
> >> Does the below (untested) patch help? I haven't spent time investigating
> >> whether not doing the add_dev/remove_dev stuff during CPU hotplug in S3 path
> >> will break something else. But it would be great if this works, since
> >> its the simplest solution that I can think of.
> > 
> > Well, what if the CPU doesn't come up during resume?
> > 
> 
> Hmm, that's a good point. We will need to remove the sysfs files in that
> case. The updated patch below uses CPU_UP_CANCELED_FROZEN notification
> to do that.
> 
> Regards,
> Srivatsa S. Bhat
> 
> ----------------------------------------------------------------------->
> 
> From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Subject: [PATCH v2] cpufreq: Preserve sysfs file permissions across suspend/resume
> 
> The file permissions of cpufreq per-cpu sysfs files are not preserved across
> suspend/resume because we internally go through the CPU Hotplug path which
> reinitializes the file permissions on CPU online.
> 
> But the user is not supposed to know that we are using CPU hotplug
> internally within suspend/resume (IOW, the kernel should not silently wreck
> the user-set file permissions across a suspend cycle). Therefore, we need to
> preserve the file permissions as it is, across suspend/resume.
> 
> The simplest way to achieve that is to just not touch the sysfs files at
> all - ie., just ignore the CPU hotplug events in the suspend/resume path
> (_FROZEN) in the cpufreq hotplug callback.
> 
> Reported-by: Robert Jarzmik <robert.jarzmik@intel.com>
> Reported-by: Durgadoss R <durgadoss.r@intel.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Applied to linux-pm.git/linux-next as v3.10-rc2 material.

Thanks,
Rafael


> ---
> v2: Use UP_CANCELED_FROZEN notification to delete the sysfs files if the
> CPUs don't come up during resume.
> 
>  drivers/cpufreq/cpufreq.c       |    4 +---
>  drivers/cpufreq/cpufreq_stats.c |    7 ++++---
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1b8a48e..284ba63 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1832,15 +1832,13 @@ static int __cpuinit cpufreq_cpu_callback(struct notifier_block *nfb,
>  	if (dev) {
>  		switch (action) {
>  		case CPU_ONLINE:
> -		case CPU_ONLINE_FROZEN:
>  			cpufreq_add_dev(dev, NULL);
>  			break;
>  		case CPU_DOWN_PREPARE:
> -		case CPU_DOWN_PREPARE_FROZEN:
> +		case CPU_UP_CANCELED_FROZEN:
>  			__cpufreq_remove_dev(dev, NULL);
>  			break;
>  		case CPU_DOWN_FAILED:
> -		case CPU_DOWN_FAILED_FROZEN:
>  			cpufreq_add_dev(dev, NULL);
>  			break;
>  		}
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index bfd6273..fb65dec 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -349,15 +349,16 @@ static int __cpuinit cpufreq_stat_cpu_callback(struct notifier_block *nfb,
>  
>  	switch (action) {
>  	case CPU_ONLINE:
> -	case CPU_ONLINE_FROZEN:
>  		cpufreq_update_policy(cpu);
>  		break;
>  	case CPU_DOWN_PREPARE:
> -	case CPU_DOWN_PREPARE_FROZEN:
>  		cpufreq_stats_free_sysfs(cpu);
>  		break;
>  	case CPU_DEAD:
> -	case CPU_DEAD_FROZEN:
> +		cpufreq_stats_free_table(cpu);
> +		break;
> +	case CPU_UP_CANCELED_FROZEN:
> +		cpufreq_stats_free_sysfs(cpu);
>  		cpufreq_stats_free_table(cpu);
>  		break;
>  	}
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
