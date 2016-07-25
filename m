From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 1/9] hwmon: (core) Order include files alphabetically
Date: Sun, 24 Jul 2016 20:32:24 -0700
Message-ID: <1469417552-9749-2-git-send-email-linux@roeck-us.net>
References: <1469417552-9749-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <1469417552-9749-1-git-send-email-linux@roeck-us.net>
Sender: linux-hwmon-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

Ordering include files alphabetically makes it easier to add new ones.
Stop including linux/spinlock.h and linux/kdev_t.h since both are not
needed.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: No change
v2: Added patch

 drivers/hwmon/hwmon.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index a26c385a435b..649a68d119b4 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -12,16 +12,14 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/kdev_t.h>
-#include <linux/idr.h>
-#include <linux/hwmon.h>
 #include <linux/gfp.h>
-#include <linux/spinlock.h>
+#include <linux/hwmon.h>
+#include <linux/idr.h>
+#include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 
 #define HWMON_ID_PREFIX "hwmon"
-- 
2.5.0

