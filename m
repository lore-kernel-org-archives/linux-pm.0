From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 3/3] PM / devfreq: fix mem leak in devfreq_add_device()
Date: Mon, 21 Jan 2019 10:42:00 +0900
Message-ID: <0ae2e104-4ff0-888a-c6ce-12b40a76e14d@samsung.com>
References: <20190119160454.23151-1-tiny.windzz@gmail.com>
        <CGME20190119183020epcas1p4c0ce7cf4c2ed02da5d6ffb7bbadfd8b8@epcas1p4.samsung.com>
        <20190119160454.23151-3-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190119160454.23151-3-tiny.windzz@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19. 1. 20. 오전 1:04, Yangtao Li wrote:
> 'devfreq' is malloced in devfreq_add_device() and should be freed in
> the error handling cases, otherwise it will cause memory leak.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 923889229a0b..fe6c157cb7e0 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -651,7 +651,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		mutex_unlock(&devfreq->lock);
>  		err = set_freq_table(devfreq);
>  		if (err < 0)
> -			goto err_out;
> +			goto err_dev;
>  		mutex_lock(&devfreq->lock);
>  	}
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
