From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V5 0/4] Reduce the intel_pstate timer overhead
Date: Sun,  6 Mar 2016 08:34:02 +0100
Message-ID: <1457249646-23072-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46499 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbcCFHc5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 6 Mar 2016 02:32:57 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rafael@kernel.org

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

