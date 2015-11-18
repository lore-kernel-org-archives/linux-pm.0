From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH] ARM: imx6: pm: declare pm domain latency on power_state struct.
Date: Wed, 18 Nov 2015 07:57:36 -0700
Message-ID: <1447858656-62464-1-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-6-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34967 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933042AbbKRO5o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 09:57:44 -0500
Received: by pacej9 with SMTP id ej9so47214401pac.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 06:57:43 -0800 (PST)
In-Reply-To: <1447799871-56374-6-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

The generic_pm_domain structure uses an array of latencies to be able to
declare multiple intermediate states.

Declare a single "OFF" state with the default latencies So that the
power_off_latency_ns and power_on_latency_ns fields of generic_pm_domain
structure can be eventualy removed.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[Lina: pm_genpd_init() argument change]
---
 arch/arm/mach-imx/gpc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 8e7976a..b070e06 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -368,13 +368,23 @@ static struct generic_pm_domain imx6q_arm_domain = {
 	.name = "ARM",
 };
 
+static struct genpd_power_state imx6q_arm_domain_states[] = {
+	{
+		.name = "OFF",
+		.power_off_latency_ns = 25000,
+		.power_on_latency_ns = 2000000,
+	},
+};
+
 static struct pu_domain imx6q_pu_domain = {
 	.base = {
 		.name = "PU",
 		.power_off = imx6q_pm_pu_power_off,
 		.power_on = imx6q_pm_pu_power_on,
-		.power_off_latency_ns = 25000,
-		.power_on_latency_ns = 2000000,
+		.gov = NULL,
+		.status = GPD_STATE_POWER_OFF,
+		.states = imx6q_arm_domain_states,
+		.state_count = ARRAY_SIZE(imx6q_arm_domain_states),
 	},
 };
 
-- 
2.1.4

