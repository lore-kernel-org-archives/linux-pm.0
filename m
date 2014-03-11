From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH v2] cpufreq: Reformat printk() statements
Date: Tue, 11 Mar 2014 10:03:00 -0700
Message-ID: <1394557380-15054-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joe Perches <joe@perches.com>
Cc: cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Joe Perches <joe@perches.com>

 - Add missing newlines
 - Coalesce format fragments
 - Convert printks to pr_<level>
 - Align arguments

Original-patch-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
I didn't send this out yesterday, did I?
Anyway, this is Joe's patch. I thought I just submit it as proper patch=
 which is
easier to handle than assembling this from all the pieces in the origin=
al
thread.

	Thanks,
	S=C3=B6ren

 drivers/cpufreq/cpufreq.c | 85 ++++++++++++++++++++++-----------------=
--------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 08ca8c9f41cd..9eb1bd924817 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -181,8 +181,8 @@ unsigned int cpufreq_generic_get(unsigned int cpu)
 	struct cpufreq_policy *policy =3D per_cpu(cpufreq_cpu_data, cpu);
=20
 	if (!policy || IS_ERR(policy->clk)) {
-		pr_err("%s: No %s associated to cpu: %d\n", __func__,
-				policy ? "clk" : "policy", cpu);
+		pr_err("%s: No %s associated to cpu: %d\n",
+		       __func__, policy ? "clk" : "policy", cpu);
 		return 0;
 	}
=20
@@ -254,15 +254,15 @@ static void adjust_jiffies(unsigned long val, str=
uct cpufreq_freqs *ci)
 	if (!l_p_j_ref_freq) {
 		l_p_j_ref =3D loops_per_jiffy;
 		l_p_j_ref_freq =3D ci->old;
-		pr_debug("saving %lu as reference value for loops_per_jiffy; "
-			"freq is %u kHz\n", l_p_j_ref, l_p_j_ref_freq);
+		pr_debug("saving %lu as reference value for loops_per_jiffy; freq is=
 %u kHz\n",
+			 l_p_j_ref, l_p_j_ref_freq);
 	}
 	if ((val =3D=3D CPUFREQ_POSTCHANGE && ci->old !=3D ci->new) ||
 	    (val =3D=3D CPUFREQ_RESUMECHANGE || val =3D=3D CPUFREQ_SUSPENDCHA=
NGE)) {
 		loops_per_jiffy =3D cpufreq_scale(l_p_j_ref, l_p_j_ref_freq,
 								ci->new);
-		pr_debug("scaling loops_per_jiffy to %lu "
-			"for frequency %u kHz\n", loops_per_jiffy, ci->new);
+		pr_debug("scaling loops_per_jiffy to %lu for frequency %u kHz\n",
+			 loops_per_jiffy, ci->new);
 	}
 }
 #else
@@ -282,7 +282,7 @@ static void __cpufreq_notify_transition(struct cpuf=
req_policy *policy,
=20
 	freqs->flags =3D cpufreq_driver->flags;
 	pr_debug("notification %u of frequency transition to %u kHz\n",
-		state, freqs->new);
+		 state, freqs->new);
=20
 	switch (state) {
=20
@@ -294,9 +294,8 @@ static void __cpufreq_notify_transition(struct cpuf=
req_policy *policy,
 		if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
 			if ((policy) && (policy->cpu =3D=3D freqs->cpu) &&
 			    (policy->cur) && (policy->cur !=3D freqs->old)) {
-				pr_debug("Warning: CPU frequency is"
-					" %u, cpufreq assumed %u kHz.\n",
-					freqs->old, policy->cur);
+				pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
+					 freqs->old, policy->cur);
 				freqs->old =3D policy->cur;
 			}
 		}
@@ -307,8 +306,8 @@ static void __cpufreq_notify_transition(struct cpuf=
req_policy *policy,
=20
 	case CPUFREQ_POSTCHANGE:
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
-		pr_debug("FREQ: %lu - CPU: %lu", (unsigned long)freqs->new,
-			(unsigned long)freqs->cpu);
+		pr_debug("FREQ: %lu - CPU: %lu\n",
+			 (unsigned long)freqs->new, (unsigned long)freqs->cpu);
 		trace_cpu_frequency(freqs->new, freqs->cpu);
 		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 				CPUFREQ_POSTCHANGE, freqs);
@@ -368,13 +367,13 @@ static ssize_t store_boost(struct kobject *kobj, =
struct attribute *attr,
 		return -EINVAL;
=20
 	if (cpufreq_boost_trigger_state(enable)) {
-		pr_err("%s: Cannot %s BOOST!\n", __func__,
-		       enable ? "enable" : "disable");
+		pr_err("%s: Cannot %s BOOST!\n",
+		       __func__, enable ? "enable" : "disable");
 		return -EINVAL;
 	}
=20
-	pr_debug("%s: cpufreq BOOST %s\n", __func__,
-		 enable ? "enabled" : "disabled");
+	pr_debug("%s: cpufreq BOOST %s\n",
+		 __func__, enable ? "enabled" : "disabled");
=20
 	return count;
 }
@@ -1184,7 +1183,7 @@ static int __cpufreq_add_dev(struct device *dev, =
struct subsys_interface *sif,
 	if (gov) {
 		policy->governor =3D gov;
 		pr_debug("Restoring governor %s for cpu %d\n",
-		       policy->governor->name, cpu);
+			 policy->governor->name, cpu);
 	}
 #endif
=20
@@ -1263,7 +1262,7 @@ static int cpufreq_nominate_new_policy_cpu(struct=
 cpufreq_policy *policy,
 	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
 	ret =3D kobject_move(&policy->kobj, &cpu_dev->kobj);
 	if (ret) {
-		pr_err("%s: Failed to move kobj: %d", __func__, ret);
+		pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
=20
 		down_write(&policy->rwsem);
 		cpumask_set_cpu(old_cpu, policy->cpus);
@@ -1332,7 +1331,7 @@ static int __cpufreq_remove_dev_prepare(struct de=
vice *dev,
=20
 			if (!frozen) {
 				pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
-						__func__, new_cpu, cpu);
+					 __func__, new_cpu, cpu);
 			}
 		}
 	}
@@ -1372,7 +1371,7 @@ static int __cpufreq_remove_dev_finish(struct dev=
ice *dev,
 					CPUFREQ_GOV_POLICY_EXIT);
 			if (ret) {
 				pr_err("%s: Failed to exit governor\n",
-						__func__);
+				       __func__);
 				return ret;
 			}
 		}
@@ -1400,7 +1399,7 @@ static int __cpufreq_remove_dev_finish(struct dev=
ice *dev,
 			if ((ret =3D __cpufreq_governor(policy, CPUFREQ_GOV_START)) ||
 					(ret =3D __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS))) {
 				pr_err("%s: Failed to start governor\n",
-						__func__);
+				       __func__);
 				return ret;
 			}
 		}
@@ -1457,8 +1456,8 @@ static void cpufreq_out_of_sync(unsigned int cpu,=
 unsigned int old_freq,
 	struct cpufreq_freqs freqs;
 	unsigned long flags;
=20
-	pr_debug("Warning: CPU frequency out of sync: cpufreq and timing "
-	       "core thinks of %u, is %u kHz.\n", old_freq, new_freq);
+	pr_debug("Warning: CPU frequency out of sync: cpufreq and timing core=
 thinks of %u, is %u kHz\n",
+		 old_freq, new_freq);
=20
 	freqs.old =3D old_freq;
 	freqs.new =3D new_freq;
@@ -1599,8 +1598,8 @@ static int cpufreq_bp_suspend(void)
 	if (cpufreq_driver->suspend) {
 		ret =3D cpufreq_driver->suspend(policy);
 		if (ret)
-			printk(KERN_ERR "cpufreq: suspend failed in ->suspend "
-					"step on CPU %u\n", policy->cpu);
+			pr_err("suspend failed in ->suspend step on CPU %u\n",
+			       policy->cpu);
 	}
=20
 	cpufreq_cpu_put(policy);
@@ -1637,8 +1636,8 @@ static void cpufreq_bp_resume(void)
 	if (cpufreq_driver->resume) {
 		ret =3D cpufreq_driver->resume(policy);
 		if (ret) {
-			printk(KERN_ERR "cpufreq: resume failed in ->resume "
-					"step on CPU %u\n", policy->cpu);
+			pr_err("resume failed in ->resume step on CPU %u\n",
+			       policy->cpu);
 			goto fail;
 		}
 	}
@@ -1768,7 +1767,7 @@ int __cpufreq_driver_target(struct cpufreq_policy=
 *policy,
 		target_freq =3D policy->min;
=20
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n"=
,
-			policy->cpu, target_freq, relation, old_target_freq);
+		 policy->cpu, target_freq, relation, old_target_freq);
=20
 	/*
 	 * This might look like a redundant call as we are checking it again
@@ -1813,8 +1812,7 @@ int __cpufreq_driver_target(struct cpufreq_policy=
 *policy,
 			freqs.flags =3D 0;
=20
 			pr_debug("%s: cpu: %d, oldfreq: %u, new freq: %u\n",
-					__func__, policy->cpu, freqs.old,
-					freqs.new);
+				 __func__, policy->cpu, freqs.old, freqs.new);
=20
 			cpufreq_notify_transition(policy, &freqs,
 					CPUFREQ_PRECHANGE);
@@ -1823,7 +1821,7 @@ int __cpufreq_driver_target(struct cpufreq_policy=
 *policy,
 		retval =3D cpufreq_driver->target_index(policy, index);
 		if (retval)
 			pr_err("%s: Failed to change cpu frequency: %d\n",
-					__func__, retval);
+			       __func__, retval);
=20
 		if (notify)
 			cpufreq_notify_post_transition(policy, &freqs, retval);
@@ -1875,11 +1873,8 @@ static int __cpufreq_governor(struct cpufreq_pol=
icy *policy,
 		if (!gov)
 			return -EINVAL;
 		else {
-			printk(KERN_WARNING "%s governor failed, too long"
-			       " transition latency of HW, fallback"
-			       " to %s governor\n",
-			       policy->governor->name,
-			       gov->name);
+			pr_warn("%s governor failed, too long transition latency of HW, fal=
lback to %s governor\n",
+				policy->governor->name, gov->name);
 			policy->governor =3D gov;
 		}
 	}
@@ -1889,7 +1884,7 @@ static int __cpufreq_governor(struct cpufreq_poli=
cy *policy,
 			return -EINVAL;
=20
 	pr_debug("__cpufreq_governor for CPU %u, event %u\n",
-						policy->cpu, event);
+		 policy->cpu, event);
=20
 	mutex_lock(&cpufreq_governor_lock);
 	if ((policy->governor_enabled && event =3D=3D CPUFREQ_GOV_START)
@@ -2020,8 +2015,8 @@ static int cpufreq_set_policy(struct cpufreq_poli=
cy *policy,
 {
 	int ret =3D 0, failed =3D 1;
=20
-	pr_debug("setting new policy for CPU %u: %u - %u kHz\n", new_policy->=
cpu,
-		new_policy->min, new_policy->max);
+	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
+		 new_policy->cpu, new_policy->min, new_policy->max);
=20
 	memcpy(&new_policy->cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo=
));
=20
@@ -2059,7 +2054,7 @@ static int cpufreq_set_policy(struct cpufreq_poli=
cy *policy,
 	policy->max =3D new_policy->max;
=20
 	pr_debug("new min and max freqs are %u - %u kHz\n",
-					policy->min, policy->max);
+		 policy->min, policy->max);
=20
 	if (cpufreq_driver->setpolicy) {
 		policy->policy =3D new_policy->policy;
@@ -2152,7 +2147,7 @@ int cpufreq_update_policy(unsigned int cpu)
 	if (cpufreq_driver->get) {
 		new_policy.cur =3D cpufreq_driver->get(cpu);
 		if (!policy->cur) {
-			pr_debug("Driver did not initialize current freq");
+			pr_debug("Driver did not initialize current freq\n");
 			policy->cur =3D new_policy.cur;
 		} else {
 			if (policy->cur !=3D new_policy.cur && has_target())
@@ -2255,8 +2250,8 @@ int cpufreq_boost_trigger_state(int state)
 		cpufreq_driver->boost_enabled =3D !state;
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
=20
-		pr_err("%s: Cannot %s BOOST\n", __func__,
-		       state ? "enable" : "disable");
+		pr_err("%s: Cannot %s BOOST\n",
+		       __func__, state ? "enable" : "disable");
 	}
=20
 	return ret;
@@ -2328,7 +2323,7 @@ int cpufreq_register_driver(struct cpufreq_driver=
 *driver_data)
 		ret =3D cpufreq_sysfs_create_file(&boost.attr);
 		if (ret) {
 			pr_err("%s: cannot register global BOOST sysfs file\n",
-				__func__);
+			       __func__);
 			goto err_null_driver;
 		}
 	}
@@ -2351,7 +2346,7 @@ int cpufreq_register_driver(struct cpufreq_driver=
 *driver_data)
 		/* if all ->init() calls failed, unregister */
 		if (ret) {
 			pr_debug("no CPU initialized for driver %s\n",
-							driver_data->name);
+				 driver_data->name);
 			goto err_if_unreg;
 		}
 	}
--=20
1.9.0.1.g4196000

