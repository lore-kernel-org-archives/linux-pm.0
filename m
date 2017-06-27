From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH for 4.12] Revert "pinctrl: rockchip: avoid hardirq-unsafe
 functions in irq_chip"
Date: Tue, 27 Jun 2017 15:01:32 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706271357520.1798@nanos>
References: <20170517225634.GA11404@google.com> <20170527021900.GA119873@google.com> <20170623205911.GA143883@google.com> <alpine.DEB.2.20.1706232353220.2234@nanos> <20170627000622.GA63039@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45846 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbdF0NCJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 09:02:09 -0400
In-Reply-To: <20170627000622.GA63039@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>, "David.Wu" <david.wu@rock-chips.com>, =?ISO-2022-JP?Q?'=1B$B2+Es=1B=28J'?= <huangtao@rock-chips.com>

On Mon, 26 Jun 2017, Brian Norris wrote:
> So I agree that the above commit was problematic, and that you have
> fixed that in your patch ("PM / wakeirq: Convert to SRCU"). But I
> noticed there were other threads where people have complained about the
> $subject patch also causing problems with drivers that call
> disable_irq_nosync() from within an IRQ context. So I poked around with
> one such driver that calls disable_irq_nosync() from its ISR [1], and
> saw this:
> 
> [   14.524945] Bluetooth: : OOB Wake-on-BT configured at IRQ 56
> [   14.531657] usbcore: registered new interface driver btusb
> [   18.973886] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
> [   18.987695] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
> [   18.995282] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.12.0-rc6+ #1233
> [   19.002669] Hardware name: Google Kevin (DT)
> [   19.007435] Call trace:
> [   19.010171] [<ffffff8008089928>] dump_backtrace+0x0/0x24c
> [   19.016202] [<ffffff8008089b94>] show_stack+0x20/0x28
> [   19.021846] [<ffffff8008371270>] dump_stack+0x90/0xb0
> [   19.027488] [<ffffff80080cd2a0>] ___might_sleep+0x10c/0x124
> [   19.033713] [<ffffff80080cd330>] __might_sleep+0x78/0x88
> [   19.039647] [<ffffff800879e248>] mutex_lock+0x2c/0x64
> [   19.045291] [<ffffff80083ad578>] rockchip_irq_bus_lock+0x30/0x3c
> [   19.052003] [<ffffff80080f6c68>] __irq_get_desc_lock+0x78/0x98
> [   19.058519] [<ffffff80080f8e90>] __disable_irq_nosync+0x38/0x80
> [   19.065132] [<ffffff80080f8ef8>] disable_irq_nosync+0x20/0x2c
> [   19.071555] [<ffffff8000a99f58>] btusb_oob_wake_handler+0x4c/0x68 [btusb]
> [   19.079140] [<ffffff80080f7428>] __handle_irq_event_percpu+0xf0/0x254
> [   19.086336] [<ffffff80080f75c4>] handle_irq_event_percpu+0x38/0x88
> [   19.093239] [<ffffff80080f7660>] handle_irq_event+0x4c/0x7c
> [   19.099464] [<ffffff80080fb5dc>] handle_level_irq+0xd0/0x108
> [   19.105785] [<ffffff80080f64e0>] generic_handle_irq+0x30/0x44
> [   19.112204] [<ffffff80083ad308>] rockchip_irq_demux+0xe8/0x190
> [   19.118720] [<ffffff80080f64e0>] generic_handle_irq+0x30/0x44
> [   19.125138] [<ffffff80080f6b88>] __handle_domain_irq+0x90/0xbc
> [   19.131652] [<ffffff8008080e98>] gic_handle_irq+0xe8/0x1b0
> 
> The documentation is fairly suggestive that ->irq_bus_lock() can sleep,
> but then it also suggests that disable_irq_nosync() is safe in IRQ
> context. So which is the "more true" one?

The function kerneldoc comment says:

* This function may be called from IRQ context. 

'May be called' is definitely different from 'is safe'.

So yes, there are issues with the interrupt controllers behind slow busses,
but OTOH, if you look at the complete picture:

    	  |-----------|
 [GPOI] - |           |
 [GPOI] - |           |
 [GPOI] - | I2C GPIO  |-----------------[ CPU IRQ ]
 [GPOI] - |           |
 [GPOI] - |           |-----------------[ I2C Controller ]
	  |-----------|

Then it's pretty obvious that you cannot access the I2C controller from the
hard interrupt context of the CPU IRQ. The wakeup machinery here needs to
mark the GPIO pin as wakeup irq and the underlying parent CPU irq as well.

So the CPU IRQ is what triggers the wakeup and that needs to be disabled
until the system comes back and the real stuff gets called when the
CPU interrupt is replayed.

Now the problem is that the CPU IRQ might be implemented as chained
interrupt. And chained interrupts are not playing well with all of this
because they evade all the normal interrupt handling mechanisms
completely. So in the wakeup case the CPU irq cannot be disabled by the
generic mechanisms, instead the chained handler is invoked, demuxes stuff
and you end up with a call into the slow irq chip.

As a side note: I recently converted the AMD pinctrl driver to use a
regular interrupt for demultiplexing because BIOS wreckaged machines
drowned in spurious interrupts and locked up hard because chained interrupt
handlers have no safety net whatsoever.

That aside, looking at the commit which caused this discussion:

88bb94216f59e pinctrl: rockchip: avoid hardirq-unsafe functions in irq_chip

I assume (the changelog lacks details) that the patch want's to avoid a
might sleep splat from the irq callbacks caused by the regmap spinlock,
which gets converted into a sleeping lock on RT. It does this by abusing
the irq_bus_lock() mechanism, which is wrong to begin with.

The only irq chip function which uses the regmap magic is the
irq_set_type() callback. Now, I have a hard time to understand (though I'm
no regmap/pinctrl expert) why that regmap stuff needs to be called in the
first place. The level and the polarity are programmed via:

        writel_relaxed(level, gc->reg_base + GPIO_INTTYPE_LEVEL);
        writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);

Why needs the regmap machinery to be invoked there? The GPIO is already
muxed and configured as interrupt, otherwise none of the irq functions
could be invoked. Hmm?

Thanks,

	tglx
