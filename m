From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 1/4] include: dt-bindings: add Performance Monitoring
 Unit for Exynos
Date: Thu, 18 Apr 2019 15:38:29 +0200
Message-ID: <1555594712-18341-2-git-send-email-l.luba@partner.samsung.com>
References: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190418133851eucas1p192c8530255d6a4ce2aa8d8115f84a3db@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

This patch add support of a new feature which can be used in DT:
Performance Monitoring Unit with defined event data type.
In this patch the event data types are defined for Exynos PPMU.
The patch also updates the MAINTAINERS file accordingly and
adds the header file to devfreq event subsystem.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 MAINTAINERS                           |  1 +
 include/dt-bindings/pmu/exynos_ppmu.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3671fde..1ba4b9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4560,6 +4560,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
 S:	Supported
 F:	drivers/devfreq/event/
 F:	drivers/devfreq/devfreq-event.c
+F:	include/dt-bindings/pmu/exynos_ppmu.h
 F:	include/linux/devfreq-event.h
 F:	Documentation/devicetree/bindings/devfreq/event/
 
diff --git a/include/dt-bindings/pmu/exynos_ppmu.h b/include/dt-bindings/pmu/exynos_ppmu.h
new file mode 100644
index 0000000..08fdce9
--- /dev/null
+++ b/include/dt-bindings/pmu/exynos_ppmu.h
@@ -0,0 +1,26 @@
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
+#define PPMU_V2_RO_DATA_CNT		0x4
+#define PPMU_V2_WO_DATA_CNT		0x5
+#define PPMU_V2_EVT3_RW_DATA_CNT	0x22
+
+#endif
-- 
2.7.4
