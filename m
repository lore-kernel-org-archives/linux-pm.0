From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4x12
Date: Sat, 1 Aug 2015 16:47:21 +0530
Message-ID: <20150801111721.GI899@linux>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <1438368557-2352-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438368557-2352-4-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

On 31-07-15, 20:49, Bartlomiej Zolnierkiewicz wrote:
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 659879a..bf6d596 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -191,6 +191,7 @@ config CPUFREQ_DT
>  	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
>  	depends on !CPU_THERMAL || THERMAL
>  	select PM_OPP
> +	select EXYNOS_THERMAL if ARCH_EXYNOS
>  	help
>  	  This adds a generic DT based cpufreq driver for frequency management.
>  	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)

No, we shouldn't pollute generic Kconfig options with platform specific stuff.
Why don't you enable thermal in your .config?

-- 
viresh
