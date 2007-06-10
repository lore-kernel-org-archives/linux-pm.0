From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PM: Remove prev_state from dev_pm_info
Date: Mon, 11 Jun 2007 01:31:54 +0200
Message-ID: <200706110131.54904.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0706101018430.29131-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706101018430.29131-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sunday, 10 June 2007 16:32, Alan Stern wrote:
> On Sat, 9 Jun 2007, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The saved_state member of struct dev_pm_info, defined in include/linux/pm.h, is
> > not used anywhere, so it can be removed.
> 
> Along the same lines, feature_removal_schedule.txt says that 
> dev->power.power_state will be removed next month.  In preparation, 
> you could consider removing the prev_state member now.  As far as I 
> know, it isn't used for anything other than avoiding resume method 
> calls to devices that were already suspended when a system sleep 
> began.

Patch for that is appended.

Greetings,
Rafael


---
From: Rafael J. Wysocki <rjw@sisk.pl>

The prev_state member of struct dev_pm_info (defined in include/linux/pm.h) is
only used during a resume to check if the device's state before the suspend was
'off', in which case the device is not resumed.  However, in such
cases the decision whether or not to resume the device should be made on the
driver level and the resume callbacks from the device's bus and class should be
executed anyway (the may be needed for some things other than just powering on
the device).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/resume.c  |    3 +--
 drivers/base/power/suspend.c |    2 --
 drivers/usb/core/hub.c       |    5 -----
 include/linux/pm.h           |    1 -
 4 files changed, 1 insertion(+), 10 deletions(-)

Index: linux-2.6.22-rc4/drivers/base/power/resume.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/base/power/resume.c	2007-06-10 19:36:52.000000000 +0200
+++ linux-2.6.22-rc4/drivers/base/power/resume.c	2007-06-10 19:53:57.000000000 +0200
@@ -83,8 +83,7 @@ void dpm_resume(void)
 		list_move_tail(entry, &dpm_active);
 
 		mutex_unlock(&dpm_list_mtx);
-		if (!dev->power.prev_state.event)
-			resume_device(dev);
+		resume_device(dev);
 		mutex_lock(&dpm_list_mtx);
 		put_device(dev);
 	}
Index: linux-2.6.22-rc4/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/base/power/suspend.c	2007-06-10 19:36:52.000000000 +0200
+++ linux-2.6.22-rc4/drivers/base/power/suspend.c	2007-06-10 19:53:09.000000000 +0200
@@ -71,8 +71,6 @@ int suspend_device(struct device * dev, 
 			dev->parent->power.power_state.event);
 	}
 
-	dev->power.prev_state = dev->power.power_state;
-
 	if (dev->class && dev->class->suspend && !dev->power.power_state.event) {
 		suspend_device_dbg(dev, state, "class ");
 		error = dev->class->suspend(dev, state);
Index: linux-2.6.22-rc4/drivers/usb/core/hub.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/usb/core/hub.c	2007-06-08 13:09:18.000000000 +0200
+++ linux-2.6.22-rc4/drivers/usb/core/hub.c	2007-06-10 19:54:08.000000000 +0200
@@ -1110,11 +1110,6 @@ void usb_root_hub_lost_power(struct usb_
 
 	dev_warn(&rhdev->dev, "root hub lost power or was reset\n");
 
-	/* Make sure no potential wakeup events get lost,
-	 * by forcing the root hub to be resumed.
-	 */
-	rhdev->dev.power.prev_state.event = PM_EVENT_ON;
-
 	spin_lock_irqsave(&device_state_lock, flags);
 	hub = hdev_to_hub(rhdev);
 	for (port1 = 1; port1 <= rhdev->maxchild; ++port1) {
Index: linux-2.6.22-rc4/include/linux/pm.h
===================================================================
--- linux-2.6.22-rc4.orig/include/linux/pm.h	2007-06-10 19:36:52.000000000 +0200
+++ linux-2.6.22-rc4/include/linux/pm.h	2007-06-10 19:52:56.000000000 +0200
@@ -235,7 +235,6 @@ struct dev_pm_info {
 	unsigned		can_wakeup:1;
 #ifdef	CONFIG_PM
 	unsigned		should_wakeup:1;
-	pm_message_t		prev_state;
 	struct list_head	entry;
 #endif
 };
