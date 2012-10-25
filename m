From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [RFC] cpufreq: Make sure target freq is within limits
Date: Thu, 25 Oct 2012 12:03:34 +0530
Message-ID: <f0099171c1c4f3048d0f29b7deb42144f26ac5d5.1351146515.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdsw-power-team-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

__cpufreq_driver_target() must not pass target frequency beyond the limits of
current policy.

Today most of cpufreq platform drivers are doing this check in their target
routines. Why not move it to __cpufreq_driver_target().

I wanted to get your opinion on this before making changes in all driver files.
That's why this is an RFC.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f552d5f..59264f1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1470,12 +1470,19 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	int retval = -EINVAL;
+	unsigned int old_target_freq = target_freq;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	pr_debug("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
-		target_freq, relation);
+	/* Make sure that target_freq is within supported range */
+	if (target_freq > policy->max)
+		target_freq = policy->max;
+	if (target_freq < policy->min)
+		target_freq = policy->min;
+
+	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
+			policy->cpu, target_freq, relation, old_target_freq);
 	if (cpu_online(policy->cpu) && cpufreq_driver->target)
 		retval = cpufreq_driver->target(policy, target_freq, relation);
 
-- 
1.7.12.rc2.18.g61b472e
