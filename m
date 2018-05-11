From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 05/13] dt-bindings: power: add RK3128 SoCs header for power-domain
Date: Fri, 11 May 2018 11:32:39 +0800
Message-ID: <1526009559-1807-1-git-send-email-zhangqing@rock-chips.com>
References: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

According to a description from TRM, add all the power domains.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/power/rk3128-power.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3128-power.h

diff --git a/include/dt-bindings/power/rk3128-power.h b/include/dt-bindings/power/rk3128-power.h
new file mode 100644
index 000000000000..26aef519cd94
--- /dev/null
+++ b/include/dt-bindings/power/rk3128-power.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __DT_BINDINGS_POWER_RK3128_POWER_H__
+#define __DT_BINDINGS_POWER_RK3128_POWER_H__
+
+/* VD_CORE */
+#define RK3128_PD_CORE		0
+
+/* VD_LOGIC */
+#define RK3128_PD_VIO		1
+#define RK3128_PD_VIDEO		2
+#define RK3128_PD_GPU		3
+#define RK3128_PD_MSCH		4
+
+#endif
-- 
1.9.1
