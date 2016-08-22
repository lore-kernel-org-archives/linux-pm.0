From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Power driver patches to avoid lockdep complaints
Date: Mon, 22 Aug 2016 10:43:03 -0700
Message-ID: <20160822174303.GG3482@linux.vnet.ibm.com>
References: <20160615211344.GA31850@linux.vnet.ibm.com>
 <1883021.VkIzpAuQoG@vostro.rjw.lan>
 <20160820142837.dqh3kmem4o3ca54t@atomide.com>
 <1585052.xToFB1dsV6@vostro.rjw.lan>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NqSa+Xr3J/G6Hhls"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752145AbcHVRm6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2016 13:42:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u7MHd8XT063674
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2016 13:42:57 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 24ybquth1r-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2016 13:42:57 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 22 Aug 2016 11:42:54 -0600
Content-Disposition: inline
In-Reply-To: <1585052.xToFB1dsV6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Lindgren <tony@atomide.com>, pavel@ucw.cz, linux@roeck-us.net, rostedt@goodmis.org, linux-pm@vger.kernel.org


--NqSa+Xr3J/G6Hhls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 22, 2016 at 07:34:57PM +0200, Rafael J. Wysocki wrote:
> On Saturday, August 20, 2016 07:28:37 AM Tony Lindgren wrote:
> > * Rafael J. Wysocki <rjw@rjwysocki.net> [160819 18:35]:
> > > On Thursday, August 18, 2016 03:51:52 PM Tony Lindgren wrote:
> > > > Hi,
> > > > 
> > > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160615 14:16]:
> > > > > Hello!
> > > > > 
> > > > > Ingo was not comfortable taking these through -tip, which is understandable,
> > > > > given that they don't depend on each other or on anything else not already
> > > > > in mainline, and that they don't have anything to do with -tip.
> > > > > 
> > > > > So what would you guys like to do with these?
> > > > > 
> > > > > They may be pulled from 13e698e68f75 (power: Use _rcuidle for
> > > > > suspend/resume tracepoints) in my -rcu tree:
> > > > > 
> > > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > > > 
> > > > 
> > > > Rafael, looks like commit 13e698e68f75 is still missing from the
> > > > mainline tree. Care to merge it to your fixes so I don't have to
> > > > keep looking at that splat on daily basis?
> > > 
> > > I could pull it if I knew where to pull it from.  The above gives me
> > > "Already up-to-date."
> > 
> > Here are the ones still missing:
> > 
> > $ git log --pretty=oneline v4.7-rc2..13e698e68f75
> > 13e698e68f75708c45241a2dad23cd6b65181056 power: Use _rcuidle for suspend/resume tracepoints
> > 320e2a2d081b6c519f80fca9377b8fb90db7bb9c power: Add _rcuidle suffix to allow rpm_resume() to be called from idle
> > b72aadb1d082d3935cbffd60e979238252045971 power: Add _rcuidle suffix to allow rpm_idle() use from idle
> > 
> > So maybe just git merge 13e698e68f75 if you have the linux-rcu.git
> > fetched and the above look OK to you?
> 
> If I do
> 
> $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> 
> and then
> 
> $ git show 13e698e68f75
> 
> then it tells me
> 
> fatal: ambiguous argument '13e698e68f75': unknown revision or path not in the working tree.
> 
> Do I need to fetch it in any special way or something?

Strange.  When I do "git show 13e698e68f75" in my local -rcu repo, I
get the following.  I get the same from my test repository that pulls
from kernel.org, and also when I "git clone" a fresh image of -rcu.

So maybe a fresh clone of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git?

I have added the other two commits as attachments, so feel free to apply
them from this email, if that works better for you.

							Thanx, Paul

------------------------------------------------------------------------

commit 13e698e68f75708c45241a2dad23cd6b65181056
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Apr 26 10:42:25 2016 -0700

    power: Use _rcuidle for suspend/resume tracepoints
    
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
index fd553d0cbb6b..15b6d5b199d4 100644
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
 

--NqSa+Xr3J/G6Hhls
Content-Type: text/plain; charset=us-ascii
Content-Description: diffs.320e2a2d081b6c519f80fca9377b8fb90db7bb9c
Content-Disposition: attachment; filename="diffs.320e2a2d081b6c519f80fca9377b8fb90db7bb9c"

commit 320e2a2d081b6c519f80fca9377b8fb90db7bb9c
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Apr 26 13:38:55 2016 -0700

    power: Add _rcuidle suffix to allow rpm_resume() to be called from idle
    
    This commit applies another _rcuidle suffix to fix an RCU use from
    idle.
    
    > ===============================
    > [ INFO: suspicious RCU usage. ]
    > 4.6.0-rc5-next-20160426+ #1122 Not tainted
    > -------------------------------
    > include/trace/events/rpm.h:69 suspicious rcu_dereference_check() usage!
    >
    > other info that might help us debug this:
    >
    >
    > RCU used illegally from idle CPU!
    > rcu_scheduler_active = 1, debug_locks = 0
    > RCU used illegally from extended quiescent state!
    > 1 lock held by swapper/0/0:
    >  #0:  (&(&dev->power.lock)->rlock){-.-...}, at: [<c052e3dc>] __pm_runtime_resume+0x3c/0x64
    >
    > stack backtrace:
    > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1122
    > Hardware name: Generic OMAP36xx (Flattened Device Tree)
    > [<c0110290>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
    > [<c010c3a8>] (show_stack) from [<c047fd68>] (dump_stack+0xb0/0xe4)
    > [<c047fd68>] (dump_stack) from [<c052e178>] (rpm_resume+0x5cc/0x7f4)
    > [<c052e178>] (rpm_resume) from [<c052e3ec>] (__pm_runtime_resume+0x4c/0x64)
    > [<c052e3ec>] (__pm_runtime_resume) from [<c04bf2c4>] (omap2_gpio_resume_after_idle+0x54/0x68)
    > [<c04bf2c4>] (omap2_gpio_resume_after_idle) from [<c01269dc>] (omap3_enter_idle_bm+0xfc/0x1ec)
    > [<c01269dc>] (omap3_enter_idle_bm) from [<c060198c>] (cpuidle_enter_state+0x80/0x3d4)
    > [<c060198c>] (cpuidle_enter_state) from [<c0183b08>] (cpu_startup_entry+0x198/0x3a0)
    > [<c0183b08>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
    > [<c0b00c0c>] (start_kernel) from [<8000807c>] (0x8000807c)
    
    Reported-by: Tony Lindgren <tony@atomide.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Tested-by: Tony Lindgren <tony@atomide.com>
    Tested-by: Guenter Roeck <linux@roeck-us.net>
    Cc: Russell King <linux@arm.linux.org.uk>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
    Cc: <linux-omap@vger.kernel.org>
    Cc: <linux-arm-kernel@lists.infradead.org>
    Cc: <linux-pm@vger.kernel.org>

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index da38ecf022f7..fd553d0cbb6b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -601,7 +601,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	struct device *parent = NULL;
 	int retval = 0;
 
-	trace_rpm_resume(dev, rpmflags);
+	trace_rpm_resume_rcuidle(dev, rpmflags);
 
  repeat:
 	if (dev->power.runtime_error)
@@ -764,7 +764,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 		spin_lock_irq(&dev->power.lock);
 	}
 
-	trace_rpm_return_int(dev, _THIS_IP_, retval);
+	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
 
 	return retval;
 }

--NqSa+Xr3J/G6Hhls
Content-Type: text/plain; charset=us-ascii
Content-Description: diffs.b72aadb1d082d3935cbffd60e979238252045971
Content-Disposition: attachment; filename="diffs.b72aadb1d082d3935cbffd60e979238252045971"

commit b72aadb1d082d3935cbffd60e979238252045971
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Apr 26 13:03:51 2016 -0700

    power: Add _rcuidle suffix to allow rpm_idle() use from idle
    
    This commit appends a few _rcuidle suffixes to fix the following
    RCU-used-from-idle bug:
    
    > ===============================
    > [ INFO: suspicious RCU usage. ]
    > 4.6.0-rc5-next-20160426+ #1116 Not tainted
    > -------------------------------
    > include/trace/events/rpm.h:95 suspicious rcu_dereference_check() usage!
    >
    > other info that might help us debug this:
    >
    >
    > RCU used illegally from idle CPU!
    > rcu_scheduler_active = 1, debug_locks = 0
    > RCU used illegally from extended quiescent state!
    > 1 lock held by swapper/0/0:
    >  #0:  (&(&dev->power.lock)->rlock){-.-...}, at: [<c052cc2c>] __rpm_callback+0x58/0x60
    >
    > stack backtrace:
    > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1116
    > Hardware name: Generic OMAP36xx (Flattened Device Tree)
    > [<c0110290>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
    > [<c010c3a8>] (show_stack) from [<c047fd68>] (dump_stack+0xb0/0xe4)
    > [<c047fd68>] (dump_stack) from [<c052d5d0>] (rpm_suspend+0x580/0x768)
    > [<c052d5d0>] (rpm_suspend) from [<c052ec58>] (__pm_runtime_suspend+0x64/0x84)
    > [<c052ec58>] (__pm_runtime_suspend) from [<c04bf25c>] (omap2_gpio_prepare_for_idle+0x5c/0x70)
    > [<c04bf25c>] (omap2_gpio_prepare_for_idle) from [<c0125568>] (omap_sram_idle+0x140/0x244)
    > [<c0125568>] (omap_sram_idle) from [<c01269dc>] (omap3_enter_idle_bm+0xfc/0x1ec)
    > [<c01269dc>] (omap3_enter_idle_bm) from [<c0601bdc>] (cpuidle_enter_state+0x80/0x3d4)
    > [<c0601bdc>] (cpuidle_enter_state) from [<c0183b08>] (cpu_startup_entry+0x198/0x3a0)
    > [<c0183b08>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
    > [<c0b00c0c>] (start_kernel) from [<8000807c>] (0x8000807c)
    
    In the immortal words of Steven Rostedt, "*Whack* *Whack* *Whack*!!!"
    
    Reported-by: Tony Lindgren <tony@atomide.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Tested-by: Tony Lindgren <tony@atomide.com>
    Tested-by: Guenter Roeck <linux@roeck-us.net>
    Cc: Russell King <linux@arm.linux.org.uk>
    WhACKED-by: Steven Rostedt <rostedt@goodmis.org>
    Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
    Cc: <linux-omap@vger.kernel.org>
    Cc: <linux-arm-kernel@lists.infradead.org>
    Cc: <linux-pm@vger.kernel.org>

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4c7055009bd6..da38ecf022f7 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -301,7 +301,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	int (*callback)(struct device *);
 	int retval;
 
-	trace_rpm_idle(dev, rpmflags);
+	trace_rpm_idle_rcuidle(dev, rpmflags);
 	retval = rpm_check_suspend_allowed(dev);
 	if (retval < 0)
 		;	/* Conditions are wrong. */
@@ -337,7 +337,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 			dev->power.request_pending = true;
 			queue_work(pm_wq, &dev->power.work);
 		}
-		trace_rpm_return_int(dev, _THIS_IP_, 0);
+		trace_rpm_return_int_rcuidle(dev, _THIS_IP_, 0);
 		return 0;
 	}
 
@@ -352,7 +352,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	wake_up_all(&dev->power.wait_queue);
 
  out:
-	trace_rpm_return_int(dev, _THIS_IP_, retval);
+	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
 	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
 }
 

--NqSa+Xr3J/G6Hhls--

