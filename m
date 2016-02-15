From: ahaslam@baylibre.com
Subject: [PATCH v12 2/3] ARM: imx6: pm: declare pm domain latency on power_state struct.
Date: Mon, 15 Feb 2016 11:10:52 +0100
Message-ID: <1455531053-11291-3-git-send-email-ahaslam@baylibre.com>
References: <1455531053-11291-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36176 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcBOKLI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 05:11:08 -0500
Received: by mail-wm0-f48.google.com with SMTP id g62so50661450wme.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 02:11:07 -0800 (PST)
In-Reply-To: <1455531053-11291-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, lina.iyer@linaro.org
Cc: khilman@baylibre.com, linux-pm@vger.kernel.org, geert@linux-m68k.org, mtitinger@baylibre.com, rjw@rjwysocki.net, bcousson@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

The generic_pm_domain structure uses an array of latencies to be able to
declare multiple intermediate states.

Declare a single "OFF" state with the default latencies So that the
power_off_latency_ns and power_on_latency_ns fields of generic_pm_domain
structure can be eventually removed.

[Lina: pm_genpd_init() argument changev]
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 arch/arm/mach-imx/gpc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index cfc696b..fd87205 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -374,8 +374,13 @@ static struct pu_domain imx6q_pu_domain = {
 		.name = "PU",
 		.power_off = imx6q_pm_pu_power_off,
 		.power_on = imx6q_pm_pu_power_on,
-		.power_off_latency_ns = 25000,
-		.power_on_latency_ns = 2000000,
+		.states = {
+			[0] = {
+				.power_off_latency_ns = 25000,
+				.power_on_latency_ns = 2000000,
+			},
+		},
+		.state_count = 1,
 	},
 };
 
-- 
2.6.3

