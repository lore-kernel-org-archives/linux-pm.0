From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: Re: [PATCH V7] Report interrupt that caused system wakeup
Date: Thu, 10 Sep 2015 11:42:15 -0700
Message-ID: <55F1CF07.8070505@linux.intel.com>
References: <Pine.LNX.4.44L0.1509101012180.1422-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9450 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbbIJSkT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 14:40:19 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509101012180.1422-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net

Hi Alan,

On 09/10/2015 07:14 AM, Alan Stern wrote:
> On Wed, 9 Sep 2015, Alexandra Yates wrote:
>
>> This feature reports which IRQ cause the system to wakeup from sleep last
>> time it was suspended.
> I thought you said V7 of this patch was written based on the feedback I
> provided.  Obviously that is not true.
Yes, that was the intention.
> This feature does NOT report which IRQ caused the system to wake up
> from sleep the last time it was suspended!  All it does is report one
> of the IRQs which have occurred since the last time the system started
> a sleep transition.
I'm not sure why you say this, please elaborate further.

The way I understand the code and proposed solution is that when
the system goes into freeze mode, at that point wakeup_irq is set to 0.

Once the system sees an interrupt at wakeup from freeze. wakeup_irq is 
set to
the irq_number that caused the wakeup.  This path of code is protected 
by spin lock,

which should protect the code path from other IRQs that came after the 
first IRQ.
This is only set once. When other IRQs come and the wakeup_irq is set 
then the code
doesn't store them.

> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Thank you,
<Alexandra>

