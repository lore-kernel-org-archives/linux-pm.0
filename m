From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v3 2/4] video / backlight: remove the backlight_device_registered API
Date: Wed, 27 Apr 2016 20:45:03 +0800
Message-ID: <1461761105-5961-3-git-send-email-aaron.lu@intel.com>
References: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

Since we will need the backlight_device_get_by_type API, we can use it
instead of the backlight_device_registered API whenever necessary so
remove the backlight_device_registered API.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Acked-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/acpi/video_detect.c         | 2 +-
 drivers/video/backlight/backlight.c | 6 ------
 include/linux/backlight.h           | 1 -
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 1316ddd92fac..3d1327615f72 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -358,7 +358,7 @@ enum acpi_backlight_type acpi_video_get_backlight_type(void)
 	if (!(video_caps & ACPI_VIDEO_BACKLIGHT))
 		return acpi_backlight_vendor;
 
-	if (acpi_osi_is_win8() && backlight_device_registered(BACKLIGHT_RAW))
+	if (acpi_osi_is_win8() && backlight_device_get_by_type(BACKLIGHT_RAW))
 		return acpi_backlight_native;
 
 	return acpi_backlight_video;
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 18901b9b1eb4..288318ad21dd 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -407,12 +407,6 @@ struct backlight_device *backlight_device_get_by_type(enum backlight_type type)
 }
 EXPORT_SYMBOL(backlight_device_get_by_type);
 
-bool backlight_device_registered(enum backlight_type type)
-{
-	return backlight_device_get_by_type(type) ? true : false;
-}
-EXPORT_SYMBOL(backlight_device_registered);
-
 /**
  * backlight_device_unregister - unregisters a backlight device object.
  * @bd: the backlight device object to be unregistered and freed.
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index f46b88fa4a09..5f2fd61ef4fb 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -141,7 +141,6 @@ extern void devm_backlight_device_unregister(struct device *dev,
 					struct backlight_device *bd);
 extern void backlight_force_update(struct backlight_device *bd,
 				   enum backlight_update_reason reason);
-extern bool backlight_device_registered(enum backlight_type type);
 extern int backlight_register_notifier(struct notifier_block *nb);
 extern int backlight_unregister_notifier(struct notifier_block *nb);
 extern struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
-- 
2.5.5

