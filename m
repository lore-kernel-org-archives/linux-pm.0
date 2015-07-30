From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 2/3] ARM: berlin: register cpufreq-dt for the BG2Q
Date: Thu, 30 Jul 2015 14:35:51 +0200
Message-ID: <1438259752-16320-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1438259752-16320-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36023 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751992AbbG3Mf4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 08:35:56 -0400
In-Reply-To: <1438259752-16320-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The BG2Q SoC uses cpufreq-dt for cpufreq. Register a platform device for
this.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/mach-berlin/berlin.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
index ac181c6797ee..0de906374994 100644
--- a/arch/arm/mach-berlin/berlin.c
+++ b/arch/arm/mach-berlin/berlin.c
@@ -15,9 +15,21 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 
+static const struct of_device_id berlin2q_match[] = {
+	{ .compatible = "marvell,berlin2q" },
+	{ },
+};
+
+static void __init berlin_init_late(void)
+{
+	if (of_find_matching_node(NULL, berlin2q_match))
+		platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+}
+
 static const char * const berlin_dt_compat[] = {
 	"marvell,berlin",
 	NULL,
@@ -25,6 +37,7 @@ static const char * const berlin_dt_compat[] = {
 
 DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
 	.dt_compat	= berlin_dt_compat,
+	.init_late	= berlin_init_late,
 	/*
 	 * with DT probing for L2CCs, berlin_init_machine can be removed.
 	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
-- 
2.5.0

