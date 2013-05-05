From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] Cpufreq: Fix incorrect dependecies for ARM SA11xx drivers
Date: Sun,  5 May 2013 16:18:08 +0400
Message-ID: <1367756288-13422-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:56835 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab3EEMSn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 5 May 2013 08:18:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index a1488f5..534fcb8 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -47,7 +47,7 @@ config CPU_FREQ_STAT_DETAILS
 
 choice
 	prompt "Default CPUFreq governor"
-	default CPU_FREQ_DEFAULT_GOV_USERSPACE if CPU_FREQ_SA1100 || CPU_FREQ_SA1110
+	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
 	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 	help
 	  This option sets which CPUFreq governor shall be loaded at
-- 
1.8.1.5

