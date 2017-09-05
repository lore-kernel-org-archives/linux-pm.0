From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] device: Fix link to device power management documentation
Date: Tue,  5 Sep 2017 20:16:27 +0200
Message-ID: <1504635387-30217-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Correct location as of commit 2728b2d2e5be4b82 ("PM / core / docs:
Convert sleep states API document to reST").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Note that the link was already broken before...
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index beabdbc0842059b3..9db9c528bb5d1608 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -838,7 +838,7 @@ struct dev_links_info {
  * @driver_data: Private pointer for driver specific info.
  * @links:	Links to suppliers and consumers of this device.
  * @power:	For device power management.
- * 		See Documentation/power/admin-guide/devices.rst for details.
+ *		See Documentation/driver-api/pm/devices.rst for details.
  * @pm_domain:	Provide callbacks that are executed during system suspend,
  * 		hibernation, system resume and during runtime PM transitions
  * 		along with subsystem-level and driver-level callbacks.
-- 
2.7.4

