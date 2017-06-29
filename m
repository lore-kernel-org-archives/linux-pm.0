From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH for 4.12] Revert "pinctrl: rockchip: avoid hardirq-unsafe
 functions in irq_chip"
Date: Thu, 29 Jun 2017 15:05:07 +0200
Message-ID: <CACRpkdbwTR24eo6RYVR3GmWT+aWKEAj3CpAqv45xQwbFyxb8mw@mail.gmail.com>
References: <20170517225634.GA11404@google.com> <20170527021900.GA119873@google.com>
 <20170623205911.GA143883@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170623205911.GA143883@google.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Thomas Gleixner <tglx@linutronix.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Julia Cartwright <julia@ni.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, John Keeping <john@metanate.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 23, 2017 at 10:59 PM, Brian Norris <briannorris@chromium.org> wrote:

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
> Cc: John Keeping <john@metanate.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Revert applied for fixes with Heiko's review tag after reading up
on the discussion.

What a mess, sigh. Thanks to everyone who is helping to fix this
up.

Yours,
Linus Walleij
