From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH RFC v2 6/7] PM / devfreq: exynos: Fix typo in macro
Date: Thu, 22 May 2014 22:52:01 +0530
Message-ID: <1400779322-4410-7-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:36055 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbaEVRWm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 13:22:42 -0400
In-Reply-To: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, t.figa@samsung.com, myungjoo.ham@samsung.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: kesavan.abhilash@gmail.com

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

