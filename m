From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Extend Samsung SoC entry with S3C/S5P
 drivers
Date: Wed, 22 Jun 2016 21:16:04 +0530
Message-ID: <20160622154604.GH5458@vireshk-i7>
References: <1466597805-31988-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466597805-31988-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 22-06-16, 14:16, Krzysztof Kozlowski wrote:
> Some of the drivers for S3C and S5P families of Samsung SoCs go in
> through Samsung SoC tree.  Extend the entry so proper maintainers would
> be displayed in such cases, most notably the cpufreq drivers.  This does
> not change the work-flow for other drivers which have sub-maintainers
> (like Samsung clocks).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 092ce3990541..1e5cf07030ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1619,8 +1619,10 @@ F:	arch/arm/mach-s3c24*/
>  F:	arch/arm/mach-s3c64xx/
>  F:	arch/arm/mach-s5p*/
>  F:	arch/arm/mach-exynos*/
> -F:	drivers/*/*s3c2410*
> -F:	drivers/*/*/*s3c2410*
> +F:	drivers/*/*s3c24*
> +F:	drivers/*/*/*s3c24*
> +F:	drivers/*/*s3c64xx*
> +F:	drivers/*/*s5pv210*
>  F:	drivers/memory/samsung/*
>  F:	drivers/soc/samsung/*
>  F:	drivers/spi/spi-s3c*

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
