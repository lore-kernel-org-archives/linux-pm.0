From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 2/3] cpufreq, powernow-k6: Fix double invocation of
 cpufreq_freq_transition_begin/end
Date: Fri, 25 Apr 2014 13:48:21 +0530
Message-ID: <20140425081815.10258.36201.stgit@srivatsabhat.in.ibm.com>
References: <20140425081728.10258.63980.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20140425081728.10258.63980.stgit@srivatsabhat.in.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net, mroos@linux.ee, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

During frequency transitions, the cpufreq core takes the responsibility of
invoking cpufreq_freq_transition_begin() and cpufreq_freq_transition_end()
for those cpufreq drivers that define the ->target_index callback but don't
set the ASYNC_NOTIFICATION flag.

The powernow-k6 cpufreq driver falls under this category, but this driver was
invoking the _begin() and _end() APIs itself around frequency transitions,
which led to double invocation of the _begin() API. The _begin API makes
contending callers wait until the previous invocation is complete. Hence,
the powernow-k6 driver ended up waiting on itself, leading to system hangs
during boot.

Fix this by removing the calls to the _begin() and _end() APIs from the
powernow-k6 driver, since they rightly belong to the cpufreq core.

(Note that during ->exit(), the powernow-k6 driver sets the frequency
 without any help from the cpufreq core. So add explicit calls to the
 _begin() and _end() APIs around that frequency transition alone, to take
 care of that special case. Also, add a missing 'break' statement there.)

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/cpufreq/powernow-k6.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index 49f120e..6a4c34e 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -138,22 +138,14 @@ static void powernow_k6_set_cpu_multiplier(unsigned int best_i)
 static int powernow_k6_target(struct cpufreq_policy *policy,
 		unsigned int best_i)
 {
-	struct cpufreq_freqs freqs;
 
 	if (clock_ratio[best_i].driver_data > max_multiplier) {
 		printk(KERN_ERR PFX "invalid target frequency\n");
 		return -EINVAL;
 	}
 
-	freqs.old = busfreq * powernow_k6_get_cpu_multiplier();
-	freqs.new = busfreq * clock_ratio[best_i].driver_data;
-
-	cpufreq_freq_transition_begin(policy, &freqs);
-
 	powernow_k6_set_cpu_multiplier(best_i);
 
-	cpufreq_freq_transition_end(policy, &freqs, 0);
-
 	return 0;
 }
 
@@ -228,8 +220,18 @@ static int powernow_k6_cpu_exit(struct cpufreq_policy *policy)
 {
 	unsigned int i;
 	for (i = 0; i < 8; i++) {
-		if (i == max_multiplier)
+		if (i == max_multiplier) {
+			struct cpufreq_freqs freqs;
+
+			freqs.old = policy->cur;
+			freqs.new = clock_ratio[i].frequency;
+			freqs.flags = 0;
+
+			cpufreq_freq_transition_begin(policy, &freqs);
 			powernow_k6_target(policy, i);
+			cpufreq_freq_transition_end(policy, &freqs, 0);
+			break;
+		}
 	}
 	return 0;
 }

