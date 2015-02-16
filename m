From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] thermal: exynos: fix: Check if data->tmu_read callback is
 present before read
Date: Mon, 16 Feb 2015 10:53:59 +0100
Message-ID: <20150216105359.1b39fac8@amdc2363>
References: <1423228030-18708-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1423228030-18708-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> The exynos_tmu_data() function should on entrance test not only for
> valid data pointer, but also for data->tmu_read one.
> It is important, since afterwards it is dereferenced to get
> temperature code.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c
> b/drivers/thermal/samsung/exynos_tmu.c index 3a19353..a86e0495e 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -717,7 +717,7 @@ static int exynos_get_temp(void *p, long *temp)
>  {
>  	struct exynos_tmu_data *data = p;
>  
> -	if (!data)
> +	if (!data || !data->tmu_read)
>  		return -EINVAL;
>  
>  	mutex_lock(&data->lock);

This fix shall be added to v3.20.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
