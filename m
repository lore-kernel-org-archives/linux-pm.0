From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: ia64: Remove unused header files
Date: Fri, 30 Nov 2018 09:16:20 -0500
Message-ID: <20181130141620.2488-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

seq_file.h does not need to be included,so remove it.Moreover deleted a
line of meaningless return and move the module declaration to the end.
In a function whose return type is void, returning on the last line is
not required.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/ia64-acpi-cpufreq.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index dd5440d3372d..43ac191fb46a 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 #include <asm/io.h>
 #include <linux/uaccess.h>
 #include <asm/pal.h>
@@ -24,11 +23,6 @@
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
-MODULE_AUTHOR("Venkatesh Pallipadi");
-MODULE_DESCRIPTION("ACPI Processor P-States Driver");
-MODULE_LICENSE("GPL");
-
-
 struct cpufreq_acpi_io {
 	struct acpi_processor_performance	acpi_data;
 	unsigned int				resume;
@@ -348,9 +342,11 @@ acpi_cpufreq_exit (void)
 	pr_debug("acpi_cpufreq_exit\n");
 
 	cpufreq_unregister_driver(&acpi_cpufreq_driver);
-	return;
 }
 
+MODULE_AUTHOR("Venkatesh Pallipadi");
+MODULE_DESCRIPTION("ACPI Processor P-States Driver");
+MODULE_LICENSE("GPL");
 
 late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
-- 
2.17.0
