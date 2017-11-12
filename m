From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Remove unnecessary NULL check before
 kfree
Date: Mon, 13 Nov 2017 07:28:43 +0900
Message-ID: <5A08CB1B.6000201@samsung.com>
References: <CGME20171112082944epcas5p216efba5e38d3bf17ee993abe51aa4dc3@epcas5p2.samsung.com>
        <20171112082739.GA20464@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36449 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbdKLW2n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Nov 2017 17:28:43 -0500
In-reply-to: <20171112082739.GA20464@embeddedor.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 2017년 11월 12일 17:27, Gustavo A. R. Silva wrote:
> NULL check before freeing functions like kfree is not needed.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/devfreq/devfreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 78fb496..21164a9 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -672,8 +672,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	device_unregister(&devfreq->dev);
>  err_dev:
> -	if (devfreq)
> -		kfree(devfreq);
> +	kfree(devfreq);
>  err_out:
>  	return ERR_PTR(err);
>  }
> 

It prevents the memory leak when the registration
of devfreq device is failed. You can check the
detailed reason on patch1[1].

[1] PM / devfreq: Fix memory leak when fail to register device
- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9e14de1077e9c34f141cf98bdba60cdd5193d962


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
