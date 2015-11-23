From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH v1 0/5] intel_pstate: Use the cpu load first on Atom only
Date: Mon, 23 Nov 2015 14:06:36 +0100
Message-ID: <1448284006-13596-2-git-send-email-philippe.longepe@linux.intel.com>
References: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40543 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753891AbbKWNGI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 08:06:08 -0500
In-Reply-To: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Philippe Longepe <philippe.longepe@intel.com>

From: Philippe Longepe <philippe.longepe@intel.com>

This patch serie aims to use the load as the input of the PID.

The load is defined by cpu_load = 100 * (delta_mperf / delta_tsc)
since mperf is counting at HFM during C0 state and TSC is counting at 
the same frequency during all C-States.

The load gives very good power improvements on Android manly for gaming
use cases.
Also include the IOBoost improvement that converts time spent in iowait 
into mperf cycles to avoid performance degradation during IOs use cases.

Measured on a Cherrytrail with this algorithm:

			Power (in J)	Power with patch	Power Gain
Candycrush Saga (30sec) 46.7 		14.5 			221.6%
Circular ProgressBar 	10.4 		3.2 			226.12%
SmartBench 		76 		54.3 			40%
FishTank 		226		116			95%
AnTuTu5.6		315		311 			2.7%

Philippe Longepe (5):
  cpufreq: intel_pstate: change function name for calculation for busy
  cpufreq: intel_pstate: Rename current busy calculation function
  cpufreq: intel_pstate: account for non C0 time
  cpufreq: intel_pstate: configurable busy calculation
  cpufreq: intel_pstate: try load instead of busy_scaled

 drivers/cpufreq/intel_pstate.c | 56 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 8 deletions(-)

-- 
1.9.1

