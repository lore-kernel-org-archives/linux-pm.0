From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH] intel_pstate: Correct rounding in busy calculation again
Date: Tue, 17 Jun 2014 09:56:19 -0700
Message-ID: <1403024179-26280-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:62856 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965332AbaFQQ4m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jun 2014 12:56:42 -0400
Received: by mail-pd0-f171.google.com with SMTP id fp1so2499725pdb.30
        for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2014 09:56:42 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dsmythies@telus.net, dirk.brandewie@gmail.com

There was a mistake in the actual rounding portion of the previous patch,
such that the rounding was asymetric and incorrect.
(see also: f0fe3cd7e12d8290c82284b5c8aee723cbd0371a intel_pstate: Correct rounding in busy calculation)

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

