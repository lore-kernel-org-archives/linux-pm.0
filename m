From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] PM / devfreq: Fix trivial typo in exynos4_bus.c
Date: Wed, 27 Nov 2013 14:50:26 +0530
Message-ID: <1385544026-24789-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36066 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab3K0JWu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2013 04:22:50 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so9592695pdj.29
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2013 01:22:49 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, trivial@kernel.org, sachin.kamat@linaro.org

Changed exynox -> Exynos.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/devfreq/exynos/exynos4_bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index cede6f71cd63..bbbfe6853b18 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -116,7 +116,7 @@ static struct bus_opp_table exynos4210_busclk_table[] = {
 };
 
 /*
- * MIF is the main control knob clock for exynox4x12 MIF/INT
+ * MIF is the main control knob clock for Exynos4x12 MIF/INT
  * clock and voltage of both mif/int are controlled.
  */
 static struct bus_opp_table exynos4x12_mifclk_table[] = {
-- 
1.7.9.5

