From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 02/16] cpufreq: intel_pstate: Drop pointless initialization of PID parameters
Date: Tue, 28 Mar 2017 00:04:30 +0200
Message-ID: <13687383.3o6irlutMi@aspire.rjw.lan>
References: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6409323.DYHvh3CYlO@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The P-state selection algorithm used by intel_pstate for Atom
processors is not based on the PID controller and the initialization
of PID parametrs for those processors is pointless and confusing, so
drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1540,14 +1540,6 @@ static struct cpu_defaults core_params =
 };
 
 static const struct cpu_defaults silvermont_params = {
-	.pid_policy = {
-		.sample_rate_ms = 10,
-		.deadband = 0,
-		.setpoint = 60,
-		.p_gain_pct = 14,
-		.d_gain_pct = 0,
-		.i_gain_pct = 4,
-	},
 	.funcs = {
 		.get_max = atom_get_max_pstate,
 		.get_max_physical = atom_get_max_pstate,
@@ -1561,14 +1553,6 @@ static const struct cpu_defaults silverm
 };
 
 static const struct cpu_defaults airmont_params = {
-	.pid_policy = {
-		.sample_rate_ms = 10,
-		.deadband = 0,
-		.setpoint = 60,
-		.p_gain_pct = 14,
-		.d_gain_pct = 0,
-		.i_gain_pct = 4,
-	},
 	.funcs = {
 		.get_max = atom_get_max_pstate,
 		.get_max_physical = atom_get_max_pstate,
@@ -1602,14 +1586,6 @@ static const struct cpu_defaults knl_par
 };
 
 static const struct cpu_defaults bxt_params = {
-	.pid_policy = {
-		.sample_rate_ms = 10,
-		.deadband = 0,
-		.setpoint = 60,
-		.p_gain_pct = 14,
-		.d_gain_pct = 0,
-		.i_gain_pct = 4,
-	},
 	.funcs = {
 		.get_max = core_get_max_pstate,
 		.get_max_physical = core_get_max_pstate_physical,
@@ -2637,9 +2613,9 @@ static int __init intel_pstate_init(void
 			return -ENODEV;
 
 		cpu_def = (struct cpu_defaults *)id->driver_data;
-
-		copy_pid_params(&cpu_def->pid_policy);
 		copy_cpu_funcs(&cpu_def->funcs);
+		if (pstate_funcs.get_target_pstate == get_target_pstate_use_performance)
+			copy_pid_params(&cpu_def->pid_policy);
 	}
 
 	if (intel_pstate_msrs_not_valid())
