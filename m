From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: stopping the governor before
 device_unregister()
Date: Fri, 31 Aug 2018 17:52:39 +0900
Message-ID: <5B8901D7.5040301@samsung.com>
References: <CGME20180830100409epcas3p266dc05fdd02cd2c086a4355e9a481007@epcas3p2.samsung.com>
        <1535623320-28281-1-git-send-email-vincent.donnefort@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1535623320-28281-1-git-send-email-vincent.donnefort@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vincent.donnefort@arm.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.reitan@arm.com, beata.michalska@arm.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 08월 30일 19:02, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> device_release() is freeing the resources before calling the device
> specific release callback which is, in the case of devfreq, stopping
> the governor.
> 
> It is a problem as some governors are using the device resources. e.g.
> simpleondemand which is using the devfreq deferrable monitoring work. If it
> is not stopped before the resources are freed, it might lead to a use after
> free.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Reviewed-by: John Einar Reitan <john.reitan@arm.com>
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4c49bb1..4e43830 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -534,10 +534,6 @@ static void devfreq_dev_release(struct device *dev)
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
> -	if (devfreq->governor)
> -		devfreq->governor->event_handler(devfreq,
> -						 DEVFREQ_GOV_STOP, NULL);
> -
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> @@ -672,7 +668,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
> -	device_unregister(&devfreq->dev);
> +	devfreq_remove_device(devfreq);
>  	devfreq = NULL;
>  err_dev:
>  	if (devfreq)
> @@ -693,6 +689,9 @@ int devfreq_remove_device(struct devfreq *devfreq)
>  	if (!devfreq)
>  		return -EINVAL;
>  
> +	if (devfreq->governor)
> +		devfreq->governor->event_handler(devfreq,
> +						 DEVFREQ_GOV_STOP, NULL);
>  	device_unregister(&devfreq->dev);
>  
>  	return 0;
> 

As description of this patch, if devfreq_wq is executed and then execute
the 'devfreq->governor->get_target_freq' between step1 and step2
after already freed the 'dev' related resource, it might happen the problem
because the registered callback of get_target_freq requires the 'dev' resource.

device_unregister(dev)
	step 1. device_del(dev)
		<- if devfreq_wq is executed
	step 2. put_device(dev)
		device_release()
			devfreq_dev_release()
				stop the governor for specific devfreq instance

It looks good to me. Stop the governor before calling device_unregister().
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>				

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
