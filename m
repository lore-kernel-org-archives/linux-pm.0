From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 05/11] PM / devfreq: governors: Return device frequency
 limits instead of user limits
Date: Mon, 28 May 2018 15:56:40 +0900
Message-ID: <5B0BA828.4070903@samsung.com>
References: <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203310epcas4p34b5ad54243a2e93c7e5bff019ac9e627@epcas4p3.samsung.com>
        <20180525203043.249193-6-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180525203043.249193-6-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
> The performance, powersave and simpleondemand governors can return
> df->min/max_freq, which are the user defined frequency limits.
> update_devfreq() already takes care of adjusting the target frequency
> with the user limits if necessary, therefore we can return
> df->scaling_min/max_freq instead, which is the min/max frequency
> supported by the device at a given time (depending on the
> enabled/disabled OPPs)

As you mentioned on the description, update_devfreq() adjusts
the final target frequency. So, actually, there are no any
benefits when changing from max_freq/min_freq to scaling_max/min_freq.

I think that it is not necessary.

> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/governor_performance.c    | 2 +-
>  drivers/devfreq/governor_powersave.c      | 2 +-
>  drivers/devfreq/governor_simpleondemand.c | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
> index 1c990cb45098..a8e3478b3c43 100644
> --- a/drivers/devfreq/governor_performance.c
> +++ b/drivers/devfreq/governor_performance.c
> @@ -20,7 +20,7 @@ static int devfreq_performance_func(struct devfreq *df,
>  	 * target callback should be able to get floor value as
>  	 * said in devfreq.h
>  	 */
> -	*freq = df->max_freq;
> +	*freq = df->scaling_max_freq;
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
> index 0c42f23249ef..8696efd32e5a 100644
> --- a/drivers/devfreq/governor_powersave.c
> +++ b/drivers/devfreq/governor_powersave.c
> @@ -20,7 +20,7 @@ static int devfreq_powersave_func(struct devfreq *df,
>  	 * target callback should be able to get ceiling value as
>  	 * said in devfreq.h
>  	 */
> -	*freq = df->min_freq;
> +	*freq = df->scaling_min_freq;
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 3da7554b4837..805fee09c754 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -46,7 +46,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  
>  	/* Assume MAX if it is going to be divided by zero */
>  	if (stat->total_time == 0) {
> -		*freq = df->max_freq;
> +		*freq = df->scaling_max_freq;
>  		return 0;
>  	}
>  
> @@ -59,13 +59,13 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	/* Set MAX if it's busy enough */
>  	if (stat->busy_time * 100 >
>  	    stat->total_time * dfso_upthreshold) {
> -		*freq = df->max_freq;
> +		*freq = df->scaling_max_freq;
>  		return 0;
>  	}
>  
>  	/* Set MAX if we do not know the initial frequency */
>  	if (stat->current_frequency == 0) {
> -		*freq = df->max_freq;
> +		*freq = df->scaling_max_freq;
>  		return 0;
>  	}
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
