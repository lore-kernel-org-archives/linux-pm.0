From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4] time: dynamic irq affinity
Date: Wed, 27 Feb 2013 23:00:36 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302272243340.22263@ionos>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org> <512DA0EB.5000803@ti.com> <20130227104701.GZ17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60129 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab3B0WA6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Feb 2013 17:00:58 -0500
In-Reply-To: <20130227104701.GZ17833@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, john.stultz@linaro.org, viresh.kumar@linaro.org, jacob.jun.pan@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, linus.walleij@stericsson.com

On Wed, 27 Feb 2013, Russell King - ARM Linux wrote:

> On Wed, Feb 27, 2013 at 11:30:11AM +0530, Santosh Shilimkar wrote:
> > P.S: Time and again it proves that making the local timer wakeup
> > capable solves the issue.
> 
> Slightly different take: it proves that hardware people don't talk to
> software people about what they require to make an operating system
> work.  Hardware people think they understand that and go off and do
> their own thing, and expect software people to sort out their mess.
> 
> This happens all the time; there is no solution for it as long as
> companies view the creation of hardware as being entirely separate
> from software.

Amen!

We have seen the mess this kind of thinking creates on x86 already 10+
years ago and we are still suffering.

As I said before, I really can't understand that ARM and the ARM SoC
vendors insisted to repeat the same mistakes, which we kernel people
have proven to be fatal already. It's even worse: they asked me what
problems they should avoid before they went to implement them.

I can halfways understand the little kid who insists to burn his hand
on the hot oven instead of listening to parental advice, but this kind
of advisory resistance is either caused by abuse of secrect drugs or
by living in a disconnected universe or both.

Thanks,

	tglx
