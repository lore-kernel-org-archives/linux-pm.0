From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V3 1/2] firmware: imx: add pm svc headfile
Date: Sun, 30 Sep 2018 08:53:16 +0800
Message-ID: <1538268797-24830-2-git-send-email-aisheng.dong@nxp.com>
References: <1538268797-24830-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1538268797-24830-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dong Aisheng <aisheng.dong@nxp.com>, ulf.hansson@linaro.org, dongas86@gmail.com, khilman@kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org

Add SCU PM SVC related protocol definitions which will be used by a number
of PM functions like Power Domain, Clock, Reset and etc. The detailed
implementation of each function will put in the individual function drivers.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * name updated with IMX_SC prefix
v1->v2:
 * new introduced
---
 include/soc/imx/scu/sci.h    |  1 +
 include/soc/imx/scu/svc/pm.h | 85 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 include/soc/imx/scu/svc/pm.h

diff --git a/include/soc/imx/scu/sci.h b/include/soc/imx/scu/sci.h
index 4a60d70..b600f7e 100644
--- a/include/soc/imx/scu/sci.h
+++ b/include/soc/imx/scu/sci.h
@@ -14,4 +14,5 @@
 #include <soc/imx/scu/types.h>
 
 #include <soc/imx/scu/svc/misc.h>
+#include <soc/imx/scu/svc/pm.h>
 #endif /* _SC_SCI_H */
diff --git a/include/soc/imx/scu/svc/pm.h b/include/soc/imx/scu/svc/pm.h
new file mode 100644
index 0000000..192dee3
--- /dev/null
+++ b/include/soc/imx/scu/svc/pm.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Power Management (PM) function. This includes functions for power state
+ * control, clock control, reset control, and wake-up event control.
+ *
+ * PM_SVC (SVC) Power Management Service
+ *
+ * Module for the Power Management (PM) service.
+ */
+
+#ifndef _SC_PM_API_H
+#define _SC_PM_API_H
+
+#include <soc/imx/scu/sci.h>
+
+/*
+ * This type is used to indicate RPC PM function calls.
+ */
+enum imx_sc_pm_func {
+	IMX_SC_PM_FUNC_UNKNOWN = 0,
+	IMX_SC_PM_FUNC_SET_SYS_POWER_MODE = 19,
+	IMX_SC_PM_FUNC_SET_PARTITION_POWER_MODE = 1,
+	IMX_SC_PM_FUNC_GET_SYS_POWER_MODE = 2,
+	IMX_SC_PM_FUNC_SET_RESOURCE_POWER_MODE = 3,
+	IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE = 4,
+	IMX_SC_PM_FUNC_REQ_LOW_POWER_MODE = 16,
+	IMX_SC_PM_FUNC_SET_CPU_RESUME_ADDR = 17,
+	IMX_SC_PM_FUNC_REQ_SYS_IF_POWER_MODE = 18,
+	IMX_SC_PM_FUNC_SET_CLOCK_RATE = 5,
+	IMX_SC_PM_FUNC_GET_CLOCK_RATE = 6,
+	IMX_SC_PM_FUNC_CLOCK_ENABLE = 7,
+	IMX_SC_PM_FUNC_SET_CLOCK_PARENT = 14,
+	IMX_SC_PM_FUNC_GET_CLOCK_PARENT = 15,
+	IMX_SC_PM_FUNC_RESET = 13,
+	IMX_SC_PM_FUNC_RESET_REASON = 10,
+	IMX_SC_PM_FUNC_BOOT = 8,
+	IMX_SC_PM_FUNC_REBOOT = 9,
+	IMX_SC_PM_FUNC_REBOOT_PARTITION = 12,
+	IMX_SC_PM_FUNC_CPU_START = 11,
+};
+
+/*
+ * Defines for ALL parameters
+ */
+#define IMX_SC_PM_CLK_ALL		UINT8_MAX	/* All clocks */
+
+/*
+ * Defines for SC PM Power Mode
+ */
+#define IMX_SC_PM_PW_MODE_OFF	0	/* Power off */
+#define IMX_SC_PM_PW_MODE_STBY	1	/* Power in standby */
+#define IMX_SC_PM_PW_MODE_LP	2	/* Power in low-power */
+#define IMX_SC_PM_PW_MODE_ON	3	/* Power on */
+
+/*
+ * Defines for SC PM CLK
+ */
+#define IMX_SC_PM_CLK_SLV_BUS	0	/* Slave bus clock */
+#define IMX_SC_PM_CLK_MST_BUS	1	/* Master bus clock */
+#define IMX_SC_PM_CLK_PER	2	/* Peripheral clock */
+#define IMX_SC_PM_CLK_PHY	3	/* Phy clock */
+#define IMX_SC_PM_CLK_MISC	4	/* Misc clock */
+#define IMX_SC_PM_CLK_MISC0	0	/* Misc 0 clock */
+#define IMX_SC_PM_CLK_MISC1	1	/* Misc 1 clock */
+#define IMX_SC_PM_CLK_MISC2	2	/* Misc 2 clock */
+#define IMX_SC_PM_CLK_MISC3	3	/* Misc 3 clock */
+#define IMX_SC_PM_CLK_MISC4	4	/* Misc 4 clock */
+#define IMX_SC_PM_CLK_CPU	2	/* CPU clock */
+#define IMX_SC_PM_CLK_PLL	4	/* PLL */
+#define IMX_SC_PM_CLK_BYPASS	4	/* Bypass clock */
+
+/*
+ * Defines for SC PM CLK Parent
+ */
+#define IMX_SC_PM_PARENT_XTAL	0	/* Parent is XTAL. */
+#define IMX_SC_PM_PARENT_PLL0	1	/* Parent is PLL0 */
+#define IMX_SC_PM_PARENT_PLL1	2	/* Parent is PLL1 or PLL0/2 */
+#define IMX_SC_PM_PARENT_PLL2	3	/* Parent in PLL2 or PLL0/4 */
+#define IMX_SC_PM_PARENT_BYPS	4	/* Parent is a bypass clock. */
+
+#endif /* _SC_PM_API_H */
-- 
2.7.4
