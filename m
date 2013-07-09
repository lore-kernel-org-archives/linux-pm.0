From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: Re: [v3.10 regression] deadlock on cpu hotplug
Date: Tue, 09 Jul 2013 13:51:19 +0200
Message-ID: <1754044.EVIH1UZj6p@amdc1032>
References: <1443144.WnBWEpaopK@amdc1032> <51DB724F.9050708@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:24291 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab3GILvf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2013 07:51:35 -0400
In-reply-to: <51DB724F.9050708@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Wang <wangyun@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>, Tomasz Figa <t.figa@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


Hi,

On Tuesday, July 09, 2013 10:15:43 AM Michael Wang wrote:
> Hi, Bartlomiej
> 
> On 07/08/2013 11:26 PM, Bartlomiej Zolnierkiewicz wrote:
> [snip]
> > 
> > # echo 0 > /sys/devices/system/cpu/cpu3/online
> > # echo 0 > /sys/devices/system/cpu/cpu2/online
> > # echo 0 > /sys/devices/system/cpu/cpu1/online
> > # while true;do echo 1 > /sys/devices/system/cpu/cpu1/online;echo 0 > /sys/devices/system/cpu/cpu1/online;done
> > 
> > The commit in question (2f7021a8) was merged in v3.10-rc5 as a fix for
> > commit 031299b ("cpufreq: governors: Avoid unnecessary per cpu timer
> > interrupts") which was causing a kernel warning to show up.
> > 
> > Michael/Viresh: do you have some idea how to fix the issue?
> 
> Thanks for the report :) would you like to take a try
> on below patch and see whether it solve the issue?

It doesn't help and unfortunately it just can't help as it only
addresses lockdep functionality while the issue is not a lockdep
problem but a genuine locking problem. CPU hot-unplug invokes
_cpu_down() which calls cpu_hotplug_begin() which in turn takes
&cpu_hotplug.lock. The lock is then hold during __cpu_notify()
call. Notifier chain goes up to cpufreq_governor_dbs() which for
CPUFREQ_GOV_STOP event does gov_cancel_work(). This function
flushes pending work and waits for it to finish. The all above
happens in one kernel thread. At the same time the other kernel
thread is doing the work we are waiting to complete and it also
happens to do gov_queue_work() which calls get_online_cpus().
Then the code tries to take &cpu_hotplug.lock which is already
held by the first thread and deadlocks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 5af40ad..aa05eaa 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -229,6 +229,8 @@ static void set_sampling_rate(struct dbs_data *dbs_data,
>         }
>  }
>  
> +static struct lock_class_key j_cdbs_key;
> +
>  int cpufreq_governor_dbs(struct cpufreq_policy *policy,
>                 struct common_dbs_data *cdata, unsigned int event)
>  {
> @@ -366,6 +368,8 @@ int (struct cpufreq_policy *policy,
>                                         kcpustat_cpu(j).cpustat[CPUTIME_NICE];
>  
>                         mutex_init(&j_cdbs->timer_mutex);
> +                       lockdep_set_class(&j_cdbs->timer_mutex, &j_cdbs_key);
> +
>                         INIT_DEFERRABLE_WORK(&j_cdbs->work,
>                                              dbs_data->cdata->gov_dbs_timer);
>                 }
> 
> Regards,
> Michael Wang

