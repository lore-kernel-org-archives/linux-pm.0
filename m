From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: Set policy->related_cpus to atleast policy->cpus
Date: Tue, 29 Jan 2013 10:09:59 +0530
Message-ID: <d6827976a56d429848ab8ababa2779a21c68d65f.1359434113.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, inderpal.singh@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

With the addition of following patch, related_cpus is required to be set by
cpufreq platform drivers:

commit c1070fd743533efb54e98142252283583f379190
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon Jan 14 13:23:04 2013 +0000

    cpufreq: Simplify cpufreq_add_dev()

Because this change is required by all platform drivers, why not do this in=
 the
core itself. Hence, this patch is an attempt towards fixing all broken driv=
ers.

>From now on, platforms don't really need to set related_cpus from their ini=
t()
routines, as the same work is done by core too.

If platform driver needs to set the related_cpus mask with some additional =
cpus,
other than cpus present in policy->cpus, they are free to do it as we aren'=
t
overriding anything.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Inderpal,

Can you please add your tested-by for this patch? And this will require you=
 to
drop your patch for exynos-cpufreq.c :)

 drivers/cpufreq/cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f5dc02b..db81382 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -554,8 +554,6 @@ static ssize_t show_cpus(const struct cpumask *mask, ch=
ar *buf)
  */
 static ssize_t show_related_cpus(struct cpufreq_policy *policy, char *buf)
 {
-=09if (cpumask_empty(policy->related_cpus))
-=09=09return show_cpus(policy->cpus, buf);
 =09return show_cpus(policy->related_cpus, buf);
 }
=20
@@ -945,6 +943,9 @@ static int cpufreq_add_dev(struct device *dev, struct s=
ubsys_interface *sif)
 =09=09goto err_unlock_policy;
 =09}
=20
+=09/* related cpus should atleast have policy->cpus */
+=09cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
+
 =09/*
 =09 * affected cpus must always be the one, which are online. We aren't
 =09 * managing offline cpus here.
--=20
1.7.12.rc2.18.g61b472e


