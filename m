From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Increase precision
Date: Mon,  5 Jun 2017 18:01:04 -0700
Message-ID: <1496710864-117662-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:40838 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbdFFBCT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Jun 2017 21:02:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

In some cases the scaling max/min limit set via cpufreq interface doesn't
result in correct max/min.

For example, with the data below:

cpuinfo_max_freq:3700000
scaling_max_freq:2500000
HWP max ratio = 37

With the current fixed point conversion to ratio using 14 bit shift:
max_perf = (2500000 << 14) / 3700000 = 11070
Rounding up with 14 = 11070
HWP max ratio corresponding to 2500000 will be
= (hwp max ratio * max_perf) >> 14
= 24

So this will result in 100Mhz less frequency than what is requested,
with scaling factor of 100000.

To fix this if we increase the shift to 15 bits.
max_perf = (2500000 << 15) / 3700000 = 22140
rounded up with 15 = 22144
The new max ratio corresponding to 2500000 will be
= (hwp max ratio * max_perf) >> 15
= 25
This will result in correct scaling max frequency.

This patch changes EXT_BITS to 7 from 6, so this will result in 15 bit
shift during fixed point math above.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 640eb7e4..6386422 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -52,7 +52,7 @@
 #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
 #define fp_toint(X) ((X) >> FRAC_BITS)
 
-#define EXT_BITS 6
+#define EXT_BITS 7
 #define EXT_FRAC_BITS (EXT_BITS + FRAC_BITS)
 #define fp_ext_toint(X) ((X) >> EXT_FRAC_BITS)
 #define int_ext_tofp(X) ((int64_t)(X) << EXT_FRAC_BITS)
-- 
2.7.4
