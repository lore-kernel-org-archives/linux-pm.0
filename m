From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH] intel_pstate: Correct rounding in busy calculation
Date: Tue, 17 Jun 2014 13:36:10 -0700
Message-ID: <1403037370-3484-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:58081 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933275AbaFQUgc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jun 2014 16:36:32 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so4320290pad.9
        for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2014 13:36:32 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dsmythies@telus.net, dirk.brandewie@gmail.com

There was a mistake in the actual rounding portion this previous patch:
f0fe3cd7e12d8290c82284b5c8aee723cbd0371a intel_pstate: Correct rounding in busy calculation
such that the rounding was asymetric and incorrect.

Severity: Not very serious, but can increase target pstate by one extra value.
For real world work flows the issue should self correct (but I have no proof).
It is the equivalent of different PID gains for positive and negative numbers.

Examples:
-3.000000 used to round to -4, rounds to -3 with this patch.
-3.503906 used to round to -5, rounds to -4 with this patch.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4e7f492..924bb2d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -196,10 +196,7 @@ static signed int pid_calc(struct _pid *pid, int32_t busy)
 	pid->last_err = fp_error;
 
 	result = pterm + mul_fp(pid->integral, pid->i_gain) + dterm;
-	if (result >= 0)
-		result = result + (1 << (FRAC_BITS-1));
-	else
-		result = result - (1 << (FRAC_BITS-1));
+	result = result + (1 << (FRAC_BITS-1));
 	return (signed int)fp_toint(result);
 }
 
-- 
1.9.1

