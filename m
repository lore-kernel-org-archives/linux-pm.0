From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: s3c2440: fix spelling mistake: "divsiors" ->
 "divisors"
Date: Wed, 2 May 2018 11:07:21 +0530
Message-ID: <20180502053721.5h6jhicjsjss2ixe@vireshk-i7>
References: <20180430144801.6727-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180430144801.6727-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 30-04-18, 15:48, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in s3c_freq_dbg debug message text.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/cpufreq/s3c2440-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
> index d0d75b65ddd6..d2f67b7a20dd 100644
> --- a/drivers/cpufreq/s3c2440-cpufreq.c
> +++ b/drivers/cpufreq/s3c2440-cpufreq.c
> @@ -143,7 +143,7 @@ static void s3c2440_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
>  {
>  	unsigned long clkdiv, camdiv;
>  
> -	s3c_freq_dbg("%s: divsiors: h=%d, p=%d\n", __func__,
> +	s3c_freq_dbg("%s: divisors: h=%d, p=%d\n", __func__,
>  		     cfg->divs.h_divisor, cfg->divs.p_divisor);
>  
>  	clkdiv = __raw_readl(S3C2410_CLKDIVN);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
