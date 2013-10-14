From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 13/14] ARM: mvebu: register the cpuidle driver for the Armada XP SoCs
Date: Mon, 14 Oct 2013 15:58:25 +0200
Message-ID: <1381759106-15004-14-git-send-email-gregory.clement@free-electrons.com>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60892 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756737Ab3JNN67 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 09:58:59 -0400
In-Reply-To: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

The cpuidle is a platform driver so we have to register the device
during the initialization of the boards.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index e2acff9..885d511 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -29,6 +29,10 @@
 #include "common.h"
 #include "coherency.h"
 
+static struct platform_device armada_xp_cpuidle_device = {
+	.name = "cpuidle-armada-370-xp",
+};
+
 static void __init armada_370_xp_map_io(void)
 {
 	debug_ll_io_init();
@@ -48,6 +52,8 @@ static void __init armada_370_xp_timer_and_clk_init(void)
 static void __init armada_370_xp_dt_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	if (of_machine_is_compatible("marvell,armadaxp"))
+		platform_device_register(&armada_xp_cpuidle_device);
 }
 
 static const char * const armada_370_xp_dt_compat[] = {
-- 
1.8.1.2

