From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [RFC 3/4] Voltage/Current Regulator framework
Date: Mon, 28 Jan 2008 15:32:34 +0000
Message-ID: <1201534354.3551.144.camel@localhost.localdomain>
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

Regulator platform/device API :-

diff --git a/include/linux/regulator/regulator-platform.h b/include/linux/regulator/regulator-platform.h
new file mode 100644
index 0000000..5558630
--- /dev/null
+++ b/include/linux/regulator/regulator-platform.h
@@ -0,0 +1,104 @@
+/*
+ * regulator-platform.h -- SoC Regulator support, platform driver API.
+ *
+ * Copyright (C) 2007, 2008 Wolfson Microelectronics PLC.
+ *
+ * Author: Liam Girdwood <lg@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Regulator Platform Interface.
+ */
+
+
+#ifndef __LINUX_REGULATOR_PLATFORM_H_
+#define __LINUX_REGULATOR_PLATFORM_H_
+
+#include <linux/regulator/regulator.h>
+
+struct regulator;
+
+/*
+ * Regulator operation constraint flags. These flags are used to enable
+ * certain regulator operations.
+ *
+ * @VOLTAGE:  Regulator output voltage can be changed by software on this
+ *            board/machine.
+ * @CURRENT:  Regulator output current can be changed by software on this
+ *            board machine.
+ * @MODE:     Regulator operating mode can be changed by software on this
+ *            board machine.
+ * @STATUS:   Regulator can be enabled and disabled.
+ * @DRMS:     Dynamic Regulator Mode Switching is enabled for this regulator.
+ */
+
+#define REGULATOR_CHANGE_VOLTAGE	0x1
+#define REGULATOR_CHANGE_CURRENT	0x2
+#define REGULATOR_CHANGE_MODE		0x4
+#define REGULATOR_CHANGE_STATUS		0x8
+#define REGULATOR_CHANGE_DRMS		0x10
+
+/**
+ * struct regulation_constraints - regulator operating constraints.
+ *
+ * This struct describes regulator and board/machine specific constraints.
+ */
+struct regulation_constraints {
+
+	char *name;
+
+	/* voltage output range - for voltage control */
+	int min_uV;
+	int max_uV;
+
+	/* current output range - for current control */
+	int min_uA;
+	int max_uA;
+
+	/* valid regulator operating modes for this machine */
+	unsigned int valid_modes_mask;
+
+	/* valid operations for regulator on this machine */
+	unsigned int valid_ops_mask;
+
+	/* input voltage */
+	int input_uV;
+};
+
+/**
+ * regulator_set_platform_source - set regulator source regulator
+ * @regulator: regulator source
+ * @parent: source or parent regulator
+ *
+ * Called by platform initialisation code to set the source supply or "parent"
+ * regulator for this regulator. This ensures that a regulator source will
+ * also be enabled by the core if it's child is enabled.
+ */
+int regulator_set_platform_source(const char *regulator_source,
+	const char *regulator_parent);
+
+/**
+ * regulator_get_platform_source - get regulator source regulator
+ * @regulator: regulator source
+ *
+ * Returns the regulator supply regulator or NULL if no supply regulator
+ * exists (i.e the regulator is supplied directly from USB, Line, Battery, etc)
+ */
+const char *regulator_get_platform_source(const char *regulator_name);
+
+
+/**
+ * regulator_set_platform_constraints - sets regulator constraints
+ * @regulator: regulator source
+ *
+ * Allows platform initialisation code to define and constrain regulator
+ * circuits e.g. valid voltage/current ranges, etc.
+ * NOTE: Constraints *must* be set by platform code in order for some
+ * regulator operations to proceed i.e. set_voltage, set_current, set_mode.
+ */
+int regulator_set_platform_constraints(const char *regulator_name,
+	struct regulation_constraints *constraints);
+
+#endif
