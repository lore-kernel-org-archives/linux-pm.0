From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: Re: [PATCH V8] Report interrupt that caused system wakeup
Date: Mon, 14 Sep 2015 11:12:17 -0700
Message-ID: <55F70E01.6080801@linux.intel.com>
References: <1441929860-5488-1-git-send-email-alexandra.yates@linux.intel.com>
 <2235143.PitGJtzR6R@vostro.rjw.lan> <55F49C0B.3090903@linux.intel.com>
 <3945979.3EXZBXTxvt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13426 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbbINSKN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Sep 2015 14:10:13 -0400
In-Reply-To: <3945979.3EXZBXTxvt@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org



On 09/14/2015 06:56 AM, Rafael J. Wysocki wrote:
> On Saturday, September 12, 2015 02:41:31 PM Alexandra Yates wrote:
>> Hi Rafael,
>>
>> On 09/11/2015 04:36 PM, Rafael J. Wysocki wrote:
>>> On Thursday, September 10, 2015 05:04:20 PM Alexandra Yates wrote:
>>>> This feature reports the IRQ that was armed for system wakeup after
>>>> the system was last time suspended. It adds a new sysfs attribute
>>>> under /sys/power/ named: pm_last_wakeup_irq
>> Sounds good
>>> What about changing it this way:
>>>
>>> Add a sysfs attribute, /sys/power/pm_wakeup_irq, reporting the IRQ number of
>>> the first wakeup interrupt (that is, the first interrupt from an IRQ line
>>> armed for system wakeup) seen by the kernel during the most recent system
>>> suspend/resume cycle.
>>>
>>>> This feature will be useful for system wakeup diagnostics of
>>>> spurious wakeup interrupts.
>>>>
>>>> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
>>>> ---
>>>>    Documentation/ABI/testing/sysfs-power | 11 +++++++++++
>>>>    drivers/base/power/wakeup.c           | 12 ++++++++++++
>>>>    include/linux/suspend.h               |  8 +++++++-
>>>>    kernel/irq/pm.c                       |  4 ++--
>>>>    kernel/power/main.c                   | 19 +++++++++++++++++++
>>>>    5 files changed, 51 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
>>>> index f455181..75f27ed 100644
>>>> --- a/Documentation/ABI/testing/sysfs-power
>>>> +++ b/Documentation/ABI/testing/sysfs-power
>>>> @@ -256,3 +256,14 @@ Description:
>>>>    		Writing a "1" enables this printing while writing a "0"
>>>>    		disables it.  The default value is "0".  Reading from this file
>>>>    		will display the current value.
>>>> +
>>>> +What:		/sys/power/pm_last_wakeup_irq
>>> I'd change that to /sys/power/pm_wakeup_irq
>>>
>>>> +Date:		April 2015
>>>> +Contact:	Alexandra Yates <alexandra.yates@linux.intel.org>
>>>> +Description:
>>>> +		The /sys/power/pm_last_wakeup_irq file reports to user space
>>>> +		the IRQ that was armed for system wakeup and occurred since
>>>> +		suspend_device_irqs() was last called.
>>> And here I'd say:
>>>
>>> The /sys/power/pm_wakeup_irq file reports to user space the IRQ number of
>>> the first wakeup interrupt (that is, the first interrupt from an IRQ line
>>> armed for system wakeup) seen by the kernel during the most recent system
>>> suspend/resume cycle.
>>>
>>>> +
>>>> +		This output is useful for system wakeup diagnostics of spurious
>>>> +		wakeup interrupts.
>>>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>>>> index 51f15bc..f663fb1 100644
>>>> --- a/drivers/base/power/wakeup.c
>>>> +++ b/drivers/base/power/wakeup.c
>>>> @@ -870,6 +870,18 @@ void pm_wakeup_clear(void)
>>>>    	pm_abort_suspend = false;
>>>>    }
>>>>    
>>>> +void pm_system_irq_wakeup(unsigned int irq_number)
>>>> +{
>>>> +	if (wakeup_irq == 0)
>>>> +		wakeup_irq = irq_number;
>>>> +	pm_system_wakeup();
>>> I'm wondering if we need to call pm_system_wakeup() in the wakeup_irq != 0 case?
>>>
>>> If wakeup_irq != 0, pm_system_wakeup() has been called (at least) once already
>>> and it is not necessary to call it more than once.  Or am I missing anything?
>> Here I'm following Thomas advice to create pm_system_irq_wakeup to
>> handle the
>> storage of wakeup_irq I'm simply calling/wrapping pm_system_wakeup()
>> since it was
>> originally called from pm_system_irq_wakeup()with out other additional
>> conditionals.
>> I think doing anything else here may have unwanted results.   The core
>> functionality of
>> the code can be changed but I think that should be another patch. one
>> targeted towards
>> performance optimization.  Please let me know and I could add this to my
>> to do list.
My concern is how this change would impact any other IRQs that were armed.

Apparently from my testing there is no further impact.

The patch was sent with version10.  In case there are issues patch V09 
doesn't
include this change.
> My point is that you can do
>
> 	if (wakeup_irq == 0) {
> 		wakeup_irq = irq_number;
> 		pm_system_wakeup();
> 	}
>
> instead of calling pm_system_wakeup() unconditionally even if wakeup_irq != 0,
> can't you?
>
> Thanks,
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Thank you,
<Alexandra>

