From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 01/13] dt-bindings: power: add RK3036 SoCs header for
 power-domain
Date: Fri, 11 May 2018 11:30:46 +0800
Message-ID: <1526009458-28579-2-git-send-email-zhangqing@rock-chips.com>
References: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: huangtao@rock-chips.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, Elaine Zhang <zhangqing@rock-chips.com>, linux-pm@vger.kernel.org, xxx@rock-chips.com, khilman@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, xf@rock-chips.com, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, wxt@rock-chips.com
List-Id: linux-pm@vger.kernel.org

According to a description from TRM, add all the power domains.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---
 include/dt-bindings/power/rk3036-power.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3036-power.h

diff --git a/include/dt-bindings/power/rk3036-power.h b/include/dt-bindings/power/rk3036-power.h
new file mode 100644
index 000000000000..59e09f1c5af7
--- /dev/null
+++ b/include/dt-bindings/power/rk3036-power.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
+ * Author: Caesar Wang <wxt@rock-chips.com>
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
+#ifndef __DT_BINDINGS_POWER_RK3036_POWER_H__
+#define __DT_BINDINGS_POWER_RK3036_POWER_H__
+
+#define RK3036_PD_MSCH		0
+#define RK3036_PD_CORE		1
+#define RK3036_PD_PERI		2
+#define RK3036_PD_VIO		3
+#define RK3036_PD_VPU		4
+#define RK3036_PD_GPU		5
+#define RK3036_PD_SYS		6
+
+#endif
-- 
1.9.1
