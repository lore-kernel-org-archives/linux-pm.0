From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] cpufreq: enable ARM drivers on arm64
Date: Mon, 24 Feb 2014 11:27:57 +0900
Message-ID: <1393208877-15797-1-git-send-email-broonie@kernel.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rob Herring <rob.herring@calxeda.com>

Enable cpufreq and power kconfig menus on arm64 along with arm cpufreq
drivers. The power menu is needed for OPP support. At least on Calxeda
systems, the same cpufreq driver is used for arm and arm64 based
systems.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/Kconfig      | 8 ++++++++
 drivers/cpufreq/Kconfig | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fea7b47..939e95a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -327,6 +327,14 @@ source "drivers/cpuidle/Kconfig"
 
 endmenu
 
+menu "Power management options"
+
+source "kernel/power/Kconfig"
+
+source "drivers/cpufreq/Kconfig"
+
+endmenu
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 4b029c0..1fbe11f 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -200,7 +200,7 @@ source "drivers/cpufreq/Kconfig.x86"
 endmenu
 
 menu "ARM CPU frequency scaling drivers"
-depends on ARM
+depends on ARM || ARM64
 source "drivers/cpufreq/Kconfig.arm"
 endmenu
 
-- 
1.9.0.rc3

