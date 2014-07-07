From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 1/8] clk: add an APPLY_RATE_CHANGE notifier event during clk_set_rate()
Date: Mon,  7 Jul 2014 16:51:35 +0200
Message-ID: <1404744702-32010-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57775 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753455AbaGGOvr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jul 2014 10:51:47 -0400
In-Reply-To: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The current clk_set_rate() logic allows notifiers to be notified of
three different events:

 * PRE_RATE_CHANGE: before the clock driver ->set_rate() function is
   called.
 * ABORT_RATE_CHANGE: called if the rate change failed
 * POST_RATE_CHANGE: called after the rate change has been
   successfully done, but after ->recalc_rate() has been called, and
   only if the rate of the clock has actually changed.

This commit adds an additional APPLY_RATE_CHANGE, which we require on
Armada XP to implement dynamic frequency scaling of the CPU
clocks. The problem is as follows.

On Armada XP, there are three hardware blocks involved in the dynamic
frequency scaling of the CPU clocks:

 - The CPU clocks hardware block itself, whose registers are already
   "managed" by drivers/clk/mvebu/clk-cpu.c (compatible string:
   marvell,armada-xp-cpu-clock). The driver currently only supports
   changing the rate of the CPU clock when the clock is off (i.e
   before we boot the secondary CPUs).

 - The PMU DFS registers, which are used to configure the target
   frequency for a dynamic rate change. Those registers are relatively
   well isolated from other PMU registers, so they can also be
   "managed" by the drivers/clk/mvebu/clk-cpu.c.

 - The PMSU registers, which are used to actually trigger the dynamic
   frequency change procedure, which consists in programming a bunch
   of PMSU registers, entering the idle state on the CPU we want to
   change the frequency, and then again reprogram a bunch of PMSU
   registers.

The procedure to change the frequency is:

 1/ Reset some clocks using the CPU clocks hardware block.
 2/ Define the target frequency using the PMU DFS registers.
 3/ Do the actual frequency change using the PMSU registers.

However, the PMSU registers are already "managed" by a driver in
arch/arm/mach-mvebu/pmsu.c, and the code there is needed for a wide
variety of power management activities: booting of secondary CPUs, CPU
hotplug, cpuidle, cpufreq, and soon suspend/resume. The same registers
in the PMSU are used for several of those activities.

So, what we need to do is to have steps (1) and (2) above done in the
CPU clocks driver, and then step (3) done through a clk notifier.

However, the current POST_RATE_CHANGE notifier is called too late
(after ->recalc_rate) and only if the rate has changed. So it works
fine for a pure notification of a frequency change, but it doesn't
work if the notified code is actually involved in the frequency
change, which is exactly the case we have here. Until the sequence
that uses the PMSU registers has been executed, the rate of the CPU
clock has not changed.

In order to solve this problem, we propose to add an APPLY_RATE_CHANGE
notifier event, which gets called right after ->set_rate(), but before
->recalc_rate(), and therefore regardless of whether there was an
actualy frequency change or not.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/clk.c   | 3 +++
 include/linux/clk.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8b73ede..afa559b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1525,6 +1525,9 @@ static void clk_change_rate(struct clk *clk)
 	if (!skip_set_rate && clk->ops->set_rate)
 		clk->ops->set_rate(clk->hw, clk->new_rate, best_parent_rate);
 
+	if (clk->notifier_count)
+		__clk_notify(clk, APPLY_RATE_CHANGE, old_rate, clk->new_rate);
+
 	clk->rate = clk_recalc(clk, best_parent_rate);
 
 	if (clk->notifier_count && old_rate != clk->rate)
diff --git a/include/linux/clk.h b/include/linux/clk.h
index fb5e097..9ea9f5f 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -39,10 +39,14 @@ struct clk;
  * POST_RATE_CHANGE - called after the clk rate change has successfully
  *     completed.  Callbacks must always return NOTIFY_DONE or NOTIFY_OK.
  *
+ * APPLY_RATE_CHANGE - called right after calling ->set_rate(), but
+ *     before recalculating the rate.
+ *
  */
 #define PRE_RATE_CHANGE			BIT(0)
 #define POST_RATE_CHANGE		BIT(1)
 #define ABORT_RATE_CHANGE		BIT(2)
+#define APPLY_RATE_CHANGE		BIT(3)
 
 /**
  * struct clk_notifier - associate a clk with a notifier
-- 
2.0.0

