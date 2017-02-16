From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: Regression in next with use printk_safe buffers in printk
Date: Thu, 16 Feb 2017 10:31:09 +0900
Message-ID: <20170216013109.GA772@jagdpanzerIV.localdomain>
References: <20170213185956.GM3897@atomide.com>
 <20170214160140.GA401@tigerII.localdomain>
 <20170215180158.GO21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33953 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdBPBau (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Feb 2017 20:30:50 -0500
Content-Disposition: inline
In-Reply-To: <20170215180158.GO21809@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Russell King <rmk@armlinux.org.uk>

On (02/15/17 10:01), Tony Lindgren wrote:
[..]
> Below is another issue I noticed caused by commit f975237b7682 that
> I noticed during booting.

do you mean that with f975237b7682 you _always_ see that illegal RCU
usage warning?


> 8< --------------------------
> [    2.581939] hw-breakpoint: Failed to enable monitor mode on CPU 0.
> [    2.591613] hw-breakpoint: CPU 0 failed to disable vector catch
> [    2.597686]
> [    2.597717] ===============================
> [    2.597717] [ ERR: suspicious RCU usage.  ]
> [    2.597717] 4.10.0-rc8-next-20170215+ #119 Not tainted
> [    2.597717] -------------------------------
> [    2.597717] ./include/trace/events/printk.h:32 suspicious rcu_dereference_check() usage!

so this is trace_console(text, len) from

	cpuidle_enter_state()
	...
		vprintk_emit()		<< error: Failed to enable monitor mode/CPU 0 failed to disable...
		  console_unlock()
		    call_console_drivers()
		      trace_console()


> [    2.597717]
> [    2.597717] other info that might help us debug this:
> [    2.597717]
> [    2.597717]
> [    2.597717] RCU used illegally from idle CPU!

um... is this what rcuidle() for?


---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7180088cbb23..34da86e73d00 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1563,7 +1563,7 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 {
 	struct console *con;
 
-	trace_console(text, len);
+	trace_console_rcuidle(text, len);
 
 	if (!console_drivers)
 		return;

---


I need to look more at this.

	-ss

> [    2.597717] rcu_scheduler_active = 2, debug_locks = 0
> [    2.597747] RCU used illegally from extended quiescent state!


> [    2.597747] 2 locks held by swapper/0/0:
> [    2.597747]  #0:  (cpu_pm_notifier_lock){......}, at: [<c0237e2c>] cpu_pm_exit+0x10/0x54
> [    2.597747]  #1:  (console_lock){+.+.+.}, at: [<c01ab350>] vprintk_emit+0x264/0x474
> [    2.597747]
> [    2.597747] stack backtrace:
> [    2.597778] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.10.0-rc8-next-20170215+ #119
> [    2.597778] Hardware name: Generic OMAP4 (Flattened Device Tree)
> [    2.597778] [<c0110228>] (unwind_backtrace) from [<c010c224>] (show_stack+0x10/0x14)
> [    2.597778] [<c010c224>] (show_stack) from [<c04ca8a0>] (dump_stack+0xac/0xe0)
> [    2.597778] [<c04ca8a0>] (dump_stack) from [<c01ab084>] (console_unlock+0x5e8/0x650)
> [    2.597778] [<c01ab084>] (console_unlock) from [<c01ab35c>] (vprintk_emit+0x270/0x474)
> [    2.597778] [<c01ab35c>] (vprintk_emit) from [<c01ab6f0>] (vprintk_default+0x20/0x28)
> [    2.597808] [<c01ab6f0>] (vprintk_default) from [<c0250c94>] (printk+0x20/0x30)
> [    2.597808] [<c0250c94>] (printk) from [<c0111004>] (reset_ctrl_regs+0x108/0x288)
> [    2.597808] [<c0111004>] (reset_ctrl_regs) from [<c0111220>] (dbg_cpu_pm_notify+0x28/0x30)
> [    2.597808] [<c0111220>] (dbg_cpu_pm_notify) from [<c015f3ac>] (notifier_call_chain+0x44/0x80)
> [    2.597808] [<c015f3ac>] (notifier_call_chain) from [<c0237e48>] (cpu_pm_exit+0x2c/0x54)
> [    2.597808] [<c0237e48>] (cpu_pm_exit) from [<c0126ca0>] (omap_enter_idle_coupled+0x80/0x208)
> [    2.597808] [<c0126ca0>] (omap_enter_idle_coupled) from [<c0680d80>] (cpuidle_enter_state+0x118/0x4ac)
> [    2.597808] [<c0680d80>] (cpuidle_enter_state) from [<c0682e54>] (cpuidle_enter_state_coupled+0x3a8/0x40c)
> [    2.597839] [<c0682e54>] (cpuidle_enter_state_coupled) from [<c0190c04>] (do_idle+0x1a4/0x218)
> [    2.597839] [<c0190c04>] (do_idle) from [<c0190ffc>] (cpu_startup_entry+0x18/0x1c)
> [    2.597839] [<c0190ffc>] (cpu_startup_entry) from [<c0c00c40>] (start_kernel+0x35c/0x3d4)
> [    2.597839] [<c0c00c40>] (start_kernel) from [<8000807c>] (0x8000807c)
