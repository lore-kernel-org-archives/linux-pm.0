From: Felipe Franciosi <felipe@nutanix.com>
Subject: [PATCH v2] Documentation: cpufreq: intel_pstate: fix typo
Date: Thu, 18 Feb 2016 00:21:27 +0000
Message-ID: <1455754887-3168-1-git-send-email-felipe@nutanix.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpc92322-cmbg19-2-0-cust996.5-4.cable.virginm.net ([86.26.35.229]:50955
	"EHLO centos.localdomain" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1424695AbcBRKKU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 05:10:20 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Felipe Franciosi <felipe@nutanix.com>

This just swaps a colon for a quote in the intel_pstate documentation.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 Documentation/cpu-freq/intel-pstate.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
index f7b12c0..e6bd1e6 100644
--- a/Documentation/cpu-freq/intel-pstate.txt
+++ b/Documentation/cpu-freq/intel-pstate.txt
@@ -25,7 +25,7 @@ callback, so cpufreq core can't request a transition to a specific frequency.
 The driver provides minimum and maximum frequency limits and callbacks to set a
 policy. The policy in cpufreq sysfs is referred to as the "scaling governor".
 The cpufreq core can request the driver to operate in any of the two policies:
-"performance: and "powersave". The driver decides which frequency to use based
+"performance" and "powersave". The driver decides which frequency to use based
 on the above policy selection considering minimum and maximum frequency limits.
 
 The Intel P-State driver falls under the latter category, which implements the
-- 
1.7.1

