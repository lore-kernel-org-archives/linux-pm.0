From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] cpufreq: intel_pstate: calling acpi_processor_register_performance
Date: Fri, 13 Nov 2015 17:05:32 -0800
Message-ID: <1447463133-10252-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42311 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbbKNBHI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 13 Nov 2015 20:07:08 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v2: Reworked as suggested by Rafael

Srinivas Pandruvada (1):
  cpufreq: intel_pstate: wrong call to
    acpi_processor_unregister_performance

 drivers/cpufreq/intel_pstate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.4.3

