From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v3 4/4] cpufreq: exynos: remove Exynos5250 specific
 cpufreq driver support
Date: Thu, 2 Jul 2015 13:30:39 +0200
Message-ID: <CABxcv=ky0ZeLWo0mqgGMOqjXwVySPUMnkx7orpyqGwEPLU9PNA@mail.gmail.com>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
	<1435756238-845-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1435756238-845-5-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Bartlomiej,

On Wed, Jul 1, 2015 at 3:10 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Exynos5250 based platforms have switched over to use generic
> cpufreq driver for cpufreq functionality. So the Exynos
> specific cpufreq support for these platforms can be removed.
>
> Based on the earlier work by Thomas Abraham.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |  11 --
>  drivers/cpufreq/Makefile             |   1 -
>  drivers/cpufreq/exynos-cpufreq.c     |   3 -
>  drivers/cpufreq/exynos-cpufreq.h     |  17 ---
>  drivers/cpufreq/exynos5250-cpufreq.c | 210 -----------------------------------
>  5 files changed, 242 deletions(-)
>  delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c
>

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

I also tested and on an Exynos5250 Snow Chromebook with
exynos_defconfig + CONFIG_CPUFREQ_DT + CONFIG_CPU_FREQ_GOV_*, using
different governors and see that the cpu0 and cpu1 frequencies are
scaled and that the total number of CPU frequency transitions in
total_trans are incremented.

Tested-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
