From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V5 0/3] cpufreq: intel_pstate: account non C0 time
Date: Thu,  3 Dec 2015 18:55:53 +0100
Message-ID: <1449165359-25832-2-git-send-email-philippe.longepe@linux.intel.com>
References: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28380 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbbLCRy5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Dec 2015 12:54:57 -0500
In-Reply-To: <1449165359-25832-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Philippe Longepe <philippe.longepe@intel.com>

From: Philippe Longepe <philippe.longepe@intel.com>

V5 : it fixes a small typo on 'Signed-off-by'

Rework on this patch description as proposed by Srinivas:

Include 1 patch from Srinivas to make the algorithm configurable and 
2 patches from me and Stephane to include the load and IOBoost 
calc_busy function

Philippe Longepe (1):
  cpufreq: intel_pstate: account for non C0 time

Srinivas Pandruvada (1):
  cpufreq: intel_pstate: configurable algorithm to get target pstate

Stephane Gasparini (1):
  cpufreq: intel_pstate: Account for IO wait time

 drivers/cpufreq/intel_pstate.c | 64 +++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 13 deletions(-)

-- 
1.9.1

