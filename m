From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 1/5] thermal: exynos: Fix unbalanced regulator disable on
 probe failure
Date: Wed, 04 Nov 2015 11:52:02 +0100
Message-ID: <20151104115202.1321c996@amdc2363>
References: <1444282446-6419-1-git-send-email-k.kozlowski@samsung.com>
 <CAGOxZ52DE42YA3b5z-16H7fxs58f6Mv+AjMcaaaJEM6bftEmnA@mail.gmail.com>
 <56179DC0.1040003@samsung.com>
 <CAGOxZ53KA3bB6F4Ucc8r7rLZFfYiATPsQjKs2BOeWV2BdK=nvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAGOxZ53KA3bB6F4Ucc8r7rLZFfYiATPsQjKs2BOeWV2BdK=nvA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-pm@vger.kernel.org, k.kozlowski.k@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Alim,

> Hello,
> 
> On Fri, Oct 9, 2015 at 4:28 PM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> > W dniu 09.10.2015 o 01:45, Alim Akhtar pisze:
> >> Hello,
> >>
> >> On Thu, Oct 8, 2015 at 11:04 AM, Krzysztof Kozlowski
> >> <k.kozlowski@samsung.com> wrote:
> >>> During probe if the regulator could not be enabled, the error
> >>> exit path would still disable it. This could lead to unbalanced
> >>> counter of regulator enable/disable.
> >>>
> >> Do you see a regulator unbalanced reported here during boot? You
> >> may want to add that to commit message.
> >
> > I did not see the warning/error message about unbalanced disable. It
> > would happen in certain condition only - no other enables of
> > regulator and count going below 0.
> >
> > I would have to simulate this error to get the warning message. I
> > don't think it is worth the effort.
> >
> Ok, looking at code, it does looks to be calling regulator disable in
> case regulator enable fails.
> Feel free to add
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> Thanks!!
> 
> > Best regards,
> > Krzysztof
> >
> >>
> >>> The patch moves code for getting and enabling the regulator from
> >>> exynos_map_dt_data() to probe function because it is really not a
> >>> part of getting Device Tree properties.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>> Fixes: 5f09a5cbd14a ("thermal: exynos: Disable the regulator on
> >>> probe failure") Cc: <stable@vger.kernel.org>
> >>> ---
> >>>  drivers/thermal/samsung/exynos_tmu.c | 34
> >>> +++++++++++++++++----------------- 1 file changed, 17
> >>> insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/samsung/exynos_tmu.c
> >>> b/drivers/thermal/samsung/exynos_tmu.c index
> >>> 0bae8cc6c23a..23f4320f8ef7 100644 ---
> >>> a/drivers/thermal/samsung/exynos_tmu.c +++
> >>> b/drivers/thermal/samsung/exynos_tmu.c @@ -1168,27 +1168,10 @@
> >>> static int exynos_map_dt_data(struct platform_device *pdev)
> >>> struct exynos_tmu_data *data = platform_get_drvdata(pdev); struct
> >>> exynos_tmu_platform_data *pdata; struct resource res;
> >>> -       int ret;
> >>>
> >>>         if (!data || !pdev->dev.of_node)
> >>>                 return -ENODEV;
> >>>
> >>> -       /*
> >>> -        * Try enabling the regulator if found
> >>> -        * TODO: Add regulator as an SOC feature, so that
> >>> regulator enable
> >>> -        * is a compulsory call.
> >>> -        */
> >>> -       data->regulator = devm_regulator_get(&pdev->dev, "vtmu");
> >>> -       if (!IS_ERR(data->regulator)) {
> >>> -               ret = regulator_enable(data->regulator);
> >>> -               if (ret) {
> >>> -                       dev_err(&pdev->dev, "failed to enable
> >>> vtmu\n");
> >>> -                       return ret;
> >>> -               }
> >>> -       } else {
> >>> -               dev_info(&pdev->dev, "Regulator node (vtmu) not
> >>> found\n");
> >>> -       }
> >>> -
> >>>         data->id = of_alias_get_id(pdev->dev.of_node, "tmuctrl");
> >>>         if (data->id < 0)
> >>>                 data->id = 0;
> >>> @@ -1312,6 +1295,23 @@ static int exynos_tmu_probe(struct
> >>> platform_device *pdev) pr_err("thermal: tz: %p ERROR\n",
> >>> data->tzd); return PTR_ERR(data->tzd);
> >>>         }
> >>> +
> >>> +       /*
> >>> +        * Try enabling the regulator if found
> >>> +        * TODO: Add regulator as an SOC feature, so that
> >>> regulator enable
> >>> +        * is a compulsory call.
> >>> +        */
> >>> +       data->regulator = devm_regulator_get(&pdev->dev, "vtmu");
> >>> +       if (!IS_ERR(data->regulator)) {
> >>> +               ret = regulator_enable(data->regulator);
> >>> +               if (ret) {
> >>> +                       dev_err(&pdev->dev, "failed to enable
> >>> vtmu\n");
> >>> +                       return ret;
> >>> +               }
> >>> +       } else {
> >>> +               dev_info(&pdev->dev, "Regulator node (vtmu) not
> >>> found\n");
> >>> +       }
> >>> +
> >>>         ret = exynos_map_dt_data(pdev);
> >>>         if (ret)
> >>>                 goto err_sensor;
> >>> --
> >>> 1.9.1
> >>>
> >>>
> >>> _______________________________________________
> >>> linux-arm-kernel mailing list
> >>> linux-arm-kernel@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >>
> >>
> >>
> >
> 
> 
> 

Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Tested-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
