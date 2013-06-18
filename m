From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v2 31/38] cpufreq: exynos4x12: Remove check for
 SOC_EXYNOS4412
Date: Tue, 18 Jun 2013 18:18:07 +0900
Message-ID: <1b9a01ce6c04$bef04750$3cd0d5f0$%kim@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
 <1371486863-12398-32-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1371486863-12398-32-git-send-email-t.figa@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Tomasz Figa' <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, 'Arnd Bergmann' <arnd@arndb.de>, 'Olof Johansson' <olof@lixom.net>, 'Marek Szyprowski' <m.szyprowski@samsung.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-pm@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Tomasz Figa wrote:
> 
> Since SOC_EXYNOS4412 Kconfig symbol has been removed, it is enough to
> check for SOC_EXYNOS4212 for both SoCs from Exynos4x12 series.
> 
> Cc: linux-pm@vger.kernel.org
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index a924408..b214ad6 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -32,7 +32,7 @@ config ARM_EXYNOS4210_CPUFREQ
>  	  SoC (S5PV310 or S5PC210).
> 
>  config ARM_EXYNOS4X12_CPUFREQ
> -	def_bool (SOC_EXYNOS4212 || SOC_EXYNOS4412)
> +	def_bool SOC_EXYNOS4212
>  	help
>  	  This adds the CPUFreq driver for Samsung EXYNOS4X12
>  	  SoC (EXYNOS4212 or EXYNOS4412).
> --
> 1.8.2.1

NAK, the reason is same with my comments on 30th patch.

- Kukjin
