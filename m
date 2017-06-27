From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for 4.12] Revert "pinctrl: rockchip: avoid hardirq-unsafe
 functions in irq_chip"
Date: Mon, 26 Jun 2017 17:06:23 -0700
Message-ID: <20170627000622.GA63039@google.com>
References: <20170517225634.GA11404@google.com>
 <20170527021900.GA119873@google.com>
 <20170623205911.GA143883@google.com>
 <alpine.DEB.2.20.1706232353220.2234@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1706232353220.2234@nanos>
Sender: linux-gpio-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>, "David.Wu" <david.wu@rock-chips.com>, =?utf-8?B?J+m7hOa2myc=?= <huangtao@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Hi again Thomas,

On Sat, Jun 24, 2017 at 12:12:49AM +0200, Thomas Gleixner wrote:
> On Fri, 23 Jun 2017, Brian Norris wrote:
> > On Fri, May 26, 2017 at 07:19:00PM -0700, Brian Norris wrote:
> > > On Wed, May 17, 2017 at 03:56:34PM -0700, Brian Norris wrote:
> > 
> > > > The thing is, the documentation (and apparent design) suggest that
> > > > calling sleeping functions from ->irq_bus_lock() is perfectly valid. I'm
> > > > not 100% following the ___might_sleep() logic, but is this complaining
> > > > because of the RCU read locking in device_wakeup_arm_wake_irqs()? I have
> > > > CONFIG_PREEMPT_RCU and CONFIG_PREEMPT enabled, FWIW.
> 
> Sigh, The real wreckage happened in commit:
> 
> commit 4990d4fe327b9d9a7a3be7103a82699406fdde69
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Mon May 18 15:40:29 2015 -0700
> 
>     PM / Wakeirq: Add automated device wake IRQ handling
> 
> which added that RCU locking stuff and thereby broke the long existing
> bus_lock() facility of the interrupt core.

So I agree that the above commit was problematic, and that you have
fixed that in your patch ("PM / wakeirq: Convert to SRCU"). But I
noticed there were other threads where people have complained about the
$subject patch also causing problems with drivers that call
disable_irq_nosync() from within an IRQ context. So I poked around with
one such driver that calls disable_irq_nosync() from its ISR [1], and
saw this:

[   14.524945] Bluetooth: : OOB Wake-on-BT configured at IRQ 56
[   14.531657] usbcore: registered new interface driver btusb
[   18.973886] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
[   18.987695] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
[   18.995282] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.12.0-rc6+ #1233
[   19.002669] Hardware name: Google Kevin (DT)
[   19.007435] Call trace:
[   19.010171] [<ffffff8008089928>] dump_backtrace+0x0/0x24c
[   19.016202] [<ffffff8008089b94>] show_stack+0x20/0x28
[   19.021846] [<ffffff8008371270>] dump_stack+0x90/0xb0
[   19.027488] [<ffffff80080cd2a0>] ___might_sleep+0x10c/0x124
[   19.033713] [<ffffff80080cd330>] __might_sleep+0x78/0x88
[   19.039647] [<ffffff800879e248>] mutex_lock+0x2c/0x64
[   19.045291] [<ffffff80083ad578>] rockchip_irq_bus_lock+0x30/0x3c
[   19.052003] [<ffffff80080f6c68>] __irq_get_desc_lock+0x78/0x98
[   19.058519] [<ffffff80080f8e90>] __disable_irq_nosync+0x38/0x80
[   19.065132] [<ffffff80080f8ef8>] disable_irq_nosync+0x20/0x2c
[   19.071555] [<ffffff8000a99f58>] btusb_oob_wake_handler+0x4c/0x68 [btusb]
[   19.079140] [<ffffff80080f7428>] __handle_irq_event_percpu+0xf0/0x254
[   19.086336] [<ffffff80080f75c4>] handle_irq_event_percpu+0x38/0x88
[   19.093239] [<ffffff80080f7660>] handle_irq_event+0x4c/0x7c
[   19.099464] [<ffffff80080fb5dc>] handle_level_irq+0xd0/0x108
[   19.105785] [<ffffff80080f64e0>] generic_handle_irq+0x30/0x44
[   19.112204] [<ffffff80083ad308>] rockchip_irq_demux+0xe8/0x190
[   19.118720] [<ffffff80080f64e0>] generic_handle_irq+0x30/0x44
[   19.125138] [<ffffff80080f6b88>] __handle_domain_irq+0x90/0xbc
[   19.131652] [<ffffff8008080e98>] gic_handle_irq+0xe8/0x1b0

The documentation is fairly suggestive that ->irq_bus_lock() can sleep,
but then it also suggests that disable_irq_nosync() is safe in IRQ
context. So which is the "more true" one?

Brian

[1] Seem familiar? You were complaining about this driver previously.
    At least I didn't point you at an out-of-tree driver, where some of
    the other reports came from :)
