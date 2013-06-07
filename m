From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 1/3] PM / devfreq: Fix incorrect usage of IS_ERR_OR_NULL
 in exynos5_bus.c
Date: Fri, 7 Jun 2013 19:21:58 +0900
Message-ID: <CAJ0PZbRM0tUs=FrhdVWVf9-_z=O_gkDSYjEGFgJP1xHsEVGNZw@mail.gmail.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:51857 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab3FGKV7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2013 06:21:59 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz10so2884679veb.5
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2013 03:21:58 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, "patches@linaro.org" <patches@linaro.org>

On Wed, Jun 5, 2013 at 3:12 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>
> platform_device_register_simple does not return NULL.
> Hence NULL check is not required.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Will be applied soon.

> ---
>  drivers/devfreq/exynos/exynos5_bus.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
> index 574b16b..cd1e630 100644
> --- a/drivers/devfreq/exynos/exynos5_bus.c
> +++ b/drivers/devfreq/exynos/exynos5_bus.c
> @@ -479,7 +479,7 @@ static int __init exynos5_busfreq_int_init(void)
>
>         exynos5_devfreq_pdev =
>                 platform_device_register_simple("exynos5-bus-int", -1, NULL, 0);
> -       if (IS_ERR_OR_NULL(exynos5_devfreq_pdev)) {
> +       if (IS_ERR(exynos5_devfreq_pdev)) {
>                 ret = PTR_ERR(exynos5_devfreq_pdev);
>                 goto out1;
>         }
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




--
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
