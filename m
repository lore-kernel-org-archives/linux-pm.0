From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V6 0/3] cpufreq: intel_pstate: account non C0 time
Date: Fri,  4 Dec 2015 17:40:28 +0100
Message-ID: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31858 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233AbbLDQkp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 11:40:45 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Philippe Longepe <philippe.longepe@intel.com>

From: Philippe Longepe <philippe.longepe@intel.com>

V6 : Rework based on Rafael's remarks

Add also a check to avoid division by zero.

Philippe Longepe (3):
  cpufreq: intel_pstate: configurable algorithm to get target pstate
  cpufreq: intel_pstate: account for non C0 time
  cpufreq: intel_pstate: Account for IO wait time

 drivers/cpufreq/intel_pstate.c | 73 +++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 16 deletions(-)

-- 
1.9.1

