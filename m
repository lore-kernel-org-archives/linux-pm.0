From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v1 2/3] MAINTAINERS: add zx2967 thermal drivers to ARM ZTE architecture
Date: Sat,  7 Jan 2017 13:38:07 +0800
Message-ID: <1483767488-19778-2-git-send-email-baoyou.xie@linaro.org>
References: <1483767488-19778-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36646 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161355AbdAGFiv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Jan 2017 00:38:51 -0500
Received: by mail-pg0-f46.google.com with SMTP id f188so258255580pgc.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2017 21:38:50 -0800 (PST)
In-Reply-To: <1483767488-19778-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org, gregkh@linuxfoundation.org, davem@davemloft.net, geert+renesas@glider.be, akpm@linux-foundation.org, mchehab@kernel.org, linux@roeck-us.net
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

Add the zx2967 thermal drivers as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64f04df..2593296 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1981,6 +1981,7 @@ S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
 F:	drivers/soc/zte/
+F:	drivers/thermal/zx*
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
 F:	Documentation/devicetree/bindings/soc/zte/
-- 
2.7.4

