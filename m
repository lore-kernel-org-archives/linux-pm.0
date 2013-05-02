From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH, RFC 02/22] cpufreq: ARM_DT_BL_CPUFREQ needs ARM_CPU_TOPOLOGY
Date: Thu,  2 May 2013 17:16:06 +0200
Message-ID: <1367507786-505303-3-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The big.LITTLE cpufreq driver uses the CPU topology API, which
needs to be reflected in Kconfig to prevent broken configurations.

warning: (ARM_DT_BL_CPUFREQ) selects ARM_BIG_LITTLE_CPUFREQ which
has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && ARM && ARM_CPU_TOPOLOGY)

Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index f3af18b..3fd6bdf 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -10,6 +10,7 @@ config ARM_DT_BL_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver probed via DT"
 	select ARM_BIG_LITTLE_CPUFREQ
 	depends on OF && HAVE_CLK
+	depends on ARM_CPU_TOPOLOGY
 	help
 	  This enables the Generic CPUfreq driver for ARM big.LITTLE platform.
 	  This gets frequency tables from DT.
-- 
1.8.1.2
