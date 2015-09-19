From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v2 1/5] regulator: smd: Add floor and corner operations
Date: Fri, 18 Sep 2015 17:52:05 -0700
Message-ID: <1442623929-4507-2-git-send-email-sboyd@codeaurora.org>
References: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36548 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357AbbISAwN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2015 20:52:13 -0400
In-Reply-To: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-msm@vger.kernel.org
Cc: Andy Gross <agross@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>

From: Andy Gross <agross@codeaurora.org>

This patch addes the Qualcomm specific functions for setting the floor and
corner voltages on the regulators.

Signed-off-by: Andy Gross <agross@codeaurora.org>
[georgi.djakov@linaro.org: Make work with struct regulator]
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/regulator/qcom_smd-regulator.c       | 52 ++++++++++++++++++++++++++++
 include/linux/regulator/qcom_smd-regulator.h | 30 ++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 include/linux/regulator/qcom_smd-regulator.h

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 9c6167dd2c8b..cd4a0deb578e 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -20,6 +20,9 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/soc/qcom/smd-rpm.h>
+#include <linux/regulator/qcom_smd-regulator.h>
+
+#include "internal.h"
 
 struct qcom_rpm_reg {
 	struct device *dev;
@@ -44,6 +47,11 @@ struct rpm_regulator_req {
 #define RPM_KEY_SWEN	0x6e657773 /* "swen" */
 #define RPM_KEY_UV	0x00007675 /* "uv" */
 #define RPM_KEY_MA	0x0000616d /* "ma" */
+#define RPM_KEY_FLOOR	0x00636676 /* "vfc" */
+#define RPM_KEY_CORNER	0x6e726f63 /* "corn" */
+
+#define RPM_MIN_FLOOR_CORNER	0
+#define RPM_MAX_FLOOR_CORNER	6
 
 static int rpm_reg_write_active(struct qcom_rpm_reg *vreg,
 				struct rpm_regulator_req *req,
@@ -56,6 +64,50 @@ static int rpm_reg_write_active(struct qcom_rpm_reg *vreg,
 				  req, size);
 }
 
+int qcom_rpm_set_floor(struct regulator *regulator, int floor)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
+	struct rpm_regulator_req req;
+	int ret;
+
+	req.key = RPM_KEY_FLOOR;
+	req.nbytes = sizeof(u32);
+	req.value = floor;
+
+	if (floor < RPM_MIN_FLOOR_CORNER || floor > RPM_MAX_FLOOR_CORNER)
+		return -EINVAL;
+
+	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
+	if (ret)
+		dev_err(rdev_get_dev(rdev), "Failed to set floor %d\n", floor);
+
+	return ret;
+}
+EXPORT_SYMBOL(qcom_rpm_set_floor);
+
+int qcom_rpm_set_corner(struct regulator *regulator, int corner)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
+	struct rpm_regulator_req req;
+	int ret;
+
+	req.key = RPM_KEY_CORNER;
+	req.nbytes = sizeof(u32);
+	req.value = corner;
+
+	if (corner < RPM_MIN_FLOOR_CORNER || corner > RPM_MAX_FLOOR_CORNER)
+		return -EINVAL;
+
+	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
+	if (ret)
+		dev_err(rdev_get_dev(rdev), "Failed to set corner %d\n", corner);
+
+	return ret;
+}
+EXPORT_SYMBOL(qcom_rpm_set_corner);
+
 static int rpm_reg_enable(struct regulator_dev *rdev)
 {
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
diff --git a/include/linux/regulator/qcom_smd-regulator.h b/include/linux/regulator/qcom_smd-regulator.h
new file mode 100644
index 000000000000..a71b6adc64ba
--- /dev/null
+++ b/include/linux/regulator/qcom_smd-regulator.h
@@ -0,0 +1,30 @@
+/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __QCOM_SMD_REGULATOR_H_
+#define __QCOM_SMD_REGULATOR_H_
+
+#ifdef CONFIG_REGULATOR_QCOM_SMD_RPM
+int qcom_rpm_set_floor(struct regulator *regulator, int floor);
+int qcom_rpm_set_corner(struct regulator *regulator, int corner);
+#else
+static inline int qcom_rpm_set_floor(struct regulator *regulator, int floor)
+{
+	return -EINVAL;
+}
+
+static inline int qcom_rpm_set_corner(struct regulator *regulator, int corner)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

