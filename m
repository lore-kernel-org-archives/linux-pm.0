From: Thomas Renninger <trenn@suse.com>
Subject: [PATCH 4/5] cpupowerutils: bench: trivial fix of spelling mistake on "average"
Date: Thu, 28 Apr 2016 15:24:39 +0200
Message-ID: <1461849880-24777-4-git-send-email-trenn@suse.com>
References: <1461849880-24777-1-git-send-email-trenn@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33288 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbcD1NYt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Apr 2016 09:24:49 -0400
In-Reply-To: <1461849880-24777-1-git-send-email-trenn@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, trenn@suse.com, Colin Ian King <colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

fix spelling mistake, avarage -> average

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/bench/README-BENCH | 2 +-
 tools/power/cpupower/bench/benchmark.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/bench/README-BENCH b/tools/power/cpupower/bench/README-BENCH
index 8093ec7..97727ae 100644
--- a/tools/power/cpupower/bench/README-BENCH
+++ b/tools/power/cpupower/bench/README-BENCH
@@ -113,7 +113,7 @@ cpufreq-bench Command Usage
 -c, --cpu=<unsigned int>        CPU Number to use, starting at 0
 -p, --prio=<priority>           scheduler priority, HIGH, LOW or DEFAULT
 -g, --governor=<governor>       cpufreq governor to test
--n, --cycles=<int>              load/sleep cycles to get an avarage value to compare
+-n, --cycles=<int>              load/sleep cycles to get an average value to compare
 -r, --rounds<int>               load/sleep rounds
 -f, --file=<configfile>         config file to use
 -o, --output=<dir>              output dir, must exist
diff --git a/tools/power/cpupower/bench/benchmark.c b/tools/power/cpupower/bench/benchmark.c
index 81b1c48..429d51a 100644
--- a/tools/power/cpupower/bench/benchmark.c
+++ b/tools/power/cpupower/bench/benchmark.c
@@ -130,7 +130,7 @@ void start_benchmark(struct config *config)
 			_round, load_time, sleep_time);
 
 		if (config->verbose)
-			printf("avarage: %lius, rps:%li\n",
+			printf("average: %lius, rps:%li\n",
 				load_time / calculations,
 				1000000 * calculations / load_time);
 
@@ -177,7 +177,7 @@ void start_benchmark(struct config *config)
 
 		progress_time += sleep_time + load_time;
 
-		/* compare the avarage sleep/load cycles  */
+		/* compare the average sleep/load cycles  */
 		fprintf(config->output, "%li ",
 			powersave_time / config->cycles);
 		fprintf(config->output, "%.3f\n",
-- 
1.8.5.6

