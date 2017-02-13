From: <yuantian.tang@nxp.com>
Subject: [PATCH 1/2 v4] cpufreq: qoriq: added arm64 socs support
Date: Mon, 13 Feb 2017 11:30:54 +0800
Message-ID: <1486956655-4261-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam03on0040.outbound.protection.outlook.com ([104.47.42.40]:52896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751297AbdBMDon (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Feb 2017 22:44:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, leoyang.li@nxp.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <Yuantian.Tang@nxp.com>, Tang Yuantian <yuantian.tang@nxp.com>

From: Tang Yuantian <Yuantian.Tang@nxp.com>

Add arm64 config to Kconfig to enable cpu frequency feature on
nxp arm64 socs.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
v2-v4: no change

 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 15adef4..3964383 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -324,7 +324,7 @@ endif
 
 config QORIQ_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
-	depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
+	depends on OF && COMMON_CLK && (PPC_E500MC || ARM || ARM64)
 	depends on !CPU_THERMAL || THERMAL
 	select CLK_QORIQ
 	help
-- 
2.1.0.27.g96db324

