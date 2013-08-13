From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 12/16] drivers/cpufreq/pxa3xx-cpufreq.c: Avoid using ARRAY_AND_SIZE(e) as a function argument
Date: Tue, 13 Aug 2013 15:22:09 +0200
Message-ID: <2461013.EC2pHmIZ5g@vostro.rjw.lan>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr> <1376239917-15594-13-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1376239917-15594-13-git-send-email-Julia.Lawall@lip6.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, August 11, 2013 06:51:53 PM Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
> arity of the called function.
> 
> The semantic match that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e,f;
> @@
> 
> f(...,
> - ARRAY_AND_SIZE(e)
> + e,ARRAY_SIZE(e)
>   ,...)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Queued up for 3.12.

Thanks,
Rafael


> ---
> Not compiled.
> 
>  drivers/cpufreq/pxa3xx-cpufreq.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
> index 9c92ef0..d26306f 100644
> --- a/drivers/cpufreq/pxa3xx-cpufreq.c
> +++ b/drivers/cpufreq/pxa3xx-cpufreq.c
> @@ -213,10 +213,12 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cur = policy->min = policy->max;
>  
>  	if (cpu_is_pxa300() || cpu_is_pxa310())
> -		ret = setup_freqs_table(policy, ARRAY_AND_SIZE(pxa300_freqs));
> +		ret = setup_freqs_table(policy, pxa300_freqs,
> +					ARRAY_SIZE(pxa300_freqs));
>  
>  	if (cpu_is_pxa320())
> -		ret = setup_freqs_table(policy, ARRAY_AND_SIZE(pxa320_freqs));
> +		ret = setup_freqs_table(policy, pxa320_freqs,
> +					ARRAY_SIZE(pxa320_freqs));
>  
>  	if (ret) {
>  		pr_err("failed to setup frequency table\n");
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
