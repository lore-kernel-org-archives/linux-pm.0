From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/3] PM / devfreq: fix indentation in
 devfreq_add_device()
Date: Mon, 21 Jan 2019 10:58:44 +0900
Message-ID: <e45d38da-1dc4-c1ca-83d4-0efeb64acef1@samsung.com>
References: <CGME20190119183407epcas1p4958e4526d07c36605307c49b0c0e2e2c@epcas1p4.samsung.com>
        <20190119160454.23151-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190119160454.23151-1-tiny.windzz@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19. 1. 20. 오전 1:04, Yangtao Li wrote:
> To beautify the code format.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b..076b1c2f40a4 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -683,16 +683,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_out;
>  	}
>  
> -	devfreq->trans_table =
> -		devm_kzalloc(&devfreq->dev,
> -			     array3_size(sizeof(unsigned int),
> -					 devfreq->profile->max_state,
> -					 devfreq->profile->max_state),
> -			     GFP_KERNEL);
> +	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> +					    array3_size(sizeof(unsigned int),
> +					    devfreq->profile->max_state,
> +					    devfreq->profile->max_state),
> +					    GFP_KERNEL);
>  	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> -						devfreq->profile->max_state,
> -						sizeof(unsigned long),
> -						GFP_KERNEL);
> +					      devfreq->profile->max_state,
> +					      sizeof(unsigned long),
> +					      GFP_KERNEL);
>  	devfreq->last_stat_updated = jiffies;
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
