From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Fix handling of min/max_freq == 0
Date: Fri, 18 May 2018 08:27:55 +0900
Message-ID: <5AFE0FFB.6050408@samsung.com>
References: <CGME20180517223318epcas3p2c4bf4ef6d2c1c4b097df92c309adafa6@epcas3p2.samsung.com>
        <20180517223255.211918-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180517223255.211918-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Please resend the patch with related other patches.
It is hard to check the dependency/sequence of your patches.

On 2018년 05월 18일 07:32, Matthias Kaehlcke wrote:
> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
> devfreq device") initializes df->min/max_freq with the min/max OPP when
> the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
> available min/max frequency") adds df->scaling_min/max_freq and the
> following to the frequency adjustment code:
> 
>   max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
> 
> With the current handling of min/max_freq this is incorrect:
> 
> Even though df->max_freq is now initialized to a value != 0 user space
> can still set it to 0, in this case max_freq would be 0 instead of
> df->scaling_max_freq as intended. In consequence the frequency adjustment
> is not performed:
> 
>   if (max_freq && freq > max_freq) {
> 	freq = max_freq;
> 
> To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
> when the user passes a value of 0. This also prevents df->max_freq from
> being set below the min OPP when df->min_freq is 0, and similar for
> min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
> checks for this case can be removed.
> 
> Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..e007534297f7 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -283,11 +283,11 @@ int update_devfreq(struct devfreq *devfreq)
>  	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
>  	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
>  
> -	if (min_freq && freq < min_freq) {
> +	if (freq < min_freq) {
>  		freq = min_freq;
>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>  	}
> -	if (max_freq && freq > max_freq) {
> +	if (freq > max_freq) {
>  		freq = max_freq;
>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>  	}
> @@ -1123,17 +1123,20 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  	struct devfreq *df = to_devfreq(dev);
>  	unsigned long value;
>  	int ret;
> -	unsigned long max;
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&df->lock);
> -	max = df->max_freq;
> -	if (value && max && value > max) {
> -		ret = -EINVAL;
> -		goto unlock;
> +
> +	if (value) {
> +		if (value > df->max_freq) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +	} else {
> +		value = df->profile->freq_table[df->profile->max_state - 1];
>  	}
>  
>  	df->min_freq = value;
> @@ -1158,17 +1161,20 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  	struct devfreq *df = to_devfreq(dev);
>  	unsigned long value;
>  	int ret;
> -	unsigned long min;
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&df->lock);
> -	min = df->min_freq;
> -	if (value && min && value < min) {
> -		ret = -EINVAL;
> -		goto unlock;
> +
> +	if (!value) {
> +		value = df->profile->freq_table[0];
> +	} else {
> +		if (value < df->min_freq) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
>  	}
>  
>  	df->max_freq = value;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
