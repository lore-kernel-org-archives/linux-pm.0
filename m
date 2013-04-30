From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] PM: Add pm_ops_ptr() macro
Date: Tue, 30 Apr 2013 10:09:22 +0900
Message-ID: <000201ce453f$5ce4fc90$16aef5b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "'Rafael J. Wysocki'" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Len Brown' <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'Pavel Machek' <pavel-+ZI9xUNit7I@public.gmane.org>, 'Andrew Morton' <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add pm_ops_ptr() macro that allows the .pm entry in the driver structures
to be assigned without having an #define xxx NULL for the case that PM is
not enabled.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |    8 +-------
 include/linux/pm.h               |    2 ++
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 6e8ee92..e7b6639 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1218,7 +1218,6 @@ static int s3c24xx_i2c_resume(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM
 static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
 	.suspend_noirq = s3c24xx_i2c_suspend_noirq,
@@ -1226,11 +1225,6 @@ static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
 #endif
 };
 
-#define S3C24XX_DEV_PM_OPS (&s3c24xx_i2c_dev_pm_ops)
-#else
-#define S3C24XX_DEV_PM_OPS NULL
-#endif
-
 /* device driver for platform bus bits */
 
 static struct platform_driver s3c24xx_i2c_driver = {
@@ -1240,7 +1234,7 @@ static struct platform_driver s3c24xx_i2c_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c-i2c",
-		.pm	= S3C24XX_DEV_PM_OPS,
+		.pm	= pm_ops_ptr(&s3c24xx_i2c_dev_pm_ops),
 		.of_match_table = of_match_ptr(s3c24xx_i2c_match),
 	},
 };
diff --git a/include/linux/pm.h b/include/linux/pm.h
index a224c7f..bd50d15 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -55,8 +55,10 @@ struct device;
 
 #ifdef CONFIG_PM
 extern const char power_group_name[];		/* = "power" */
+#define pm_ops_ptr(_ptr)	(_ptr)
 #else
 #define power_group_name	NULL
+#define pm_ops_ptr(_ptr)	NULL
 #endif
 
 typedef struct pm_message {
-- 
1.7.2.5
