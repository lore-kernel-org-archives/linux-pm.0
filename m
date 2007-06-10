From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/2] PM: Reduce code duplication in the core
	suspend code
Date: Sun, 10 Jun 2007 15:21:14 +0200
Message-ID: <200706101521.15105.rjw@sisk.pl>
References: <200706101519.50588.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706101519.50588.rjw@sisk.pl>
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
To: linux-pm <linux-pm@lists.osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Reduce code duplication in drivers/base/suspend.c by introducing an inline
function for printing diagnostic messages.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/suspend.c |   49 +++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

Index: linux-2.6.22-rc4/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/base/power/suspend.c	2007-06-10 13:30:45.000000000 +0200
+++ linux-2.6.22-rc4/drivers/base/power/suspend.c	2007-06-10 15:00:40.000000000 +0200
@@ -40,6 +40,14 @@ static inline char *suspend_verb(u32 eve
 }
 
 
+static inline void
+suspend_device_dbg(struct device * dev, pm_message_t state, char *info)
+{
+	dev_dbg(dev, "%s%s%s\n", info, suspend_verb(state.event),
+		((state.event == PM_EVENT_SUSPEND) && device_may_wakeup(dev)) ?
+		", may wakeup" : "");
+}
+
 /**
  *	suspend_device - Save state of one device.
  *	@dev:	Device.
@@ -66,37 +74,21 @@ int suspend_device(struct device * dev, 
 	dev->power.prev_state = dev->power.power_state;
 
 	if (dev->class && dev->class->suspend && !dev->power.power_state.event) {
-		dev_dbg(dev, "class %s%s\n",
-			suspend_verb(state.event),
-			((state.event == PM_EVENT_SUSPEND)
-					&& device_may_wakeup(dev))
-				? ", may wakeup"
-				: ""
-			);
+		suspend_device_dbg(dev, state, "class ");
 		error = dev->class->suspend(dev, state);
 		suspend_report_result(dev->class->suspend, error);
 	}
 
-	if (!error && dev->type && dev->type->suspend && !dev->power.power_state.event) {
-		dev_dbg(dev, "%s%s\n",
-			suspend_verb(state.event),
-			((state.event == PM_EVENT_SUSPEND)
-					&& device_may_wakeup(dev))
-				? ", may wakeup"
-				: ""
-			);
+	if (!error && dev->type && dev->type->suspend
+	    && !dev->power.power_state.event) {
+		suspend_device_dbg(dev, state, "type ");
 		error = dev->type->suspend(dev, state);
 		suspend_report_result(dev->type->suspend, error);
 	}
 
-	if (!error && dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
-		dev_dbg(dev, "%s%s\n",
-			suspend_verb(state.event),
-			((state.event == PM_EVENT_SUSPEND)
-					&& device_may_wakeup(dev))
-				? ", may wakeup"
-				: ""
-			);
+	if (!error && dev->bus && dev->bus->suspend
+	    && !dev->power.power_state.event) {
+		suspend_device_dbg(dev, state, "");
 		error = dev->bus->suspend(dev, state);
 		suspend_report_result(dev->bus->suspend, error);
 	}
@@ -114,14 +106,9 @@ static int suspend_device_late(struct de
 {
 	int error = 0;
 
-	if (dev->bus && dev->bus->suspend_late && !dev->power.power_state.event) {
-		dev_dbg(dev, "LATE %s%s\n",
-			suspend_verb(state.event),
-			((state.event == PM_EVENT_SUSPEND)
-					&& device_may_wakeup(dev))
-				? ", may wakeup"
-				: ""
-			);
+	if (dev->bus && dev->bus->suspend_late
+	    && !dev->power.power_state.event) {
+		suspend_device_dbg(dev, state, "LATE ");
 		error = dev->bus->suspend_late(dev, state);
 		suspend_report_result(dev->bus->suspend_late, error);
 	}
