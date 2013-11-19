From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: exynos: Fix compilation warnings
Date: Tue, 19 Nov 2013 10:29:12 +0530
Message-ID: <CAKohpok34dKXAU2K-o4UpmWDq6Y8xcCuN2Cjk_AbbG5mL8Jf9w@mail.gmail.com>
References: <1384835019-3251-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1384835019-3251-1-git-send-email-sachin.kamat@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 19 November 2013 09:53, Sachin Kamat <sachin.kamat@linaro.org> wrote=
:
> Commit a403797bbd81 ("cpufreq: exynos: Convert exynos-cpufreq
> to platform driver") forgot to change the function prototype.

I can't find this commit anywhere..

And I can see that you had already given comments for the patch and
so this should be fixed right there..

> Change it now to fix the following compilation warnings:
>
> drivers/cpufreq/exynos-cpufreq.c:292:18: warning: incorrect type in i=
nitializer
> (different argument counts)
> drivers/cpufreq/exynos-cpufreq.c:292:18:    expected int ( *probe )( =
=2E.. )
> drivers/cpufreq/exynos-cpufreq.c:292:18:    got int ( static [topleve=
l]
> *<noident> )( ... )
>   CC      drivers/cpufreq/exynos-cpufreq.o
> drivers/cpufreq/exynos-cpufreq.c:292:2: warning: initialization from
> incompatible pointer type [enabled by default]
>   .probe =3D exynos_cpufreq_init,
>   ^
> drivers/cpufreq/exynos-cpufreq.c:292:2: warning: (near initialization=
 for
> =91exynos_cpufreq_platdrv.probe=92) [enabled by default]
>   LD      drivers/cpufreq/built-in.o
>
> WARNING: drivers/cpufreq/built-in.o(.data+0x644): Section mismatch in=
 reference
> from the variable exynos_cpufreq_platdrv to the function
> .init.text:exynos_cpufreq_init()
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
