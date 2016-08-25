From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] PM / devfreq: fix Kconfig indent style
Date: Thu, 25 Aug 2016 20:06:14 +0800
Message-ID: <20160825120614.511-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:20790 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933048AbcHYMK3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Aug 2016 08:10:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>

Use tab rather than space to indent, and tab + two spaces to indent
help message.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/devfreq/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index a5be56e..86d06ab 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -91,14 +91,14 @@ config ARM_EXYNOS_BUS_DEVFREQ
 	  This does not yet operate with optimal voltages.
 
 config ARM_TEGRA_DEVFREQ
-       tristate "Tegra DEVFREQ Driver"
-       depends on ARCH_TEGRA_124_SOC
-       select DEVFREQ_GOV_SIMPLE_ONDEMAND
-       select PM_OPP
-       help
-         This adds the DEVFREQ driver for the Tegra family of SoCs.
-         It reads ACTMON counters of memory controllers and adjusts the
-         operating frequencies and voltages with OPP support.
+	tristate "Tegra DEVFREQ Driver"
+	depends on ARCH_TEGRA_124_SOC
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select PM_OPP
+	help
+	  This adds the DEVFREQ driver for the Tegra family of SoCs.
+	  It reads ACTMON counters of memory controllers and adjusts the
+	  operating frequencies and voltages with OPP support.
 
 source "drivers/devfreq/event/Kconfig"
 
-- 
2.9.3

