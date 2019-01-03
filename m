From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH V2] thermal: Fix locking in cooling device sysfs update
 cur_state
Date: Wed, 2 Jan 2019 21:29:10 -0500
Message-ID: <5C2D7376.3010408@linaro.org>
References: <1543358591-25189-1-git-send-email-thara.gopinath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543358591-25189-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/27/2018 05:43 PM, Thara Gopinath wrote:
> Sysfs interface to update cooling device cur_state does not
> currently holding cooling device lock sometimes leading to
> stale values in cur_state if getting updated simultanelously
> from user space and thermal framework. Adding the proper locking
> code fixes this issue.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> V1->V2: Rearranged the code as per Daniel's  review comment 

Hi Eduardo, Daniel

Any comments on this ?

Regards
Thara

> 
>  drivers/thermal/thermal_sysfs.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 2241cea..aa99edb 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -712,11 +712,14 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
>  	if ((long)state < 0)
>  		return -EINVAL;
>  
> +	mutex_lock(&cdev->lock);
> +
>  	result = cdev->ops->set_cur_state(cdev, state);
> -	if (result)
> -		return result;
> -	thermal_cooling_device_stats_update(cdev, state);
> -	return count;
> +	if (!result)
> +		thermal_cooling_device_stats_update(cdev, state);
> +
> +	mutex_unlock(&cdev->lock);
> +	return result ? result : count;
>  }
>  
>  static struct device_attribute
> 
