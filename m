From: y@samsung.com
Subject: [PATCH] cpufreq: exynos: Fix build error of no type of module_init
Date: Wed, 22 Jan 2014 15:18:29 +0100
Message-ID: <1390400309-22806-1-git-send-email-y@samsung.com>
References: <y@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:11843 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553AbaAVOSl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 09:18:41 -0500
In-reply-to: <y@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

=46rom: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Add missing include to fix build error:
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition has no=
 type or storage class [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to =E2=80=98=
int=E2=80=99 in declaration of =E2=80=98module_init=E2=80=99 [-Werror=3D=
implicit-int]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (witho=
ut types) in function declaration [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition has no=
 type or storage class [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to =E2=80=98=
int=E2=80=99 in declaration of =E2=80=98module_exit=E2=80=99 [-Werror=3D=
implicit-int]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (witho=
ut types) in function declaration [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: =E2=80=98exynos_cpufre=
q_platdrv_init=E2=80=99 defined but not used [-Wunused-function]
cc1: some warnings being treated as errors
make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
make[1]: *** [drivers/cpufreq] Error 2

Build error happens on gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
and was introduced by commit d568b6f71df1 (cpufreq: exynos: Convert
exynos-cpufreq to platform driver).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/cpufreq/exynos-cpufreq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-=
cpufreq.c
index fcd2914d081a..fa54c2b88dd7 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/cpufreq.h>
 #include <linux/suspend.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
=20
 #include <plat/cpu.h>
--=20
1.7.9.5

