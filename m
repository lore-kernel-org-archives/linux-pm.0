From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/5] cpufreq: ARM big LITTLE: Select PM_OPP
Date: Mon, 29 Apr 2013 18:54:44 +0530
Message-ID: <5f331211da81501872e518a1dc70fbc6f9e45591.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

ARM big LITTLE cpufreq driver uses opp layer for its functionality. Select it
in Kconfig.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index bce2195..797cbd2 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -5,6 +5,7 @@
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate
 	depends on ARM_CPU_TOPOLOGY
+	select PM_OPP
 
 config ARM_DT_BL_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver probed via DT"
-- 
1.7.12.rc2.18.g61b472e
