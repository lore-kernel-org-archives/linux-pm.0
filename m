From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] kernel/SRCU: provide a static initializer
Date: Thu, 7 Jun 2018 00:32:52 -0700
Message-ID: <20180607073252.GD3593@linux.vnet.ibm.com>
References: <20180525101958.13277-1-bigeasy@linutronix.de>
 <20180525101958.13277-2-bigeasy@linutronix.de>
 <CAJZ5v0jEUR7YxzujvZn8WVK+dMxmOxoHNiLKcmgCq9awHR=vYg@mail.gmail.com>
 <20180529120443.GE3803@linux.vnet.ibm.com>
 <CAJZ5v0j_O=nL6Eym5GqGGDC8LPB5vu-YAp9DFfZSJsHd-TMEmg@mail.gmail.com>
 <20180529172611.GL3803@linux.vnet.ibm.com>
 <CAJZ5v0gYcFywNZh+-EHSmwU89AER=a8ouKtK93j=Lu4DSHUzNw@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gYcFywNZh+-EHSmwU89AER=a8ouKtK93j=Lu4DSHUzNw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, May 30, 2018 at 01:09:57PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 29, 2018 at 7:26 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Tue, May 29, 2018 at 07:14:49PM +0200, Rafael J. Wysocki wrote:
> >> On Tue, May 29, 2018 at 2:04 PM, Paul E. McKenney
> >> <paulmck@linux.vnet.ibm.com> wrote:
> >> > On Tue, May 29, 2018 at 10:09:51AM +0200, Rafael J. Wysocki wrote:
> >> >> On Fri, May 25, 2018 at 12:19 PM, Sebastian Andrzej Siewior
> >> >> <bigeasy@linutronix.de> wrote:
> >> >> > There are macros for static initializer for the three out of four
> >> >> > possible notifier types, that are:
> >> >> >         ATOMIC_NOTIFIER_HEAD()
> >> >> >         BLOCKING_NOTIFIER_HEAD()
> >> >> >         RAW_NOTIFIER_HEAD()
> >> >> >
> >> >> > This patch provides a static initilizer for the forth type to make it
> >> >> > complete.
> >> >> >
> >> >> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> >> >> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> >>
> >> >> I cannot apply this without an ACK from Paul.
> >> >
> >> > I have both queued, but if you would prefer to take them, then for the
> >> > SRCU piece:
> >> >
> >> > Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >> > Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >>
> >> Thanks!
> >>
> >> I'll route them along with the other cpufreq material then.
> >
> > Please let me know when you have them queued so that I can remove
> > them from -rcu.
> 
> I've just added them to my linux-next branch.

And I have removed them, thank you!

							Thanx, Paul
