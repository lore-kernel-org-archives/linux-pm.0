From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 1/3] cpufreq: acpi-cpufreq: Fix up the handling of the cpb sysfs attribute
Date: Tue, 21 Jul 2015 00:13:36 +0200
Message-ID: <1936782.1GAQA9zHNp@vostro.rjw.lan>
References: <10273534.kyzK8rhvUz@vostro.rjw.lan> <1504169.B7TvYS4CS0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1504169.B7TvYS4CS0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pan Xinhui <xinhuix.pan@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The cpb sysfs attribute is only exposed by the ACPI cpufreq driver
after a runtime check.  For this purpose, the driver keeps a NULL
placeholder in its table of sysfs attributes and replaces the NULL
with a pointer to an attribute structure if it decides to expose
cpb.

That is confusing, so make the driver set a pointer to the cpb
attribute structure upfront and replace it with NULL if the
attribute should not be exposed instead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -886,7 +886,9 @@ static int acpi_cpufreq_resume(struct cp
 static struct freq_attr *acpi_cpufreq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	&freqdomain_cpus,
-	NULL,	/* this is a placeholder for cpb, do not remove */
+#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
+	&cpb,
+#endif
 	NULL,
 };
 
@@ -959,17 +961,16 @@ static int __init acpi_cpufreq_init(void
 	 * only if configured. This is considered legacy code, which
 	 * will probably be removed at some point in the future.
 	 */
-	if (check_amd_hwpstate_cpu(0)) {
-		struct freq_attr **iter;
-
-		pr_debug("adding sysfs entry for cpb\n");
+	if (!check_amd_hwpstate_cpu(0)) {
+		struct freq_attr **attr;
 
-		for (iter = acpi_cpufreq_attr; *iter != NULL; iter++)
-			;
+		pr_debug("CPB unsupported, do not expose it\n");
 
-		/* make sure there is a terminator behind it */
-		if (iter[1] == NULL)
-			*iter = &cpb;
+		for (attr = acpi_cpufreq_attr; *attr; attr++)
+			if (*attr == &cpb) {
+				*attr = NULL;
+				break;
+			}
 	}
 #endif
 	acpi_cpufreq_boost_init();

