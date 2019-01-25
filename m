From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] devfreq: Suspend all devices on system shutdown
Date: Fri, 25 Jan 2019 14:54:03 +0100
Message-ID: <20190125135403.10228-1-m.szyprowski@samsung.com>
References: <CGME20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Luba <l.luba@partner.samsung.com>, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pm@vger.kernel.org

This way devfreq core ensures that all its devices will be set to safe
operation points before reboot operation. There are board on which some
aggressive power saving operation points are behind the capabilities of
the bootloader to properly reset the hardware and boot the board. This
way one can avoid board crash early after reboot.

Similar pattern is used in CPUfreq subsystem.

Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/devfreq/devfreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b..f6aba8344c56 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -23,6 +23,7 @@
 #include <linux/devfreq.h>
 #include <linux/workqueue.h>
 #include <linux/platform_device.h>
+#include <linux/syscore_ops.h>
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/hrtimer.h>
@@ -1422,6 +1423,10 @@ static struct attribute *devfreq_attrs[] = {
 };
 ATTRIBUTE_GROUPS(devfreq);
 
+static struct syscore_ops devfreq_syscore_ops = {
+	.shutdown = devfreq_suspend,
+};
+
 static int __init devfreq_init(void)
 {
 	devfreq_class = class_create(THIS_MODULE, "devfreq");
@@ -1438,6 +1443,8 @@ static int __init devfreq_init(void)
 	}
 	devfreq_class->dev_groups = devfreq_groups;
 
+	register_syscore_ops(&devfreq_syscore_ops);
+
 	return 0;
 }
 subsys_initcall(devfreq_init);
-- 
2.17.1
