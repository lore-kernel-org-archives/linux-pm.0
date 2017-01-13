From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v4 2/3] MAINTAINERS: add zx2967 thermal drivers to ARM ZTE architecture
Date: Fri, 13 Jan 2017 18:46:57 +0800
Message-ID: <1484304418-17489-2-git-send-email-baoyou.xie@linaro.org>
References: <1484304418-17489-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33578 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdAMKrX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 05:47:23 -0500
Received: by mail-pf0-f181.google.com with SMTP id y143so30025745pfb.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2017 02:47:23 -0800 (PST)
In-Reply-To: <1484304418-17489-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, jun.nie@linaro.org, gregkh@linuxfoundation.org, davem@davemloft.net, geert+renesas@glider.be, akpm@linux-foundation.org, mchehab@kernel.org, linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

Add the zx2967 thermal drivers as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64f04df..2793808 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1981,9 +1981,11 @@ S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
 F:	drivers/soc/zte/
+F:	drivers/thermal/zx*
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
 F:	Documentation/devicetree/bindings/soc/zte/
+F:	Documentation/devicetree/bindings/thermal/zx*
 F:	include/dt-bindings/soc/zx*.h
 
 ARM/ZYNQ ARCHITECTURE
-- 
2.7.4

