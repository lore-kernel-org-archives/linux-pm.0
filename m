From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v8 2/3] MAINTAINERS: add zx2967 thermal drivers to ARM ZTE  architecture
Date: Sat,  4 Feb 2017 11:39:56 +0800
Message-ID: <1486179597-30953-2-git-send-email-baoyou.xie@linaro.org>
References: <1486179597-30953-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486179597-30953-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org, jun.nie@linaro.org, rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shawnguo@kernel.org, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
List-Id: linux-pm@vger.kernel.org

Add the zx2967 thermal drivers as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5fb9b62..edfdea3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1989,10 +1989,12 @@ F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
 F:	drivers/reset/reset-zx2967.c
 F:	drivers/soc/zte/
+F:	drivers/thermal/zx*
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
 F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 F:	Documentation/devicetree/bindings/soc/zte/
+F:	Documentation/devicetree/bindings/thermal/zx*
 F:	include/dt-bindings/soc/zx*.h
 
 ARM/ZYNQ ARCHITECTURE
-- 
2.7.4
