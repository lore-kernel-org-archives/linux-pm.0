From: Brian Norris <briannorris@chromium.org>
Subject: Re: [4.12 REGRESSION] pinctrl: rockchip: sleeping function called
 from atomic context
Date: Fri, 26 May 2017 19:19:01 -0700
Message-ID: <20170527021900.GA119873@google.com>
References: <20170517225634.GA11404@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170517225634.GA11404@google.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Any thoughts? Revert the offending patch? I can spend a little more time
next week trying to debug what's actually going on if needed.

Brian

On Wed, May 17, 2017 at 03:56:34PM -0700, Brian Norris wrote:
> Hi,
> 
> Looks like we've added a mutex in the ->bus_lock() callback for
> Rockchip's pinctrl irqchip, which triggers a CONFIG_DEBUG_ATOMIC_SLEEP
> warning when entering system suspend:
> 
> [  151.406483] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
> [  151.420321] in_atomic(): 0, irqs_disabled(): 0, pid: 2447, name: cat
> [  151.427457] CPU: 2 PID: 2447 Comm: cat Tainted: G        W     4.12.0-rc1+
> [  151.435922] Hardware name: Google Kevin (DT)
> [  151.440687] Call trace:
> [  151.443440] [<ffffff900808b2fc>] dump_backtrace+0x0/0x2b8
> [  151.449485] [<ffffff900808b5d4>] show_stack+0x20/0x28
> [  151.455137] [<ffffff900848f738>] dump_stack+0xa4/0xcc
> [  151.460797] [<ffffff90080e3118>] ___might_sleep+0x16c/0x188
> [  151.467036] [<ffffff90080e31f4>] __might_sleep+0xc0/0xd4
> [  151.472979] [<ffffff9008a70ca0>] mutex_lock+0x2c/0x68
> [  151.478637] [<ffffff90084e806c>] rockchip_irq_bus_lock+0x48/0x54
> [  151.485364] [<ffffff900811e3ac>] __irq_get_desc_lock+0x9c/0xc8
> [  151.491895] [<ffffff900811fa3c>] irq_set_irq_wake+0x44/0x178
> [  151.498235] [<ffffff900860d190>] dev_pm_arm_wake_irq+0x78/0x84
> [  151.504769] [<ffffff90086137bc>] device_wakeup_arm_wake_irqs+0x48/0x70
> [  151.512077] [<ffffff90086109c8>] dpm_suspend_noirq+0x180/0x51c
> [  151.518608] [<ffffff90081171a4>] suspend_devices_and_enter+0x1dc/0xde4
> [  151.525914] [<ffffff90081187a4>] pm_suspend+0x9f8/0xa38
> [...]
> 
> The warning goes away if I revert commit 88bb94216f59 ("pinctrl:
> rockchip: avoid hardirq-unsafe functions in irq_chip").
> 
> The thing is, the documentation (and apparent design) suggest that
> calling sleeping functions from ->irq_bus_lock() is perfectly valid. I'm
> not 100% following the ___might_sleep() logic, but is this complaining
> because of the RCU read locking in device_wakeup_arm_wake_irqs()? I have
> CONFIG_PREEMPT_RCU and CONFIG_PREEMPT enabled, FWIW.
> 
> Brian
