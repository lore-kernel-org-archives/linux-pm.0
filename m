From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v1] PM / devfreq: exynos-ppmu : Handle return value of clk_prepare_enable
Date: Fri, 19 May 2017 16:26:04 +0530
Message-ID: <1495191364-16015-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35093 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdESK5b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2017 06:57:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org, kgene@kernel.org, javier@osg.samsung.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 9b73509..8f6537a 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -648,7 +648,11 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
 			dev_name(&pdev->dev), desc[i].name);
 	}
 
-	clk_prepare_enable(info->ppmu.clk);
+	ret = clk_prepare_enable(info->ppmu.clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to prepare ppmu clock\n");
+		return ret;
+	}
 
 	return 0;
 }
-- 
1.9.1
