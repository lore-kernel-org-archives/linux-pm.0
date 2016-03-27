From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 6/7][Resend] cpufreq: Support for fast frequency switching
Date: Sun, 27 Mar 2016 03:27:11 +0200
Message-ID: <CAJZ5v0j3PKvTL0b+W=cttOf6xkzHRwWH-Q9wRUGi2Hccm2brhg@mail.gmail.com>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
	<25154681.B5BGJ94JlQ@vostro.rjw.lan>
	<56F5E1EB.1050702@linaro.org>
	<CAJZ5v0inp178MJ=vxN-Qss1cBW5Ogmrq0xpccKfPB5Lky_i-Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0inp178MJ=vxN-Qss1cBW5Ogmrq0xpccKfPB5Lky_i-Wg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 26, 2016 at 2:46 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Sat, Mar 26, 2016 at 2:12 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> Hi Rafael,
>>
>> On 03/21/2016 06:53 PM, Rafael J. Wysocki wrote:
>>> Add two new policy flags, fast_switch_possible, to be set by the
>>> cpufreq driver if fast frequency switching can be used for the
>>> given policy and fast_switch_enabled, to be set by the governor
>>> if it is going to use fast frequency switching for the given
>>> policy.  Also add a helper for setting the latter.
>> ...
>>> @@ -740,6 +777,9 @@ static int acpi_cpufreq_cpu_init(struct
>>>               goto err_unreg;
>>>       }
>>>
>>> +     policy->fast_switch_possible = !acpi_pstate_strict &&
>>> +             !(policy_is_shared(policy) && policy->shared_type != CPUFREQ_SHARED_TYPE_ANY);
>>
>> Could the policy->fast_switch_possible flag be avoided by just checking
>> whether a driver has registered the .fast_switch callback?
>
> No, it couldn't.
>
> As in this case, the driver has the ->fast_switch callback, but it
> can't be used for policies that don't satisfy the above condition.  At
> the same time it may be possible to use it for other policies on the
> same system in principle.

In fact, for fast switching to be useful, the driver has to guarantee
that frequency can be updated on any of the policy CPUs (and it
doesn't matter which of them updates the frequency) and that's what
the fast_switch_possible flag is really for.  I guess I should add a
comment to that effect to its definition.

Thanks,
Rafael
