From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [RESEND][PATCH 1/3] thermal: mediatek: Add cpu dynamic power cooling model.
Date: Tue, 15 Mar 2016 16:10:35 +0800
Message-ID: <1458029437-12846-2-git-send-email-dawei.chien@mediatek.com>
References: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:21434 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964942AbcCOIPI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 04:15:08 -0400
In-Reply-To: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dawei Chien <dawei.chien@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>

MT8173 cpufreq driver select of_cpufreq_power_cooling_register registering
cooling devices with dynamic power coefficient.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
This patch is base on patchset:
https://lkml.org/lkml/2015/11/17/251
---
 drivers/cpufreq/mt8173-cpufreq.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 1efba34..d8ad406 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -309,17 +309,24 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
+#define DYNAMIC_POWER "dynamic-power-coefficient"
+
 static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
 {
 	struct mtk_cpu_dvfs_info *info = policy->driver_data;
 	struct device_node *np = of_node_get(info->cpu_dev->of_node);
+	u32 capacitance = 0;
 
 	if (WARN_ON(!np))
 		return;
 
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		info->cdev = of_cpufreq_cooling_register(np,
-							 policy->related_cpus);
+		of_property_read_u32(np, DYNAMIC_POWER, &capacitance);
+
+		info->cdev = of_cpufreq_power_cooling_register(np,
+						policy->related_cpus,
+						capacitance,
+						NULL);
 
 		if (IS_ERR(info->cdev)) {
 			dev_err(info->cpu_dev,
-- 
1.7.9.5

