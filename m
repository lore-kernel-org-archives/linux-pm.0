From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] drivers/cpufreq: include <module.h> for modular exynos-cpufreq.c code
Date: Tue, 16 Jun 2015 01:47:13 +0200
Message-ID: <5110473.q5rJrrjs9a@vostro.rjw.lan>
References: <1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com> <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64851 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751193AbbFOXVR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 19:21:17 -0400
In-Reply-To: <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

On Wednesday, June 03, 2015 05:18:18 PM Paul Gortmaker wrote:
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

I'm assuming that this will go in via the Samsung tree.


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
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
