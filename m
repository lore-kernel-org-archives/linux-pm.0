From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: use put_device() instead of kfree()
Date: Fri, 13 Apr 2018 10:03:01 +0900
Message-ID: <5AD001C5.2040406@samsung.com>
References: <CGME20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be@epcas5p1.samsung.com>
        <d8d8708d2283349c2c4f3e9f3c9fd5f47126d2bc.1522410143.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <d8d8708d2283349c2c4f3e9f3c9fd5f47126d2bc.1522410143.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

I'm sorry for the late reply.

On 2018년 03월 30일 20:44, Arvind Yadav wrote:
> Never directly free @dev after calling device_register() or
> device_unregister(), even if device_register() returned an error.
> Always use put_device() to give up the reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6a..a225b94 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -625,7 +625,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	err = device_register(&devfreq->dev);
>  	if (err) {
>  		mutex_unlock(&devfreq->lock);
> -		goto err_dev;
> +		put_device(&devfreq->dev);
> +		goto err_out;

why do you change the goto postion?
err_out is correct to free the memory of devfreq instance.

>  	}
>  
>  	devfreq->trans_table =	devm_kzalloc(&devfreq->dev,
> @@ -671,6 +672,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	mutex_unlock(&devfreq_list_lock);
>  
>  	device_unregister(&devfreq->dev);
> +	devfreq = NULL;

It is wrong. If you initialize the devfreq as NULL,
never free the 'devfreq' instance.

>  err_dev:
>  	if (devfreq)
>  		kfree(devfreq);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
