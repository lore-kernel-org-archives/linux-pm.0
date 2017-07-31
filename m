From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: intel_pstate: Drop INTEL_PSTATE_HWP_SAMPLING_INTERVAL
Date: Mon, 31 Jul 2017 14:27:37 +0200
Message-ID: <3794727.icaFcjFGXG@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 62611cb912f7 (intel_pstate: delete scheduler hook in HWP
mode) the INTEL_PSTATE_HWP_SAMPLING_INTERVAL is not used anywhere in
the code, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -38,7 +38,6 @@
 #include <asm/intel-family.h>
 
 #define INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
-#define INTEL_PSTATE_HWP_SAMPLING_INTERVAL	(50 * NSEC_PER_MSEC)
 
 #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
 #define INTEL_CPUFREQ_TRANSITION_DELAY		500
