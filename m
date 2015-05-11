From: "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCH] cpupower: mperf monitor: fix output in MAX_FREQ_SYSFS mode
Date: Mon, 11 May 2015 11:35:35 -0300
Message-ID: <1431354935-7538-1-git-send-email-herton@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58026 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbbEKOfo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 May 2015 10:35:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Herton R. Krzesinski" <herton@redhat.com>

There is clearly wrong output when mperf monitor runs in MAX_FREQ_SYSFS mode:
average frequency shows in kHz unit (despite the intended output to be in MHz),
and percentages for C state information are all wrong (including high/negative
values shown).

The problem is that the max_frequency read on initialization isn't used where it
should have been used on mperf_get_count_percent (to estimate the number of
ticks in the given time period), and the value we read from sysfs is in kHz, so
we must divide it to get the MHz value to use in current calculations.

While at it, also I fixed another small issues in the debug output of
max_frequency value in mperf_get_count_freq.

Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
---
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 90a8c4f..369d49ca 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -135,7 +135,7 @@ static int mperf_get_count_percent(unsigned int id, double *percent,
 		dprint("%s: TSC Ref - mperf_diff: %llu, tsc_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, tsc_diff);
 	} else if (max_freq_mode == MAX_FREQ_SYSFS) {
-		timediff = timespec_diff_us(time_start, time_end);
+		timediff = max_frequency * timespec_diff_us(time_start, time_end);
 		*percent = 100.0 * mperf_diff / timediff;
 		dprint("%s: MAXFREQ - mperf_diff: %llu, time_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, timediff);
@@ -176,7 +176,7 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 	dprint("%s: Average freq based on %s maximum frequency:\n",
 	       mperf_cstates[id].name,
 	       (max_freq_mode == MAX_FREQ_TSC_REF) ? "TSC calculated" : "sysfs read");
-	dprint("%max_frequency: %lu", max_frequency);
+	dprint("%%max_frequency: %lu\n", max_frequency);
 	dprint("aperf_diff: %llu\n", aperf_diff);
 	dprint("mperf_diff: %llu\n", mperf_diff);
 	dprint("avg freq:   %llu\n", *count);
@@ -279,6 +279,7 @@ use_sysfs:
 		return -1;
 	}
 	max_freq_mode = MAX_FREQ_SYSFS;
+	max_frequency /= 1000; /* Default automatically to MHz value */
 	return 0;
 }
 
-- 
2.1.0

