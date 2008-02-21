From: Pavel Machek <pavel@ucw.cz>
Subject: power_state: remove it from driver core
Date: Thu, 21 Feb 2008 13:58:10 +0100
Message-ID: <20080221125809.GA30308@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765316AbYBUNGX@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org


power_state is scheduled for removal, and it is used only for debug
prints by driver core. Remove it.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d180795..268855d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -421,11 +421,6 @@ int suspend_device(struct device *dev, p
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

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
