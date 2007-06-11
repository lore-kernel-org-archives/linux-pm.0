From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 4/7] PM: Remove suspend and resume
	support from struct device_type
Date: Mon, 11 Jun 2007 17:01:44 +0200
Message-ID: <200706111701.44988.rjw__49786.8466344245$1181574186$gmane$org@sisk.pl>
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

The suspend and resume support in struct device_type (include/linux/device.h)
is not used anywhere.  It is also undocumented, so it can be removed.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/resume.c  |    5 -----
 drivers/base/power/suspend.c |    7 -------
 include/linux/device.h       |    2 --
 3 files changed, 14 deletions(-)

Index: linux-2.6.22-rc4/drivers/base/power/resume.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/base/power/resume.c	2007-06-10 15:00:23.000000000 +0200
+++ linux-2.6.22-rc4/drivers/base/power/resume.c	2007-06-10 15:02:04.000000000 +0200
@@ -41,11 +41,6 @@ int resume_device(struct device * dev)
 		error = dev->bus->resume(dev);
 	}
 
-	if (!error && dev->type && dev->type->resume) {
-		dev_dbg(dev,"resuming\n");
-		error = dev->type->resume(dev);
-	}
-
 	if (!error && dev->class && dev->class->resume) {
 		dev_dbg(dev,"class resume\n");
 		error = dev->class->resume(dev);
Index: linux-2.6.22-rc4/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/base/power/suspend.c	2007-06-10 15:00:40.000000000 +0200
+++ linux-2.6.22-rc4/drivers/base/power/suspend.c	2007-06-10 15:02:04.000000000 +0200
@@ -79,13 +79,6 @@ int suspend_device(struct device * dev, 
 		suspend_report_result(dev->class->suspend, error);
 	}
 
-	if (!error && dev->type && dev->type->suspend
-	    && !dev->power.power_state.event) {
-		suspend_device_dbg(dev, state, "type ");
-		error = dev->type->suspend(dev, state);
-		suspend_report_result(dev->type->suspend, error);
-	}
-
 	if (!error && dev->bus && dev->bus->suspend
 	    && !dev->power.power_state.event) {
 		suspend_device_dbg(dev, state, "");
Index: linux-2.6.22-rc4/include/linux/device.h
===================================================================
--- linux-2.6.22-rc4.orig/include/linux/device.h	2007-06-10 15:00:23.000000000 +0200
+++ linux-2.6.22-rc4/include/linux/device.h	2007-06-10 15:02:04.000000000 +0200
@@ -343,8 +343,6 @@ struct device_type {
 	int (*uevent)(struct device *dev, char **envp, int num_envp,
 		      char *buffer, int buffer_size);
 	void (*release)(struct device *dev);
-	int (*suspend)(struct device * dev, pm_message_t state);
-	int (*resume)(struct device * dev);
 };
 
 /* interface for exporting device attributes */
