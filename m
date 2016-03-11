From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Make cpufreq_quick_get() safe to call.
Date: Fri, 11 Mar 2016 03:23:22 +0100
Message-ID: <CAJZ5v0gDkVyHyQ-4YPV5SYz5ppbc+OT6xm-zaAVfMdponS4L8A@mail.gmail.com>
References: <1457622636-10028-1-git-send-email-rcochran@linutronix.de>
	<3267506.5YnhcYthBi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:32841 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933259AbcCKCXY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2016 21:23:24 -0500
In-Reply-To: <3267506.5YnhcYthBi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Richard Cochran <rcochran@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rt@linutronix.de, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Mar 10, 2016 at 11:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, March 10, 2016 04:10:36 PM Richard Cochran wrote:
>> The function, cpufreq_quick_get, accesses the global 'cpufreq_driver' and
>> its fields without taking the associated lock, cpufreq_driver_lock.
>>
>> Without the locking, nothing guarantees that 'cpufreq_driver' remains
>> consistent during the call.  This patch fixes the issue by taking the lock
>> before accessing the data structure.
>>
>> Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Richard Cochran <rcochran@linutronix.de>
>
> Can you please CC PM-related patches to linux-pm@vger.kernel.org?  They
> are much easier to handle for me then.
>
>> ---
>>  drivers/cpufreq/cpufreq.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index e979ec7..ce02b2b 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1457,9 +1457,17 @@ unsigned int cpufreq_quick_get(unsigned int cpu)
>>  {
>>       struct cpufreq_policy *policy;
>>       unsigned int ret_freq = 0;
>> +     unsigned long flags;
>> +
>> +     read_lock_irqsave(&cpufreq_driver_lock, flags);
>>
>>       if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get)
>> -             return cpufreq_driver->get(cpu);
>> +             ret_freq = cpufreq_driver->get(cpu);
>> +
>> +     read_unlock_irqrestore(&cpufreq_driver_lock, flags);
>> +
>> +     if (ret_freq)
>> +             return ret_freq;
>>
>>       policy = cpufreq_cpu_get(cpu);
>>       if (policy) {
>>
>
> I would prefer something like this:
>
>         read_lock_irqsave(&cpufreq_driver_lock, flags);
>
>         if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get) {
>                 unsigned int ret_freq = cpufreq_driver->get(cpu);

Sorry, ret_freq is needed outside of this block anyway, so that would be

                   ret_freq = cpufreq_driver->get(cpu);
>
>                 read_unlock_irqrestore(&cpufreq_driver_lock, flags);
>                 return ret_freq;
>         }
>
>         read_unlock_irqrestore(&cpufreq_driver_lock, flags);
