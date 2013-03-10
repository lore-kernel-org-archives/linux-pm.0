From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/4] time: dynamic irq affinity
Date: Sun, 10 Mar 2013 23:03:56 +0530
Message-ID: <513CC404.6000200@ti.com>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53461 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711Ab3CJRck (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 10 Mar 2013 13:32:40 -0400
In-Reply-To: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: john.stultz@linaro.org, tglx@linutronix.de, viresh.kumar@linaro.org, jacob.jun.pan@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, linus.walleij@stericsson.com

On Wednesday 27 February 2013 03:47 AM, Daniel Lezcano wrote:
> When a cpu goes to a deep idle state where its local timer is shutdown,
> it notifies the time framework to use the broadcast timer instead.
> 
> Unfortunately, the broadcast device could wake up any CPU, including an
> idle one which is not concerned by the wake up at all.
> 
> This implies, in the worst case, an idle CPU will wake up to send an IPI
> to another idle cpu.
> 
> This patch solves this by setting the irq affinity to the cpu concerned
> by the nearest timer event, by this way, the CPU which is wake up is
> guarantee to be the one concerned by the next event and we are safe with
> unnecessary wakeup for another idle CPU.
> 
> As the irq affinity is not supported by all the archs, a flag is needed
> to specify which clocksource can handle it.
> 
> Daniel Lezcano (3):
>   time : pass broadcast parameter
>   time : set broadcast irq affinity
>   ARM: nomadik: add dynamic irq flag to the timer
> 
> Viresh Kumar (1):
>   ARM: timer-sp: Set dynamic irq affinity
> 
Thanks Daniel for addressing the comments from earlier version. This
version looks good to me.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards,
Santosh
P.S: As I mentioned 'CLOCK_EVT_FEAT_DYNIRQ' optimization on
OMAP at least I found risky because you might end up missing
the asynchronous IPI wakeups because of the current SGI's
implementation. This must be true for other ARM platforms
as well.

