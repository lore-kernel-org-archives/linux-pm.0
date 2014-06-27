From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 10/16] ARM: mvebu: Export the SCU address
Date: Fri, 27 Jun 2014 15:22:51 +0200
Message-ID: <1403875377-940-11-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42115 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753292AbaF0NYA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:24:00 -0400
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

The SCU address will be needed in other files than the board file, for
example in pmsu.c. So this patch adds a function allowing to get the
SCU address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 9 +++++++--
 arch/arm/mach-mvebu/common.h   | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 8bb742fdf5ca..4c1d955f51c0 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -33,14 +33,14 @@
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
@@ -50,6 +50,11 @@ static void __init mvebu_scu_enable(void)
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
index 6ad62cf8352c..9beb0c45ba59 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -25,4 +25,6 @@ void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr);
 
 void armada_xp_cpu_die(unsigned int cpu);
 
+void __iomem *mvebu_get_scu_base(void);
+
 #endif
-- 
1.8.1.2

