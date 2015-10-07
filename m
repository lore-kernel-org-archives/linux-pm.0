From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/2] crash on reading cpufreq sysfs
Date: Wed,  7 Oct 2015 13:50:42 -0700
Message-ID: <1444251044-11231-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8113 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbbJGUvY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 16:51:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Fixes for crash on reading cpufreq sysfs for offline cpus

v1
Fix commit discription on Patch 1/2. Included Acks from Viresh.
It has both patches, even though only one patch has change.

v0
two patches: one for acp-cpufreq and one for cpufreq core

Srinivas Pandruvada (2):
  cpufreq: acpi_cpufreq: prevent crash on reading freqdomain_cpus
  cpufreq: prevent lockup on reading scaling_available_frequencies

 drivers/cpufreq/acpi-cpufreq.c | 3 +++
 drivers/cpufreq/cpufreq.c      | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
1.9.3

