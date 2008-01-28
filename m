From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [RFC 2/4] Voltage/Current Regulator framework
Date: Mon, 28 Jan 2008 15:32:21 +0000
Message-ID: <1201534342.3551.143.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: Vincent Sanders <vince@simtec.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ross Wille <wille@freescale.com>
List-Id: linux-pm@vger.kernel.org

Regulator driver API :-

diff --git a/include/linux/regulator/regulator-drv.h b/include/linux/regulator/regulator-drv.h
new file mode 100644
index 0000000..3c9b398
--- /dev/null
+++ b/include/linux/regulator/regulator-drv.h
@@ -0,0 +1,119 @@
+/*
+ * regulator-drv.h -- SoC Regulator support.
+ *
+ * Copyright (C) 2007, 2008 Wolfson Microelectronics PLC.
+ *
+ * Author: Liam Girdwood <lg@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Regulator Driver Interface.
+ */
+
+
+#ifndef __LINUX_REGULATOR_DRV_H_
+#define __LINUX_REGULATOR_DRV_H_
+
+#include <linux/device.h>
+#include <linux/regulator/regulator.h>
+
+struct regulator_constraints;
+struct regulator_cdev;
+
+/**
+ * struct regulator_ops - regulator operations.
+ *
+ * This struct describes regulator operations.
+ */
+struct regulator_ops {
+
+	/* get/set regulator voltage */
+	int (*set_voltage)(struct regulator_cdev *, int uV);
+	int (*get_voltage)(struct regulator_cdev *);
+
+	/* get/set regulator current  */
+	int (*set_current)(struct regulator_cdev *, int uA);
+	int (*get_current)(struct regulator_cdev *);
+
+	/* enable/disable regulator */
+	int (*enable)(struct regulator_cdev *);
+	int (*disable)(struct regulator_cdev *);
+	int (*is_enabled)(struct regulator_cdev *);
+
+	/* get/set regulator operating mode (defined in regulator.h) */
+	int (*set_mode)(struct regulator_cdev *, unsigned int mode);
+	unsigned int (*get_mode)(struct regulator_cdev *);
+
+	/* get most efficient regulator operating mode for load */
+	unsigned int (*get_optimum_mode)(struct regulator_cdev *, int input_uV,
+		int output_uV, int load_uA);
+};
+
+/*
+ * Regulators can either control voltage or current.
+ */
+enum regulator_type {
+	REGULATOR_VOLTAGE,
+	REGULATOR_CURRENT,
+};
+
+/**
+ * struct regulator_desc - Regulator descriptor
+ *
+ */
+struct regulator_desc {
+	const char *name;
+	int id;
+	struct regulator_ops *ops;
+	int irq;
+	enum regulator_type type;
+	struct module *owner;
+};
+
+/**
+ * regulator_register - register regulator
+ * @regulator: regulator source
+ * @reg_data: private regulator data
+ *
+ * Called by regulator drivers to register a regulator.
+ * Returns 0 on success.
+ */
+struct regulator_cdev *regulator_register(
+	struct regulator_desc *regulator_desc, void *reg_data);
+
+/**
+ * regulator_unregister - unregister regulator
+ * @regulator: regulator source
+ *
+ * Called by regulator drivers to unregister a regulator.
+ */
+void regulator_unregister(struct regulator_cdev *rcdev);
+
+/**
+ * regulator_notifier_call_chain - call regulator event notifier
+ * @regulator: regulator source
+ * @event: notifier block
+ * @data:
+ *
+ * Called by regulator drivers to notify clients a regulator event has
+ * occurred.
+ */
+int regulator_notifier_call_chain(struct regulator_cdev *rcdev,
+	unsigned long event, void *data);
+
+/**
+ * regulator_get_drvdata - get regulator driver data
+ * @regulator: regulator
+ */
+void *rcdev_get_drvdata (struct regulator_cdev *rcdev);
+
+/**
+ * regulator_get_id - get regulator ID
+ * @regulator: regulator
+ */
+int rcdev_get_id (struct regulator_cdev *rcdev);
+
+
+#endif
