From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Propagate error from devfreq_add_device()
Date: Mon, 06 Nov 2017 07:41:29 +0900
Message-ID: <59FF9399.6010305@samsung.com>
References: <CGME20171104033835epcas3p2a0e62915bf40aab150c78b4a3d341b13@epcas3p2.samsung.com>
        <20171104033828.16773-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30097 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdKEWlc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Nov 2017 17:41:32 -0500
In-reply-to: <20171104033828.16773-1-bjorn.andersson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 2017년 11월 04일 12:38, Bjorn Andersson wrote:
> Propagate the error of devfreq_add_device() in devm_devfreq_add_device()
> rather than statically returning ENOMEM. This makes it slightly faster
> to pinpoint the cause of a returned error.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 78fb496ecb4e..99c4021fc33b 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -737,7 +737,7 @@ struct devfreq *devm_devfreq_add_device(struct device *dev,
>  	devfreq = devfreq_add_device(dev, profile, governor_name, data);
>  	if (IS_ERR(devfreq)) {
>  		devres_free(ptr);
> -		return ERR_PTR(-ENOMEM);
> +		return devfreq;
>  	}
>  
>  	*ptr = devfreq;
> 

Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

But, you better to send this patch to the 'stable@vger.kernel.org'
with the fixes information as following:

Fixes: 8cd84092d35e ("PM / devfreq: Add resource-managed function for devfreq device")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
