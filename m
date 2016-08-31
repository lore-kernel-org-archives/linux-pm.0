From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 10/10] cpuidle: cpuidle-cps: Enable use with MIPSr6 CPUs.
Date: Wed, 31 Aug 2016 11:44:39 +0100
Message-ID: <1472640279-26593-11-git-send-email-matt.redfearn@imgtec.com>
References: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Matt Redfearn <matt.redfearn@imgtec.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch enables the MIPS CPS driver for MIPSr6 CPUs.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>

---

 drivers/cpuidle/Kconfig.mips  | 2 +-
 drivers/cpuidle/cpuidle-cps.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.mips b/drivers/cpuidle/Kconfig.mips
index 4102be01d06a..512ee37b374b 100644
--- a/drivers/cpuidle/Kconfig.mips
+++ b/drivers/cpuidle/Kconfig.mips
@@ -5,7 +5,7 @@ config MIPS_CPS_CPUIDLE
 	bool "CPU Idle driver for MIPS CPS platforms"
 	depends on CPU_IDLE && MIPS_CPS
 	depends on SYS_SUPPORTS_MIPS_CPS
-	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT || CPU_MIPSR6
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select MIPS_CPS_PM
 	default y
diff --git a/drivers/cpuidle/cpuidle-cps.c b/drivers/cpuidle/cpuidle-cps.c
index 1adb6980b707..926ba9871c62 100644
--- a/drivers/cpuidle/cpuidle-cps.c
+++ b/drivers/cpuidle/cpuidle-cps.c
@@ -163,7 +163,7 @@ static int __init cps_cpuidle_init(void)
 		core = cpu_data[cpu].core;
 		device = &per_cpu(cpuidle_dev, cpu);
 		device->cpu = cpu;
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 		cpumask_copy(&device->coupled_cpus, &cpu_sibling_map[cpu]);
 #endif
 
-- 
2.7.4
