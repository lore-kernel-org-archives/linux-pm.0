From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: speedstep: convert BUG() to BUG_ON()
Date: Mon, 18 Feb 2019 10:29:45 +0530
Message-ID: <20190218045945.rsaj4vfarael4tbm@vireshk-i7>
References: <20190216161501.12168-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190216161501.12168-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16-02-19, 11:15, Yangtao Li wrote:
> To fix coccinelle WARNING.
> 
> WARNING: Use BUG_ON instead of if condition followed by BUG.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/speedstep-ich.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
> index fbbcb88db061..5d8a09b82efb 100644
> --- a/drivers/cpufreq/speedstep-ich.c
> +++ b/drivers/cpufreq/speedstep-ich.c
> @@ -243,8 +243,7 @@ static unsigned int speedstep_get(unsigned int cpu)
>  	unsigned int speed;
>  
>  	/* You're supposed to ensure CPU is online. */
> -	if (smp_call_function_single(cpu, get_freq_data, &speed, 1) != 0)
> -		BUG();
> +	BUG_ON(smp_call_function_single(cpu, get_freq_data, &speed, 1));
>  
>  	pr_debug("detected %u kHz as current frequency\n", speed);
>  	return speed;

Applied. Thanks.

-- 
viresh
