From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH RFC v2] PM / sleep: Fix racing timers
Date: Mon, 28 Jul 2014 12:19:22 -0700
Message-ID: <53D6A23A.6010904@codeaurora.org>
References: <53D083C5.2000501@linaro.org> <1406322408-15408-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:49667 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaG1TTX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jul 2014 15:19:23 -0400
In-Reply-To: <1406322408-15408-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>

On 07/25/14 14:06, Soren Brinkmann wrote:
> On platforms that do not power off during suspend, successfully entering
> suspend races with timers.
>
> The race happening in a couple of location is:
>
>   1. disable IRQs   		(e.g. arch_suspend_disable_irqs())
>      ...
>   2. syscore_suspend()
>       -> timekeeping_suspend()
>        -> clockevents_notify(SUSPEND)
>         -> tick_suspend()   	(timers are turned off here)
>      ...
>   3. wfi            		(wait for wake-IRQ here)
>
> Between steps 1 and 2 the timers can still generate interrupts that are
> not handled and stay pending until step 3. That pending IRQ causes an
> immediate - spurious - wake.
>
> The solution is to move the clockevents suspend/resume notification
> out of the syscore_suspend step and explictly call them at the appropriate
> time in the suspend/hibernation paths. I.e. timers are suspend _before_
> IRQs get disabled. And accordingly in the resume path.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Do we know which timer_list or hrtimer wants to run while entering
suspend? I'd suspect the scheduler tick but perhaps we just forgot to
cancel some timer during suspend?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

