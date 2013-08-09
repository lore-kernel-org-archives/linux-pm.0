From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/2] cpuidle: calxeda: add missing __iomem annotation
Date: Fri, 09 Aug 2013 16:09:15 +0900
Message-ID: <000501ce94cf$5c12cc40$143864c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:29130 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967344Ab3HIHJS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2013 03:09:18 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR900CR657C1JS0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 09 Aug 2013 16:09:16 +0900 (KST)
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: 'Daniel Lezcano' <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Jingoo Han <jg1.han@samsung.com>

Added missing __iomem annotation in order to fix the following
sparse warnings:

drivers/cpuidle/cpuidle-calxeda.c:44:24: warning: incorrect type in argument 1 (different address spaces)
drivers/cpuidle/cpuidle-calxeda.c:44:24:    expected void [noderef] <asn:2>*<noident>
drivers/cpuidle/cpuidle-calxeda.c:44:24:    got void *extern [addressable] [toplevel] scu_base_addr
drivers/cpuidle/cpuidle-calxeda.c:56:24: warning: incorrect type in argument 1 (different address spaces)
drivers/cpuidle/cpuidle-calxeda.c:56:24:    expected void [noderef] <asn:2>*<noident>
drivers/cpuidle/cpuidle-calxeda.c:56:24:    got void *extern [addressable] [toplevel] scu_base_addr

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/cpuidle/cpuidle-calxeda.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index 0e6e408..3460584 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -35,7 +35,7 @@
 #include <asm/cp15.h>
 
 extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
-extern void *scu_base_addr;
+extern void __iomem *scu_base_addr;
 
 static noinline void calxeda_idle_restore(void)
 {
-- 
1.7.10.4


