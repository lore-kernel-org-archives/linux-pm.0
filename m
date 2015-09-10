From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: Re: [PATCH V6] Report interrupt(s) that caused system wakeup
Date: Wed, 9 Sep 2015 19:57:04 -0700
Message-ID: <55F0F180.9010908@linux.intel.com>
References: <1440705643-3092-2-git-send-email-alexandra.yates@linux.intel.com>
 <7458110.bud3pBbYxc@vostro.rjw.lan> <3154314.pSSLUa6EJS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16830 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632AbbIJCzE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Sep 2015 22:55:04 -0400
In-Reply-To: <3154314.pSSLUa6EJS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org

Hi,

On 09/08/2015 05:56 PM, Rafael J. Wysocki wrote:
> On Tuesday, September 08, 2015 12:16:37 AM Rafael J. Wysocki wrote:
>> On Thursday, August 27, 2015 01:00:43 PM Alexandra Yates wrote:
>>> This feature reports which IRQs cause the system to wakeup from sleep last
>>> time it was suspended.
>>>
>>> It adds a new sysfs attribute under /sys/power/ named: pm_last_wakeup_irqs
>>> when read, will return a list of IRQs that caused the system to wakeup.
>>> That will be useful for system wakeup diagnostics.
>>>
>>> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
>>> ---
>>>   Documentation/ABI/testing/sysfs-power | 11 +++++++++++
>>>   drivers/base/power/wakeup.c           | 33 ++++++++++++++++++++++++++++++++-
>>>   include/linux/suspend.h               |  5 +++--
>>>   kernel/irq/pm.c                       |  2 +-
>>>   kernel/power/main.c                   | 23 +++++++++++++++++++++++
>>>   5 files changed, 70 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
>>> index f455181..4f9cc3a 100644
>>> --- a/Documentation/ABI/testing/sysfs-power
>>> +++ b/Documentation/ABI/testing/sysfs-power
>>> @@ -256,3 +256,14 @@ Description:
>>>   		Writing a "1" enables this printing while writing a "0"
>>>   		disables it.  The default value is "0".  Reading from this file
>>>   		will display the current value.
>>> +
>>> +What:		/sys/power/pm_last_wakeup_irqs
>> There will be only one now, so I'll call it simply "pm_wakeup_irq".
>>
>>> +Date:		April 2015
>>> +Contact:	Alexandra Yates <alexandra.yates@linux.intel.org>
>>> +Description:
>>> +		The /sys/power/pm_last_wakeup_irqs file allows user space
>>> +		to identify and report the IRQs responsible for waking the
>>> +		system up from sleep. The IRQD_WAKEUP_TRIGGERED flag is set and
>>> +		reported when the given IRQ fires after it has been armed for
>>> +		system wakeup. This output is useful for system wakeup
>>> +		diagnostics.
>>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>>> index 51f15bc..0f6cc55 100644
>>> --- a/drivers/base/power/wakeup.c
>>> +++ b/drivers/base/power/wakeup.c
>>> @@ -28,6 +28,9 @@ bool events_check_enabled __read_mostly;
>>>   /* If set and the system is suspending, terminate the suspend. */
>>>   static bool pm_abort_suspend __read_mostly;
>>>   
>>> +/* IRQ number which causes system wakeup  */
>>> +static unsigned int wakeup_irq;
>>> +
>>>   /*
>>>    * Combined counters of registered wakeup events and wakeup events in progress.
>>>    * They need to be modified together atomically, so it's better to use one
>>> @@ -858,8 +861,9 @@ bool pm_wakeup_pending(void)
>>>   	return ret || pm_abort_suspend;
>>>   }
>>>   
>>> -void pm_system_wakeup(void)
>> You can't replace pm_system_wakeup() with the new thing, because it is used
>> beyond the IRQ subsystem.  You can make pm_system_irq_wakeup() call
>> pm_system_wakeup().
>>
>>> +void pm_system_irq_wakeup(unsigned int irq_number)
>>>   {
>>> +	wakeup_irq = irq_number;
>>>   	pm_abort_suspend = true;
>>>   	freeze_wake();
>>>   }
> One more point.
>
> We need this to register the first wakeup interrupt and ignore the next
> ones, but this code will simply register the last wakeup interrupt during
> the cycle.
>
> Thanks,
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Just sent patch V7.  It includes changes for the feedback received from 
Rafael, Alan, Thomas and Yan.

Thank you all for your review.  Rafael.  Please accept V7 of the patch.

-- 
Thank you,
<Alexandra>

