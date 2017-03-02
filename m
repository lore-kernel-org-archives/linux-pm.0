From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] cpufreq: intel_pstate: Do not use performance_limits in passive mode
Date: Thu, 02 Mar 2017 23:22:29 +0100
Message-ID: <2612157.PpWm9LcpIt@aspire.rjw.lan>
References: <1573986.gdsgdO0VUn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573986.gdsgdO0VUn@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Using performance_limits in the passive mode doesn't make
sense, because in that mode the global limits are applied to the
frequency selected by the scaling governor.

The maximum and minimum P-state limits in performance_limits are both
set to 100 percent which will put all CPUs into the turbo range
regardless of what governor is used and what frequencies are
selected by it (that is particularly undesirable on CPUs with the
generic powersave governor attached).

For this reason, make intel_pstate_register_driver() always point
limits to powersave_limits in the passive mode.

Fixes: 001c76f05b01 (cpufreq: intel_pstate: Generic governors support)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2442,8 +2442,11 @@ static int intel_pstate_register_driver(
 
 	intel_pstate_init_limits(&powersave_limits);
 	intel_pstate_set_performance_limits(&performance_limits);
-	limits = IS_ENABLED(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE) ?
-			&performance_limits : &powersave_limits;
+	if (IS_ENABLED(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE) &&
+	    intel_pstate_driver == &intel_pstate)
+		limits = &performance_limits;
+	else
+		limits = &powersave_limits;
 
 	ret = cpufreq_register_driver(intel_pstate_driver);
 	if (ret) {
