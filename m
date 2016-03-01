From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] Documentation: cpufreq: Additional interface for acpi-cpufreq
Date: Mon, 29 Feb 2016 16:10:09 -0800
Message-ID: <1456791009-950-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1456791009-950-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32182 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbcCAALp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Feb 2016 19:11:45 -0500
In-Reply-To: <1456791009-950-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added new file for acpi-cpufreq driver, with explanation for
base_frequency.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/cpu-freq/acpi-cpufreq-addition.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/cpu-freq/acpi-cpufreq-addition.txt

diff --git a/Documentation/cpu-freq/acpi-cpufreq-addition.txt b/Documentation/cpu-freq/acpi-cpufreq-addition.txt
new file mode 100644
index 0000000..40efb22
--- /dev/null
+++ b/Documentation/cpu-freq/acpi-cpufreq-addition.txt
@@ -0,0 +1,20 @@
+Additional sysfs attribute for acpi-cpufreq
+
+In addition to the standard sysfs interface as defined in the
+user-guide.txt under section "Preferred Interface: sysfs",
+acpi-cpufreq can have following additional sysfs attribute:
+
+base_frequency: 	Max non-turbo frequency
+For example:
+scaling_available_frequencies displays list of available frequencies which
+can be used to set max/min or current scaling frequency.
+>cat scaling_available_frequencies
+2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000 1400000
+1300000 1100000 1000000 900000 800000 600000 500000
+If the base_frequency attribute is present, then any frequency above is
+purely opportunistic or turbo frequency. For example
+>cat base_frequency
+2200000
+Then in the above displayed list of scaling_available_frequencies, any
+frequency 2300000 or 2301000 is opportunistic or turbo frequency.
+
-- 
2.5.0

