From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Wed, 20 Jan 2016 16:41:10 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601201634520.3575@nanos>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org> <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org> <alpine.DEB.2.11.1601081631380.3575@nanos> <569CE6F1.2090707@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60177 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbcATPmN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 10:42:13 -0500
In-Reply-To: <569CE6F1.2090707@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Mon, 18 Jan 2016, Daniel Lezcano wrote:
> On 01/08/2016 04:43 PM, Thomas Gleixner wrote:
> > The above is completely unprotected against interrupts being setup or even
> > freed concurrently.
> > 
> > Aside of that, you call that setup function in setup_irq for each action()
> > and
> > here you call it only for the first one.
> 
> I went through the different comments and almost finished the changes but I
> think the 'register_ops' approach, which happens after some irq were setup,
> introduces some useless complexity and because of the desc lock section, the
> ops can't do memory allocation.

You can't protect that with desc_lock. You need to take the sparse_irq_lock,
which is a mutex, to protect the irq desc walk.

> Before going further, I am wondering if declaring the irq_timings_ops
> statically (read without 'register_ops' - hence without a init time
> dependency) and calling the init/free ops from alloc_desc/free_desc wouldn't
> be cleaner and simpler.

Then you don't need those ops at all. You can make it simple function calls,
which get compiled out if that stuff is not enabled.

Thanks,

	tglx


