From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH RFC] suspend/hibernation: Fix racing timers
Date: Wed, 23 Jul 2014 20:55:49 -0700
Message-ID: <53D083C5.2000501@linaro.org>
References: <1405964152-17865-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33753 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934053AbaGXDzw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 23:55:52 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so2825443pdi.11
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2014 20:55:52 -0700 (PDT)
In-Reply-To: <1405964152-17865-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>

On 07/21/2014 10:35 AM, Soren Brinkmann wrote:
> On platforms that do not power off during suspend, successfully entering
> suspend races with timers.
>
> The race happening in a couple of location is:
>
>   1. disable IRQs 	(e.g. arch_suspend_disable_irqs())
>      ...
>   2. syscore_suspend()
>         -> tick_suspend() 	(timers are turned off here)
>      ...
>   3. wfi		(wait for wake-IRQ here)
>
> Between steps 1 and 2 the timers can still generate interrupts that are
> not handled and stay pending until step 3. That pending IRQ causes an
> immediate - spurious - wake.
>
> The solution is to remove the timekeeping suspend/resume functions from
> the syscore functions and explictly call them at the appropriate time in
> the suspend/hibernation patchs. I.e. timers are suspend _before_ IRQs
> get disabled. And accordingly in the resume path.

So.. I sort of follow this, though from the description disabling
timekeeping to turn off timers seems a little indirect (I do see that
suspending timekeeping calls clockevents_suspend() which is the key
part). Maybe this could be clarified in a future version of the patch
description?

I worry that moving timekeeping_suspend earlier in the suspend process
might cause problems where things access time in the suspend path. I
recall these orderings have been problematic in the past, and slightly
tweaking them can often destabilize things badly.

I wonder if it would be better just to move the clockevent_suspend()
call to the earlier site, that way timers are halted but timekeeping
continues until its normal suspend point.

thanks
-john

