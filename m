From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2] power: reset: keystone: Enable COMPILE_TEST
Date: Fri, 04 Mar 2016 10:04:40 +0900
Message-ID: <1457053480-20091-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:17737 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbcCDBEy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 20:04:54 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Enable the COMPILE_TEST to get build coverage, except on platforms
!HAS_IOMEM (required by selected MFD_SYSCON).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v1:
1. Fix comments from Arnd: Change this to COMPILE_TEST and then add
   required HAS_IOMEM dependency.
---
 drivers/power/reset/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 0a6408a39c66..8e6279d75c93 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -140,7 +140,8 @@ config POWER_RESET_XGENE
 
 config POWER_RESET_KEYSTONE
 	bool "Keystone reset driver"
-	depends on ARCH_KEYSTONE
+	depends on ARCH_KEYSTONE || COMPILE_TEST
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MFD_SYSCON
 	help
 	  Reboot support for the KEYSTONE SoCs.
-- 
2.5.0

