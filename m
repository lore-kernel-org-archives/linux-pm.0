From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in next with use printk_safe buffers in printk
Date: Wed, 15 Feb 2017 10:01:58 -0800
Message-ID: <20170215180158.GO21809@atomide.com>
References: <20170213185956.GM3897@atomide.com>
 <20170214160140.GA401@tigerII.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:35300 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750719AbdBOSCE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Feb 2017 13:02:04 -0500
Content-Disposition: inline
In-Reply-To: <20170214160140.GA401@tigerII.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Russell King <rmk@armlinux.org.uk>

Hi,

* Sergey Senozhatsky <sergey.senozhatsky@gmail.com> [170214 08:03]:
> Hello,
> 
> Cc Rafael, just in case

Found another issue on booting ARM devices, so adding Russell too.

> On (02/13/17 10:59), Tony Lindgren wrote:
> > Looks like commit f975237b7682 ("printk: use printk_safe buffers in
> > printk") causes "possible circular locking dependency detected " for
> > me on the first suspend.
> 
> thanks for the report.
> 
> > Reverting the following four patches in next makes it go away:
> > 
> > d9c23523ed98 ("printk: drop call_console_drivers() unused param")
> > de6fcbdb68b2 ("printk: convert the rest to printk-safe")
> > 8b1742c9c207 ("printk: remove zap_locks() function")
> > f975237b7682 ("printk: use printk_safe buffers in printk")
> 
> 
> these patches basically just enable locked where it previously was
> forcibly turned off. no timekeeping/pm/sched/etc code was modified.

Below is another issue I noticed caused by commit f975237b7682 that
I noticed during booting.

Regards,

Tony

8< --------------------------
[    2.581939] hw-breakpoint: Failed to enable monitor mode on CPU 0.
[    2.591613] hw-breakpoint: CPU 0 failed to disable vector catch
[    2.597686]
[    2.597717] ===============================
[    2.597717] [ ERR: suspicious RCU usage.  ]
[    2.597717] 4.10.0-rc8-next-20170215+ #119 Not tainted
[    2.597717] -------------------------------
[    2.597717] ./include/trace/events/printk.h:32 suspicious rcu_dereference_check() usage!
[    2.597717]
[    2.597717] other info that might help us debug this:
[    2.597717]
[    2.597717]
[    2.597717] RCU used illegally from idle CPU!
[    2.597717] rcu_scheduler_active = 2, debug_locks = 0
[    2.597747] RCU used illegally from extended quiescent state!
[    2.597747] 2 locks held by swapper/0/0:
[    2.597747]  #0:  (cpu_pm_notifier_lock){......}, at: [<c0237e2c>] cpu_pm_exit+0x10/0x54
[    2.597747]  #1:  (console_lock){+.+.+.}, at: [<c01ab350>] vprintk_emit+0x264/0x474
[    2.597747]
[    2.597747] stack backtrace:
[    2.597778] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.10.0-rc8-next-20170215+ #119
[    2.597778] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    2.597778] [<c0110228>] (unwind_backtrace) from [<c010c224>] (show_stack+0x10/0x14)
[    2.597778] [<c010c224>] (show_stack) from [<c04ca8a0>] (dump_stack+0xac/0xe0)
[    2.597778] [<c04ca8a0>] (dump_stack) from [<c01ab084>] (console_unlock+0x5e8/0x650)
[    2.597778] [<c01ab084>] (console_unlock) from [<c01ab35c>] (vprintk_emit+0x270/0x474)
[    2.597778] [<c01ab35c>] (vprintk_emit) from [<c01ab6f0>] (vprintk_default+0x20/0x28)
[    2.597808] [<c01ab6f0>] (vprintk_default) from [<c0250c94>] (printk+0x20/0x30)
[    2.597808] [<c0250c94>] (printk) from [<c0111004>] (reset_ctrl_regs+0x108/0x288)
[    2.597808] [<c0111004>] (reset_ctrl_regs) from [<c0111220>] (dbg_cpu_pm_notify+0x28/0x30)
[    2.597808] [<c0111220>] (dbg_cpu_pm_notify) from [<c015f3ac>] (notifier_call_chain+0x44/0x80)
[    2.597808] [<c015f3ac>] (notifier_call_chain) from [<c0237e48>] (cpu_pm_exit+0x2c/0x54)
[    2.597808] [<c0237e48>] (cpu_pm_exit) from [<c0126ca0>] (omap_enter_idle_coupled+0x80/0x208)
[    2.597808] [<c0126ca0>] (omap_enter_idle_coupled) from [<c0680d80>] (cpuidle_enter_state+0x118/0x4ac)
[    2.597808] [<c0680d80>] (cpuidle_enter_state) from [<c0682e54>] (cpuidle_enter_state_coupled+0x3a8/0x40c)
[    2.597839] [<c0682e54>] (cpuidle_enter_state_coupled) from [<c0190c04>] (do_idle+0x1a4/0x218)
[    2.597839] [<c0190c04>] (do_idle) from [<c0190ffc>] (cpu_startup_entry+0x18/0x1c)
[    2.597839] [<c0190ffc>] (cpu_startup_entry) from [<c0c00c40>] (start_kernel+0x35c/0x3d4)
[    2.597839] [<c0c00c40>] (start_kernel) from [<8000807c>] (0x8000807c)
