From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: PM / wakeirq: Convert to SRCU
Date: Sun, 25 Jun 2017 07:45:59 -0700
Message-ID: <20170625144559.GA3721@linux.vnet.ibm.com>
References: <alpine.DEB.2.20.1706241153260.1941@nanos>
 <20170624135320.GS3721@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1706251103320.1996@nanos>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1706251103320.1996@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 25, 2017 at 11:11:57AM +0200, Thomas Gleixner wrote:
> On Sat, 24 Jun 2017, Paul E. McKenney wrote:
> > On Sat, Jun 24, 2017 at 11:56:11AM +0200, Thomas Gleixner wrote:
> > >  static DECLARE_WAIT_QUEUE_HEAD(wakeup_count_wait_queue);
> > > 
> > > +static struct srcu_struct wakeup_srcu;
> > 
> > I suggest this to avoid the need for boot-time init_srcu_struct():
> > 
> > DEFINE_STATIC_SRCU(wakeup_srcu);
> 
> Now I know why I had this nagging feeling, that should stay away from
> computers yesterday morning.....

Believe me, I know that feeling well!

> > >  static struct wakeup_source deleted_ws = {
> > >  	.name = "deleted",
> > >  	.lock =  __SPIN_LOCK_UNLOCKED(deleted_ws.lock),
> > > @@ -198,7 +200,7 @@ void wakeup_source_remove(struct wakeup_
> > >  	spin_lock_irqsave(&events_lock, flags);
> > >  	list_del_rcu(&ws->entry);
> > >  	spin_unlock_irqrestore(&events_lock, flags);
> > > -	synchronize_rcu();
> > > +	synchronize_srcu(&wakeup_srcu);
> > >  }
> > >  EXPORT_SYMBOL_GPL(wakeup_source_remove);
> > 
> > The uses of RCU in device_wakeup_arm_wake_irqs() and
> > device_wakeup_disarm_wake_irqs() are unrelated and thus do not
> > need to be converted?  Or am I looking at the wrong version of
> > the kernel?  (Looking at f65013d655ac ("Merge branch 'for-linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")
> > in Linus's tree.)
> 
> No, you are looking at the result of heat induced brain melt. Will send a
> proper one soon.

And if anything, I know that feeling even better.  Looking forward to
seeing the new patch.

							Thanx, Paul
