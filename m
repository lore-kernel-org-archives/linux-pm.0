From: Abhilash Jindal <klock.android@gmail.com>
Subject: [PATCH] PM/freezer: y2038, use boottime to compare tstamps
Date: Sun, 31 Jan 2016 14:29:01 -0500
Message-ID: <1454268541-28064-1-git-send-email-klock.android@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35476 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933307AbcAaT3J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jan 2016 14:29:09 -0500
Received: by mail-ig0-f180.google.com with SMTP id t15so21104337igr.0
        for <linux-pm@vger.kernel.org>; Sun, 31 Jan 2016 11:29:09 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, pavel@ucw.cz, Abhilash Jindal <klock.android@gmail.com>

Wall time obtained from do_gettimeofday gives 32 bit timeval which can only
represent time until January 2038. This patch moves to ktime_t, a 64-bit time.

Also, wall time is susceptible to sudden jumps due to user setting the time or
due to NTP.  Boot time is constantly increasing time better suited for
subtracting two timestamps.

Signed-off-by: Abhilash Jindal <klock.android@gmail.com>
---
 kernel/power/process.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 564f786..df058be 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -30,13 +30,12 @@ static int try_to_freeze_tasks(bool user_only)
 	unsigned long end_time;
 	unsigned int todo;
 	bool wq_busy = false;
-	struct timeval start, end;
-	u64 elapsed_msecs64;
+	ktime_t start, end, elapsed;
 	unsigned int elapsed_msecs;
 	bool wakeup = false;
 	int sleep_usecs = USEC_PER_MSEC;
 
-	do_gettimeofday(&start);
+	start = ktime_get_boottime();
 
 	end_time = jiffies + msecs_to_jiffies(freeze_timeout_msecs);
 
@@ -78,10 +77,9 @@ static int try_to_freeze_tasks(bool user_only)
 			sleep_usecs *= 2;
 	}
 
-	do_gettimeofday(&end);
-	elapsed_msecs64 = timeval_to_ns(&end) - timeval_to_ns(&start);
-	do_div(elapsed_msecs64, NSEC_PER_MSEC);
-	elapsed_msecs = elapsed_msecs64;
+	end = ktime_get_boottime();
+	elapsed = ktime_sub(end, start);
+	elapsed_msecs = ktime_to_ms(elapsed);
 
 	if (todo) {
 		pr_cont("\n");
-- 
1.7.9.5

