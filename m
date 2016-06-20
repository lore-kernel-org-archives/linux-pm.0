From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH] thermal: hisilicon: Add dependency on the clock driver to allow frequency scaling
Date: Mon, 20 Jun 2016 17:46:36 +0530
Message-ID: <f6bbd7ddf978001aa0f1c6fb8fc454a30241d0a8.1466424352.git.amit.kucheria@linaro.org>
References: <32d418f24a4da44ad4ca5b2b1276ffcea2aa7d6c.1466424352.git.amit.kucheria@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35442 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbcFTMXc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 08:23:32 -0400
Received: by mail-pf0-f177.google.com with SMTP id c2so53938726pfa.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 05:21:58 -0700 (PDT)
In-Reply-To: <32d418f24a4da44ad4ca5b2b1276ffcea2aa7d6c.1466424352.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, leo.yan@linaro.org, Eduardo Valentin <edubezval@gmail.com>, kongxinwei <kong.kongxinwei@hisilicon.com>, Zhang Rui <rui.zhang@intel.com>

The Hisilicon clock stub driver is needed to allow the thermal drivers to
actually scale the frequency. Make it an automatic dependency.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 22ae1f7..4e843f7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -178,6 +178,7 @@ config THERMAL_EMULATION
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
 	depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
+	select STUB_CLK_HI6220
 	help
 	  Enable this to plug hisilicon's thermal sensor driver into the Linux
 	  thermal framework. cpufreq is used as the cooling device to throttle
-- 
2.5.0

