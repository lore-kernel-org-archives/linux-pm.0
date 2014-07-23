From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 09/16] ARM: mvebu: export the SCU address
Date: Wed, 23 Jul 2014 15:00:46 +0200
Message-ID: <1406120453-29291-10-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40709 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753813AbaGWNBF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 09:01:05 -0400
In-Reply-To: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

The SCU address will be needed in other files than board-v7.c,
especially in pmsu.c for cpuidle related activities. So this patch
adds a function that allows to retrieve the virtual address at which
the SCU has been mapped.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 9 +++++++--
 arch/arm/mach-mvebu/common.h   | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index f244622..6478626 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -34,14 +34,14 @@
 #include "coherency.h"
 #include "mvebu-soc-id.h"
 
+static void __iomem *scu_base;
+
 /*
  * Enables the SCU when available. Obviously, this is only useful on
  * Cortex-A based SOCs, not on PJ4B based ones.
  */
 static void __init mvebu_scu_enable(void)
 {
-	void __iomem *scu_base;
-
 	struct device_node *np =
 		of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 	if (np) {
@@ -51,6 +51,11 @@ static void __init mvebu_scu_enable(void)
 	}
 }
 
+void __iomem *mvebu_get_scu_base(void)
+{
+	return scu_base;
+}
+
 /*
  * Early versions of Armada 375 SoC have a bug where the BootROM
  * leaves an external data abort pending. The kernel is hit by this
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index a97778e..3ccb40c 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -23,4 +23,6 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
 void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr);
 int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev);
 
+void __iomem *mvebu_get_scu_base(void);
+
 #endif
-- 
2.0.0

