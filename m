From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 04/11] PM / devfreq: Remove redundant frequency
 adjustment from governors
Date: Mon, 28 May 2018 14:36:06 +0900
Message-ID: <5B0B9546.7070101@samsung.com>
References: <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203333epcas1p230489fbae43296516f3febb327dcdeca@epcas1p2.samsung.com>
        <20180525203043.249193-5-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180525203043.249193-5-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
> The userspace and simpleondemand governor determine a target frequency and
> then adjust it according to the df->min/max_freq limits that might have
> been set by user space. This adjustment is redundant, it is done in
> update_devfreq() for any governor, right after returning from
> governor->get_target_freq().
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/governor_simpleondemand.c |  5 -----
>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>  2 files changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 278964783fa6..3da7554b4837 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -84,11 +84,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
>  	*freq = (unsigned long) b;
>  
> -	if (df->min_freq && *freq < df->min_freq)
> -		*freq = df->min_freq;
> -	if (df->max_freq && *freq > df->max_freq)
> -		*freq = df->max_freq;
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 080607c3f34d..378d84c011df 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -26,19 +26,11 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>  {
>  	struct userspace_data *data = df->data;
>  
> -	if (data->valid) {
> -		unsigned long adjusted_freq = data->user_frequency;
> -
> -		if (df->max_freq && adjusted_freq > df->max_freq)
> -			adjusted_freq = df->max_freq;
> -
> -		if (df->min_freq && adjusted_freq < df->min_freq)
> -			adjusted_freq = df->min_freq;
> -
> -		*freq = adjusted_freq;
> -	} else {
> +	if (data->valid)
> +		*freq = data->user_frequency;
> +	else
>  		*freq = df->previous_freq; /* No user freq specified yet */
> -	}
> +
>  	return 0;
>  }
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
