From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 1/3] include: dt-bindings: add Performance Monitoring Unit
 for Exynos
Date: Wed, 17 Apr 2019 09:48:06 +0200
Message-ID: <1555487288-4777-2-git-send-email-l.luba@partner.samsung.com>
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, l.luba@partner.samsung.com
List-Id: linux-pm@vger.kernel.org

This patch add support of a new feature which can be used in DT:
Performance Monitoring Unit with defined event data type.
In this patch the event data types are defined for Exynos PPMU.
The patch also updates the MAINTAINERS file accordingly.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 MAINTAINERS                           |  5 +++++
 include/dt-bindings/pmu/exynos_ppmu.h | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3671fde..f4aac78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12376,6 +12376,11 @@ L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/pm8001/
 
+PMU EXYNOS DT BINDINGS
+M:	Lukasz Luba <l.luba@partner.samsung.com>
+S:	Maintained
+F:	include/dt-bindings/pmu/exynos_ppmu.h
+
 PNP SUPPORT
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 S:	Maintained
diff --git a/include/dt-bindings/pmu/exynos_ppmu.h b/include/dt-bindings/pmu/exynos_ppmu.h
new file mode 100644
index 0000000..a6971eb
--- /dev/null
+++ b/include/dt-bindings/pmu/exynos_ppmu.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Samsung Exynos PPMU event types for counting in regs
+ *
+ * Copyright (c) 2019, Samsung
+ * Author: Lukasz Luba <l.luba@partner.samsung.com>
+ */
+
+#ifndef __DT_BINDINGS_PMU_EXYNOS_PPMU_H
+#define __DT_BINDINGS_PMU_EXYNOS_PPMU_H
+
+
+#define PPMU_RO_BUSY_CYCLE_CNT		0x0
+#define PPMU_WO_BUSY_CYCLE_CNT		0x1
+#define PPMU_RW_BUSY_CYCLE_CNT		0x2
+#define PPMU_RO_REQUEST_CNT		0x3
+#define PPMU_WO_REQUEST_CNT		0x4
+#define PPMU_RO_DATA_CNT		0x5
+#define PPMU_WO_DATA_CNT		0x6
+#define PPMU_RO_LATENCY			0x12
+#define PPMU_WO_LATENCY			0x16
+#define PPMU_V2_EVT3_RW_DATA_CNT	0x22
+
+#endif
-- 
2.7.4
