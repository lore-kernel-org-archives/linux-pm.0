From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3] acpi-cpufreq: introduce base_frequency
Date: Tue,  1 Mar 2016 14:07:38 -0800
Message-ID: <1456870059-21681-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23438 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbcCAWJ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 17:09:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v3
-Merged Documentation and code patch to one patch.
-Created a common function to read tar which is used init and during read
-Documentation and code changed suggested by Viresh
-On unsupported CPUs, user when tries to read base_frequency
"Operation not supported" error will be returned.

v2
sysfs_create_file on policy->kobj is no longer possible on recent kernel
versions. So we can't create selectively create base_frequency attribute
on supported policies.
This version creates a base_frequency attribute, if the boot cpu supports
as part of cpufreq_driver->attributes. If for some CPUs the TAR can't be
read, return error.

v1:
Base version

Srinivas Pandruvada (1):
  cpufreq: acpi_cpufreq: base frequency attribute support

 Documentation/cpu-freq/acpi-cpufreq.txt | 27 ++++++++++++++++++++
 drivers/cpufreq/acpi-cpufreq.c          | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/cpu-freq/acpi-cpufreq.txt

-- 
2.5.0

