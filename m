From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 08/13] dt-bindings: power: add RK3228 SoCs header for power-domain
Date: Wed, 23 May 2018 14:51:26 +0800
Message-ID: <1527058286-10503-1-git-send-email-zhangqing@rock-chips.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

According to a description from TRM, add all the power domains.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/power/rk3228-power.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3228-power.h

diff --git a/include/dt-bindings/power/rk3228-power.h b/include/dt-bindings/power/rk3228-power.h
new file mode 100644
index 000000000000..6a8dc1bf76ce
--- /dev/null
+++ b/include/dt-bindings/power/rk3228-power.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_POWER_RK3228_POWER_H__
+#define __DT_BINDINGS_POWER_RK3228_POWER_H__
+
+/**
+ * RK3228 idle id Summary.
+ */
+
+#define RK3228_PD_CORE		0
+#define RK3228_PD_MSCH		1
+#define RK3228_PD_BUS		2
+#define RK3228_PD_SYS		3
+#define RK3228_PD_VIO		4
+#define RK3228_PD_VOP		5
+#define RK3228_PD_VPU		6
+#define RK3228_PD_RKVDEC	7
+#define RK3228_PD_GPU		8
+#define RK3228_PD_PERI		9
+#define RK3228_PD_GMAC		10
+
+#endif
-- 
1.9.1
