From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] Documentation: intel_pstate: Add energy performance hint
Date: Thu,  1 Dec 2016 15:39:09 -0800
Message-ID: <1480635549-43518-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1480635549-43518-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:62200 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756378AbcLAXjQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Dec 2016 18:39:16 -0500
In-Reply-To: <1480635549-43518-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Updated documentation for the support of energy performance hint.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/cpu-freq/intel-pstate.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
index 198b2ef..e8c6fc8 100644
--- a/Documentation/cpu-freq/intel-pstate.txt
+++ b/Documentation/cpu-freq/intel-pstate.txt
@@ -139,6 +139,25 @@ architecture of the processor permits:
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
 Tuning Intel P-State driver
 
 When the performance can be tuned using PID (Proportional Integral
-- 
2.7.4

