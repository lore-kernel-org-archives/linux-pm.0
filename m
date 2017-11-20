From: Jesse Chan <jc@linux.com>
Subject: [PATCH] power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon, 20 Nov 2017 12:58:27 -0800
Message-ID: <20171120205827.88610-1-jc@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jesse Chan <jc@linux.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
---
 drivers/power/reset/zx-reboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reboot.c
index 7549c7f74a3c..c03e96e6a041 100644
--- a/drivers/power/reset/zx-reboot.c
+++ b/drivers/power/reset/zx-reboot.c
@@ -82,3 +82,7 @@ static struct platform_driver zx_reboot_driver = {
 	},
 };
 module_platform_driver(zx_reboot_driver);
+
+MODULE_DESCRIPTION("ZTE SoCs reset driver");
+MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1
