From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] cpufreq: mediatek: fix build error
Date: Mon, 16 Nov 2015 22:27:55 +0100
Message-ID: <3905943.jgsUmEgmnP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The recently added mt8173 cpufreq driver relies on the cpu topology
that is always present on ARM64 but optional on ARM32:

drivers/cpufreq/mt8173-cpufreq.c: In function 'mtk_cpufreq_init':
drivers/cpufreq/mt8173-cpufreq.c:441:30: error: 'cpu_topology' undeclared (first use in this function)
  cpumask_copy(policy->cpus, &cpu_topology[policy->cpu].core_sibling);

This refines the Kconfig dependencies so that we can still build on
ARM32, but only if COMPILE_TEST is selected and the CPU topology
code is present.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1582c1c016b0..8014c2307332 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -84,6 +84,7 @@ config ARM_KIRKWOOD_CPUFREQ
 config ARM_MT8173_CPUFREQ
 	bool "Mediatek MT8173 CPUFreq support"
 	depends on ARCH_MEDIATEK && REGULATOR
+	depends on ARM64 || (ARM_CPU_TOPOLOGY && COMPILE_TEST)
 	depends on !CPU_THERMAL || THERMAL=y
 	select PM_OPP
 	help
