From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: intel_pstate: remove incorrect __initconst annotation
Date: Fri,  8 Jun 2018 17:14:02 +0200
Message-ID: <20180608151411.3892739-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Doug Smythies <doug.smythies@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We get a build warning about the newly introduced code in
intel_pstate_init_cpu() that references an __initconst variable after
it has been freed:

WARNING: vmlinux.o(.text+0xf9eca2): Section mismatch in reference from the function intel_pstate_init_cpu() to the variable .init.rodata:intel_pstate_hwp_boost_ids
The function intel_pstate_init_cpu() references
the variable __initconst intel_pstate_hwp_boost_ids.
This is often because intel_pstate_init_cpu lacks a __initconst
annotation or the annotation of intel_pstate_hwp_boost_ids is wrong.

This removes the annotation to keep the variable around at
runtime.

Fixes: f50f70793d78 ("cpufreq: intel_pstate: enable boost for Skylake Xeon")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2065724dbffc..380936700165 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1794,7 +1794,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
 	{}
 };
 
-static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] __initconst = {
+static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
 	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
 	{}
-- 
2.9.0
