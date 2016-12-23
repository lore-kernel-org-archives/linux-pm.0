From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: intel_pstate: Do not expose PID parameters in passive mode
Date: Sat, 24 Dec 2016 00:29:56 +0100
Message-ID: <5932094.TdNu43FsQu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If intel_pstate works in the passive mode in which it acts as
a regular cpufreq driver and collaborates with generic cpufreq
governors, the PID parameters are not used, so do not expose
them via debugfs in that case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1018,10 +1018,6 @@ static void __init intel_pstate_debug_ex
 	struct dentry *debugfs_parent;
 	int i = 0;
 
-	if (hwp_active ||
-	    pstate_funcs.get_target_pstate == get_target_pstate_use_cpu_load)
-		return;
-
 	debugfs_parent = debugfs_create_dir("pstate_snb", NULL);
 	if (IS_ERR_OR_NULL(debugfs_parent))
 		return;
@@ -2487,7 +2483,10 @@ hwp_cpu_matched:
 	if (rc)
 		goto out;
 
-	intel_pstate_debug_expose_params();
+	if (intel_pstate_driver == &intel_pstate && !hwp_active &&
+	    pstate_funcs.get_target_pstate != get_target_pstate_use_cpu_load)
+		intel_pstate_debug_expose_params();
+
 	intel_pstate_sysfs_expose_params();
 
 	if (hwp_active)
