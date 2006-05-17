From: David Brownell <david-b@pacbell.net>
Subject: [PATCH/RFC 2.6.17-rc4-git] clk_must_disable()
Date: Tue, 16 May 2006 17:39:15 -0700
Message-ID: <200605161739.17059.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932391AbWEQAmb@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.osdl.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Victor <andrew@sanpeople.com>
List-Id: linux-pm@vger.kernel.org

This defines a new optional clock API ... comments?

In implementation terms, the platform's pm_ops.prepare() can record the
target system state, and its implementation of this method would know
thinks like "STR turns off those two PLLs and their derived clocks",
while "standby leaves those PLLs on".

Alternate PM approaches -- DPM, operating points, whatever -- could have
their own internal representations of these constraints, but drivers would
only need this one API call to check them from suspend() callbacks.

- Dave


-------------------------	SNIP!

This patch adds a clk_must_disable() operation, exposing clock constraints
that often distinguish system power states.  Systems with such constraints
include ones using ARM-based AT91, OMAP, and PXA chips.  The new operation
lets driver methods check those constraints.

A common benefit to leaving some device clocks enabled is that a suspended
device may then be able to issue system wakeup events.  RS232, USB, Ethernet,
and other drivers can use driver model wakeup flags to trade off between the
lowest power "full off" states and more functional wakeup-enabled states,
as configured through sysfs.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


--- at91-pre2.orig/include/linux/clk.h	2006-05-15 10:07:24.000000000 -0700
+++ at91-pre2/include/linux/clk.h	2006-05-15 10:41:15.000000000 -0700
@@ -121,4 +121,24 @@ int clk_set_parent(struct clk *clk, stru
  */
 struct clk *clk_get_parent(struct clk *clk);
 
+/**
+ * clk_must_disable - report whether a clock's users must disable it
+ * @clk: one node in the clock tree
+ *
+ * This routine returns true only if the upcoming system state requires
+ * disabling the specified clock.
+ *
+ * It's common for platform power states to constrain certain clocks (and
+ * their descendants) to be unavailable, while other states allow that
+ * clock to be active.  A platform's power states often include an "all on"
+ * mode; system wide sleep states like "standby" or "suspend-to-RAM"; and
+ * operating states which sacrifice functionality for lower power usage.
+ *
+ * The constraint value is commonly tested in device driver suspend(), to
+ * leave clocks active if they are needed for features like wakeup events.
+ * On platforms that support reduced functionality operating states, the
+ * constraint may also need to be tested during resume() and probe() calls.
+ */
+int clk_must_disable(struct clk *clk);
+
 #endif
