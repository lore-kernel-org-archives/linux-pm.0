From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH] PM / devfreq: exynos-ppmu: fix error path in exynos_ppmu_probe()
Date: Tue, 28 Jun 2016 21:10:58 +0900
Message-ID: <CAGTfZH2iTwPgEqYWqXf-+nwg8P8ZZJ7+t-aDWeWThBMTA5OhjQ@mail.gmail.com>
References: <1467112869-30488-1-git-send-email-b.zolnierkie@samsung.com>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32836 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbcF1MLA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 08:11:00 -0400
In-Reply-To: <1467112869-30488-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

2016-06-28 20:21 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> iounmap() needs to be called in case of memory allocation
> (for devfreq-event devices) failure.  Fix it.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index f312485..845bf25 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -482,7 +482,8 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>         if (!info->edev) {
>                 dev_err(&pdev->dev,
>                         "failed to allocate memory devfreq-event devices\n");
> -               return -ENOMEM;
> +               ret = -ENOMEM;
> +               goto err;
>         }
>         edev = info->edev;
>         platform_set_drvdata(pdev, info);
> --
> 1.9.1
>

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Also, this patch fix the bug. So, this patch should be included in v4.7-rc.

Thanks,
Chanwoo Choi
