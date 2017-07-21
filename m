From: <sean.wang@mediatek.com>
Subject: [PATCH 2/3] soc: mediatek: add header files required for MT7622 SCPSYS dt-binding
Date: Fri, 21 Jul 2017 11:57:13 +0800
Message-ID: <f0a5990699432508a3210b29cafae32db5691ed8.1500608650.git.sean.wang@mediatek.com>
References: <cover.1500608650.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500608650.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Chen Zhong <chen.zhong@mediatek.com>, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Chen Zhong <chen.zhong@mediatek.com>

Add relevant header files required for dt-bindings of SCPSYS power domain
control for all subsystems found on MT7622 SoC.

Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/dt-bindings/power/mt7622-power.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 include/dt-bindings/power/mt7622-power.h

diff --git a/include/dt-bindings/power/mt7622-power.h b/include/dt-bindings/power/mt7622-power.h
new file mode 100644
index 0000000..1b63926
--- /dev/null
+++ b/include/dt-bindings/power/mt7622-power.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2017 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT7622_POWER_H
+#define _DT_BINDINGS_POWER_MT7622_POWER_H
+
+#define MT7622_POWER_DOMAIN_ETHSYS	0
+#define MT7622_POWER_DOMAIN_HIF0	1
+#define MT7622_POWER_DOMAIN_HIF1	2
+#define MT7622_POWER_DOMAIN_WB		3
+
+#endif /* _DT_BINDINGS_POWER_MT7622_POWER_H */
-- 
2.7.4
