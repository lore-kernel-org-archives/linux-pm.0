From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC PATCH 1/2] PM / runtime: Add CPU runtime PM suspend/resume
 api
Date: Tue, 20 Oct 2015 19:59:57 -0600
Message-ID: <20151021015957.GA14526@linaro.org>
References: <1444168656-6576-1-git-send-email-lina.iyer@linaro.org>
 <1444168656-6576-2-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFp9P=uuSkGN_HD3JGn_YMi=ZnfG5ynX5y3ZfFt28fXxUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34844 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbbJUCAA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2015 22:00:00 -0400
Received: by oiev17 with SMTP id v17so21051799oie.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2015 18:59:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFp9P=uuSkGN_HD3JGn_YMi=ZnfG5ynX5y3ZfFt28fXxUg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Stephen Boyd <sboyd@codeaurora.org>

On Mon, Oct 19 2015 at 03:44 -0600, Ulf Hansson wrote:
>On 6 October 2015 at 23:57, Lina Iyer <lina.iyer@linaro.org> wrote:
>> CPU devices that use runtime PM, have the followign characteristics -
>>         - Runs in a IRQs disabled context
>>         - Every CPU does its own runtime PM
>>         - CPUs do not access other CPU's runtime PM
>>         - The runtime PM state of the CPU is determined by the CPU
>>
>> These allow for some interesting optimizations -
>>         - The CPUs have a limited runtime PM states
>>         - The runtime state of CPU need not be protected by spinlocks
>>         - Options like auto-suspend/async are not relevant to CPU
>>           devices
>>
>> A simplified runtime PM would therefore provide all that is needed for
>> the CPU devices. After making a quick check for the usage count of the
>> CPU devices (to allow for the CPU to not power down the domain), the
>> runtime PM could just call the PM callbacks for the CPU devices. Locking
>> is also avoided.
>
>It's an interesting idea. :-)
>
>While I need to give it some more thinking for how/if this could fit
>into the runtime PM API, let me start by providing some initial
>feedback on the patch as such.
>
>>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/base/power/runtime.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_runtime.h   |  3 ++-
>>  2 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index e1a10a0..5f7512c 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/pm_wakeirq.h>
>>  #include <trace/events/rpm.h>
>>  #include "power.h"
>> +#include <linux/cpu.h>
>>
>>  typedef int (*pm_callback_t)(struct device *);
>>
>> @@ -577,6 +578,66 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>>         goto out;
>>  }
>>
>> +void cpu_pm_runtime_suspend(void)
>
>I think you want to return int instead of void.
>
The outcome of this function would not change the runtime state of the
CPU. The void return seems appropriate.

>> +{
>> +       int ret;
>> +       int (*callback)(struct device *);
>> +       struct device *dev = get_cpu_device(smp_processor_id());
>
>Perhaps we should follow the other runtime PM APIs and have the struct
>*device provided as an in-parameter!?
>
But that information is can be deduced by this function - the function
is called for that CPU from *that* CPU. Also, the absence of an
argument, ensures that the caller won't make a mistake of calling any
other CPUs runtime PM from a CPU or worse, pass a device that is not a
CPU.

>> + +       trace_rpm_suspend(dev, 0);
>> +
>> +       /**
>> +        * Use device usage_count to disallow bubbling up suspend.
>> +        * This CPU has already decided to suspend, we cannot
>> +        * prevent it here.
>> +        */
>> +       if (!atomic_dec_and_test(&dev->power.usage_count))
>> +               return 0;
>> +
>> +       ret = rpm_check_suspend_allowed(dev);
>
>I don't think you can use this function. For example it calls
>__dev_pm_qos_read_value() which expects the dev->power.lock to be
>held.
>
Right. I realized that. Will fix.

>> +       if (ret)
>> +               return ret;
>> +
>> +       __update_runtime_status(dev, RPM_SUSPENDING);
>> +
>> +       pm_runtime_cancel_pending(dev);
>
>Hmm. For the same struct device (CPU) could really calls to
>cpu_pm_runtime_suspend|resume() happen in parallel? Do we need to
>protect against that?
>
That wouldnt happen, the functions are only called that CPU on that CPU.
See the explanation above.

>I don't have such in-depth knowledge about CPU idle, so apologize if
>this may be a stupid question.
>
>If the answer to the above is *no*, I believe you don't need to care
>about the intermediate RPM_SUSPENDING state and you don't need an
>atomic counter either, right!?
>
This calls into genpd framework, which expects devices to be
RPM_SUSPENDING in pm_genpd_power_off; I wanted to keep the behavior
between the frameworks consistent.

>Instead you could then just update the runtime PM status to
>RPM_SUSPENDED if the RPM callback doesn't return an error.
>
>> +       callback = RPM_GET_CALLBACK(dev, runtime_suspend);
>> +
>> +       ret = callback(dev);
>> +       if (!ret)
>> +               __update_runtime_status(dev, RPM_SUSPENDED);
>> +       else
>> +               __update_runtime_status(dev, RPM_ACTIVE);
>> +
>> +       trace_rpm_return_int(dev, _THIS_IP_, ret);
>> +}
>> +
>> +void cpu_pm_runtime_resume(void)
>
>Similar comments as for the suspend function.
>
>> +{
>> +       int ret;
>> +       int (*callback)(struct device *);
>> +       struct device *dev = get_cpu_device(smp_processor_id());
>> +
>> +       trace_rpm_resume(dev, 0);
>> +
>> +       if (dev->power.runtime_status == RPM_ACTIVE)
>> +               return 1;
>> +
>> +       atomic_inc(&dev->power.usage_count);
>> +
>> +       __update_runtime_status(dev, RPM_RESUMING);
>> +
>> +       callback = RPM_GET_CALLBACK(dev, runtime_resume);
>> +
>> +       ret = callback(dev);
>> +       if (!ret)
>> +               __update_runtime_status(dev, RPM_ACTIVE);
>> +       else
>> +               __update_runtime_status(dev, RPM_SUSPENDED);
>> +
>> +       trace_rpm_return_int(dev, _THIS_IP_, ret);
>> +}
>> +
>>  /**
>>   * rpm_resume - Carry out runtime resume of given device.
>>   * @dev: Device to resume.
>> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
>> index 3bdbb41..3655ead 100644
>> --- a/include/linux/pm_runtime.h
>> +++ b/include/linux/pm_runtime.h
>> @@ -31,6 +31,8 @@ static inline bool queue_pm_work(struct work_struct *work)
>>         return queue_work(pm_wq, work);
>>  }
>>
>> +extern void cpu_pm_runtime_suspend(void);
>> +extern void cpu_pm_runtime_resume(void);
>
>extern int ...
>
>>  extern int pm_generic_runtime_suspend(struct device *dev);
>>  extern int pm_generic_runtime_resume(struct device *dev);
>>  extern int pm_runtime_force_suspend(struct device *dev);
>> @@ -273,5 +275,4 @@ static inline void pm_runtime_dont_use_autosuspend(struct device *dev)
>>  {
>>         __pm_runtime_use_autosuspend(dev, false);
>>  }
>> -
>>  #endif
>> --
>> 2.1.4
>>
>
>Kind regards
>Uffe
