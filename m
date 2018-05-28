From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 01/11] PM / devfreq: Init user limits from OPP limits,
 not viceversa
Date: Mon, 28 May 2018 14:26:49 +0900
Message-ID: <5B0B9319.9060709@samsung.com>
References: <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203410epcas1p2fd2a35468b9c37f2c542e499d3ed5a03@epcas1p2.samsung.com>
        <20180525203043.249193-2-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180525203043.249193-2-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding
> the devfreq device") introduced the initialization of the user
> limits min/max_freq from the lowest/highest available OPPs. Later
> commit f1d981eaecf8 ("PM / devfreq: Use the available min/max
> frequency") added scaling_min/max_freq, which actually represent
> the frequencies of the lowest/highest available OPP. scaling_min/
> max_freq are initialized with the values from min/max_freq, which
> is totally correct in the context, but a bit awkward to read.
> 
> Swap the initialization and assign scaling_min/max_freq with the
> OPP freqs and then the user limts min/max_freq with scaling_min/
> max_freq.
> 
> Needless to say that this change is a NOP, intended to improve
> readability.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..0057ef5b0a98 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -604,21 +604,21 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		mutex_lock(&devfreq->lock);
>  	}
>  
> -	devfreq->min_freq = find_available_min_freq(devfreq);
> -	if (!devfreq->min_freq) {
> +	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> +	if (!devfreq->scaling_min_freq) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->scaling_min_freq = devfreq->min_freq;
> +	devfreq->min_freq = devfreq->scaling_min_freq;
>  
> -	devfreq->max_freq = find_available_max_freq(devfreq);
> -	if (!devfreq->max_freq) {
> +	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> +	if (!devfreq->scaling_max_freq) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->scaling_max_freq = devfreq->max_freq;
> +	devfreq->max_freq = devfreq->scaling_max_freq;
>  
>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
> 

I already replied with my Reviewed-by tag. You are missing my tag.

Again, 
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
