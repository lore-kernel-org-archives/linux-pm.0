From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: [PATCH 1/3] mfd: max77693: Add defines for charger current control
Date: Tue, 27 Sep 2016 01:31:08 +0200
Message-ID: <1474932670-11953-2-git-send-email-wolfgit@wiedmeyer.de>
References: <1474932670-11953-1-git-send-email-wolfgit@wiedmeyer.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474932670-11953-1-git-send-email-wolfgit@wiedmeyer.de>
Sender: linux-kernel-owner@vger.kernel.org
To: krzk@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: cw00.choi@samsung.com, b.zolnierkie@samsung.com, broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
List-Id: linux-pm@vger.kernel.org

This prepares for an updated regulator and charger driver. The defines
are needed to set the maximum input current and the fast charge
current.

Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
---
 include/linux/mfd/max77693-private.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 3c7a63b..ca18344 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -222,6 +222,9 @@ enum max77693_charger_battery_state {
 #define CHG_CNFG_00_CHG_MASK		0x1
 #define CHG_CNFG_00_BUCK_MASK		0x4
 
+/* MAX77693 CHG_CNFG_02 register */
+#define CHG_CNFG_02_CC_MASK		0x3F
+
 /* MAX77693_CHG_REG_CHG_CNFG_01 register */
 #define CHG_CNFG_01_FCHGTIME_SHIFT	0
 #define CHG_CNFG_01_CHGRSTRT_SHIFT	4
@@ -258,6 +261,10 @@ enum max77693_charger_battery_state {
 
 /* MAX77693 CHG_CNFG_09 Register */
 #define CHG_CNFG_09_CHGIN_ILIM_MASK	0x7F
+#define CHG_CNFG_09_CHGIN_ILIM_500_MAX	500000
+#define CHG_CNFG_09_CHGIN_ILIM_500_MIN	470000
+#define CHG_CNFG_09_CHGIN_ILIM_0_MAX	60000
+#define CHG_CNFG_09_CHGIN_ILIM_0_MIN	0
 
 /* MAX77693 CHG_CTRL Register */
 #define SAFEOUT_CTRL_SAFEOUT1_MASK	0x3
-- 
2.8.0.rc3
