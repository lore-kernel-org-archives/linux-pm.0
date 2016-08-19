From: Andreas Herrmann <aherrmann@suse.com>
Subject: [PATCH 1/1] cpufreq: pcc-cpufreq: Re-introduce deadband effect to
 reduce number of frequency changes
Date: Fri, 19 Aug 2016 14:21:01 +0200
Message-ID: <20160819122101.GB17296@suselix.suse.de>
References: <20160819121814.GA17296@suselix.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160819121814.GA17296@suselix.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>
List-Id: linux-pm@vger.kernel.org


Commit 6393d6a102 (cpufreq: ondemand: Eliminate the deadband effect)
introduced a performance regression for systems using pcc-cpufreq and
ondemand governor. This is measurable with different workloads. E.g.
wall-clock time for kernel compilation significantly increased.

The elimination of the deadband effect significantly increased the
number of frequency changes with pcc-cpufreq.

Instead of reverting commit 6393d6a102 I suggest to add a workaround
in pcc-cpufreq to re-introduce the deadband effect for this driver
only - to restore the old performance behaviour with pcc-cpufreq with
ondemand governor.

Following some performance numbers for similar kernel compilations to
illustrate the effect of commit 6393d6a102 and the proposed fix.

Following typical numbers of kernel compilation tests with varying number of
compile jobs:

                     v4.8.0-rc2               4.8.0-rc2-pcc-cpufreq-deadband
 # of jobst   user     sys   elapsed   CPU     user     sys   elapsed   CPU
       2     440.39  116.49  4:33.35   203%   404.85  109.10  4:10.35   205%
       4     436.87  133.39  2:22.88   399%   381.83  128.00  2:06.84   401%
       8     475.49  157.68  1:22.24   769%   344.36  149.08  1:04.29   767%
      16     620.69  188.33  0:54.74  1477%   374.60  157.40  0:36.76  1447%
      32     815.79  209.58  0:37.22  2754%   490.46  160.22  0:24.87  2616%
      64     394.13   60.55  0:13.54  3355%   386.54   60.33  0:12.79  3493%
     120     398.24   61.55  0:14.60  3148%   390.44   61.19  0:13.07  3453%

(HP ProLiant DL580 Gen8 system, 60 CPUs @ 2.80GHz)

Link: http://marc.info/?l=linux-pm&m=147160912625600
Signed-off-by: Andreas Herrmann <aherrmann@suse.com>
---
 drivers/cpufreq/pcc-cpufreq.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

If this change is accepted maybe it's a good idea to tag it also for
stable kernels, e.g. starting with v4.4.


Thanks,

Andreas


diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 3f0ce2a..d2e2963 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -200,10 +200,26 @@ static int pcc_cpufreq_target(struct cpufreq_policy *policy,
 {
 	struct pcc_cpu *pcc_cpu_data;
 	struct cpufreq_freqs freqs;
+	static u32 limit = 0;
+
 	u16 status;
 	u32 input_buffer;
 	int cpu;
 
+	if (!limit) {
+		u32 f_min = policy->cpuinfo.min_freq / 1000;
+		u32 f_max = policy->cpuinfo.max_freq / 1000;
+		limit = (f_max - f_min) * f_min;
+		limit /= f_max;
+		limit *= 1000;
+		limit += f_min * 1000;
+		pr_debug("pcc-cpufreq: setting deadband limit to %u kHz\n",
+			limit);
+	}
+
+	if (target_freq < limit)
+		target_freq = policy->min;
+
 	cpu = policy->cpu;
 	pcc_cpu_data = per_cpu_ptr(pcc_cpu_info, cpu);
 
@@ -214,6 +230,10 @@ static int pcc_cpufreq_target(struct cpufreq_policy *policy,
 
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
+
+	if (freqs.new == freqs.old)
+		return 0;
+
 	cpufreq_freq_transition_begin(policy, &freqs);
 	spin_lock(&pcc_lock);
 
-- 
2.1.4
