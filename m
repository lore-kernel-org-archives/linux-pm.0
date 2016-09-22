From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: exynos-ppmu: ppmu_events array should not be
 NULL terminated
Date: Thu, 22 Sep 2016 15:26:26 +0900
Message-ID: <57E37992.2030500@samsung.com>
References: <CGME20160921003108epcas1p13c13f6dbfbcf86c22d88e33606e8fc97@epcas1p1.samsung.com>
 <1474417840-7999-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:53331 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbcIVG03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2016 02:26:29 -0400
In-reply-to: <1474417840-7999-1-git-send-email-axel.lin@ingics.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hello,

On 2016년 09월 21일 09:30, Axel Lin wrote:
> The rest of the code uses ARRAY_SIZE to count the number of entries in
> ppmu_events array. The NULL terminated entry makes ARRAY_SIZE return
> off-by-one value.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index f55cf0e..c9ffaf0 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -90,8 +90,6 @@ struct __exynos_ppmu_events {
>  	PPMU_EVENT(d1-cpu),
>  	PPMU_EVENT(d1-general),
>  	PPMU_EVENT(d1-rt),
> -
> -	{ /* sentinel */ },
>  };
>  
>  static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
