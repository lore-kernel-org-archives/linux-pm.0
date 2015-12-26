From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] cpufreq: acpi-cpufreq: Simplify boost-related code
Date: Sun, 27 Dec 2015 00:25:35 +0100
Message-ID: <725597086.REkFdzhlmI@vostro.rjw.lan>
References: <2196419.fjWAQbI2Nm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2196419.fjWAQbI2Nm@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The store_boost() routine is only used by store_cpb(), so move
the code from it directly to that function and rename _store_boost()
to set_boost() to make its name reflect the name of the driver
callback pointing to it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -135,7 +135,7 @@ static void boost_set_msrs(bool enable,
 	wrmsr_on_cpus(cpumask, msr_addr, msrs);
 }
 
-static int _store_boost(int val)
+static int set_boost(int val)
 {
 	get_online_cpus();
 	boost_set_msrs(val, cpu_online_mask);
@@ -158,29 +158,24 @@ static ssize_t show_freqdomain_cpus(stru
 cpufreq_freq_attr_ro(freqdomain_cpus);
 
 #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
-static ssize_t store_boost(const char *buf, size_t count)
+static ssize_t store_cpb(struct cpufreq_policy *policy, const char *buf,
+			 size_t count)
 {
 	int ret;
-	unsigned long val = 0;
+	unsigned int val = 0;
 
 	if (!acpi_cpufreq_driver.boost_supported)
 		return -EINVAL;
 
-	ret = kstrtoul(buf, 10, &val);
-	if (ret || (val > 1))
+	ret = kstrtouint(buf, 10, &val);
+	if (ret || val > 1)
 		return -EINVAL;
 
-	_store_boost((int) val);
+	set_boost(val);
 
 	return count;
 }
 
-static ssize_t store_cpb(struct cpufreq_policy *policy, const char *buf,
-			 size_t count)
-{
-	return store_boost(buf, count);
-}
-
 static ssize_t show_cpb(struct cpufreq_policy *policy, char *buf)
 {
 	return sprintf(buf, "%u\n", acpi_cpufreq_driver.boost_enabled);
@@ -905,7 +900,7 @@ static struct cpufreq_driver acpi_cpufre
 	.resume		= acpi_cpufreq_resume,
 	.name		= "acpi-cpufreq",
 	.attr		= acpi_cpufreq_attr,
-	.set_boost      = _store_boost,
+	.set_boost      = set_boost,
 };
 
 static void __init acpi_cpufreq_boost_init(void)
