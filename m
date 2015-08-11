From: Abhilash Jindal <klock.android@gmail.com>
Subject: [PATCH] cpufreq: speedstep-lib: Use monotonic clock
Date: Tue, 11 Aug 2015 12:01:22 -0400
Message-ID: <1439308882-7743-1-git-send-email-klock.android@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36476 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965208AbbHKQB0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 12:01:26 -0400
Received: by igbij6 with SMTP id ij6so93729343igb.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 09:01:25 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, Abhilash Jindal <klock.android@gmail.com>

Wall time obtained from do_gettimeofday is susceptible to sudden jumps due to
user setting the time or due to NTP.

Monotonic time is constantly increasing time better suited for comparing two
timestamps.

Signed-off-by: Abhilash Jindal <klock.android@gmail.com>
---
 drivers/cpufreq/speedstep-lib.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index 4ab7a21..15d3214 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -386,7 +386,7 @@ unsigned int speedstep_get_freqs(enum speedstep_processor processor,
 	unsigned int prev_speed;
 	unsigned int ret = 0;
 	unsigned long flags;
-	struct timeval tv1, tv2;
+	ktime_t tv1, tv2;
 
 	if ((!processor) || (!low_speed) || (!high_speed) || (!set_state))
 		return -EINVAL;
@@ -415,14 +415,14 @@ unsigned int speedstep_get_freqs(enum speedstep_processor processor,
 
 	/* start latency measurement */
 	if (transition_latency)
-		do_gettimeofday(&tv1);
+		tv1 = ktime_get();
 
 	/* switch to high state */
 	set_state(SPEEDSTEP_HIGH);
 
 	/* end latency measurement */
 	if (transition_latency)
-		do_gettimeofday(&tv2);
+		tv2 = ktime_get();
 
 	*high_speed = speedstep_get_frequency(processor);
 	if (!*high_speed) {
@@ -442,8 +442,7 @@ unsigned int speedstep_get_freqs(enum speedstep_processor processor,
 		set_state(SPEEDSTEP_LOW);
 
 	if (transition_latency) {
-		*transition_latency = (tv2.tv_sec - tv1.tv_sec) * USEC_PER_SEC +
-			tv2.tv_usec - tv1.tv_usec;
+		*transition_latency = ktime_to_us(ktime_sub(tv2, tv1));
 		pr_debug("transition latency is %u uSec\n", *transition_latency);
 
 		/* convert uSec to nSec and add 20% for safety reasons */
-- 
1.7.9.5

