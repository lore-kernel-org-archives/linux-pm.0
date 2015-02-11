From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Wed, 11 Feb 2015 15:26:31 -0800
Message-ID: <20150211232631.GE11190@codeaurora.org>
References: <54D52F84.9050600@free.fr>
 <266c7b1ff2d1a8ba0ae4866f4fb4eca5@agner.ch>
 <54D576B1.4000001@free.fr>
 <54D903F6.3050608@codeaurora.org>
 <54D93556.9050008@free.fr>
 <54D93FFA.3090506@codeaurora.org>
 <54D947B4.4080401@free.fr>
 <54DB94B0.8020000@free.fr>
 <20150211184515.GB11190@codeaurora.org>
 <54DBD095.3040800@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48381 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbbBKX0e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 18:26:34 -0500
Content-Disposition: inline
In-Reply-To: <54DBD095.3040800@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Stefan Agner <stefan@agner.ch>, Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>

On 02/11, Mason wrote:
> 
> Looking at the difference between OF and !OF registration functions
> in smp_twd.c
> 
> !OF
>   if (twd_base || twd_evt) return -EBUSY;
>   assign twd_ppi and twd_base
>   twd_local_timer_common_register(NULL)
> 
> OF
>   if (!is_smp() || !setup_max_cpus) return; // TO BE DELETED
>   assign twd_ppi and twd_base
>   twd_local_timer_common_register(np)
> 
> I suppose OF guarantees that the init code is called only once?

It's called as many times as there's a match with the
corresponding CLOCKSOURCE_OF_DECLARE. In practice that's once.

> (Hence the !OF guard code would be unnecessary.)
> 

The other difference is that OF based registration needs to use
OF functions for irqs and ioremap whereas the non-OF code relies
on the irqs being provided before hand and the ioremap done
without OF functions.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
