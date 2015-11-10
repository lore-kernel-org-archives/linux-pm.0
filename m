From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] Atom SoC fixes for Airmont
Date: Mon,  9 Nov 2015 17:30:55 -0800
Message-ID: <1447119057-10759-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:6421 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbbKJBbw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 20:31:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

These are patches from Philippe Longepe, I did some minor changes
- get_max_physical callback for Airmont
- Fix checkpatch issues, for BUG_ON. 

Added my ACK.

Philippe Longepe (1):
  cpufreq: intel_pstate: Replace BYT by ATOM

Srinivas Pandruvada (1):
  cpufreq: intel_pstate: Fix the FSB feq for Airmont

 drivers/cpufreq/intel_pstate.c | 97 ++++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 31 deletions(-)

-- 
1.9.3

