From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2]  PM / wakeirq: Convert to SRCU
Date: Mon, 26 Jun 2017 03:15:57 -0700
Message-ID: <20170626101557.GV3730@atomide.com>
References: <alpine.DEB.2.20.1706241153260.1941@nanos>
 <20170624135320.GS3721@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1706251103320.1996@nanos>
 <20170625144559.GA3721@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1706251930220.2528@nanos>
 <20170625182926.GB3721@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170625182926.GB3721@linux.vnet.ibm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

* Paul E. McKenney <paulmck@linux.vnet.ibm.com> [170625 11:29]:
> On Sun, Jun 25, 2017 at 07:31:13PM +0200, Thomas Gleixner wrote:
> > The wakeirq infrastructure uses RCU to protect the list of wakeirqs. That
> > breaks the irq bus locking infrastructure, which is allows sleeping
> > functions to be called so interrupt controllers behind slow busses,
> > e.g. i2c, can be handled.
> > 
> > The wakeirq functions hold rcu_read_lock and call into irq functions, which
> > in case of interrupts using the irq bus locking will trigger a
> > might_sleep() splat.
> > 
> > Convert the wakeirq infrastructure to Sleepable RCU and unbreak it.
> > 
> > Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ handling")
> > Reported-by: Brian Norris <briannorris@chromium.org>
> > Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Looks good to me!
> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

And still works for me!

Tested-by: Tony Lindgren <tony@atomide.com>
