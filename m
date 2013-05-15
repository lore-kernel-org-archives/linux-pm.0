From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Wed, 15 May 2013 13:03:45 +0530
Message-ID: <51933A59.2000205@linux.vnet.ibm.com>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com> <65F5F98566038744B1B43C8FD3B7549F1911A240@IRSMSX104.ger.corp.intel.com> <51922F68.2010404@linux.vnet.ibm.com>	<2396135.fo7RrTTQCl@vostro.rjw.lan> <51924221.2080707@linux.vnet.ibm.com> <CAKohpongKq7Oi0Gm2-xfh5yQMDtTDEy2COuB6MNekUcDd2-X5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:34176 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab3EOHgs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2013 03:36:48 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Wed, 15 May 2013 13:01:52 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id B12FFE0053
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2013 13:09:05 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r4F7aWQT524628
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2013 13:06:32 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r4F7adL3005430
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2013 17:36:39 +1000
In-Reply-To: <CAKohpongKq7Oi0Gm2-xfh5yQMDtTDEy2COuB6MNekUcDd2-X5w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Jarzmik, Robert" <robert.jarzmik@intel.com>, "R, Durgadoss" <durgadoss.r@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 05/15/2013 12:15 PM, Viresh Kumar wrote:
> On 14 May 2013 19:24, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> Subject: [PATCH v2] cpufreq: Preserve sysfs file permissions across suspend/resume
>>
>> The file permissions of cpufreq per-cpu sysfs files are not preserved across
>> suspend/resume because we internally go through the CPU Hotplug path which
>> reinitializes the file permissions on CPU online.
>>
>> But the user is not supposed to know that we are using CPU hotplug
>> internally within suspend/resume (IOW, the kernel should not silently wreck
>> the user-set file permissions across a suspend cycle). Therefore, we need to
>> preserve the file permissions as it is, across suspend/resume.
>>
>> The simplest way to achieve that is to just not touch the sysfs files at
>> all - ie., just ignore the CPU hotplug events in the suspend/resume path
>> (_FROZEN) in the cpufreq hotplug callback.
>>
>> Reported-by: Robert Jarzmik <robert.jarzmik@intel.com>
>> Reported-by: Durgadoss R <durgadoss.r@intel.com>
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> ---
>> v2: Use UP_CANCELED_FROZEN notification to delete the sysfs files if the
>> CPUs don't come up during resume.
>>
>>  drivers/cpufreq/cpufreq.c       |    4 +---
>>  drivers/cpufreq/cpufreq_stats.c |    7 ++++---
>>  2 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 1b8a48e..284ba63 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1832,15 +1832,13 @@ static int __cpuinit cpufreq_cpu_callback(struct notifier_block *nfb,
>>         if (dev) {
>>                 switch (action) {
>>                 case CPU_ONLINE:
>> -               case CPU_ONLINE_FROZEN:
>>                         cpufreq_add_dev(dev, NULL);
>>                         break;
>>                 case CPU_DOWN_PREPARE:
>> -               case CPU_DOWN_PREPARE_FROZEN:
>> +               case CPU_UP_CANCELED_FROZEN:
>>                         __cpufreq_remove_dev(dev, NULL);
>>                         break;
>>                 case CPU_DOWN_FAILED:
>> -               case CPU_DOWN_FAILED_FROZEN:
>>                         cpufreq_add_dev(dev, NULL);
>>                         break;
>>                 }
>> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
>> index bfd6273..fb65dec 100644
>> --- a/drivers/cpufreq/cpufreq_stats.c
>> +++ b/drivers/cpufreq/cpufreq_stats.c
>> @@ -349,15 +349,16 @@ static int __cpuinit cpufreq_stat_cpu_callback(struct notifier_block *nfb,
>>
>>         switch (action) {
>>         case CPU_ONLINE:
>> -       case CPU_ONLINE_FROZEN:
>>                 cpufreq_update_policy(cpu);
>>                 break;
>>         case CPU_DOWN_PREPARE:
>> -       case CPU_DOWN_PREPARE_FROZEN:
>>                 cpufreq_stats_free_sysfs(cpu);
>>                 break;
>>         case CPU_DEAD:
>> -       case CPU_DEAD_FROZEN:
>> +               cpufreq_stats_free_table(cpu);
>> +               break;
>> +       case CPU_UP_CANCELED_FROZEN:
>> +               cpufreq_stats_free_sysfs(cpu);
>>                 cpufreq_stats_free_table(cpu);
>>                 break;
>>         }
> 
> I accept that the patch makes things work but honestly speaking I
> didn't like it much :(
> 
> As it looks like more of a hack than a proper solution. We are off-lining
> cpus but we are still keeping cpufreq directories (cpu/cpu*/cpufreq)...
> That goes against the basic rules...
>

Why do you say that? We want to do *suspend/resume*, not *CPU hotplug*.
So we do a "light" form of hotplug where only the most necessary things
are done. Deleting all the sysfs files and recreating them on resume is
a total waste of time anyway (and adds to the suspend/resume latency).
The _FROZEN flags have been introduced and used for a long time now,
for this very purpose : provide a way to make hotplug as light, and as
smart as possible in the suspend/resume path, because our intention is
to do *suspend/resume* and *not* hotplug per-se. It is only coincidental
that we use hotplug internally in the those paths to get the job done easily.

> This works because there is no potential user between suspend/resume
> who can notice above issue. But that doesn't mean we write such code.
> 

I disagree. There is absolutely nothing wrong here - we have *frozen* the
userspace much before we did any of that! Why do you think we do that?
IOW, it is not purely by chance that nobody is observing what we are doing
in the suspend/resume path - we intentionally *froze* everybody! And until
we thaw them in the resume path, nobody can see anything. And that is
by design. Of course, freezing of tasks is important to restore them back
on resume to the same state, but it serves higher-level purposes too, like
this (ie., not surprising the user with unrelated events). That's part of
the reason why its almost the first thing we do in the suspend path.

> On the other side, it looks difficult to preserve permissions by writing some
> complicated code to preserve and restore original settings for
> Suspend/resume.
> 

Think about it - nobody asked us to delete the sysfs files or wreck their
settings and then worry about restoring them back; we were just asked to suspend
and resume the system. Wrecking the settings is a side-effect of doing hotplug
internally in the suspend/resume path. And that's exactly why we have the
_FROZEN flags, to help us avoid shooting ourselves in the foot like that.

We have used this solution of ignoring stuff to give the effect of
preserving and restoring state, for much more serious stuff before.
Take a look at commit 8f2f748b0656 (CPU hotplug, cpusets, suspend: Don't
touch cpusets during suspend/resume). (But that commit had to be reworked later
to handle a different problem, but that is not relevant here). There have been
some clever optimizations too, that used similar methods : commit 3fb82d56ad0
(x86, suspend: Avoid unnecessary smp alternatives switch during suspend/resume).

So IMHO this is a perfectly sane way to deal with suspend/resume with the
infrastructure we have today. There is nothing wrong in doing this.
Using the _FROZEN flags to speed up suspend/resume (and handle problems like
this) is the closest approximation of the "inactive" state that Alan Stern
described, that we have today in the kernel.

> For now I can't imaging this breaking some stuff in cpufreq core.
> 

What I was concerned was if there were any hidden dependencies between these
functions which deal with sysfs and functions that deal with putting back
the CPUs to the previously set frequencies upon resume (in case there are such
things to be done at resume). Good to know that there are no such dependencies.

> I don't want to but I have to (As i don't have a better solution):
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thank you! I wish you had ACKed it more happily though ;-)

Regards,
Srivatsa S. Bhat

