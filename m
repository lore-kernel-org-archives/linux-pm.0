From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH 2/4] cpufreq: mt8173: remove redundant regulator_get_voltage() call
Date: Sun, 29 Nov 2015 16:31:36 +0800
Message-ID: <1448785898-17838-2-git-send-email-pi-cheng.chen@linaro.org>
References: <1448785898-17838-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35732 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbbK2Ibt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Nov 2015 03:31:49 -0500
Received: by pacej9 with SMTP id ej9so152807965pac.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2015 00:31:48 -0800 (PST)
In-Reply-To: <1448785898-17838-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Remove redundant regulator_get_voltage() call to get Vsram value
since it will be obtained later at the beginning of voltage tracking
loop.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
 drivers/cpufreq/mt8173-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index c438109..750cda7 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -59,7 +59,6 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 	int old_vproc, old_vsram, new_vsram, vsram, vproc, ret;
 
 	old_vproc = regulator_get_voltage(proc_reg);
-	old_vsram = regulator_get_voltage(sram_reg);
 	/* Vsram should not exceed the maximum allowed voltage of SoC. */
 	new_vsram = min(new_vproc + MIN_VOLT_SHIFT, MAX_VOLT_LIMIT);
 
-- 
1.9.1

