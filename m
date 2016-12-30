From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 4/8] PM / devfreq: exynos-ppmu: Show the registred
 device for ppmu device
Date: Fri, 30 Dec 2016 19:35:00 +0900
Message-ID: <CAJ0PZbRKPpbHG_dMFowd7nXbxUGJRmY=jsscKBLDY27GTFjO7g@mail.gmail.com>
References: <CGME20161228115654epcas1p1fcd9be231f97e6782e06d75ace95a9ba@epcas1p1.samsung.com>
 <1482926212-19223-1-git-send-email-cw00.choi@samsung.com> <1482926212-19223-5-git-send-email-cw00.choi@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33646 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751431AbcL3KfR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2016 05:35:17 -0500
In-Reply-To: <1482926212-19223-5-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, chanwoo@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>

On Wed, Dec 28, 2016 at 8:56 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch just adds the simple log to show the PPMU device's registration
> during the kernel booting.
>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index fb3706faf5bd..9b5294d0bff4 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -591,7 +591,7 @@ static int exynos_ppmu_parse_dt(struct platform_device *pdev,
>         info->ppmu.clk = devm_clk_get(dev, "ppmu");
>         if (IS_ERR(info->ppmu.clk)) {
>                 info->ppmu.clk = NULL;
> -               dev_warn(dev, "cannot get PPMU clock\n");
> +               dev_dbg(dev, "cannot get PPMU clock\n");

Do you really want not to emit warning with a clock not found?

>         }
>
>         ret = of_get_devfreq_events(np, info);
> @@ -643,6 +643,9 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>                                 "failed to add devfreq-event device\n");
>                         return PTR_ERR(edev[i]);
>                 }
> +
> +               pr_info("exynos-ppmu: new PPMU device registered %s (%s)\n",
> +                       dev_name(&pdev->dev), desc[i].name);
>         }
>
>         clk_prepare_enable(info->ppmu.clk);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
