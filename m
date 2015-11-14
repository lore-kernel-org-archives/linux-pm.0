From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3] cpufreq: intel_pstate: wrong call to acpi_processor_unregister_performance
Date: Fri, 13 Nov 2015 17:17:00 -0800
Message-ID: <1447463821-14595-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2150 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbbKNBSe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 13 Nov 2015 20:18:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v3: Change the commit log to be more clear.

v2: Fix as suggested by Rafael

Srinivas Pandruvada (1):
  cpufreq: intel_pstate: wrong call to
    acpi_processor_unregister_performance

 drivers/cpufreq/intel_pstate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.4.3

