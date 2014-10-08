From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 3/4] irq: Allow multiple clients to register for irq
 affinity notification
Date: Wed, 8 Oct 2014 16:20:28 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1410081607510.4292@nanos>
References: <1409170479-29955-1-git-send-email-lina.iyer@linaro.org> <1409170479-29955-4-git-send-email-lina.iyer@linaro.org> <alpine.DEB.2.10.1408272239190.3323@nanos> <20140902184305.GB91995@ilina-mac.local> <alpine.DEB.2.10.1409022109050.3333@nanos>
 <7htx3vbfqr.fsf@deeprootsystems.com> <alpine.DEB.2.11.1409261129220.4567@nanos> <20140926094003.GL5182@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38080 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaJHOUk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Oct 2014 10:20:40 -0400
In-Reply-To: <20140926094003.GL5182@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@kernel.org>, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>, linux-arm-kernel@lists.infradead.org

On Fri, 26 Sep 2014, Russell King - ARM Linux wrote:
> On Fri, Sep 26, 2014 at 11:29:56AM +0200, Thomas Gleixner wrote:
> > On Thu, 25 Sep 2014, Kevin Hilman wrote:
> > > Maybe I'm missing something, or maybe we're just lucky and nobody uses
> > > them together, but irq_set_affinity_notifier() only allows a single
> > > notifier to be registered at any given time.  So if you had a system
> > 
> > A single notifier per irq .....
> 
> So what about two drivers wanting to use this notifier, but sharing an
> interrupt?
> 
> It sounds to me like this notifier was misdesigned from the very start,
> and it should always have supported multiple notifiers.

Well, it was designed for a particular usecase which does not require
multiple notifiers. And we wanted it as simple as possible.

So while we could make it take multiple notifiers, it's just wrong for
the use case in question. QoS wants a system wide overview and not a
gazillion notifiers with life time issues etc.

So the proper solution is a general notifier, which gets called if any
interrupt affinity changes. That allows the QoS code or any other
interested party to gain a coherent per CPU knowledge.

That also avoid the whole lifetime issues of notifiers on interrupts,
when they are teared down and the descriptor gets freed. Of course
such a teardown or a simple disable_irq should inform the QoS code as
well so it knows that the CPU is not longer targeted by this
interrupt. Nothing we want to whack into a per irq notifier, really.

Thoughts?

	tglx
