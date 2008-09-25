From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: use pm_op methods for device types
Date: Thu, 25 Sep 2008 17:07:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809251704580.2181-100000__24554.7296050519$1222377097$gmane$org@iolanthe.rowland.org>
References: <48DBF9C5.3030001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48DBF9C5.3030001@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1141) adds code to use the device type's pm_op methods,
if they are defined.  It fixes a regression in the USB PM code; the
various suspend and resume methods are defined in the device type
rather than in the bus, because USB devices have to be handled
differently from USB interfaces.  Without the patch, those methods
never get called.

The patch also fixes a couple of spelling errors.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Tested-by: Jiri Slaby <jirislaby@gmail.com>

---

This should be merged before 2.6.27 is released, if possible.  
Otherwise people will find their systems refuse to suspend when any USB
devices are attached.



Index: usb-2.6/drivers/base/power/main.c
===================================================================
--- usb-2.6.orig/drivers/base/power/main.c
+++ usb-2.6/drivers/base/power/main.c
@@ -107,7 +107,7 @@ void device_pm_remove(struct device *dev
 }
 
 /**
- *	pm_op - execute the PM operation appropiate for given PM event
+ *	pm_op - execute the PM operation appropriate for given PM event
  *	@dev:	Device.
  *	@ops:	PM operations to choose from.
  *	@state:	PM transition of the system being carried out.
@@ -166,7 +166,7 @@ static int pm_op(struct device *dev, str
 }
 
 /**
- *	pm_noirq_op - execute the PM operation appropiate for given PM event
+ *	pm_noirq_op - execute the PM operation appropriate for given PM event
  *	@dev:	Device.
  *	@ops:	PM operations to choose from.
  *	@state: PM transition of the system being carried out.
@@ -363,6 +363,13 @@ static int resume_device(struct device *
 			goto End;
 	}
 
+	if (dev->type && dev->type->pm) {
+		pm_dev_dbg(dev, state, "type ");
+		error = pm_op(dev, dev->type->pm, state);
+		if (error)
+			goto End;
+	}
+
 	if (dev->class) {
 		if (dev->class->pm) {
 			pm_dev_dbg(dev, state, "class ");
@@ -596,6 +603,13 @@ static int suspend_device(struct device 
 			goto End;
 	}
 
+	if (dev->type && dev->type->pm) {
+		pm_dev_dbg(dev, state, "type ");
+		error = pm_op(dev, dev->type->pm, state);
+		if (error)
+			goto End;
+	}
+
 	if (dev->bus) {
 		if (dev->bus->pm) {
 			pm_dev_dbg(dev, state, "");
