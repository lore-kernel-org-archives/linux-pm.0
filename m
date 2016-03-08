From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V6 0/4] Reduce the intel_pstate timer overhead
Date: Tue,  8 Mar 2016 10:31:13 +0100
Message-ID: <1457429481-13283-2-git-send-email-philippe.longepe@linux.intel.com>
References: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50567 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115AbcCHJaN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Mar 2016 04:30:13 -0500
In-Reply-To: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rafael@kernel.org

V6: Minor fixes on commit message (Patch 1) + add intel_pstate:

This serie includes the following code optimizations:

Patch 1: Remove extra conversions in pid calculation
Patch 2: Optimize calculation for max/min_perf_adj
Patch 3: Move the intel_pstate_calc_busy into get_target_pstate_use_performance
Patch 4: Remove the freq calculation from the intel_pstate_calc_busy function

Philippe Longepe (4):
  Remove extra conversions in pid calculation
  Optimize calculation for max/min_perf_adj
  Move the intel_pstate_calc_busy into get_target_pstate_use_performance
  intel_pstate: Remove the freq calculation from the
    intel_pstate_calc_busy function

 drivers/cpufreq/intel_pstate.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

-- 
1.9.1

