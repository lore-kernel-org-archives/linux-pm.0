From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/2] Atom SoC fixes for Airmont
Date: Mon,  9 Nov 2015 17:40:45 -0800
Message-ID: <1447119647-11376-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2151 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbbKJBlw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 20:41:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v2.
Messed up the author, fixed this.

v1
These are patches from Philippe Longepe, I did some minor changes
- get_max_physical callback for Airmont
- Fix checkpatch issues, for BUG_ON. 

Philippe Longepe (2):
  cpufreq: intel_pstate: Replace BYT by ATOM
  cpufreq: intel_pstate: Fix the FSB feq for Airmont

 drivers/cpufreq/intel_pstate.c | 97 ++++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 31 deletions(-)

-- 
1.9.3

