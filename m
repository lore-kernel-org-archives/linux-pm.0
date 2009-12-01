From: Wu Zhangin <wuzhangjin@gmail.com>
Subject: [PATCH v6 7/8] Loongson: YeeLoong: add suspend driver
Date: Tue,  1 Dec 2009 19:11:55 +0800
Message-ID: <2574dde59f2e54ef9fa80423a7f02ed32eab7ab4.1259664573.git.wuzhangjin__6001.36152138493$1259666216$gmane$org@gmail.com>
References: <cover.1259660040.git.wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1259660040.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1259664573.git.wuzhangjin@gmail.com>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, zhangfx@lemote.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds Suspend Driver, which will suspend the YeeLoong Platform
specific devices.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    8 +
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
 .../lemote-2f/yeeloong_laptop/yl_suspend.c         |  135 ++++++++++++++++++++
 3 files changed, 144 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_suspend.c

diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
index 7cf6071..f1211b4 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
@@ -45,4 +45,12 @@ config YEELOONG_VO
 	  This option adds Video Output Driver, which provides standard
 	  interface to turn on/off the video output of LCD, CRT.
 
+config YEELOONG_SUSPEND
+	tristate "Suspend Driver"
+	depends on YEELOONG_VO && LOONGSON_SUSPEND
+	default y
+	help
+	  This option adds Suspend Driver, which will suspend the YeeLoong
+	  Platform specific devices.
+
 endif
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
index aa01140..29f8050 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_YEELOONG_BACKLIGHT) += yl_backlight.o
 obj-$(CONFIG_YEELOONG_BATTERY) += yl_battery.o
 obj-$(CONFIG_YEELOONG_HWMON) += yl_hwmon.o
 obj-$(CONFIG_YEELOONG_VO) += yl_vo.o
+obj-$(CONFIG_YEELOONG_SUSPEND) += yl_suspend.o
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_suspend.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_suspend.c
new file mode 100644
index 0000000..9f53a69
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_suspend.c
@@ -0,0 +1,135 @@
+/*
+ * YeeLoong Platform Specific Suspend Driver
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/platform_device.h>
+
+#include <asm/bootinfo.h>
+
+#include "ec_kb3310b.h"
+
+MODULE_AUTHOR("Wu Zhangjin <wuzj@lemote.com>");
+MODULE_DESCRIPTION("YeeLoong laptop suspend driver");
+MODULE_LICENSE("GPL");
+
+static struct platform_device *yeeloong_pdev;
+
+static void usb_ports_set(int status)
+{
+	status = !!status;
+
+	ec_write(REG_USB0_FLAG, status);
+	ec_write(REG_USB1_FLAG, status);
+	ec_write(REG_USB2_FLAG, status);
+}
+
+static int yeeloong_suspend(struct platform_device *pdev,
+		pm_message_t state)
+{
+	pr_info("yeeloong specific suspend\n");
+
+	/* Turn off LCD */
+	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+	/* Turn off CRT */
+	yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+	/* Poweroff three usb ports */
+	usb_ports_set(BIT_USB_FLAG_OFF);
+
+	return 0;
+}
+
+static int yeeloong_resume(struct platform_device *pdev)
+{
+	pr_info("yeeloong specific resume\n");
+
+	/* Resume the status of lcd & crt */
+	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+	yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
+
+	/* Poweron three usb ports */
+	usb_ports_set(BIT_USB_FLAG_ON);
+
+	return 0;
+}
+
+static struct platform_driver platform_driver = {
+	.driver = {
+		   .name = "yeeloong-laptop",
+		   .owner = THIS_MODULE,
+		   },
+	.suspend = yeeloong_suspend,
+	.resume = yeeloong_resume,
+};
+
+static ssize_t yeeloong_pdev_name_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "yeeloong laptop\n");
+}
+
+static struct device_attribute dev_attr_yeeloong_pdev_name =
+__ATTR(name, S_IRUGO, yeeloong_pdev_name_show, NULL);
+
+static int __init yeeloong_suspend_init(void)
+{
+	int ret;
+
+	if (mips_machtype != MACH_LEMOTE_YL2F89) {
+		pr_err("This Driver is only for YeeLoong laptop\n");
+		return -EFAULT;
+	}
+
+	/* Register platform stuff */
+	ret = platform_driver_register(&platform_driver);
+	if (ret)
+		return ret;
+
+	yeeloong_pdev = platform_device_alloc("yeeloong-laptop", -1);
+	if (!yeeloong_pdev) {
+		ret = -ENOMEM;
+		platform_driver_unregister(&platform_driver);
+		return ret;
+	}
+
+	ret = platform_device_add(yeeloong_pdev);
+	if (ret) {
+		platform_device_put(yeeloong_pdev);
+		return ret;
+	}
+
+	if (IS_ERR(yeeloong_pdev)) {
+		ret = PTR_ERR(yeeloong_pdev);
+		yeeloong_pdev = NULL;
+		pr_err("Fail to register platform device\n");
+		return ret;
+	}
+
+	ret = device_create_file(&yeeloong_pdev->dev,
+				 &dev_attr_yeeloong_pdev_name);
+	if (ret) {
+		pr_err("Fail to create sysfs device attributes\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit yeeloong_suspend_exit(void)
+{
+	if (yeeloong_pdev) {
+		platform_device_unregister(yeeloong_pdev);
+		yeeloong_pdev = NULL;
+		platform_driver_unregister(&platform_driver);
+	}
+}
+
+module_init(yeeloong_suspend_init);
+module_exit(yeeloong_suspend_exit);
-- 
1.6.2.1
