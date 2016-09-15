From: Tony Lindgren <tony@atomide.com>
Subject: Re: Power driver patches to avoid lockdep complaints
Date: Thu, 15 Sep 2016 14:45:27 -0700
Message-ID: <20160915214526.bxiqp6lkgkkfnpwi@atomide.com>
References: <20160615211344.GA31850@linux.vnet.ibm.com>
 <20160823004549.b66jru7ogyfifunf@atomide.com>
 <20160823005917.GY3482@linux.vnet.ibm.com>
 <3368049.VBoKnTMGvK@vostro.rjw.lan>
 <20160823101600.GA3482@linux.vnet.ibm.com>
 <20160915194129.tq65ieriuo6a3yrf@atomide.com>
 <20160915195240.7lxrrf2s2fkgavwn@atomide.com>
 <CAJZ5v0hMywg5r56=dGA=LcsiUj92gp0ut=Mou55SUBWZBXd6GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42477 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753951AbcIOVpb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Sep 2016 17:45:31 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hMywg5r56=dGA=LcsiUj92gp0ut=Mou55SUBWZBXd6GA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Guenter Roeck <linux@roeck-us.net>, Steven Rostedt <rostedt@goodmis.org>, Linux PM <linux-pm@vger.kernel.org>

* Rafael J. Wysocki <rafael@kernel.org> [160915 13:41]:
> On Thu, Sep 15, 2016 at 9:52 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Tony Lindgren <tony@atomide.com> [160915 12:41]:
> >> Rafael, I'm still not seeing these applied, care to check?
> >
> > Sorry looks like only one of the three fixes is missing from
> > current mainline:
> >
> > 13e698e68f75 ("power: Use _rcuidle for suspend/resume tracepoints")
> >
> > So I'm still getting warning out of box with omap2plus_defconfig.
> 
> It's not been applied, because I was unaware of it.

OK well good thing I bugged you then :)

> Care to send it to me as a patch?

Below produced with git show --pretty=email 13e698e68f75.

Regards,

Tony

8< ------------------------
>From 13e698e68f75708c45241a2dad23cd6b65181056 Mon Sep 17 00:00:00 2001
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Tue, 26 Apr 2016 10:42:25 -0700
Subject: [PATCH] power: Use _rcuidle for suspend/resume tracepoints

Further testing with false negatives suppressed by commit 293e2421fe25
("rcu: Remove superfluous versions of rcu_read_lock_sched_held()")
identified a few more unprotected uses of RCU from the idle loop.
Because RCU actively ignores idle-loop code (for energy-efficiency
reasons, among other things), using RCU from the idle loop can result
in too-short grace periods, in turn resulting in arbitrary misbehavior.

The affected function is rpm_suspend().

The resulting lockdep-RCU splat is as follows:

------------------------------------------------------------------------

Warning from omap3
===============================
[ INFO: suspicious RCU usage. ]
4.6.0-rc5-next-20160426+ #1112 Not tainted
-------------------------------
include/trace/events/rpm.h:63 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

RCU used illegally from idle CPU!
rcu_scheduler_active = 1, debug_locks = 0
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0:  (&(&dev->power.lock)->rlock){-.-...}, at: [<c052ee24>] __pm_runtime_suspend+0x54/0x84

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1112
Hardware name: Generic OMAP36xx (Flattened Device Tree)
[<c0110308>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
[<c010c3a8>] (show_stack) from [<c047fec8>] (dump_stack+0xb0/0xe4)
[<c047fec8>] (dump_stack) from [<c052d7b4>] (rpm_suspend+0x604/0x7e4)
[<c052d7b4>] (rpm_suspend) from [<c052ee34>] (__pm_runtime_suspend+0x64/0x84)
[<c052ee34>] (__pm_runtime_suspend) from [<c04bf3bc>] (omap2_gpio_prepare_for_idle+0x5c/0x70)
[<c04bf3bc>] (omap2_gpio_prepare_for_idle) from [<c01255e8>] (omap_sram_idle+0x140/0x244)
[<c01255e8>] (omap_sram_idle) from [<c0126b48>] (omap3_enter_idle_bm+0xfc/0x1ec)
[<c0126b48>] (omap3_enter_idle_bm) from [<c0601db8>] (cpuidle_enter_state+0x80/0x3d4)
[<c0601db8>] (cpuidle_enter_state) from [<c0183c74>] (cpu_startup_entry+0x198/0x3a0)
[<c0183c74>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
[<c0b00c0c>] (start_kernel) from [<8000807c>] (0x8000807c)

------------------------------------------------------------------------

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: <linux-omap@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-pm@vger.kernel.org>

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index fd553d0..15b6d5b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -419,7 +419,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	struct device *parent = NULL;
 	int retval;
 
-	trace_rpm_suspend(dev, rpmflags);
+	trace_rpm_suspend_rcuidle(dev, rpmflags);
 
  repeat:
 	retval = rpm_check_suspend_allowed(dev);
@@ -549,7 +549,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	}
 
  out:
-	trace_rpm_return_int(dev, _THIS_IP_, retval);
+	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
 
 	return retval;
 
