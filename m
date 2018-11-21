From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: Fix locking in cooling device sysfs update
 cur_state
Date: Wed, 21 Nov 2018 22:35:42 +0100
Message-ID: <36669c01-4066-07ef-1fd5-74b1184408c3@linaro.org>
References: <1542826891-28642-1-git-send-email-thara.gopinath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542826891-28642-1-git-send-email-thara.gopinath@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 21/11/2018 20:01, Thara Gopinath wrote:
> Sysfs interface to update cooling device cur_state does not
> currently hold cooling device lock, leading to stale values
> in cur_state especially if getting updated simultanelously
> from user space and thermal framework. Adding the proper locking
> code fixes this issue.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/thermal_sysfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 2241cea..1f0c1e2 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -712,10 +712,14 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
>  	if ((long)state < 0)
>  		return -EINVAL;
>  
> +	mutex_lock(&cdev->lock);
>  	result = cdev->ops->set_cur_state(cdev, state);
> -	if (result)
> +	if (result) {
> +		mutex_unlock(&cdev->lock);
>  		return result;
> +	}
>  	thermal_cooling_device_stats_update(cdev, state);
> +	mutex_unlock(&cdev->lock);

I suggest to invert the condition:

	mutex_lock(&cdev->lock);
	result = cdev->ops->set_cur_state(cdev, state);
	if (!result)
		thermal_cooling_device_stats_update(cdev, state);
	mutex_unlock(&cdev->lock);

	return result ? result : count;


The same problem is there for the cur_state_show() callback.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
