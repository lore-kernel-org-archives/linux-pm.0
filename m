From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 06/16] cpufreq: intel_pstate: Set HWP sampling interval once
Date: Tue, 28 Mar 2017 00:10:47 +0200
Message-ID: <2344464.Q8GWKyOfj5@aspire.rjw.lan>
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

In the HWP enabled case pid_params.sample_rate_ns only needs to be
updated once, because it is global, so do that when setting hwp_active
instead of doing it during the initialization of every CPU.

Moreover, pid_params.sample_rate_ms is never used if HWP is enabled,
so do not update it at all then.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1911,8 +1911,6 @@ static int intel_pstate_init_cpu(unsigne
 			intel_pstate_disable_ee(cpunum);
 
 		intel_pstate_hwp_enable(cpu);
-		pid_params.sample_rate_ms = 50;
-		pid_params.sample_rate_ns = 50 * NSEC_PER_MSEC;
 	}
 
 	intel_pstate_get_cpu_pstates(cpu);
@@ -2563,6 +2561,7 @@ static int __init intel_pstate_init(void
 		} else {
 			hwp_active++;
 			intel_pstate.attr = hwp_cpufreq_attrs;
+			pid_params.sample_rate_ns = 50 * NSEC_PER_MSEC;
 			goto hwp_cpu_matched;
 		}
 	} else {
