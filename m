From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq:exynos-cpufreq - Fix for memory leak in case SOC
 name does not match.
Date: Fri, 22 May 2015 07:47:30 +0530
Message-ID: <20150522021730.GA7730@linux>
References: <1432232981-3917-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432232981-3917-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 21-05-15, 23:59, Shailendra Verma wrote:
> During probe free the memory allocated to "exynos_info" in case of unknown
> SOC type.
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 82d2fbb..b77923a 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -182,6 +182,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
>  		ret = exynos5250_cpufreq_init(exynos_info);
>  	} else {
>  		pr_err("%s: Unknown SoC type\n", __func__);
> +		kfree(exynos_info);
>  		return -ENODEV;
>  	}

There is no point replicating this stuff. Use labels like: err_vdd_arm
to get this done. But you also need to make sure the right error gets
propagated.

-- 
viresh
