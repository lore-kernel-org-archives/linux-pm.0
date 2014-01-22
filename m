From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RESEND] cpufreq: exynos: Fix build error of no type of module_init
Date: Wed, 22 Jan 2014 20:12:52 +0530
Message-ID: <CAKohpo=2wR+Sqwxj4koH0rvuk29BkNyAZgN0RR7bVH+3uqpB1Q@mail.gmail.com>
References: <1390400476-22951-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390400476-22951-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 22 January 2014 19:51, Krzysztof Kozlowski <k.kozlowski@samsung.com>=
 wrote:
> Add missing include to fix build error:
> drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition has =
no type or storage class [enabled by default]
> drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to =91in=
t=92 in declaration of =91module_init=92 [-Werror=3Dimplicit-int]
> drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (wit=
hout types) in function declaration [enabled by default]
> drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition has =
no type or storage class [enabled by default]
> drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to =91in=
t=92 in declaration of =91module_exit=92 [-Werror=3Dimplicit-int]
> drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (wit=
hout types) in function declaration [enabled by default]
> drivers/cpufreq/exynos-cpufreq.c:292:1: warning: =91exynos_cpufreq_pl=
atdrv_init=92 defined but not used [-Wunused-function]
> cc1: some warnings being treated as errors
> make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
> make[1]: *** [drivers/cpufreq] Error 2
>
> Build error happens on gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu=
5)
> and was introduced by commit d568b6f71df1 (cpufreq: exynos: Convert
> exynos-cpufreq to platform driver).
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exyno=
s-cpufreq.c
> index fcd2914d081a..fa54c2b88dd7 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/cpufreq.h>
>  #include <linux/suspend.h>
> +#include <linux/module.h>
>  #include <linux/platform_device.h>

I am surprised how that patch went through then? And nothing was
reported by kbuild for it..
