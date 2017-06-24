From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH for 4.12] Revert "pinctrl: rockchip: avoid hardirq-unsafe
 functions in irq_chip"
Date: Sat, 24 Jun 2017 11:21:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706241120360.1941@nanos>
References: <20170517225634.GA11404@google.com> <20170527021900.GA119873@google.com> <20170623205911.GA143883@google.com> <alpine.DEB.2.20.1706232353220.2234@nanos> <20170623224049.GP3721@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35427 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdFXJVv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2017 05:21:51 -0400
In-Reply-To: <20170623224049.GP3721@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>

On Fri, 23 Jun 2017, Paul E. McKenney wrote:
> On Sat, Jun 24, 2017 at 12:12:49AM +0200, Thomas Gleixner wrote:
> > which added that RCU locking stuff and thereby broke the long existing
> > bus_lock() facility of the interrupt core.
> > 
> > irq_bus_lock/unlock was explicitely made to allow sleeping locks for
> > interrupt chips which hang behind slow busses like i2c or spi. It took us
> > quite some effort to get this done and that patch broke it permanently.
> > 
> > I'm not sure what to do here. This is an ever recurring issue simply
> > because RT requires that sleeping locks can be taken inside rcu locked
> > regions. So sooner than later we need a resoilution for that problem.
> 
> The usual advice would be for 4990d4fe327b ("PM / Wakeirq: Add automated
> device wake IRQ handling") to use SRCU rather than RCU.  Is there some
> reason that won't work?

I can't see one. So yes, we should rather convert that stuff to SRCU
instead of playing ping pong forever.

Thanks,

	tglx
