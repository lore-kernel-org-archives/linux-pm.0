From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/12] cpufreq: governor: Close dbs_data update race condition
Date: Thu, 18 Feb 2016 17:20:52 +0100
Message-ID: <CAJZ5v0jFP5hdcomAw1GcMgVAhw1mnwpZ3vdM7vN59SFkiug_YA@mail.gmail.com>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
	<1592265.QLnTJA45ZD@vostro.rjw.lan>
	<20160218052409.GG2610@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:32826 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946766AbcBRQUy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 11:20:54 -0500
In-Reply-To: <20160218052409.GG2610@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Feb 18, 2016 at 6:24 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18-02-16, 02:19, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> It is possible for a dbs_data object to be updated after its
>> usage counter has become 0.  That may happen if governor_store()
>> runs (via a govenor tunable sysfs attribute write) in parallel
>> with cpufreq_governor_exit() called for the last cpufreq policy
>> associated with the dbs_data in question.  In that case, if
>> governor_store() acquires dbs_data->mutex right after
>> cpufreq_governor_exit() has released it, the ->store() callback
>> invoked by it may operate on dbs_data with no users.  Although
>> sysfs will cause the kobject_put() in cpufreq_governor_exit() to
>> block until governor_store() has returned, that situation may
>> lead to some unexpected results, depending on the implementation
>> of the ->store callback, and therefore it should be avoided.
>>
>> To that end, modify governor_store() to check the dbs_data's
>> usage count before invoking the ->store() callback and return
>> an error if it is 0 at that point.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/cpufreq/cpufreq_governor.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
>> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
>> @@ -112,7 +112,7 @@ static ssize_t governor_store(struct kob
>>
>>       mutex_lock(&dbs_data->mutex);
>>
>> -     if (gattr->store)
>> +     if (dbs_data->usage_count && gattr->store)
>
> That's not gonna be enough. The above lock doesn't guarantee
> protection with any such races.

I'm not really sure what you're talking about to be honest, so please
be more specific.  You can say "For example, function X decrements the
usage count without locking" or similar.

Such vague comments are quite difficult to address, especially if they
don't hold any water. :-)

> And so usage_count can become zero
> just after this check.

But how?

The only place it is decremented is cpufreq_governor_exit() and there
it is done under dbs_data->mutex (at my direct request, BTW).  So we
are guaranteed that it won't go down to zero while we're holding
dbs_data->mutex, aren't we?

> Btw, we should also kill the gattr->store checks here as well, as we
> did it in cpufreq-core.
>
>>               ret = gattr->store(dbs_data, buf, count);
>>
>>       mutex_unlock(&dbs_data->mutex);

Yeah, they are quite useless.  But not in this patch.

Thanks,
Rafael
