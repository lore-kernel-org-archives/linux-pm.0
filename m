From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][RFC v2] ACPI: add "processor.broadcast_ppc" hook to broadcast  _PPC
Date: Fri,  1 Mar 2019 02:07:47 +0800
Message-ID: <ee0250bfc7709ce0a0cc93bf83336133d5e248c4.1551375162.git.yu.c.chen@intel.com>
References: <cover.1551375162.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551375162.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yu.chen.surf@gmail.com, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

On some problematic platforms, the _PPC notifier is
only delivered to one CPU, which might cause information
inconsistent between CPUs within the package. Thus introduce a boot up parameter to broadcast this _PPC notifier onto all
online CPUs.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index a303fd0e108c..737dbf5aa7f7 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
 MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
 		 "limited by BIOS, this should help");
 
+static int broadcast_ppc;
+module_param(broadcast_ppc, int, 0644);
+MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
+
 #define PPC_REGISTERED   1
 #define PPC_IN_USE       2
 
@@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
 		else
 			acpi_processor_ppc_ost(pr->handle, 0);
 	}
-	if (ret >= 0)
-		cpufreq_update_policy(pr->id);
+	if (ret >= 0) {
+		if (broadcast_ppc) {
+			int cpu;
+
+			for_each_possible_cpu(cpu)
+				cpufreq_update_policy(cpu);
+		} else {
+			cpufreq_update_policy(pr->id);
+		}
+	}
 }
 
 int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
-- 
2.17.1
