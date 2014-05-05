From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: unicore32: fix typo issue for 'clk'
Date: Mon,  5 May 2014 10:16:11 +0530
Message-ID: <2320eb8c83ddc1ddc01179797999191eb8707251.1399264941.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-pm@vger.kernel.org, gang.chen.5i5j@gmail.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Chen Gang <gang.chen.5i5j@gmail.com>

Upstream commit id: b4ddad9 cpufreq: unicore32: fix typo issue for 'clk=
'

Need use 'clk' instead of 'mclk', which is the original removed local
variable.

The related original commit:

  "652ed95 cpufreq: introduce cpufreq_generic_get() routine"

The related error with allmodconfig for unicore32:

    CC      drivers/cpufreq/unicore2-cpufreq.o
  drivers/cpufreq/unicore2-cpufreq.c: In function =E2=80=98ucv2_target=E2=
=80=99:
  drivers/cpufreq/unicore2-cpufreq.c:48: error: =E2=80=98struct cpufreq=
_policy=E2=80=99 has no member named =E2=80=98mclk=E2=80=99
  make[2]: *** [drivers/cpufreq/unicore2-cpufreq.o] Error 1
  make[1]: *** [drivers/cpufreq] Error 2
  make: *** [drivers] Error 2

=46ixes: 652ed95d5fa6 (cpufreq: introduce cpufreq_generic_get() routine=
)
Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 3.14+ <stable@vger.kernel.org> # 3.14+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/unicore2-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unico=
re2-cpufreq.c
index 36cc330..99d280d6 100644
--- a/drivers/cpufreq/unicore2-cpufreq.c
+++ b/drivers/cpufreq/unicore2-cpufreq.c
@@ -45,7 +45,7 @@ static int ucv2_target(struct cpufreq_policy *policy,
 	freqs.new =3D target_freq;
=20
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-	ret =3D clk_set_rate(policy->mclk, target_freq * 1000);
+	ret =3D clk_set_rate(policy->clk, target_freq * 1000);
 	cpufreq_notify_post_transition(policy, &freqs, ret);
=20
 	return ret;
--=20
2.0.0.rc2
