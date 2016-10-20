From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] Documentation: intel_pstate: PID tuning is not always available
Date: Thu, 20 Oct 2016 13:37:06 -0700
Message-ID: <1476995826-15536-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1476995826-15536-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:13746 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755335AbcJTUhW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Oct 2016 16:37:22 -0400
In-Reply-To: <1476995826-15536-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

PID tuning is not available when the get_target_pstate_use_cpu_load()
is used to calculate target_state. So update the documentation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/cpu-freq/intel-pstate.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
index e6bd1e6..5528d6d 100644
--- a/Documentation/cpu-freq/intel-pstate.txt
+++ b/Documentation/cpu-freq/intel-pstate.txt
@@ -122,11 +122,12 @@ will run at is selected by the processor itself.
 
 Tuning Intel P-State driver
 
-When HWP mode is not used, debugfs files have also been added to allow the
-tuning of the internal governor algorithm. These files are located at
-/sys/kernel/debug/pstate_snb/. The algorithm uses a PID (Proportional
-Integral Derivative) controller. The PID tunable parameters are:
+When the performance can be tuned using PID (Proportional Integral
+Derivative) controller, debugfs files are provided for adjusting performance.
+They are presented under:
+/sys/kernel/debug/pstate_snb/
 
+The PID tunable parameters are:
       deadband
       d_gain_pct
       i_gain_pct
-- 
2.7.4

