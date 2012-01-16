From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH v2 8/8] cpufreq: Enforce PM QoS maximum frequency
Date: Mon, 16 Jan 2012 09:00:01 +0200
Message-ID: <1326697201-32406-9-git-send-email-amiettinen@nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Observe PM QoS CPU frequency maximum in addition to
policy settings.

Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
---
 drivers/cpufreq/cpufreq.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c2c1c62..d233a8b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1638,12 +1638,15 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
 	unsigned int pmax = policy->max;
 	unsigned int qmin = min(pm_qos_request(PM_QOS_CPU_FREQ_MIN),
 				data->max);
+	unsigned int qmax = max(pm_qos_request(PM_QOS_CPU_FREQ_MAX),
+				data->min);
 
-	pr_debug("setting new policy for CPU %u: %u/%u - %u kHz\n",
-		 policy->cpu, pmin, qmin, pmax);
+	pr_debug("setting new policy for CPU %u: %u/%u - %u/%u kHz\n",
+		 policy->cpu, pmin, qmin, pmax, qmax);
 
 	/* clamp the new policy to PM QoS limits */
 	policy->min = max(pmin, qmin);
+	policy->max = min(pmax, qmax);
 
 	memcpy(&policy->cpuinfo, &data->cpuinfo,
 				sizeof(struct cpufreq_cpuinfo));
@@ -1920,12 +1923,16 @@ static int cpu_freq_notify(struct notifier_block *b,
 static struct notifier_block min_freq_notifier = {
 	.notifier_call = cpu_freq_notify,
 };
+static struct notifier_block max_freq_notifier = {
+	.notifier_call = cpu_freq_notify,
+};
 
 static int cpu_freq_notify(struct notifier_block *b,
 			   unsigned long l, void *v)
 {
 	int cpu;
-	pr_debug("PM QoS min %lu\n", l);
+	pr_debug("PM QoS %s %lu\n",
+		 b == &min_freq_notifier ? "min" : "max", l);
 	for_each_online_cpu(cpu) {
 		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 		if (policy) {
@@ -1952,6 +1959,9 @@ static int __init cpufreq_core_init(void)
 	rc = pm_qos_add_notifier(PM_QOS_CPU_FREQ_MIN,
 				 &min_freq_notifier);
 	BUG_ON(rc);
+	rc = pm_qos_add_notifier(PM_QOS_CPU_FREQ_MAX,
+				 &max_freq_notifier);
+	BUG_ON(rc);
 
 	return 0;
 }
-- 
1.7.4.1
