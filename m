From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 07/10] thermal: exynos: allow compile test
Date: Sun, 13 Sep 2015 19:31:36 -0700
Message-ID: <1442197899-5952-8-git-send-email-edubezval@gmail.com>
References: <1442197899-5952-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36852 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbbINCcD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2015 22:32:03 -0400
In-Reply-To: <1442197899-5952-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, linux-samsung-soc@vger.kernel.org

Adding COMPILE_TEST flag to exynos driver to facilitate
maintenance.

Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c2c8cba..202905e8 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -345,7 +345,7 @@ source "drivers/thermal/ti-soc-thermal/Kconfig"
 endmenu
 
 menu "Samsung thermal drivers"
-depends on ARCH_EXYNOS
+depends on ARCH_EXYNOS || COMPILE_TEST
 source "drivers/thermal/samsung/Kconfig"
 endmenu
 
-- 
2.5.0

