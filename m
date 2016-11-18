From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] ACPI / processor: Make acpi_processor_ppc_has_changed() void
Date: Fri, 18 Nov 2016 13:57:54 +0100
Message-ID: <2026068.mxVXsQBFmT@vostro.rjw.lan>
References: <1975886.qL3AyWerjl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1975886.qL3AyWerjl@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The return value of acpi_processor_ppc_has_changed() is never used,
so make it void.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_perflib.c |   10 ++++------
 include/acpi/processor.h         |    2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -157,7 +157,7 @@ static void acpi_processor_ppc_ost(acpi_
 				  status, NULL);
 }
 
-int acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
+void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
 {
 	int ret;
 
@@ -168,7 +168,7 @@ int acpi_processor_ppc_has_changed(struc
 		 */
 		if (event_flag)
 			acpi_processor_ppc_ost(pr->handle, 1);
-		return 0;
+		return;
 	}
 
 	ret = acpi_processor_get_platform_limit(pr);
@@ -182,10 +182,8 @@ int acpi_processor_ppc_has_changed(struc
 		else
 			acpi_processor_ppc_ost(pr->handle, 0);
 	}
-	if (ret < 0)
-		return (ret);
-	else
-		return cpufreq_update_policy(pr->id);
+	if (ret >= 0)
+		cpufreq_update_policy(pr->id);
 }
 
 int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
Index: linux-pm/include/acpi/processor.h
===================================================================
--- linux-pm.orig/include/acpi/processor.h
+++ linux-pm/include/acpi/processor.h
@@ -295,7 +295,7 @@ static inline void acpi_processor_ffh_cs
 #ifdef CONFIG_CPU_FREQ
 void acpi_processor_ppc_init(void);
 void acpi_processor_ppc_exit(void);
-int acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag);
+void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag);
 extern int acpi_processor_get_bios_limit(int cpu, unsigned int *limit);
 #else
 static inline void acpi_processor_ppc_init(void)
