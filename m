From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Drop custom MIN/MAX macros
Date: Tue, 08 May 2018 13:49:51 +0900
Message-ID: <5AF12C6F.4040903@samsung.com>
References: <CGME20180424194654epcas2p23f29bc7de4118f84c7888a7966b90b88@epcas2p2.samsung.com>
        <20180424194639.22804-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180424194639.22804-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 04월 25일 04:46, Bjorn Andersson wrote:
> Drop the custom MIN/MAX macros in favour of the standard min/max from
> kernel.h
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/devfreq/devfreq.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..2067cd229ce3 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -28,9 +28,6 @@
>  #include <linux/of.h>
>  #include "governor.h"
>  
> -#define MAX(a,b)	((a > b) ? a : b)
> -#define MIN(a,b)	((a < b) ? a : b)
> -
>  static struct class *devfreq_class;
>  
>  /*
> @@ -280,8 +277,8 @@ int update_devfreq(struct devfreq *devfreq)
>  	 * max_freq
>  	 * min_freq
>  	 */
> -	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
> -	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
> +	max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
> +	min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
>  
>  	if (min_freq && freq < min_freq) {
>  		freq = min_freq;
> @@ -1149,7 +1146,7 @@ static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct devfreq *df = to_devfreq(dev);
>  
> -	return sprintf(buf, "%lu\n", MAX(df->scaling_min_freq, df->min_freq));
> +	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
>  }
>  
>  static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
> @@ -1185,7 +1182,7 @@ static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct devfreq *df = to_devfreq(dev);
>  
> -	return sprintf(buf, "%lu\n", MIN(df->scaling_max_freq, df->max_freq));
> +	return sprintf(buf, "%lu\n", min(df->scaling_max_freq, df->max_freq));
>  }
>  static DEVICE_ATTR_RW(max_freq);
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
