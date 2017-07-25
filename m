From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: intel_pstate: Drop ->get from intel_pstate structure
Date: Wed, 26 Jul 2017 00:42:54 +0200
Message-ID: <5898530.IS6IniWbqq@aspire.rjw.lan>
References: <1500875013-123321-1-git-send-email-yehs1@lenovo.com> <1500951465.4920.2.camel@linux.intel.com> <3849070.kDntuffBgp@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3849070.kDntuffBgp@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Huaisheng HS1 Ye <yehs1@lenovo.com>, "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ->get callback in the intel_pstate structure was mostly there
for the scaling_cur_freq sysfs attribute to work, but after commit
f8475cef9008 (x86: use common aperfmperf_khz_on_cpu() to calculate
KHz using APERF/MPERF) that attribute uses arch_freq_get_on_cpu()
provided by the x86 arch code on all processors supported by
intel_pstate, so it doesn't need the ->get callback from the
driver any more.

Moreover, the very presence of the ->get callback in the intel_pstate
structure causes the cpuinfo_cur_freq attribute to be present when
intel_pstate operates in the active mode, which is bogus, because
the role of that attribute is to return the current CPU frequency
as seen by the hardware.  For intel_pstate, though, this is just an
average frequency and not really current, but computed for the
previous sampling interval (the actual current frequency may be
way different at the point this value is obtained by reading from
cpuinfo_cur_freq), and after commit 82b4e03e01bc (intel_pstate: skip
scheduler hook when in "performance" mode) the value in
cpuinfo_cur_freq may be stale or just 0, depending on the driver's
operation mode.  In fact, however, on the hardware supported by
intel_pstate there is no way to read the current CPU frequency
from it, so the cpuinfo_cur_freq attribute should not be present
at all when this driver is in use.

For this reason, drop intel_pstate_get() and clear the ->get
callback pointer pointing to it, so that the cpuinfo_cur_freq is
not present for intel_pstate in the active mode any more.

Fixes: 82b4e03e01bc (intel_pstate: skip scheduler hook when in "performance" mode)
Reported-by: Huaisheng Ye <yehs1@lenovo.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    8 --------
 1 file changed, 8 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1674,13 +1674,6 @@ static int intel_pstate_init_cpu(unsigne
 	return 0;
 }
 
-static unsigned int intel_pstate_get(unsigned int cpu_num)
-{
-	struct cpudata *cpu = all_cpu_data[cpu_num];
-
-	return cpu ? get_avg_frequency(cpu) : 0;
-}
-
 static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 {
 	struct cpudata *cpu = all_cpu_data[cpu_num];
@@ -1921,7 +1914,6 @@ static struct cpufreq_driver intel_pstat
 	.setpolicy	= intel_pstate_set_policy,
 	.suspend	= intel_pstate_hwp_save_state,
 	.resume		= intel_pstate_resume,
-	.get		= intel_pstate_get,
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_pstate_stop_cpu,
