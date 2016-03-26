From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 6/7][Resend] cpufreq: Support for fast frequency switching
Date: Sat, 26 Mar 2016 02:46:01 +0100
Message-ID: <CAJZ5v0inp178MJ=vxN-Qss1cBW5Ogmrq0xpccKfPB5Lky_i-Wg@mail.gmail.com>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
	<25154681.B5BGJ94JlQ@vostro.rjw.lan>
	<56F5E1EB.1050702@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35997 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbcCZBqE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2016 21:46:04 -0400
In-Reply-To: <56F5E1EB.1050702@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Sat, Mar 26, 2016 at 2:12 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> Hi Rafael,
>
> On 03/21/2016 06:53 PM, Rafael J. Wysocki wrote:
>> Add two new policy flags, fast_switch_possible, to be set by the
>> cpufreq driver if fast frequency switching can be used for the
>> given policy and fast_switch_enabled, to be set by the governor
>> if it is going to use fast frequency switching for the given
>> policy.  Also add a helper for setting the latter.
> ...
>> @@ -740,6 +777,9 @@ static int acpi_cpufreq_cpu_init(struct
>>               goto err_unreg;
>>       }
>>
>> +     policy->fast_switch_possible = !acpi_pstate_strict &&
>> +             !(policy_is_shared(policy) && policy->shared_type != CPUFREQ_SHARED_TYPE_ANY);
>
> Could the policy->fast_switch_possible flag be avoided by just checking
> whether a driver has registered the .fast_switch callback?

No, it couldn't.

As in this case, the driver has the ->fast_switch callback, but it
can't be used for policies that don't satisfy the above condition.  At
the same time it may be possible to use it for other policies on the
same system in principle.

> ...
>> @@ -1726,6 +1810,34 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
>>   *                              GOVERNORS                            *
>>   *********************************************************************/
>>
>> +/**
>> + * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
>> + * @policy: cpufreq policy to switch the frequency for.
>> + * @target_freq: New frequency to set (may be approximate).
>> + *
>> + * Carry out a fast frequency switch from interrupt context.
>
> I think that should say atomic rather than interrupt as this might not
> be called from interrupt context.

"Interrupt context" here means something like "context that cannot
sleep" and it's sort of a traditional way of calling that.  I
considered saying "atomic context" here, but then decided that it
might suggest too much.

Maybe something like "Carry out a fast frequency switch without
sleeping" would be better?

Thanks,
Rafael
