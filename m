From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] cpufreq: scmi: add thermal dependency
Date: Tue, 13 Mar 2018 12:45:41 +0100
Message-ID: <20180313114607.2061209-2-arnd@arndb.de>
References: <20180313114607.2061209-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313114607.2061209-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

A built-in scmi cpufreq driver cannot link against a modular
thermal framework:

drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_ready':
scmi-cpufreq.c:(.text+0x40): undefined reference to `of_cpufreq_cooling_register'
drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_exit':
scmi-cpufreq.c:(.text+0x88): undefined reference to `cpufreq_cooling_unregister'

This adds a Kconfig dependency that makes sure this configuration
is not possible, while allowing all configurations that can work.
Note that disabling CPU_THERMAL means we don't care about the
THERMAL dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index d9457d1e535c..7f56fe5183f2 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -242,6 +242,7 @@ config ARM_SA1110_CPUFREQ
 config ARM_SCMI_CPUFREQ
 	tristate "SCMI based CPUfreq driver"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This adds the CPUfreq driver support for ARM platforms using SCMI
-- 
2.9.0
