From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PM / wakeirq: Convert to SRCU
Date: Sat, 24 Jun 2017 14:30:10 +0200
Message-ID: <78880916.SxJZvEGYbI@aspire.rjw.lan>
References: <alpine.DEB.2.20.1706241153260.1941@nanos> <CAJZ5v0iU86mmcpm_U3u8Ee0c+F3Ym9wumezY8Mr7JZFi78Hkrg@mail.gmail.com> <alpine.DEB.2.20.1706241413060.1941@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1706241413060.1941@nanos>
Sender: linux-gpio-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, Linux PM <linux-pm@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, June 24, 2017 02:13:35 PM Thomas Gleixner wrote:
> On Sat, 24 Jun 2017, Rafael J. Wysocki wrote:
> > On Sat, Jun 24, 2017 at 11:56 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > The wakeirq infrastructure uses RCU to protect the list of wakeirqs. That
> > > breaks the irq bus locking infrastructure, which allows sleeping functions
> > > to be called so interrupt controllers behind slow busses, e.g. i2c, can be
> > > handled.
> > >
> > > The wakeirq functions hold rcu_read_lock and call into irq functions, which
> > > in case of interrupts using the irq bus locking will trigger a
> > > might_sleep() splat.
> > >
> > > Convert the wakeirq infrastructure to Sleepable RCU and unbreak it.
> > >
> > > Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ handling")
> > > Reported-by: Brian Norris <briannorris@chromium.org>
> > > Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: stable@vger.kernel.org
> > 
> > OK
> > 
> > I guess it would be good to get this into 4.12?
> 
> I think so, but it probably wants some testing and breeding in next.

Right.

So here's a deal: if there is an -rc8, I can push this to Linus before the
final 4.12, but otherwise it will go into 4.13-rc during the merge window.

The -stable link will still be there, so that shouldn't be a big issue.

Thanks,
Rafael

