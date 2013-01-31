From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: SPEAr: Notify all policy->cpus of frequency change
Date: Thu, 31 Jan 2013 10:23:56 +0530
Message-ID: <ddc1bb4ed278819ffc7fac229134c01e17f03477.1359607980.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

SPEAr cpufreq driver supports dual core Cortex-A9 SoC's, where cpus share p=
olicy
structure. Whenever we update frequency of a cpu, we must notify all
policy->cpus.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufre=
q.c
index 4575cfe..63c6a7f 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -157,7 +157,9 @@ static int spear_cpufreq_target(struct cpufreq_policy *=
policy,
=20
 =09freqs.new =3D newfreq / 1000;
 =09freqs.new /=3D mult;
-=09cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+=09for_each_cpu(freqs.cpu, policy->cpus)
+=09=09cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
=20
 =09if (mult =3D=3D 2)
 =09=09ret =3D spear1340_set_cpu_rate(srcclk, newfreq);
@@ -170,7 +172,8 @@ static int spear_cpufreq_target(struct cpufreq_policy *=
policy,
 =09=09freqs.new =3D clk_get_rate(spear_cpufreq.clk) / 1000;
 =09}
=20
-=09cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+=09for_each_cpu(freqs.cpu, policy->cpus)
+=09=09cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 =09return ret;
 }
=20
--=20
1.7.12.rc2.18.g61b472e


