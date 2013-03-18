From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix unsigned variable being checked for
 negative value
Date: Mon, 18 Mar 2013 16:28:42 +0800
Message-ID: <20130318082841.GA12462@S2101-09.ap.freescale.net>
References: <000001ce23af$f51b0240$df5106c0$%choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000001ce23af$f51b0240$df5106c0$%choi@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Jonghwan Choi <jhbird.choi@samsung.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Viresh Kumar' <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 18, 2013 at 05:09:42PM +0900, Jonghwan Choi wrote:
> clk_round_rate() returns singed value which was assigned to an unsigned
> variable.
> So it can't be checked for negative.
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/cpufreq/cpufreq-cpu0.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 4e5b7fb..6bb88af 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -44,7 +44,8 @@ static int cpu0_set_target(struct cpufreq_policy *policy,
>  {
>  	struct cpufreq_freqs freqs;
>  	struct opp *opp;
> -	unsigned long freq_Hz, volt = 0, volt_old = 0, tol = 0;
> +	unsigned long volt = 0, volt_old = 0, tol = 0;
> +	long freq_Hz;
>  	unsigned int index, cpu;
>  	int ret;
>  
> -- 
> 1.7.4.1
> 

