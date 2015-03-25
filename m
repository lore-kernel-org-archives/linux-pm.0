From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH] PM / sleep: Don't unset parent's direct_complete
Date: Wed, 25 Mar 2015 16:27:55 +0100
Message-ID: <1427297276-6370-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37695 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbbCYP2Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 11:28:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

If a device isn't going to be fully-suspended because there isn't an
implementation of the suspend callback, there's no need to make sure
that its parent is going to be fully-suspended as well.

Without this change, USB interface devices will always prevent the
proper USB device to stay in runtime suspension when the system
suspends.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Hi,

I'm not sure if this is the right fix, because I don't see why the USB
interface devices are in the dpm_list in the first place, so any comments will
be welcome.

Thanks,

Tomeu

---
 drivers/base/power/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3d874ec..6bac53f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1438,7 +1438,9 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 		if (parent) {
 			spin_lock_irq(&parent->power.lock);
 
-			dev->parent->power.direct_complete = false;
+			if (callback)
+				parent->power.direct_complete = false;
+
 			if (dev->power.wakeup_path
 			    && !dev->parent->power.ignore_children)
 				dev->parent->power.wakeup_path = true;
-- 
2.1.0

