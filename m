From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 2/3] ACPI / processor: Drop an unused argument of a cleanup routine
Date: Tue, 21 Jul 2015 00:14:39 +0200
Message-ID: <6224794.B2h7S2y5Ly@vostro.rjw.lan>
References: <10273534.kyzK8rhvUz@vostro.rjw.lan> <1504169.B7TvYS4CS0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504169.B7TvYS4CS0@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pan Xinhui <xinhuix.pan@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

acpi_processor_unregister_performance() actually doesn't use its
first argument, so drop it and update the callers accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_perflib.c    |    4 +---
 drivers/cpufreq/acpi-cpufreq.c      |    5 ++---
 drivers/cpufreq/e_powersaver.c      |    2 +-
 drivers/cpufreq/ia64-acpi-cpufreq.c |    5 ++---
 drivers/cpufreq/powernow-k7.c       |    4 ++--
 drivers/cpufreq/powernow-k8.c       |    5 ++---
 drivers/xen/xen-acpi-processor.c    |   16 ++++++----------
 include/acpi/processor.h            |    5 +----
 8 files changed, 17 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -780,9 +780,7 @@ acpi_processor_register_performance(stru
 
 EXPORT_SYMBOL(acpi_processor_register_performance);
 
-void
-acpi_processor_unregister_performance(struct acpi_processor_performance
-				      *performance, unsigned int cpu)
+void acpi_processor_unregister_performance(unsigned int cpu)
 {
 	struct acpi_processor *pr;
 
Index: linux-pm/include/acpi/processor.h
===================================================================
--- linux-pm.orig/include/acpi/processor.h
+++ linux-pm/include/acpi/processor.h
@@ -228,10 +228,7 @@ extern int acpi_processor_preregister_pe
 
 extern int acpi_processor_register_performance(struct acpi_processor_performance
 					       *performance, unsigned int cpu);
-extern void acpi_processor_unregister_performance(struct
-						  acpi_processor_performance
-						  *performance,
-						  unsigned int cpu);
+extern void acpi_processor_unregister_performance(unsigned int cpu);
 
 /* note: this locks both the calling module and the processor module
          if a _PPC object exists, rmmod is disallowed then */
Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -844,7 +844,7 @@ static int acpi_cpufreq_cpu_init(struct
 err_freqfree:
 	kfree(data->freq_table);
 err_unreg:
-	acpi_processor_unregister_performance(perf, cpu);
+	acpi_processor_unregister_performance(cpu);
 err_free_mask:
 	free_cpumask_var(data->freqdomain_cpus);
 err_free:
@@ -862,8 +862,7 @@ static int acpi_cpufreq_cpu_exit(struct
 
 	if (data) {
 		policy->driver_data = NULL;
-		acpi_processor_unregister_performance(data->acpi_data,
-						      data->acpi_perf_cpu);
+		acpi_processor_unregister_performance(data->acpi_perf_cpu);
 		free_cpumask_var(data->freqdomain_cpus);
 		kfree(data->freq_table);
 		kfree(data);
Index: linux-pm/drivers/cpufreq/e_powersaver.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/e_powersaver.c
+++ linux-pm/drivers/cpufreq/e_powersaver.c
@@ -78,7 +78,7 @@ static int eps_acpi_init(void)
 static int eps_acpi_exit(struct cpufreq_policy *policy)
 {
 	if (eps_acpi_cpu_perf) {
-		acpi_processor_unregister_performance(eps_acpi_cpu_perf, 0);
+		acpi_processor_unregister_performance(0);
 		free_cpumask_var(eps_acpi_cpu_perf->shared_cpu_map);
 		kfree(eps_acpi_cpu_perf);
 		eps_acpi_cpu_perf = NULL;
Index: linux-pm/drivers/cpufreq/ia64-acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -313,7 +313,7 @@ acpi_cpufreq_cpu_init (
  err_freqfree:
 	kfree(data->freq_table);
  err_unreg:
-	acpi_processor_unregister_performance(&data->acpi_data, cpu);
+	acpi_processor_unregister_performance(cpu);
  err_free:
 	kfree(data);
 	acpi_io_data[cpu] = NULL;
@@ -332,8 +332,7 @@ acpi_cpufreq_cpu_exit (
 
 	if (data) {
 		acpi_io_data[policy->cpu] = NULL;
-		acpi_processor_unregister_performance(&data->acpi_data,
-		                                      policy->cpu);
+		acpi_processor_unregister_performance(policy->cpu);
 		kfree(data);
 	}
 
Index: linux-pm/drivers/cpufreq/powernow-k7.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/powernow-k7.c
+++ linux-pm/drivers/cpufreq/powernow-k7.c
@@ -421,7 +421,7 @@ static int powernow_acpi_init(void)
 	return 0;
 
 err2:
-	acpi_processor_unregister_performance(acpi_processor_perf, 0);
+	acpi_processor_unregister_performance(0);
 err1:
 	free_cpumask_var(acpi_processor_perf->shared_cpu_map);
 err05:
@@ -661,7 +661,7 @@ static int powernow_cpu_exit(struct cpuf
 {
 #ifdef CONFIG_X86_POWERNOW_K7_ACPI
 	if (acpi_processor_perf) {
-		acpi_processor_unregister_performance(acpi_processor_perf, 0);
+		acpi_processor_unregister_performance(0);
 		free_cpumask_var(acpi_processor_perf->shared_cpu_map);
 		kfree(acpi_processor_perf);
 	}
Index: linux-pm/drivers/cpufreq/powernow-k8.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/powernow-k8.c
+++ linux-pm/drivers/cpufreq/powernow-k8.c
@@ -795,7 +795,7 @@ err_out_mem:
 	kfree(powernow_table);
 
 err_out:
-	acpi_processor_unregister_performance(&data->acpi_data, data->cpu);
+	acpi_processor_unregister_performance(data->cpu);
 
 	/* data->acpi_data.state_count informs us at ->exit()
 	 * whether ACPI was used */
@@ -863,8 +863,7 @@ static int fill_powernow_table_fidvid(st
 static void powernow_k8_cpu_exit_acpi(struct powernow_k8_data *data)
 {
 	if (data->acpi_data.state_count)
-		acpi_processor_unregister_performance(&data->acpi_data,
-				data->cpu);
+		acpi_processor_unregister_performance(data->cpu);
 	free_cpumask_var(data->acpi_data.shared_cpu_map);
 }
 
Index: linux-pm/drivers/xen/xen-acpi-processor.c
===================================================================
--- linux-pm.orig/drivers/xen/xen-acpi-processor.c
+++ linux-pm/drivers/xen/xen-acpi-processor.c
@@ -560,11 +560,9 @@ static int __init xen_acpi_processor_ini
 
 	return 0;
 err_unregister:
-	for_each_possible_cpu(i) {
-		struct acpi_processor_performance *perf;
-		perf = per_cpu_ptr(acpi_perf_data, i);
-		acpi_processor_unregister_performance(perf, i);
-	}
+	for_each_possible_cpu(i)
+		acpi_processor_unregister_performance(i);
+
 err_out:
 	/* Freeing a NULL pointer is OK: alloc_percpu zeroes. */
 	free_acpi_perf_data();
@@ -579,11 +577,9 @@ static void __exit xen_acpi_processor_ex
 	kfree(acpi_ids_done);
 	kfree(acpi_id_present);
 	kfree(acpi_id_cst_present);
-	for_each_possible_cpu(i) {
-		struct acpi_processor_performance *perf;
-		perf = per_cpu_ptr(acpi_perf_data, i);
-		acpi_processor_unregister_performance(perf, i);
-	}
+	for_each_possible_cpu(i)
+		acpi_processor_unregister_performance(i);
+
 	free_acpi_perf_data();
 }
 
