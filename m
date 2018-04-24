From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2] cpufreq: armada-37xx: driver relies on cpufreq-dt
Date: Tue, 24 Apr 2018 12:27:38 +0200
Message-ID: <20180424102738.22967-1-miquel.raynal@bootlin.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Armada-37xx driver registers a cpufreq-dt driver. Not having
CONFIG_CPUFREQ_DT selected leads to a silent abort during the probe.
Prevent that situation by having the former depending on the latter.

Fixes: 92ce45fb875d7 ("cpufreq: Add DVFS support for Armada 37xx")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes since v1
================
 * Changed 'select' by 'depends on'
 * Added Fixes + Cc: stable tags

 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 7f56fe5183f2..2c64ee68ea8b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -20,7 +20,7 @@ config ACPI_CPPC_CPUFREQ
 
 config ARM_ARMADA_37XX_CPUFREQ
 	tristate "Armada 37xx CPUFreq support"
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU && CPUFREQ_DT
 	help
 	  This adds the CPUFreq driver support for Marvell Armada 37xx SoCs.
 	  The Armada 37xx PMU supports 4 frequency and VDD levels.
-- 
2.14.1
