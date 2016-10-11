From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] Documentation: cpufreq: intel_pstate: Clarify cpufreq limits
Date: Tue, 11 Oct 2016 16:37:05 -0700
Message-ID: <1476229025-53374-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1476229025-53374-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:15752 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbcJKXiZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Oct 2016 19:38:25 -0400
In-Reply-To: <1476229025-53374-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Update documentation related to limiting performance via Intel_Pstate
sysfs and cpufreq policy.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/cpu-freq/intel-pstate.txt | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
index e6bd1e6..cdfa044 100644
--- a/Documentation/cpu-freq/intel-pstate.txt
+++ b/Documentation/cpu-freq/intel-pstate.txt
@@ -48,7 +48,7 @@ In addition to the frequency-controlling interfaces provided by the cpufreq
 core, the driver provides its own sysfs files to control the P-State selection.
 These files have been added to /sys/devices/system/cpu/intel_pstate/.
 Any changes made to these files are applicable to all CPUs (even in a
-multi-package system).
+multi-package system, so they are global limits).
 
       max_perf_pct: Limits the maximum P-State that will be requested by
       the driver. It states it as a percentage of the available performance. The
@@ -88,7 +88,26 @@ Volume 3: System Programming Guide" to understand ratios.
 cpufreq sysfs for Intel P-State
 
 Since this driver registers with cpufreq, cpufreq sysfs is also presented.
-There are some important differences, which need to be considered.
+Under cpufreq sysfs (/sys/devices/system/cpu/cpufreq/) each logical CPU has
+its own policy. The policy limits for each CPU are still constrained by global
+limits using Intel P-State sysfs. So for example, if global limit is reducing
+max_perf_pct to 80%, the individual CPU can't exceed 80% of performance, but
+each CPU can add more restrictive limit (E.g. say 60% here). Same rule applies
+to min_perf_pct. Each CPU can request more than min_perf_pct performance.
+When performance limits are placed using cpufreq interface, the Intel P-State
+sysfs display of max_perf_pct and min_perf_pct accounts for those limits.
+Here
+	# cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
+		Prints the least maximum performance set by individual
+		CPU if any. Otherwise it will print what user has
+		written to max_perf_pct
+	# cat /sys/devices/system/cpu/intel_pstate/min_perf_pct
+		Prints the maximum of minimum performances set by individual CPU
+		if any. Otherwise it will print what user has written to
+		min_perf_pct
+
+There are some important differences compared to acpi_cpufreq, which need to
+be considered.
 
 scaling_cur_freq: This displays the real frequency which was used during
 the last sample period instead of what is requested. Some other cpufreq driver,
-- 
2.7.4

