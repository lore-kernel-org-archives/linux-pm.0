From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Tue, 14 May 2013 18:04:48 +0530
Message-ID: <51922F68.2010404@linux.vnet.ibm.com>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com> <1598695.llKRKEsWfA@vostro.rjw.lan> <4D68720C2E767A4AA6A8796D42C8EB59C8E7AD@BGSMSX101.gar.corp.intel.com> <2172262.yzQn9gFeOZ@vostro.rjw.lan> <4D68720C2E767A4AA6A8796D42C8EB59C8E7D8@BGSMSX101.gar.corp.intel.com> <65F5F98566038744B1B43C8FD3B7549F1911A240@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:55464 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab3ENMhv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2013 08:37:51 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 14 May 2013 22:27:40 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id AAF8A2CE804C
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 22:37:44 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r4ECbbks22216864
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 22:37:37 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r4ECbhsr012334
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 22:37:44 +1000
In-Reply-To: <65F5F98566038744B1B43C8FD3B7549F1911A240@IRSMSX104.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jarzmik, Robert" <robert.jarzmik@intel.com>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 05/14/2013 05:24 PM, Jarzmik, Robert wrote:
>> Okay, agreed after looking at this discussion ;) I am fine with the approach of kernel preserving permissions too.
> 
> Ok, that's great, yet I don't see a clean solution here.  This is
> the path I see and that bothers me in the S3 suspend path:
> cpufreq_sysfs_release
>   kobject_cleanup
>     kobject_release
>       kobject_put
>         __cpufreq_remove_dev
>           cpufreq_cpu_callback
>             notifier_call_chain
>               __raw_notifier_call_chain
>                 __cpu_notify
>                   _cpu_down
> 
> Here the sysfs attributes are destroyed. Cpu onlining will
> recreate them with root permissions. I don't see a good clean way
> to preserve permissions in sysfs across suspend/resume for
> deleted nodes. Do you ?
> 
> And here we come to my actual worry : what is the technical clean
> way to solve this problem ?
> 
> So far I have no idea (the cpufreq example is only a subset of
> the cases where it could happen). So if someone comes up with a
> good idea I'll volunteer to implement it :)
> 

Does the below (untested) patch help? I haven't spent time investigating
whether not doing the add_dev/remove_dev stuff during CPU hotplug in S3 path
will break something else. But it would be great if this works, since
its the simplest solution that I can think of.

---------------------------------------------------------------------->

From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: Preserve sysfs file permissions across suspend/resume

The file permissions of cpufreq per-cpu sysfs files are not preserved across
suspend/resume because we internally go through the CPU Hotplug path which
reinitializes the file permissions on CPU online.

But the user is not supposed to know that we are using CPU hotplug
internally within suspend/resume (IOW, the kernel should not silently wreck
the user-set file permissions across a suspend cycle). Therefore, we need to
preserve the file permissions as it is, across suspend/resume.

The simplest way to achieve that is to just not touch the sysfs files at
all - ie., just ignore the CPU hotplug events in the suspend/resume path
(_FROZEN) in the cpufreq hotplug callback.

Reported-by: Robert Jarzmik <robert.jarzmik@intel.com>
Reported-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/cpufreq/cpufreq.c       |    3 ---
 drivers/cpufreq/cpufreq_stats.c |    3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1b8a48e..a7b0910 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1832,15 +1832,12 @@ static int __cpuinit cpufreq_cpu_callback(struct notifier_block *nfb,
 	if (dev) {
 		switch (action) {
 		case CPU_ONLINE:
-		case CPU_ONLINE_FROZEN:
 			cpufreq_add_dev(dev, NULL);
 			break;
 		case CPU_DOWN_PREPARE:
-		case CPU_DOWN_PREPARE_FROZEN:
 			__cpufreq_remove_dev(dev, NULL);
 			break;
 		case CPU_DOWN_FAILED:
-		case CPU_DOWN_FAILED_FROZEN:
 			cpufreq_add_dev(dev, NULL);
 			break;
 		}
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index bfd6273..fc1ec57 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -349,15 +349,12 @@ static int __cpuinit cpufreq_stat_cpu_callback(struct notifier_block *nfb,
 
 	switch (action) {
 	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
 		cpufreq_update_policy(cpu);
 		break;
 	case CPU_DOWN_PREPARE:
-	case CPU_DOWN_PREPARE_FROZEN:
 		cpufreq_stats_free_sysfs(cpu);
 		break;
 	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
 		cpufreq_stats_free_table(cpu);
 		break;
 	}


