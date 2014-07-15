From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH v3 6/7] PM / devfreq: exynos: Fix typo in macro
Date: Wed, 16 Jul 2014 00:05:54 +0530
Message-ID: <1405449354-26390-1-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-7-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36550 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932786AbaGOSgI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jul 2014 14:36:08 -0400
In-Reply-To: <1400779322-4410-7-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: rjw@sisk.pl, t.figa@samsung.com, kesavan.abhilash@gmail.com, devicetree@vger.kernel.org

Fix PPMU_BEVTSEL macro being used in the PPMU driver.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/devfreq/exynos/exynos_ppmu.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos/exynos_ppmu.h b/drivers/devfreq/exynos/exynos_ppmu.h
index 71f17ba..d5c14eb 100644
--- a/drivers/devfreq/exynos/exynos_ppmu.h
+++ b/drivers/devfreq/exynos/exynos_ppmu.h
@@ -37,7 +37,7 @@
 
 #define PPMU_BEVT0SEL		0x1000
 #define PPMU_BEVTSEL_OFFSET	0x100
-#define PPMU_BEVTSEL(x)		(PPMU_BEVT0SEL + (ch * PPMU_BEVTSEL_OFFSET))
+#define PPMU_BEVTSEL(ch)	(PPMU_BEVT0SEL + (ch * PPMU_BEVTSEL_OFFSET))
 
 /* For Event Selection */
 #define RD_DATA_COUNT		0x5
-- 
1.7.9.5

