From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/3] Documentation: intel_pstate: Add energy performance hint
Date: Tue,  6 Dec 2016 13:32:17 -0800
Message-ID: <1481059937-193048-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1481059937-193048-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:30593 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752037AbcLFVcq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Dec 2016 16:32:46 -0500
In-Reply-To: <1481059937-193048-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Updated documentation for the support of energy performance hint.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/cpu-freq/intel-pstate.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
index 198b2ef..012170e 100644
--- a/Documentation/cpu-freq/intel-pstate.txt
+++ b/Documentation/cpu-freq/intel-pstate.txt
@@ -139,6 +139,30 @@ architecture of the processor permits:
 - User can read write system wide turbo status
 	/sys/devices/system/cpu/no_turbo
 
+Support of energy performance hint
+It is possible to provide hints to the HWP algorithms in the processor
+to be more performance centric to more energy centric. When driver is
+using HWP, two additional cpufreq sysfs attributes are presented for
+each logical CPU.
+These attributes are:
+	- energy_performance_available_preferences
+	- energy_performance_preference
+
+To get list of supported hints:
+$ cat energy_performance_available_preferences
+    default performance balance_performance balance_power power
+
+The current preference can be read or changed via cpufreq sysfs
+attribute "energy_performance_preference". Reading from this attribute
+will display current effective setting. User can write any of the valid
+preference string to this attribute. User can always restore to power-on
+default by writing "default".
+
+Since threads can migrate to different CPUs, this is possible that the
+new CPU may have different energy performance preference than the previous
+one. To avoid such issues, either threads can be pinned to specific CPUs
+or set the same energy performance preference value to all CPUs.
+
 Tuning Intel P-State driver
 
 When the performance can be tuned using PID (Proportional Integral
-- 
2.7.4

