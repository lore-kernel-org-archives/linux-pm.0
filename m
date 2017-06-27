From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for 4.12] Revert "pinctrl: rockchip: avoid hardirq-unsafe
 functions in irq_chip"
Date: Tue, 27 Jun 2017 10:23:09 -0700
Message-ID: <20170627172306.GA91202@google.com>
References: <20170517225634.GA11404@google.com>
 <20170527021900.GA119873@google.com>
 <20170623205911.GA143883@google.com>
 <alpine.DEB.2.20.1706232353220.2234@nanos>
 <20170627000622.GA63039@google.com>
 <alpine.DEB.2.20.1706271357520.1798@nanos>
 <alpine.DEB.2.20.1706271504521.1798@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33443 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbdF0RXN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 13:23:13 -0400
Received: by mail-pg0-f49.google.com with SMTP id f127so18807722pgc.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2017 10:23:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1706271504521.1798@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>, "David.Wu" <david.wu@rock-chips.com>, =?utf-8?B?J+m7hOa2myc=?= <huangtao@rock-chips.com>

Hi Linus,

I'm not sure I follow all of Thomas's suggestions on what should be done
in the future yet, but I agree that can be done in parallel:

On Tue, Jun 27, 2017 at 03:06:26PM +0200, Thomas Gleixner wrote:
> On Tue, 27 Jun 2017, Thomas Gleixner wrote:
> > That aside, looking at the commit which caused this discussion:
> > 
> > 88bb94216f59e pinctrl: rockchip: avoid hardirq-unsafe functions in irq_chip
> > 
> > I assume (the changelog lacks details) that the patch want's to avoid a
> > might sleep splat from the irq callbacks caused by the regmap spinlock,
> > which gets converted into a sleeping lock on RT. It does this by abusing
> > the irq_bus_lock() mechanism, which is wrong to begin with.
> > 
> > The only irq chip function which uses the regmap magic is the
> > irq_set_type() callback. Now, I have a hard time to understand (though I'm
> > no regmap/pinctrl expert) why that regmap stuff needs to be called in the
> > first place. The level and the polarity are programmed via:
> > 
> >         writel_relaxed(level, gc->reg_base + GPIO_INTTYPE_LEVEL);
> >         writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);
> > 
> > Why needs the regmap machinery to be invoked there? The GPIO is already
> > muxed and configured as interrupt, otherwise none of the irq functions
> > could be invoked. Hmm?
> 
> That said, the commit should be reverted and the issue needs to analyzed
> proper. We still need the RCU -> SCRU conversion, but that's a different
> problem.

Can we consider this an "ack" for the $subject then? Heiko also gave his
approval. How can this get merged? It's running a bit late for 4.12,
though it really shouldn't be risky (at least for non-RT stuff that was
working warning-free already in 4.11), but a 4.13-rc1 with -stable tag
could work as well.

I suppose I didn't put a proper 'Fixes' tag (though it should be obvious
from the commit message), so here goes:

Fixes: 88bb94216f59 ("pinctrl: rockchip: avoid hardirq-unsafe functions in irq_chip")

Regards,
Brian
