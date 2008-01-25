From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 4/5] Leds: Add possibility to remove leds
	classdevs during suspend/resume
Date: Fri, 25 Jan 2008 01:36:29 +0100
Message-ID: <200801250136.30292.rjw@sisk.pl>
References: <200801250127.21966.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801250127.21966.rjw@sisk.pl>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Buesch <mb@bu3sch.de>, LKML <linux-kernel@vger.kernel.org>, Alessandro Rubini <rubini@vision.unipv.it>, pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make it possible to unregister a led classdev object in a safe way
during a suspend/resume cycle.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/leds/led-class.c |   13 +++++++++----
 include/linux/leds.h     |   10 +++++++++-
 2 files changed, 18 insertions(+), 5 deletions(-)

Index: linux-2.6.24-rc8-mm1/drivers/leds/led-class.c
===================================================================
--- linux-2.6.24-rc8-mm1.orig/drivers/leds/led-class.c
+++ linux-2.6.24-rc8-mm1/drivers/leds/led-class.c
@@ -137,12 +137,14 @@ err_out:
 EXPORT_SYMBOL_GPL(led_classdev_register);
 
 /**
- * led_classdev_unregister - unregisters a object of led_properties class.
+ * __led_classdev_unregister - unregisters a object of led_properties class.
  * @led_cdev: the led device to unregister
+ * @suspended: indicates whether system-wide suspend or resume is in progress
  *
  * Unregisters a previously registered via led_classdev_register object.
  */
-void led_classdev_unregister(struct led_classdev *led_cdev)
+void __led_classdev_unregister(struct led_classdev *led_cdev,
+				      bool suspended)
 {
 	device_remove_file(led_cdev->dev, &dev_attr_brightness);
 #ifdef CONFIG_LEDS_TRIGGERS
@@ -153,13 +155,16 @@ void led_classdev_unregister(struct led_
 	up_write(&led_cdev->trigger_lock);
 #endif
 
-	device_unregister(led_cdev->dev);
+	if (suspended)
+		device_pm_schedule_removal(led_cdev->dev);
+	else
+		device_unregister(led_cdev->dev);
 
 	down_write(&leds_list_lock);
 	list_del(&led_cdev->node);
 	up_write(&leds_list_lock);
 }
-EXPORT_SYMBOL_GPL(led_classdev_unregister);
+EXPORT_SYMBOL_GPL(__led_classdev_unregister);
 
 static int __init leds_init(void)
 {
Index: linux-2.6.24-rc8-mm1/include/linux/leds.h
===================================================================
--- linux-2.6.24-rc8-mm1.orig/include/linux/leds.h
+++ linux-2.6.24-rc8-mm1/include/linux/leds.h
@@ -59,7 +59,15 @@ struct led_classdev {
 
 extern int led_classdev_register(struct device *parent,
 				 struct led_classdev *led_cdev);
-extern void led_classdev_unregister(struct led_classdev *led_cdev);
+extern void __led_classdev_unregister(struct led_classdev *led_cdev, bool sus);
+static inline void led_classdev_unregister(struct led_classdev *lcd)
+{
+	__led_classdev_unregister(lcd, false);
+}
+static inline void led_classdev_unregister_suspended(struct led_classdev *lcd)
+{
+	__led_classdev_unregister(lcd, true);
+}
 extern void led_classdev_suspend(struct led_classdev *led_cdev);
 extern void led_classdev_resume(struct led_classdev *led_cdev);
 
