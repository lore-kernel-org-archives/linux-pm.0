From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND v2] power: reset: keystone: Enable COMPILE_TEST
Date: Wed, 30 Mar 2016 09:49:48 +0900
Message-ID: <1459298988-20530-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52503 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbcC3AuL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 20:50:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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
index 0a6408a39c66..0b8f7470bb9c 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -140,7 +140,8 @@ config POWER_RESET_XGENE
 
 config POWER_RESET_KEYSTONE
 	bool "Keystone reset driver"
-	depends on ARCH_KEYSTONE
+	depends on ARCH_KEYSTONE || COMPILE_TEST
+	depends on HAS_IOMEM
 	select MFD_SYSCON
 	help
 	  Reboot support for the KEYSTONE SoCs.
-- 
2.5.0

