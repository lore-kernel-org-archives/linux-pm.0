From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 9/9] usb: common: convert to use match_string() helper
Date: Thu, 28 Jan 2016 15:14:25 +0200
Message-ID: <1453986865-133572-10-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

The new helper returns index of the mathing string in an array. We would use it
here.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/common/common.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 49fbfe8..e3d0161 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -65,18 +65,15 @@ EXPORT_SYMBOL_GPL(usb_speed_string);
 enum usb_device_speed usb_get_maximum_speed(struct device *dev)
 {
 	const char *maximum_speed;
-	int err;
-	int i;
+	int ret;
 
-	err = device_property_read_string(dev, "maximum-speed", &maximum_speed);
-	if (err < 0)
+	ret = device_property_read_string(dev, "maximum-speed", &maximum_speed);
+	if (ret < 0)
 		return USB_SPEED_UNKNOWN;
 
-	for (i = 0; i < ARRAY_SIZE(speed_names); i++)
-		if (strcmp(maximum_speed, speed_names[i]) == 0)
-			return i;
+	ret = match_string(speed_names, ARRAY_SIZE(speed_names), maximum_speed);
 
-	return USB_SPEED_UNKNOWN;
+	return (ret < 0) ? USB_SPEED_UNKNOWN : ret;
 }
 EXPORT_SYMBOL_GPL(usb_get_maximum_speed);
 
@@ -110,13 +107,10 @@ static const char *const usb_dr_modes[] = {
 
 static enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
-		if (!strcmp(usb_dr_modes[i], str))
-			return i;
+	int ret;
 
-	return USB_DR_MODE_UNKNOWN;
+	ret = match_string(usb_dr_modes, ARRAY_SIZE(usb_dr_modes), str);
+	return (ret < 0) ? USB_DR_MODE_UNKNOWN : ret;
 }
 
 enum usb_dr_mode usb_get_dr_mode(struct device *dev)
-- 
2.7.0.rc3
