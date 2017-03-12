From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 07/14] cpufreq: intel_pstate: Skip unnecessary PID resets on init
Date: Sun, 12 Mar 2017 18:18:47 +0100
Message-ID: <1628936.Jbhxs73Drc@aspire.rjw.lan>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

PID controller parameters only need to be initialized if the
get_target_pstate_use_performance() P-state selection routine
is going to be used.  It is not necessary to initialize them
otherwise, so don't do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1974,12 +1974,12 @@ static int intel_pstate_init_cpu(unsigne
 			intel_pstate_disable_ee(cpunum);
 
 		intel_pstate_hwp_enable(cpu);
+	} else if (pstate_funcs.get_target_pstate == get_target_pstate_use_performance) {
+		intel_pstate_pid_reset(cpu);
 	}
 
 	intel_pstate_get_cpu_pstates(cpu);
 
-	intel_pstate_pid_reset(cpu);
-
 	pr_debug("controlling: cpu %d\n", cpunum);
 
 	return 0;
