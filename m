From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] drivers/cpufreq: include <module.h> for modular
 exynos-cpufreq.c code
Date: Thu, 4 Jun 2015 08:02:20 +0530
Message-ID: <20150604023220.GD6811@linux>
References: <1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com>
 <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03-06-15, 17:18, Paul Gortmaker wrote:
> This file is built off of a tristate Kconfig option ("ARM_EXYNOS_CPUFREQ")
> and also contains modular function calls so it should explicitly include
> module.h to avoid compile breakage during pending header shuffles.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> 
> [ patch will be appended to the implicit include fixup series, see:
>   https://lkml.kernel.org/r/1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com
>   for the original series posting.]
> 
>  drivers/cpufreq/exynos-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 82d2fbb20f7e..4c157302365f 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -10,6 +10,7 @@
>  */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
