From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 05/14] cpufreq: exynos4x12: iounmap in error path
Date: Mon,  2 Feb 2015 16:58:08 -0400
Message-ID: <1422910697-5920-6-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:44742 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965055AbbBBU7C (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 15:59:02 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so86853546pab.12
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2015 12:59:01 -0800 (PST)
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>

When error occurs, allow systems to release iomapped area.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/exynos4x12-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index 3d067f2..3da36baf 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -232,6 +232,7 @@ err_mout_mpll:
 err_moutcore:
 	clk_put(cpu_clk);
 
+	iounmap(info->cmu_regs);
 	of_node_put(np);
 	pr_debug("%s: failed initialization\n", __func__);
 
-- 
2.1.3

