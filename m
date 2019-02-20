From: Erwan Velu <erwanaliasr1@gmail.com>
Subject: [PATCH] cpufreq: Report if CPU doesn't report boost technologies
Date: Wed, 20 Feb 2019 11:10:17 +0100
Message-ID: <20190220101017.19587-1-e.velu@criteo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Erwan Velu <e.velu@criteo.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

There is some rare cases where CPB (and possibly IDA) are missing on processors.
This is the case fixed by commit f7f3dc00f612 ("x86/cpu/AMD: Fix erratum 1076 (CPB bit)") and following.

In such context, the boost status isn't reported by /sys/devices/system/cpu/cpufreq/boost.

This commit is about printing a message reporting the CPU doesn't expose the boost capabilities.
This message could help debugging platforms hit by this phenomena.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d62fd374d5c7..06d32d21dac0 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -916,8 +916,10 @@ static void __init acpi_cpufreq_boost_init(void)
 {
 	int ret;
 
-	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)))
+	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA))) {
+		pr_debug("CPU doesn't expose boost capabilities\n");
 		return;
+	}
 
 	acpi_cpufreq_driver.set_boost = set_boost;
 	acpi_cpufreq_driver.boost_enabled = boost_state(0);
-- 
2.20.1
