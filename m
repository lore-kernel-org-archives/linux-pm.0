From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] cpufreq: exynos: Fix compilation warnings
Date: Tue, 19 Nov 2013 09:53:39 +0530
Message-ID: <1384835019-3251-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cpufreq@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, sachin.kamat@linaro.org, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Commit a403797bbd81 ("cpufreq: exynos: Convert exynos-cpufreq
to platform driver") forgot to change the function prototype.
Change it now to fix the following compilation warnings:

drivers/cpufreq/exynos-cpufreq.c:292:18: warning: incorrect type in ini=
tializer
(different argument counts)
drivers/cpufreq/exynos-cpufreq.c:292:18:    expected int ( *probe )( ..=
=2E )
drivers/cpufreq/exynos-cpufreq.c:292:18:    got int ( static [toplevel]
*<noident> )( ... )
  CC      drivers/cpufreq/exynos-cpufreq.o
drivers/cpufreq/exynos-cpufreq.c:292:2: warning: initialization from
incompatible pointer type [enabled by default]
  .probe =3D exynos_cpufreq_init,
  ^
drivers/cpufreq/exynos-cpufreq.c:292:2: warning: (near initialization f=
or
=E2=80=98exynos_cpufreq_platdrv.probe=E2=80=99) [enabled by default]
  LD      drivers/cpufreq/built-in.o

WARNING: drivers/cpufreq/built-in.o(.data+0x644): Section mismatch in r=
eference
from the variable exynos_cpufreq_platdrv to the function
=2Einit.text:exynos_cpufreq_init()

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/cpufreq/exynos-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-=
cpufreq.c
index a2f57d4101fc..e238c46efaac 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -233,7 +233,7 @@ static struct cpufreq_driver exynos_driver =3D {
 #endif
 };
=20
-static int __init exynos_cpufreq_init(void)
+static int exynos_cpufreq_init(struct platform_device *pdev)
 {
 	int ret =3D -EINVAL;
=20
--=20
1.7.9.5

