From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC][PATCH 8 of 7] cpufreq: intel_pstate: add iir filter to pstate.
Date: Thu, 25 Aug 2016 10:00:40 -0700
Message-ID: <000d01d1fef2$36ff5960$a4fe0c20$@net>
References: <1471907493-26639-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta20.telus.net ([209.171.16.93]:55930 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754739AbcHYRAr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Aug 2016 13:00:47 -0400
In-Reply-To: <1471907493-26639-1-git-send-email-dsmythies@telus.net>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

Hi Srinivas:

On 2016.08.22 16:12 Doug Smythies wrote:

...[cut]...
+	 *
+	 * no clamps. Pre-filter clamping was needed in past implementations.
+	 * To Do: Is any pre-filter clamping needed here? */

Yes, clamping is needed, otherwise, and for example, the target pstate
can "stick" low at high load for a few sample periods, until the filtered
value gets high enough. For the fix, I clamped the post-filter output value
(perhaps not in the best way, but for now):

doug@s15:~/temp-k-git/linux/drivers/cpufreq$ git diff
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ab5c004..56c09ef8f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1307,6 +1307,7 @@ static inline int32_t get_target_pstate_default(struct cpudata *cpu)
        int64_t scaled_gain, unfiltered_target;
        int32_t busy_frac;
        int pstate;
+       int max_perf, min_perf;
        u64 duration_ns;

        busy_frac = div_fp(sample->mperf, sample->tsc);
@@ -1399,6 +1400,14 @@ static inline int32_t get_target_pstate_default(struct cpudata *cpu)
        cpu->sample.target = div_u64((int_tofp(100) - scaled_gain) *
                        cpu->sample.target + scaled_gain *
                        unfiltered_target, int_tofp(100));
+       /*
+        * Clamp the filtered value.
+        */
+       intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
+       if (cpu->sample.target < int_tofp(min_perf))
+               cpu->sample.target = int_tofp(min_perf);
+        if (cpu->sample.target > int_tofp(max_perf))
+                cpu->sample.target = int_tofp(max_perf);

        return fp_toint(cpu->sample.target + (1 << (FRAC_BITS-1)));
 }

I'll send an updated patch in a few hours.

...[cut]... 

+	 *
+	 * To Do: Often the actual pstate the system ran at over the last
+	 * 	  interval is not what was asked for, due to influence from
+	 *	  other CPUs. It might make sense to use the average pstate
+	 *	  (get_avg_pstate) as the old_output here (as per previous
+	 *	  work by Philippe Longepe and Stephane Gasparini on the
+	 *	  get_target_pstate_use_cpu_load method). Test it.
+	 */

I have a version of this working. More on that it at a later date.

... Doug


