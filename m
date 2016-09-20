From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: exynos-ppmu: Remove unused mutex from struct
 exynos_ppmu
Date: Tue, 20 Sep 2016 17:07:35 +0900
Message-ID: <57E0EE47.4040300@samsung.com>
References: <CGME20160920064920epcas1p20cac67f7f048c80fdcbe489e235e0cdb@epcas1p2.samsung.com>
 <1474354100-6092-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42849 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753020AbcITIHu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Sep 2016 04:07:50 -0400
In-reply-to: <1474354100-6092-1-git-send-email-axel.lin@ingics.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hi,

If you remove the mutex, you better to remove
the header "#include <linux/mutex.h>" from exynos-ppmu.c.

If you remove the header file, looks good to me and
feel free to add my tag.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi

On 2016년 09월 20일 15:48, Axel Lin wrote:
> The mutex is not used at all, remove it.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index f55cf0e..251692b 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -15,7 +15,6 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/suspend.h>
> @@ -34,7 +33,6 @@ struct exynos_ppmu {
>  	unsigned int num_events;
>  
>  	struct device *dev;
> -	struct mutex lock;
>  
>  	struct exynos_ppmu_data ppmu;
>  };
> @@ -463,7 +461,6 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>  	if (!info)
>  		return -ENOMEM;
>  
> -	mutex_init(&info->lock);
>  	info->dev = &pdev->dev;
>  
>  	/* Parse dt data to get resource */
> 
