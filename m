From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC PATCH 1/2] PM / runtime: Add CPU runtime PM suspend/resume api
Date: Fri, 23 Oct 2015 16:46:08 -0700
Message-ID: <7h7fmdm9mn.fsf@deeprootsystems.com>
References: <1444168656-6576-1-git-send-email-lina.iyer@linaro.org>
	<1444168656-6576-2-git-send-email-lina.iyer@linaro.org>
	<7hegglmgf3.fsf@deeprootsystems.com>
	<20151023221339.GE3072@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35686 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbbJWXqL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2015 19:46:11 -0400
Received: by pasz6 with SMTP id z6so130388187pas.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2015 16:46:10 -0700 (PDT)
In-Reply-To: <20151023221339.GE3072@linaro.org> (Lina Iyer's message of "Fri,
	23 Oct 2015 16:13:39 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: linux-pm@vger.kernel.org, grygorii.strashko@ti.com, ulf.hansson@linaro.org, daniel.lezcano@linaro.org, tglx@linutronix.de, geert+renesas@glider.be, lorenzo.pieralisi@arm.com, sboyd@codeaurora.org

Lina Iyer <lina.iyer@linaro.org> writes:

> On Fri, Oct 23 2015 at 15:19 -0600, Kevin Hilman wrote:
>>Lina Iyer <lina.iyer@linaro.org> writes:
>>
>>> CPU devices that use runtime PM, have the followign characteristics -
>>> 	- Runs in a IRQs disabled context
>>> 	- Every CPU does its own runtime PM
>>> 	- CPUs do not access other CPU's runtime PM
>>> 	- The runtime PM state of the CPU is determined by the CPU
>>>
>>> These allow for some interesting optimizations -
>>> 	- The CPUs have a limited runtime PM states
>>> 	- The runtime state of CPU need not be protected by spinlocks
>>> 	- Options like auto-suspend/async are not relevant to CPU
>>> 	  devices
>>>
>>> A simplified runtime PM would therefore provide all that is needed for
>>> the CPU devices.
>>
>>I like the idea of optimizing things for CPUs.  I've assumed we would
>>eventually run into latency issues when using runtime PM and genpd on
>>CPUs, but I guess we're already there.
>>
>>> After making a quick check for the usage count of the
>>> CPU devices (to allow for the CPU to not power down the domain), the
>>> runtime PM could just call the PM callbacks for the CPU devices. Locking
>>> is also avoided.
>>
>>This part is confusing (or more accurately, I am confused) more on that below...
>>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> ---
>>>  drivers/base/power/runtime.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/pm_runtime.h   |  3 ++-
>>>  2 files changed, 63 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>>> index e1a10a0..5f7512c 100644
>>> --- a/drivers/base/power/runtime.c
>>> +++ b/drivers/base/power/runtime.c
>>> @@ -13,6 +13,7 @@
>>>  #include <linux/pm_wakeirq.h>
>>>  #include <trace/events/rpm.h>
>>>  #include "power.h"
>>> +#include <linux/cpu.h>
>>>
>>>  typedef int (*pm_callback_t)(struct device *);
>>>
>>> @@ -577,6 +578,66 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>>>  	goto out;
>>>  }
>>>
>>> +void cpu_pm_runtime_suspend(void)
>>> +{
>>> +	int ret;
>>> +	int (*callback)(struct device *);
>>> +	struct device *dev = get_cpu_device(smp_processor_id());
>>> +
>>> +	trace_rpm_suspend(dev, 0);
>>> +
>>> +	/**
>>
>>nit: the double '*' indicates kerneldoc, but this is just a multi-line
>>comment.
>>
>>> +	 * Use device usage_count to disallow bubbling up suspend.
>>
>>I don't understand this comment.
>>
>>> +	 * This CPU has already decided to suspend, we cannot
>>> +	 * prevent it here.
>>> +	 */
>>> +	if (!atomic_dec_and_test(&dev->power.usage_count))
>>
>>Isn't this basically a _put_noidle() ?
>>
>>> +		return 0;
>>> +
>>> +	ret = rpm_check_suspend_allowed(dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	__update_runtime_status(dev, RPM_SUSPENDING);
>>> +
>>> +	pm_runtime_cancel_pending(dev);
>>> +	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
>>
>>If the CPU device is part of a domain (e.g. cluster), then 'callback'
>>here will be the domain callback, right?
>>
> Yes, thats correct.
>
>>If that's true, I'm not sure I'm following the changelog description
>>that talks about avoiding the calling into the domain.
>>
> Partly correct. Avoid calling into the domain if its not the last
> device.
>
>>It seems to me that you'll still call into the domain, but patch 2/2
>>optimizes that path by only doing the *real* work of the domain for the
>>last man standing.  Am I understanding that correctly?
>>
> Yes
>
>>Hmm, if that's the case though, where would the callbacks associated with the
>>CPU (e.g. current CPU PM notifier stuff) get called?
>>
>
> They are called from cpuidle driver as it is today.
>

And if the CPU _PM notifiers are eventually converted into runtime PM
callbacks, they would then be called by the domain callbacks, but
wouldn't that mean they would only be called after the last man
standing?

Kevin
