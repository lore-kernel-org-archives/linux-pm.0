From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] PM / sleep: enable suspend-to-idle even without
 registered suspend_ops
Date: Thu, 18 Aug 2016 14:10:48 +0100
Message-ID: <ba04a8b2-3d31-fff4-dd24-b5220fd0059a@arm.com>
References: <1471511964-6341-1-git-send-email-sudeep.holla@arm.com>
 <1549989.BLB0oyvVbJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549989.BLB0oyvVbJ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org



On 18/08/16 12:06, Rafael J. Wysocki wrote:
> On Thursday, August 18, 2016 10:19:24 AM Sudeep Holla wrote:
>> Suspend-to-idle (aka the "freeze" sleep state) is a system sleep state
>> in which all of the processors enter deepest possible idle state and
>> wait for interrupts right after suspending all the devices.
>>
>> There is no hard requirement for a platform to support and register
>> platform specific suspend_ops to enter suspend-to-idle/freeze state.
>> Only deeper system sleep states like PM_SUSPEND_STANDBY and
>> PM_SUSPEND_MEM rely on such low level support/implementation.
>>
>> suspend-to-idle can be entered as along as all the devices can be
>> suspended. This patch enables the support for suspend-to-idle even on
>> systems that don't have any low level support for deeper system sleep
>> states and/or don't register any platform specific suspend_ops.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  kernel/power/main.c    | 5 +++++
>>  kernel/power/suspend.c | 8 +++++---
>>  2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> Hi Rafael,
>>
>> I am not sure if you like this approach. I found this to be the simplest
>> but I may have missed to consider all possible corner cases especially
>> for x86 and other platforms. I don't see any such issues/cases with ARM
>> systems.
>>
>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>> index 5ea50b1b7595..0f0fd9184f39 100644
>> --- a/kernel/power/main.c
>> +++ b/kernel/power/main.c
>> @@ -651,6 +651,11 @@ static int __init pm_init(void)
>>  	if (error)
>>  		return error;
>>  	pm_print_times_init();
>> +	/*
>> +	 * freeze state should be supported even without any suspend_ops,
>> +	 * calling suspend_set_ops without any ops will setup freeze state
>> +	 */
>> +	suspend_set_ops(NULL);
>
> Well, this is a core initcall, so suspend_set_ops() invocations from platforms
> really should happen after that, so something like this should be sufficient here:
>
> 	pm_state[PM_SUSPEND_FREEZE] = pm_labels[relative_states ? PM_SUSPEND_MEM : PM_SUSPEND_FREEZE];
>
> if I'm not mistaken.
>

But won't this show up as "standby" state in /sys/power/state ?
Or did you mean:
	pm_state[PM_SUSPEND_FREEZE] = pm_labels[relative_states ? 0 : 2];

which will be "mem" or "freeze" based on relative_states.

In-fact, I did exactly this when I first hacked. Since it exposed
incorrectly to sysfs and I was not sure of these relative_states and
it's usage, I preferred re-using suspend_set_ops for this.

IIUC showing freeze state as "mem" in sysfs is fine as that's the
deepest possible state when relative_states=1. But showing it as freeze
as "standby" in sysfs when relative_states=0 looked wrong to me though
it works as freeze state.

As a side-note with psci, it get called quite early before
core_initcall. But that can be fixed if needed and is different issue.

-- 
Regards,
Sudeep
