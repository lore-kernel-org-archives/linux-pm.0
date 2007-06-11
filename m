From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 6/7] PM: Remove power_state.event checks
	from suspend core code
Date: Mon, 11 Jun 2007 17:04:40 +0200
Message-ID: <200706111704.40924.rjw__6208.77755941382$1181574614$gmane$org@sisk.pl>
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

The suspend routines should be called for every device during a system sleep
transition, regardless of the device's state, so that drivers can regard these
method calls as notifications that the system is about to go to sleep, rather
than as directives to put their devices into the 'off' state.

This is documented in Documentation/power/devices.txt and is already done in
the core resume code, so it seems reasonable to make the core suspend code
behave accordingly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/suspend.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6.22-rc4/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/base/power/suspend.c	2007-06-11 09:59:54.000000000 +0200
+++ linux-2.6.22-rc4/drivers/base/power/suspend.c	2007-06-11 10:18:11.000000000 +0200
@@ -71,14 +71,13 @@ int suspend_device(struct device * dev, 
 			dev->parent->power.power_state.event);
 	}
 
-	if (dev->class && dev->class->suspend && !dev->power.power_state.event) {
+	if (dev->class && dev->class->suspend) {
 		suspend_device_dbg(dev, state, "class ");
 		error = dev->class->suspend(dev, state);
 		suspend_report_result(dev->class->suspend, error);
 	}
 
-	if (!error && dev->bus && dev->bus->suspend
-	    && !dev->power.power_state.event) {
+	if (!error && dev->bus && dev->bus->suspend) {
 		suspend_device_dbg(dev, state, "");
 		error = dev->bus->suspend(dev, state);
 		suspend_report_result(dev->bus->suspend, error);
@@ -97,8 +96,7 @@ static int suspend_device_late(struct de
 {
 	int error = 0;
 
-	if (dev->bus && dev->bus->suspend_late
-	    && !dev->power.power_state.event) {
+	if (dev->bus && dev->bus->suspend_late) {
 		suspend_device_dbg(dev, state, "LATE ");
 		error = dev->bus->suspend_late(dev, state);
 		suspend_report_result(dev->bus->suspend_late, error);
