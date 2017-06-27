From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH for 4.12] Revert "pinctrl: rockchip: avoid hardirq-unsafe
 functions in irq_chip"
Date: Tue, 27 Jun 2017 20:07:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706272006140.1890@nanos>
References: <20170517225634.GA11404@google.com> <20170527021900.GA119873@google.com> <20170623205911.GA143883@google.com> <alpine.DEB.2.20.1706232353220.2234@nanos> <20170627000622.GA63039@google.com> <alpine.DEB.2.20.1706271357520.1798@nanos>
 <alpine.DEB.2.20.1706271504521.1798@nanos> <20170627172306.GA91202@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47817 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdF0SHh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 14:07:37 -0400
In-Reply-To: <20170627172306.GA91202@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>, "David.Wu" <david.wu@rock-chips.com>, =?ISO-2022-JP?Q?'=1B$B2+Es=1B=28J'?= <huangtao@rock-chips.com>

On Tue, 27 Jun 2017, Brian Norris wrote:
> On Tue, Jun 27, 2017 at 03:06:26PM +0200, Thomas Gleixner wrote:
> > That said, the commit should be reverted and the issue needs to analyzed
> > proper. We still need the RCU -> SCRU conversion, but that's a different
> > problem.
> 
> Can we consider this an "ack" for the $subject then? Heiko also gave his
> approval. How can this get merged? It's running a bit late for 4.12,
> though it really shouldn't be risky (at least for non-RT stuff that was
> working warning-free already in 4.11), but a 4.13-rc1 with -stable tag
> could work as well.

Yes. That revert can go into 4.12 from my POV, but I leave that to Linus.

Thanks,

	tglx
