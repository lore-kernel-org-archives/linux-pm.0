From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
 params
Date: Fri, 6 Jan 2012 07:46:13 -0800
Message-ID: <20120106154613.GI12530@mgross-G62>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 06, 2012 at 02:36:20AM +0200, Antti P Miettinen wrote:
> The inspiration for this patch series is the N9 CPU frequency boost
> upon input events:
> 
> http://www.spinics.net/lists/cpufreq/msg00667.html
> 
> and the related changes in git://codeaurora.org/kernel/msm.git tree.
> Those patches modify the ondemand cpufreq governor. This patch series
> adds minimum and maximum CPU frequency as PM QoS parameters and
> modifies the cpufreq core to enforce the PM QoS limits. There is also
> an example module for boosting the frequency upon input events.
> 
> I've been testing these changes against Ubuntu 3.2 kernel on a Dell
> E6420 with the ACPI cpufreq driver. The patches are against
> linux-next/master, compile tested against it.
> 
> 	--Antti
> 
> Alex Frid (1):
>   PM QoS: Simplify PM QoS expansion/merge
> 
> Antti P Miettinen (5):
>   PM QoS: Add CPU frequency min/max as PM QoS params
>   cpufreq: Export user_policy min/max
>   cpufreq: Preserve sysfs min/max request
>   cpufreq: Enforce PM QoS min/max limits
>   input: CPU frequency booster
> 
>  drivers/cpufreq/cpufreq.c     |   57 +++++++++++++-
>  drivers/input/Kconfig         |    9 ++
>  drivers/input/Makefile        |    1 +
>  drivers/input/input-cfboost.c |  174 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_qos.h        |   19 ++++-
>  kernel/power/qos.c            |   55 ++++++++++----
>  6 files changed, 293 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/input/input-cfboost.c
> 
> -- 
> 1.7.4.1
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm

The following is my version of part of this patch set I was tinkering
with.  Its missing the cpufreq notification this change has and doesn't
do anything WRT cfboost.

Would it be ok if we could consolidate our two implementations and
completely separate the cfboost stuff as a separate patch set?

My code below is missing the cpufreq notification logic you have.

--mark

Signed-off-by: markgross <markgross@thegnar.org>


>From b4be99354c5af20cbd4041cddd6038e2353e06b4 Mon Sep 17 00:00:00 2001
From: mgross <mgross@mini>
Date: Sat, 24 Dec 2011 13:40:03 -0800
Subject: [PATCH] Some devices have a subtle relationship with the CPU
 throughput and need to set a minimum cpu frequency en order
 for the device to not experience performance issues with
 buffer under runs because the cpu was throttled too much to
 be able to keep the buffers full enough.

One graphics benchmark has shown this issue on Intel SOC devices.  The
graphics part ends up waiting on the cpu to fill the open GL instruction
queue between frames and thus graphic performance suffers because of the
cpu throttling because the CPU really isn't very busy while running the
benchmark.
---
 drivers/cpufreq/cpufreq.c |    8 ++++++++
 include/linux/pm_qos.h    |    8 +++++---
 kernel/power/qos.c        |   19 +++++++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 987a165..4cbd58b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/syscore_ops.h>
+#include <linux/pm_qos.h>
 
 #include <trace/events/power.h>
 
@@ -1629,6 +1630,9 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n", policy->cpu,
 		policy->min, policy->max);
+	
+	if (policy->min < pm_qos_request(PM_QOS_CPU_THROUGHPUT))
+		policy->min = pm_qos_request(PM_QOS_CPU_THROUGHPUT);
 
 	memcpy(&policy->cpuinfo, &data->cpuinfo,
 				sizeof(struct cpufreq_cpuinfo));
@@ -1736,6 +1740,10 @@ int cpufreq_update_policy(unsigned int cpu)
 	policy.policy = data->user_policy.policy;
 	policy.governor = data->user_policy.governor;
 
+	if (policy.min < pm_qos_request(PM_QOS_CPU_THROUGHPUT))
+		policy.min = pm_qos_request(PM_QOS_CPU_THROUGHPUT);
+
+
 	/* BIOS might change freq behind our back
 	  -> ask driver for current freq and notify governors about a change */
 	if (cpufreq_driver->get) {
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 83b0ea3..ead081c 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -11,13 +11,15 @@
 
 #define PM_QOS_RESERVED 0
 #define PM_QOS_CPU_DMA_LATENCY 1
-#define PM_QOS_NETWORK_LATENCY 2
-#define PM_QOS_NETWORK_THROUGHPUT 3
+#define PM_QOS_CPU_THROUGHPUT 2
+#define PM_QOS_NETWORK_LATENCY 3
+#define PM_QOS_NETWORK_THROUGHPUT 4
 
-#define PM_QOS_NUM_CLASSES 4
+#define PM_QOS_NUM_CLASSES 5
 #define PM_QOS_DEFAULT_VALUE -1
 
 #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
+#define PM_QOS_CPU_THROUGHPUT_DEFAULT_VALUE	0
 #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
 #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
 #define PM_QOS_DEV_LAT_DEFAULT_VALUE		0
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 995e3bd..92951fa 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -60,6 +60,19 @@ static DEFINE_SPINLOCK(pm_qos_lock);
 
 static struct pm_qos_object null_pm_qos;
 
+static BLOCKING_NOTIFIER_HEAD(cpu_throughput_notifier);
+static struct pm_qos_constraints cpu_throughput_constraints = {
+	.list = PLIST_HEAD_INIT(cpu_throughput_constraints.list),
+	.target_value = PM_QOS_CPU_THROUGHPUT_DEFAULT_VALUE,
+	.default_value = PM_QOS_CPU_THROUGHPUT_DEFAULT_VALUE,
+	.type = PM_QOS_MIN,
+	.notifiers = &cpu_throughput_notifier,
+};
+static struct pm_qos_object cpu_throughput_pm_qos = {
+	.constraints = &cpu_throughput_constraints,
+	.name = "cpu_throughput",
+};
+
 static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
 static struct pm_qos_constraints cpu_dma_constraints = {
 	.list = PLIST_HEAD_INIT(cpu_dma_constraints.list),
@@ -104,6 +117,7 @@ static struct pm_qos_object network_throughput_pm_qos = {
 static struct pm_qos_object *pm_qos_array[] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
+	&cpu_throughput_pm_qos,
 	&network_lat_pm_qos,
 	&network_throughput_pm_qos
 };
@@ -475,6 +489,11 @@ static int __init pm_qos_power_init(void)
 		printk(KERN_ERR "pm_qos_param: cpu_dma_latency setup failed\n");
 		return ret;
 	}
+	ret = register_pm_qos_misc(&cpu_throughput_pm_qos);
+	if (ret < 0) {
+		printk(KERN_ERR "pm_qos_param: cpu_throughput setup failed\n");
+		return ret;
+	}
 	ret = register_pm_qos_misc(&network_lat_pm_qos);
 	if (ret < 0) {
 		printk(KERN_ERR "pm_qos_param: network_latency setup failed\n");
-- 
1.7.5.4
