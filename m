From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] cpufreq: Enable big.LITTLE cpufreq driver on arm64
Date: Fri,  9 May 2014 17:40:31 +0100
Message-ID: <1399653631-4938-3-git-send-email-broonie@kernel.org>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39432 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756740AbaEIQlG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 12:41:06 -0400
In-Reply-To: <1399653631-4938-1-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

There are arm64 big.LITTLE systems so enable the big.LITTLE cpufreq driver.
While IKS is not available for these systems the driver is still useful
since it manages clusters with shared frequencies which is the common case
for these systems.

Long term combining the cpufreq-cpu0 and big.LITTLE drivers may be a
more sensible option but that is substantially more complex especially
in the case of IKS.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 6e05a1e18e52..6a7dd3e958d5 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -5,7 +5,8 @@
 # big LITTLE core layer and glue drivers
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver"
-	depends on ARM && BIG_LITTLE && ARM_CPU_TOPOLOGY && HAVE_CLK
+	depends on (BIG_LITTLE && ARM_CPU_TOPOLOGY) || (ARM64 && SMP)
+	depends on HAVE_CLK
 	select PM_OPP
 	help
 	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
-- 
2.0.0.rc2

