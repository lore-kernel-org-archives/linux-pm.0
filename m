From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] acpi-cpufreq: introduce base_frequency
Date: Mon, 29 Feb 2016 16:10:07 -0800
Message-ID: <1456791009-950-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32182 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbcCAALo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Feb 2016 19:11:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This patchset introduces base_frequency attribute to cpufreq sysfs
only for acpi-cpufreq.

No change but sending code and document patch together.

Srinivas Pandruvada (2):
  cpufreq: acpi_cpufreq: base frequency attribute support
  Documentation: cpufreq: Additional interface for acpi-cpufreq

 Documentation/cpu-freq/acpi-cpufreq-addition.txt | 20 +++++++++++++
 drivers/cpufreq/acpi-cpufreq.c                   | 36 ++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/cpu-freq/acpi-cpufreq-addition.txt

-- 
2.5.0

