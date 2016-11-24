From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/6] PM / devfreq: Fix the checkpatch warnings
Date: Thu, 24 Nov 2016 02:20:38 -0800
Message-ID: <1479982838.19726.3.camel@perches.com>
References: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
         <1479963668-22845-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479963668-22845-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2016-11-24 at 14:01 +0900, Chanwoo Choi wrote:
> This patch just fixes the checkpatch warnings.

unrelated trivia:

> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
[]
> @@ -538,15 +538,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq = find_device_devfreq(dev);
>  	mutex_unlock(&devfreq_list_lock);
>  	if (!IS_ERR(devfreq)) {
> -		dev_err(dev, "%s: Unable to create devfreq for the device. It already has one.\n", __func__);
> +		dev_err(dev, "%s: Unable to create devfreq for the device.\n",
> +			__func__);
>  		err = -EINVAL;
>  		goto err_out;
>  	}

It seems to be simpler if find_device_devfreq just returned NULL
in the error cases as the only test is IS_ERR and not a
specific error return type.  Then these IS_ERR calls could be
a NULL pointer test instead.

> @@ -576,11 +575,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_out;
>  	}
>  
> -	devfreq->trans_table =	devm_kzalloc(&devfreq->dev, sizeof(unsigned int) *
> +	devfreq->trans_table =	devm_kzalloc(&devfreq->dev,
> +						sizeof(unsigned int) *
>  						devfreq->profile->max_state *
>  						devfreq->profile->max_state,
>  						GFP_KERNEL);
> -	devfreq->time_in_state = devm_kzalloc(&devfreq->dev, sizeof(unsigned long) *
> +	devfreq->time_in_state = devm_kzalloc(&devfreq->dev,
> +						sizeof(unsigned long) *
>  						devfreq->profile->max_state,
>  						GFP_KERNEL);

Maybe these should be devm_kcalloc calls

>  	devfreq->last_stat_updated = jiffies;
> @@ -990,7 +991,7 @@ static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
>  
>  	if (devfreq->profile->get_cur_freq &&
>  		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
> -			return sprintf(buf, "%lu\n", freq);
> +		return sprintf(buf, "%lu\n", freq);

Be nicer to align the second line in the if test here too

	if (devfreq->profile->get_cur_freq &&
	    !devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
		return sprintf(buf, "%lu\n", freq); 

>  	return sprintf(buf, "%lu\n", devfreq->previous_freq);
>  }
