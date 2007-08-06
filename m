From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Mon, 6 Aug 2007 11:11:03 -0700
Message-ID: <200708061111.03407.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-pm@lists.linux-foundation.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

This patch adds a clk_must_disable() operation, exposing the clock constraints
which often distinguish system power states.  Systems with such constraints
include ones using ARM-based AT91, OMAP, and PXA chips.  The new operation
lets driver methods check those constraints.

A common benefit to leaving some device clocks enabled is that a suspended
device may then be able to issue system wakeup events.  RS232, USB, Ethernet,
and other drivers can use driver model wakeup flags as userspace directions
about how to trade off between the lowest power "full off" states and more
functional wakeup-enabled ones.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- at91.orig/include/linux/clk.h	2007-02-16 08:47:11.000000000 -0800
+++ at91/include/linux/clk.h	2007-02-16 08:47:17.000000000 -0800
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
+ * mode; system wide sleep states like "standby" and "suspend-to-RAM"; and
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
