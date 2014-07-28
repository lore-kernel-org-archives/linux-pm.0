From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH RFC v2] PM / sleep: Fix racing timers
Date: Mon, 28 Jul 2014 12:24:27 -0700
Message-ID: <53D6A36B.1070105@linaro.org>
References: <53D083C5.2000501@linaro.org> <1406322408-15408-1-git-send-email-soren.brinkmann@xilinx.com> <53D6A23A.6010904@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:55555 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbaG1TYb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jul 2014 15:24:31 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so10309473pdi.25
        for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2014 12:24:30 -0700 (PDT)
In-Reply-To: <53D6A23A.6010904@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>

On 07/28/2014 12:19 PM, Stephen Boyd wrote:
> On 07/25/14 14:06, Soren Brinkmann wrote:
>> On platforms that do not power off during suspend, successfully entering
>> suspend races with timers.
>>
>> The race happening in a couple of location is:
>>
>>   1. disable IRQs   		(e.g. arch_suspend_disable_irqs())
>>      ...
>>   2. syscore_suspend()
>>       -> timekeeping_suspend()
>>        -> clockevents_notify(SUSPEND)
>>         -> tick_suspend()   	(timers are turned off here)
>>      ...
>>   3. wfi            		(wait for wake-IRQ here)
>>
>> Between steps 1 and 2 the timers can still generate interrupts that are
>> not handled and stay pending until step 3. That pending IRQ causes an
>> immediate - spurious - wake.
>>
>> The solution is to move the clockevents suspend/resume notification
>> out of the syscore_suspend step and explictly call them at the appropriate
>> time in the suspend/hibernation paths. I.e. timers are suspend _before_
>> IRQs get disabled. And accordingly in the resume path.
>>
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Do we know which timer_list or hrtimer wants to run while entering
> suspend? I'd suspect the scheduler tick but perhaps we just forgot to
> cancel some timer during suspend?

Though, canceling timers really shouldn't be necessary for
suspend/resume, no?

thanks
-john

