From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] Revert "cpufreq: Don't use cpu removed during cpufreq_driver_unregister"
Date: Tue, 29 Jan 2013 10:10:00 +0530
Message-ID: <c5f698edde8215a706fb82c158fb0050798797f2.1359434113.git.viresh.kumar@linaro.org>
References: <d6827976a56d429848ab8ababa2779a21c68d65f.1359434113.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d6827976a56d429848ab8ababa2779a21c68d65f.1359434113.git.viresh.kumar@linaro.org>
In-Reply-To: <d6827976a56d429848ab8ababa2779a21c68d65f.1359434113.git.viresh.kumar@linaro.org>
References: <d6827976a56d429848ab8ababa2779a21c68d65f.1359434113.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, inderpal.singh@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This reverts commit 956f33948b95aa91f6cbc6860087671c6ac1de4b.

With the addition of following patch, this change/variable is not required:

commit b9ba2725343ae57add3f324dfa5074167f48de96
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon Jan 14 13:23:03 2013 +0000

    cpufreq: Simplify __cpufreq_remove_dev()

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index db81382..8d521422 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -47,9 +47,6 @@ static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu=
_governor);
 #endif
 static DEFINE_SPINLOCK(cpufreq_driver_lock);
=20
-/* Used when we unregister cpufreq driver */
-static struct cpumask cpufreq_online_mask;
-
 /*
  * cpu_policy_rwsem is a per CPU reader-writer semaphore designed to cure
  * all cpufreq/hotplug/workqueue/etc related lock issues.
@@ -951,7 +948,6 @@ static int cpufreq_add_dev(struct device *dev, struct s=
ubsys_interface *sif)
 =09 * managing offline cpus here.
 =09 */
 =09cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
-=09cpumask_and(policy->cpus, policy->cpus, &cpufreq_online_mask);
=20
 =09policy->user_policy.min =3D policy->min;
 =09policy->user_policy.max =3D policy->max;
@@ -1133,7 +1129,6 @@ static int cpufreq_remove_dev(struct device *dev, str=
uct subsys_interface *sif)
 =09if (unlikely(lock_policy_rwsem_write(cpu)))
 =09=09BUG();
=20
-=09cpumask_clear_cpu(cpu, &cpufreq_online_mask);
 =09retval =3D __cpufreq_remove_dev(dev, sif);
 =09return retval;
 }
@@ -1875,8 +1870,6 @@ int cpufreq_register_driver(struct cpufreq_driver *dr=
iver_data)
 =09cpufreq_driver =3D driver_data;
 =09spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
=20
-=09cpumask_setall(&cpufreq_online_mask);
-
 =09ret =3D subsys_interface_register(&cpufreq_interface);
 =09if (ret)
 =09=09goto err_null_driver;
--=20
1.7.12.rc2.18.g61b472e
