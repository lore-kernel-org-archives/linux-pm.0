From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: Re: [PATCH V11] Report interrupt that caused system wakeup
Date: Wed, 16 Sep 2015 11:15:03 -0700
Message-ID: <55F9B1A7.3080508@linux.intel.com>
References: <1442338366-16911-1-git-send-email-alexandra.yates@linux.intel.com>
 <17197937.G4AcryW2hF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48094 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbbIPSP2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Sep 2015 14:15:28 -0400
In-Reply-To: <17197937.G4AcryW2hF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, tglx@linutronix.de, kristen.c.accardi@intel.com

Hi Rafael,

On 09/15/2015 07:40 PM, Rafael J. Wysocki wrote:
> On Tuesday, September 15, 2015 10:32:46 AM Alexandra Yates wrote:
>> Add a sysfs attribute, /sys/power/pm_wakeup_irq, reporting the IRQ
>> number of the first wakeup interrupt (that is, the first interrupt
>> from an IRQ line armed for system wakeup) seen by the kernel during
>> the most recent system suspend/resume cycle.
>>
>> This feature will be useful for system wakeup diagnostics of
>> spurious wakeup interrupts.
>>
>> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> I've applied this, but I needed to fix it up due to build problems.
>
> I'd rather not to that again for any of your future patches.
I'm sorry you encountered this issue.  But, I built the patch before I 
sent it
against linux-pm with release 2.5 and the latest as of yesterday.

I'm wondering if I'm using the wrong tree/branch?  I would appreciate 
you help me
understand what went wrong so that this doesn't happen again for future 
patches.

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

