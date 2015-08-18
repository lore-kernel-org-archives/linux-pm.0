From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v2 6/6] ARM: berlin: register cpufreq-dt
Date: Tue, 18 Aug 2015 13:46:08 +0200
Message-ID: <1439898368-11543-7-git-send-email-antoine.tenart@free-electrons.com>
References: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The Berlin SoCs use cpufreq-dt for cpufreq. Register a platform device.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/mach-berlin/berlin.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
index ac181c6797ee..25d73870ccca 100644
--- a/arch/arm/mach-berlin/berlin.c
+++ b/arch/arm/mach-berlin/berlin.c
@@ -18,6 +18,11 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 
+static void __init berlin_init_late(void)
+{
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+}
+
 static const char * const berlin_dt_compat[] = {
 	"marvell,berlin",
 	NULL,
@@ -25,6 +30,7 @@ static const char * const berlin_dt_compat[] = {
 
 DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
 	.dt_compat	= berlin_dt_compat,
+	.init_late	= berlin_init_late,
 	/*
 	 * with DT probing for L2CCs, berlin_init_machine can be removed.
 	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
-- 
2.5.0
