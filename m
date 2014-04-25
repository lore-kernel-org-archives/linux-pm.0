From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 1/3] cpufreq,
 longhaul: Fix double invocation of cpufreq_freq_transition_begin/end
Date: Fri, 25 Apr 2014 13:48:09 +0530
Message-ID: <20140425081804.10258.8324.stgit@srivatsabhat.in.ibm.com>
References: <20140425081728.10258.63980.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140425081728.10258.63980.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, mroos@linux.ee, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

During frequency transitions, the cpufreq core takes the responsibility of
invoking cpufreq_freq_transition_begin() and cpufreq_freq_transition_end()
for those cpufreq drivers that define the ->target_index callback but don't
set the ASYNC_NOTIFICATION flag.

The longhaul cpufreq driver falls under this category, but this driver was
invoking the _begin() and _end() APIs itself around frequency transitions,
which led to double invocation of the _begin() API. The _begin API makes
contending callers wait until the previous invocation is complete. Hence,
the longhaul driver ended up waiting on itself, leading to system hangs
during boot.

Fix this by removing the calls to the _begin() and _end() APIs from the
longhaul driver, since they rightly belong to the cpufreq core.

(Note that during module_exit(), the longhaul driver sets the frequency
 without any help from the cpufreq core. So add explicit calls to the
 _begin() and _end() APIs around that frequency transition alone, to take
 care of that special case.)

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/cpufreq/longhaul.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index d00e5d1..9b6dd9a 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -269,8 +269,6 @@ static void longhaul_setstate(struct cpufreq_policy *policy,
 	freqs.old = calc_speed(longhaul_get_cpu_mult());
 	freqs.new = speed;
 
-	cpufreq_freq_transition_begin(policy, &freqs);
-
 	pr_debug("Setting to FSB:%dMHz Mult:%d.%dx (%s)\n",
 			fsb, mult/10, mult%10, print_speed(speed/1000));
 retry_loop:
@@ -385,8 +383,6 @@ retry_loop:
 			goto retry_loop;
 		}
 	}
-	/* Report true CPU frequency */
-	cpufreq_freq_transition_end(policy, &freqs, 0);
 
 	if (!bm_timeout)
 		printk(KERN_INFO PFX "Warning: Timeout while waiting for "
@@ -968,7 +964,15 @@ static void __exit longhaul_exit(void)
 
 	for (i = 0; i < numscales; i++) {
 		if (mults[i] == maxmult) {
+			struct cpufreq_freqs freqs;
+
+			freqs.old = policy->cur;
+			freqs.new = longhaul_table[i].frequency;
+			freqs.flags = 0;
+
+			cpufreq_freq_transition_begin(policy, &freqs);
 			longhaul_setstate(policy, i);
+			cpufreq_freq_transition_end(policy, &freqs, 0);
 			break;
 		}
 	}
