From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] ARM: defconfigs: use CONFIG_CPUFREQ_DT
Date: Mon, 15 Dec 2014 09:48:19 +0530
Message-ID: <63217079d4b61d835fed98198ae1e3f0e6329de1.1418617005.git.viresh.kumar@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arm@kernel.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org, olof@lixom.net, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

CONFIG_GENERIC_CPUFREQ_CPU0 disappeared with commit bbcf071969b20f
("cpufreq: cpu0: rename driver and internals to 'cpufreq_dt'") and some
defconfigs are still using it instead of the new one.

Use the renamed CONFIG_CPUFREQ_DT generic driver.

Cc: <stable@vger.kernel.org>        # 3.18
Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 arch/arm/configs/shmobile_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9d7a32f93fcf..f86cb86afc66 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -445,4 +445,4 @@ CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_CRYPTO_DEV_TEGRA_AES=y
-CONFIG_GENERIC_CPUFREQ_CPU0=y
+CONFIG_CPUFREQ_DT=y
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index d7346ad51043..bfe79d5b8213 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -176,5 +176,5 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPU_THERMAL=y
-CONFIG_GENERIC_CPUFREQ_CPU0=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_REGULATOR_DA9210=y
-- 
2.2.0
