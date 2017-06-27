From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH for 4.12] Revert "pinctrl: rockchip: avoid hardirq-unsafe
 functions in irq_chip"
Date: Tue, 27 Jun 2017 15:06:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706271504521.1798@nanos>
References: <20170517225634.GA11404@google.com> <20170527021900.GA119873@google.com> <20170623205911.GA143883@google.com> <alpine.DEB.2.20.1706232353220.2234@nanos> <20170627000622.GA63039@google.com> <alpine.DEB.2.20.1706271357520.1798@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45870 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdF0NGf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 09:06:35 -0400
In-Reply-To: <alpine.DEB.2.20.1706271357520.1798@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>, "David.Wu" <david.wu@rock-chips.com>, =?ISO-2022-JP?Q?'=1B$B2+Es=1B=28J'?= <huangtao@rock-chips.com>

On Tue, 27 Jun 2017, Thomas Gleixner wrote:
> That aside, looking at the commit which caused this discussion:
> 
> 88bb94216f59e pinctrl: rockchip: avoid hardirq-unsafe functions in irq_chip
> 
> I assume (the changelog lacks details) that the patch want's to avoid a
> might sleep splat from the irq callbacks caused by the regmap spinlock,
> which gets converted into a sleeping lock on RT. It does this by abusing
> the irq_bus_lock() mechanism, which is wrong to begin with.
> 
> The only irq chip function which uses the regmap magic is the
> irq_set_type() callback. Now, I have a hard time to understand (though I'm
> no regmap/pinctrl expert) why that regmap stuff needs to be called in the
> first place. The level and the polarity are programmed via:
> 
>         writel_relaxed(level, gc->reg_base + GPIO_INTTYPE_LEVEL);
>         writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);
> 
> Why needs the regmap machinery to be invoked there? The GPIO is already
> muxed and configured as interrupt, otherwise none of the irq functions
> could be invoked. Hmm?

That said, the commit should be reverted and the issue needs to analyzed
proper. We still need the RCU -> SCRU conversion, but that's a different
problem.

Thanks,

	tglx
