From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/4] Documentation: intel_pstate: Update per core limits
Date: Fri, 21 Oct 2016 09:14:25 -0700
Message-ID: <1477066466-22367-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1477066466-22367-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:11147 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934840AbcJUQOj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Oct 2016 12:14:39 -0400
In-Reply-To: <1477066466-22367-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Document restriction on per core P-State control.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/cpu-freq/intel-pstate.txt | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
index 5528d6d..18156ce 100644
--- a/Documentation/cpu-freq/intel-pstate.txt
+++ b/Documentation/cpu-freq/intel-pstate.txt
@@ -48,7 +48,7 @@ In addition to the frequency-controlling interfaces provided by the cpufreq
 core, the driver provides its own sysfs files to control the P-State selection.
 These files have been added to /sys/devices/system/cpu/intel_pstate/.
 Any changes made to these files are applicable to all CPUs (even in a
-multi-package system).
+multi-package system, Refer to later section on placing "Per core limits").
 
       max_perf_pct: Limits the maximum P-State that will be requested by
       the driver. It states it as a percentage of the available performance. The
@@ -120,6 +120,27 @@ frequency is fictional for Intel Core processors. Even if the scaling
 driver selects a single P-State, the actual frequency the processor
 will run at is selected by the processor itself.
 
+Per core limits
+
+Per core limits are not enabled without kernel command line
+ intel_pstate=per_cpu_perf_limits
+
+When user wants to control performance per core, there are some limitations
+in sysfs control, which are described above.
+-  The following controls are not available for both read and write
+	/sys/devices/system/cpu/intel_pstate/max_perf_pct
+	/sys/devices/system/cpu/intel_pstate/min_perf_pct
+- User can change limits using the following, respecting processor
+architecture
+	/sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
+	/sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
+	/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
+- User can still observe turbo percent and number of P-States from
+	/sys/devices/system/cpu/intel_pstate/turbo_pct
+	/sys/devices/system/cpu/intel_pstate/num_pstates
+- User can read write system wide turbo status
+	/sys/devices/system/cpu/no_turbo
+
 Tuning Intel P-State driver
 
 When the performance can be tuned using PID (Proportional Integral
-- 
2.7.4

