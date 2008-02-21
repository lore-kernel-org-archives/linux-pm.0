From: <gregkh@suse.de>
Subject: patch power_state-remove-it-from-driver-core.patch added to gregkh-2.6 tree
Date: Thu, 21 Feb 2008 13:43:15 -0800
Message-ID: <1203630195215@kroah.org>
References: <20080221125809.GA30308@elf.ucw.cz>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933848AbYBUVnp@vger.kernel.org>
In-Reply-To: <20080221125809.GA30308@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz, greg@kroah.com, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org, pavel@suse.cz, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: power_state: remove it from driver core

to my gregkh-2.6 tree.  Its filename is

     power_state-remove-it-from-driver-core.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From pavel@ucw.cz  Thu Feb 21 13:36:22 2008
From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 21 Feb 2008 13:58:10 +0100
Subject: power_state: remove it from driver core
To: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>
Message-ID: <20080221125809.GA30308@elf.ucw.cz>
Content-Disposition: inline


power_state is scheduled for removal, and it is used only for debug
prints by driver core. Remove it.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/power/main.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -419,11 +419,6 @@ static int suspend_device(struct device 
 {
 	int error = 0;
 
-	if (dev->power.power_state.event) {
-		dev_dbg(dev, "PM: suspend %d-->%d\n",
-			dev->power.power_state.event, state.event);
-	}
-
 	if (dev->class && dev->class->suspend) {
 		suspend_device_dbg(dev, state, "class ");
 		error = dev->class->suspend(dev, state);


Patches currently in gregkh-2.6 which might be from pavel@ucw.cz are

driver/driver-core-pm-make-suspend_device-static.patch
driver/pm-remove-unbalanced-mutex_unlock-from-dpm_resume.patch
driver/power_state-remove-it-from-driver-core.patch
usb/power_state-remove-it-from-usb.patch
