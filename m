From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 7/7] PM: Do not check parent state in
	suspend and resume core code
Date: Mon, 11 Jun 2007 17:06:04 +0200
Message-ID: <200706111706.05379.rjw__38425.7840844386$1181574696$gmane$org@sisk.pl>
References: <200706111655.50022.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706111655.50022.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The checks if the device's parent is in the right state done in
drivers/base/power/suspend.c and drivers/base/power/resume.c serve no particular
purpose, since if the parent is in a wrong power state, the device's suspend or
resume callbacks are supposed to return an error anyway.  Moreover, they are
also useless from the sanity checking point of view, because they rely on the
code being checked to set dev->parent->power.power_state.event appropriately,
which need not happen if that code is buggy.  For these reasons they can be
removed.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/resume.c  |    7 -------
 drivers/base/power/suspend.c |    7 -------
 2 files changed, 14 deletions(-)

Index: linux-2.6.22-rc4/drivers/base/power/resume.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/base/power/resume.c	2007-06-11 09:59:54.000000000 +0200
+++ linux-2.6.22-rc4/drivers/base/power/resume.c	2007-06-11 10:19:37.000000000 +0200
@@ -29,13 +29,6 @@ int resume_device(struct device * dev)
 
 	down(&dev->sem);
 
-	if (dev->parent && dev->parent->power.power_state.event) {
-		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
-			dev->power.power_state.event,
-			dev->parent->bus_id,
-			dev->parent->power.power_state.event);
-	}
-
 	if (dev->bus && dev->bus->resume) {
 		dev_dbg(dev,"resuming\n");
 		error = dev->bus->resume(dev);
Index: linux-2.6.22-rc4/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/base/power/suspend.c	2007-06-11 10:18:11.000000000 +0200
+++ linux-2.6.22-rc4/drivers/base/power/suspend.c	2007-06-11 10:19:30.000000000 +0200
@@ -63,13 +63,6 @@ int suspend_device(struct device * dev, 
 		dev_dbg(dev, "PM: suspend %d-->%d\n",
 			dev->power.power_state.event, state.event);
 	}
-	if (dev->parent && dev->parent->power.power_state.event) {
-		dev_err(dev,
-			"PM: suspend %d->%d, parent %s already %d\n",
-			dev->power.power_state.event, state.event,
-			dev->parent->bus_id,
-			dev->parent->power.power_state.event);
-	}
 
 	if (dev->class && dev->class->suspend) {
 		suspend_device_dbg(dev, state, "class ");
