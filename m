From: "hongbo.zhang" <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V3 3/5] Thermal: Remove the cooling_cpufreq_list.
Date: Tue, 30 Oct 2012 17:48:59 +0100
Message-ID: <1351615741-24134-4-git-send-email-hongbo.zhang@linaro.com>
References: <1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
	<1351615741-24134-1-git-send-email-hongbo.zhang@linaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1351615741-24134-1-git-send-email-hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, amit.kachhap-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, kernel-vMlcbD5RyM6HZuj8yyL1ah2eb7JE58TQ@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, "hongbo.zhang" <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: "hongbo.zhang" <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>

Problem of using this list is that the cpufreq_get_max_state callback will be
called when register cooling device by thermal_cooling_device_register, but
this list isn't ready at this moment. What's more, there is no need to maintain
such a list, we can get cpufreq_cooling_device instance by the private
thermal_cooling_device.devdata.

Signed-off-by: hongbo.zhang <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
Reviewed-by: Francesco Lavra <francescolavra.fl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Amit Daniel Kachhap <amit.kachhap-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/thermal/cpu_cooling.c | 91 +++++++++----------------------------------
 1 file changed, 19 insertions(+), 72 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index bfd62b7..392d57d 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -58,8 +58,9 @@ struct cpufreq_cooling_device {
 };
 static LIST_HEAD(cooling_cpufreq_list);
 static DEFINE_IDR(cpufreq_idr);
+static DEFINE_MUTEX(cooling_cpufreq_lock);
 
-static struct mutex cooling_cpufreq_lock;
+static unsigned int cpufreq_dev_count;
 
 /* notify_table passes value to the CPUFREQ_ADJUST callback function. */
 #define NOTIFY_INVALID NULL
@@ -240,28 +241,18 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
-	int ret = -EINVAL, i = 0;
-	struct cpufreq_cooling_device *cpufreq_device;
-	struct cpumask *maskPtr;
+	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	struct cpumask *maskPtr = &cpufreq_device->allowed_cpus;
 	unsigned int cpu;
 	struct cpufreq_frequency_table *table;
 	unsigned long count = 0;
+	int i = 0;
 
-	mutex_lock(&cooling_cpufreq_lock);
-	list_for_each_entry(cpufreq_device, &cooling_cpufreq_list, node) {
-		if (cpufreq_device && cpufreq_device->cool_dev == cdev)
-			break;
-	}
-	if (cpufreq_device == NULL)
-		goto return_get_max_state;
-
-	maskPtr = &cpufreq_device->allowed_cpus;
 	cpu = cpumask_any(maskPtr);
 	table = cpufreq_frequency_get_table(cpu);
 	if (!table) {
 		*state = 0;
-		ret = 0;
-		goto return_get_max_state;
+		return 0;
 	}
 
 	for (i = 0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
@@ -272,12 +263,10 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 
 	if (count > 0) {
 		*state = --count;
-		ret = 0;
+		return 0;
 	}
 
-return_get_max_state:
-	mutex_unlock(&cooling_cpufreq_lock);
-	return ret;
+	return -EINVAL;
 }
 
 /**
@@ -288,20 +277,10 @@ return_get_max_state:
 static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
-	int ret = -EINVAL;
-	struct cpufreq_cooling_device *cpufreq_device;
+	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
 
-	mutex_lock(&cooling_cpufreq_lock);
-	list_for_each_entry(cpufreq_device, &cooling_cpufreq_list, node) {
-		if (cpufreq_device && cpufreq_device->cool_dev == cdev) {
-			*state = cpufreq_device->cpufreq_state;
-			ret = 0;
-			break;
-		}
-	}
-	mutex_unlock(&cooling_cpufreq_lock);
-
-	return ret;
+	*state = cpufreq_device->cpufreq_state;
+	return 0;
 }
 
 /**
@@ -312,22 +291,9 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
 static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
-	int ret = -EINVAL;
-	struct cpufreq_cooling_device *cpufreq_device;
+	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
 
-	mutex_lock(&cooling_cpufreq_lock);
-	list_for_each_entry(cpufreq_device, &cooling_cpufreq_list, node) {
-		if (cpufreq_device && cpufreq_device->cool_dev == cdev) {
-			ret = 0;
-			break;
-		}
-	}
-	if (!ret)
-		ret = cpufreq_apply_cooling(cpufreq_device, state);
-
-	mutex_unlock(&cooling_cpufreq_lock);
-
-	return ret;
+	return cpufreq_apply_cooling(cpufreq_device, state);
 }
 
 /* Bind cpufreq callbacks to thermal cooling device ops */
@@ -351,14 +317,11 @@ struct thermal_cooling_device *cpufreq_cooling_register(
 {
 	struct thermal_cooling_device *cool_dev;
 	struct cpufreq_cooling_device *cpufreq_dev = NULL;
-	unsigned int cpufreq_dev_count = 0, min = 0, max = 0;
+	unsigned int min = 0, max = 0;
 	char dev_name[THERMAL_NAME_LENGTH];
 	int ret = 0, i;
 	struct cpufreq_policy policy;
 
-	list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list, node)
-		cpufreq_dev_count++;
-
 	/*Verify that all the clip cpus have same freq_min, freq_max limit*/
 	for_each_cpu(i, clip_cpus) {
 		/*continue if cpufreq policy not found and not return error*/
@@ -380,9 +343,6 @@ struct thermal_cooling_device *cpufreq_cooling_register(
 
 	cpumask_copy(&cpufreq_dev->allowed_cpus, clip_cpus);
 
-	if (cpufreq_dev_count == 0)
-		mutex_init(&cooling_cpufreq_lock);
-
 	ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
 	if (ret) {
 		kfree(cpufreq_dev);
@@ -401,12 +361,12 @@ struct thermal_cooling_device *cpufreq_cooling_register(
 	cpufreq_dev->cool_dev = cool_dev;
 	cpufreq_dev->cpufreq_state = 0;
 	mutex_lock(&cooling_cpufreq_lock);
-	list_add_tail(&cpufreq_dev->node, &cooling_cpufreq_list);
 
 	/* Register the notifier for first cpufreq cooling device */
 	if (cpufreq_dev_count == 0)
 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
 						CPUFREQ_POLICY_NOTIFIER);
+	cpufreq_dev_count++;
 
 	mutex_unlock(&cooling_cpufreq_lock);
 	return cool_dev;
@@ -419,33 +379,20 @@ EXPORT_SYMBOL(cpufreq_cooling_register);
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
-	struct cpufreq_cooling_device *cpufreq_dev = NULL;
-	unsigned int cpufreq_dev_count = 0;
+	struct cpufreq_cooling_device *cpufreq_dev = cdev->devdata;
 
 	mutex_lock(&cooling_cpufreq_lock);
-	list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list, node) {
-		if (cpufreq_dev && cpufreq_dev->cool_dev == cdev)
-			break;
-		cpufreq_dev_count++;
-	}
-
-	if (!cpufreq_dev || cpufreq_dev->cool_dev != cdev) {
-		mutex_unlock(&cooling_cpufreq_lock);
-		return;
-	}
-
-	list_del(&cpufreq_dev->node);
+	cpufreq_dev_count--;
 
 	/* Unregister the notifier for the last cpufreq cooling device */
-	if (cpufreq_dev_count == 1) {
+	if (cpufreq_dev_count == 0) {
 		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
 					CPUFREQ_POLICY_NOTIFIER);
 	}
 	mutex_unlock(&cooling_cpufreq_lock);
+
 	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
 	release_idr(&cpufreq_idr, cpufreq_dev->id);
-	if (cpufreq_dev_count == 1)
-		mutex_destroy(&cooling_cpufreq_lock);
 	kfree(cpufreq_dev);
 }
 EXPORT_SYMBOL(cpufreq_cooling_unregister);
-- 
1.7.11.3
