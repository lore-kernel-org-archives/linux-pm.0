From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] cpufreq: TEGRA: Set policy->cpus from driver->init()
Date: Fri,  1 Feb 2013 12:10:00 +0530
Message-ID: <1bf82454ab1f16b13212548d7c9605067c8b7a0d.1359700705.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:44293 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab3BAGkJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Feb 2013 01:40:09 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@nvidia.com>

For multicore SoC's, with cores sharing clock line, we are required to set
policy->cpus and policy->related_cpus with mask of cpus.

With following patch, we need to set policy->cpus with mask of all possible=
 cpus
and policy->related_cpus would be filled automatically by the cpufreq core.

commit 4948b355e90080cd5ec1e91189f65a01e4186ef2
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue Jan 29 14:39:08 2013 +0000

    cpufreq: Simplify cpufreq_add_dev()

Current Tegra driver fills only ->related_cpus and not ->cpus, which looks =
to be
incorrect. Lets fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/cpu-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegr=
a.c
index a74d3c7..e7ddcb2 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -244,7 +244,7 @@ static int tegra_cpu_init(struct cpufreq_policy *policy=
)
 =09policy->cpuinfo.transition_latency =3D 300 * 1000;
=20
 =09policy->shared_type =3D CPUFREQ_SHARED_TYPE_ALL;
-=09cpumask_copy(policy->related_cpus, cpu_possible_mask);
+=09cpumask_copy(policy->cpus, cpu_possible_mask);
=20
 =09if (policy->cpu =3D=3D 0)
 =09=09register_pm_notifier(&tegra_cpu_pm_notifier);
--=20
1.7.12.rc2.18.g61b472e


