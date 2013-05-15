From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Wed, 15 May 2013 12:00:49 +0530
Message-ID: <51932B99.403@linux.vnet.ibm.com>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com> <65F5F98566038744B1B43C8FD3B7549F1911A240@IRSMSX104.ger.corp.intel.com> <51922F68.2010404@linux.vnet.ibm.com>	<2396135.fo7RrTTQCl@vostro.rjw.lan> <51924221.2080707@linux.vnet.ibm.com> <CAKohpomxpPGtLU6ud816CqZtH=aFEK88FZSPL4aUNbusGiomvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:34665 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab3EOGdz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2013 02:33:55 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Wed, 15 May 2013 12:00:06 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 636BBE004F
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2013 12:06:13 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r4F6XdiY11993434
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2013 12:03:40 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r4F6XjwF019964
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2013 16:33:46 +1000
In-Reply-To: <CAKohpomxpPGtLU6ud816CqZtH=aFEK88FZSPL4aUNbusGiomvQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Jarzmik, Robert" <robert.jarzmik@intel.com>, "R, Durgadoss" <durgadoss.r@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 05/15/2013 11:46 AM, Viresh Kumar wrote:
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
> 
> Is it also possible that more cpus come up after resume? i.e. we had 2 cpus
> at suspend and 3 at resume?

Nope. That's not possible. While suspending we note down the online non-boot
CPUs we have, in a cpumask, and take them offline. On resume, we try to online
the CPUs in that cpumask. So there is no chance for more CPUs to come up during
resume.

> 
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
> 
> I have forgotten meaning of these flags now :(

Take a quick peek at kernel/cpu.c and include/linux/cpu.h and all those
memories will come rushing back ;-)

> So, CPU_ONLINE, CPU_DOWN_PREPARE and CPU_DOWN_FAILED
> are called when cpus are added/removed (but not for cpu_down in suspend
> resume)? and _FROZEN ones are only used for s2r/s2d?
> 

Yes, that's right. For the suspend/resume and hibernate/restore case, all
the notifiers use the _FROZEN flags. The regular hotplug notifications use
the flags without the _FROZEN suffix.

Regards,
Srivatsa S. Bhat

