From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 03/11] PM / devfreq: Remove check for df->max_freq == 0
 from governors
Date: Mon, 28 May 2018 14:27:54 +0900
Message-ID: <5B0B935A.8010306@samsung.com>
References: <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203351epcas2p1f22bcccf992edbc9ed76ba0bd42af752@epcas2p1.samsung.com>
        <20180525203043.249193-4-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180525203043.249193-4-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
> Commit "PM / devfreq: Fix handling of min/max_freq == 0" ensures that
> df->max_freq is not 0, remove unnecessary checks.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/governor_performance.c    | 5 +----
>  drivers/devfreq/governor_simpleondemand.c | 7 +++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
> index 4d23ecfbd948..1c990cb45098 100644
> --- a/drivers/devfreq/governor_performance.c
> +++ b/drivers/devfreq/governor_performance.c
> @@ -20,10 +20,7 @@ static int devfreq_performance_func(struct devfreq *df,
>  	 * target callback should be able to get floor value as
>  	 * said in devfreq.h
>  	 */
> -	if (!df->max_freq)
> -		*freq = UINT_MAX;
> -	else
> -		*freq = df->max_freq;
> +	*freq = df->max_freq;
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 28e0f2de7100..278964783fa6 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -27,7 +27,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
>  	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
>  	struct devfreq_simple_ondemand_data *data = df->data;
> -	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
>  
>  	err = devfreq_update_stats(df);
>  	if (err)
> @@ -47,7 +46,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  
>  	/* Assume MAX if it is going to be divided by zero */
>  	if (stat->total_time == 0) {
> -		*freq = max;
> +		*freq = df->max_freq;
>  		return 0;
>  	}
>  
> @@ -60,13 +59,13 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	/* Set MAX if it's busy enough */
>  	if (stat->busy_time * 100 >
>  	    stat->total_time * dfso_upthreshold) {
> -		*freq = max;
> +		*freq = df->max_freq;
>  		return 0;
>  	}
>  
>  	/* Set MAX if we do not know the initial frequency */
>  	if (stat->current_frequency == 0) {
> -		*freq = max;
> +		*freq = df->max_freq;
>  		return 0;
>  	}
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
