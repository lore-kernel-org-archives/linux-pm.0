From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH for 4.12] Revert "pinctrl: rockchip: avoid hardirq-unsafe
 functions in irq_chip"
Date: Sat, 24 Jun 2017 00:12:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706232353220.2234@nanos>
References: <20170517225634.GA11404@google.com> <20170527021900.GA119873@google.com> <20170623205911.GA143883@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170623205911.GA143883@google.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 23 Jun 2017, Brian Norris wrote:
  
> This reverts commit 88bb94216f59e10802aaf78c858a4146085faf18.
> 
> It introduced a new CONFIG_DEBUG_ATOMIC_SLEEP warning in v4.12-rc1:
> 
> [ 7226.716713] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
> [ 7226.716716] in_atomic(): 0, irqs_disabled(): 0, pid: 1708, name: bash
> [ 7226.716722] CPU: 1 PID: 1708 Comm: bash Not tainted 4.12.0-rc6+ #1213
> [ 7226.716724] Hardware name: Google Kevin (DT)
> [ 7226.716726] Call trace:
> [ 7226.716738] [<ffffff8008089928>] dump_backtrace+0x0/0x24c
> [ 7226.716743] [<ffffff8008089b94>] show_stack+0x20/0x28
> [ 7226.716749] [<ffffff8008371370>] dump_stack+0x90/0xb0
> [ 7226.716755] [<ffffff80080cd2a0>] ___might_sleep+0x10c/0x124
> [ 7226.716760] [<ffffff80080cd330>] __might_sleep+0x78/0x88
> [ 7226.716765] [<ffffff800879e210>] mutex_lock+0x2c/0x64
> [ 7226.716771] [<ffffff80083ad678>] rockchip_irq_bus_lock+0x30/0x3c
> [ 7226.716777] [<ffffff80080f6d40>] __irq_get_desc_lock+0x78/0x98
> [ 7226.716782] [<ffffff80080f7e6c>] irq_set_irq_wake+0x44/0x12c
> [ 7226.716787] [<ffffff8008486e18>] dev_pm_arm_wake_irq+0x4c/0x58
> [ 7226.716792] [<ffffff800848b80c>] device_wakeup_arm_wake_irqs+0x3c/0x58
> [ 7226.716796] [<ffffff80084896fc>] dpm_suspend_noirq+0xf8/0x3a0
> [ 7226.716800] [<ffffff80080f1384>] suspend_devices_and_enter+0x1a4/0x9a8
> [ 7226.716803] [<ffffff80080f21ec>] pm_suspend+0x664/0x6a4
> [ 7226.716807] [<ffffff80080f04d8>] state_store+0xd4/0xf8
> ...
> 
> It was reported on -rc1, and it's still not fixed in -rc6, so it should
> just be reverted.
> 
> + Thomas, in case he has thoughts

+ Peter and Paul, Tony
 
> Subject was "[4.12 REGRESSION] pinctrl: rockchip: sleeping function
> called from atomic context"
> 
> On Fri, May 26, 2017 at 07:19:00PM -0700, Brian Norris wrote:
> > Any thoughts? Revert the offending patch? I can spend a little more time
> > next week trying to debug what's actually going on if needed.
> > 
> > On Wed, May 17, 2017 at 03:56:34PM -0700, Brian Norris wrote:
> 
> > > The thing is, the documentation (and apparent design) suggest that
> > > calling sleeping functions from ->irq_bus_lock() is perfectly valid. I'm
> > > not 100% following the ___might_sleep() logic, but is this complaining
> > > because of the RCU read locking in device_wakeup_arm_wake_irqs()? I have
> > > CONFIG_PREEMPT_RCU and CONFIG_PREEMPT enabled, FWIW.

Sigh, The real wreckage happened in commit:

commit 4990d4fe327b9d9a7a3be7103a82699406fdde69
Author: Tony Lindgren <tony@atomide.com>
Date:   Mon May 18 15:40:29 2015 -0700

    PM / Wakeirq: Add automated device wake IRQ handling

which added that RCU locking stuff and thereby broke the long existing
bus_lock() facility of the interrupt core.

irq_bus_lock/unlock was explicitely made to allow sleeping locks for
interrupt chips which hang behind slow busses like i2c or spi. It took us
quite some effort to get this done and that patch broke it permanently.

I'm not sure what to do here. This is an ever recurring issue simply
because RT requires that sleeping locks can be taken inside rcu locked
regions. So sooner than later we need a resoilution for that problem.

Thanks,

	tglx


