From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH v2 1/9] hwmon: (core) Order include files alphabetically
Date: Sat, 16 Jul 2016 22:30:24 -0700
Message-ID: <1468733432-15730-2-git-send-email-linux@roeck-us.net>
References: <1468733432-15730-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1468733432-15730-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Ordering include files alphabetically makes it easier to add new ones.
Stop including linux/spinlock.h and linux/kdev_t.h since both are not
needed.

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
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
