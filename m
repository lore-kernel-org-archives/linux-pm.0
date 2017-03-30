From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH] cpufreq: schedutil: Reduce frequencies slower
Date: Thu, 30 Mar 2017 23:36:41 +0200
Message-ID: <1514608.eWxQqcMBcc@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, John <john.ettedgui@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The schedutil governor reduces frequencies too fast in some
situations which cases undesirable performance drops to
appear.

To address that issue, make schedutil reduce the frequency slower by
setting it to the average of the value chosen during the previous
iteration of governor computations and the new one coming from its
frequency selection formula.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=194963
Reported-by: John <john.ettedgui@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This addresses a practical issue, but one in the "responsiveness" or
"interactivity" category which is quite hard to represent quantitatively.

As reported by John in BZ194963, schedutil does not ramp up P-states quickly
enough which causes audio issues to appear in his gaming setup.  At least it
evidently is worse than ondemand in this respect and the patch below helps.

The patch essentially repeats the trick added some time ago to the load-based
P-state selection algorithm in intel_pstate, which allowed us to make it viable
for performance-oriented users, and which is to reduce frequencies at a slower
pace.

The reason why I chose the average is because it is computationally cheap
and pretty much the max reasonable slowdown and the idea is that in case
there's something about to run that we don't know about yet, it is better to
stay at a higher level for a while more to avoid having to get up from the floor
every time.

But technically speaking it is a filter. :-)

So among other things I'm wondering if that leads to substantial increases in
energy consumption anywhere.

Thanks,
Rafael

---
 kernel/sched/cpufreq_schedutil.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -101,6 +101,9 @@ static void sugov_update_commit(struct s
 	if (sg_policy->next_freq == next_freq)
 		return;
 
+	if (sg_policy->next_freq > next_freq)
+		next_freq = (sg_policy->next_freq + next_freq) >> 1;
+
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;
 
