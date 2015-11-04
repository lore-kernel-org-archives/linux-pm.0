From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 2/5] thermal: exynos: Fix first temperature read after
 registering sensor
Date: Wed, 04 Nov 2015 12:18:09 +0100
Message-ID: <20151104121809.24f99f79@amdc2363>
References: <1444282446-6419-1-git-send-email-k.kozlowski@samsung.com>
 <1444282446-6419-2-git-send-email-k.kozlowski@samsung.com>
 <CAGOxZ51BuqBGBECngB3YnNQJ4Ae+LNfTvqntg+GxdAih4GPXzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAGOxZ51BuqBGBECngB3YnNQJ4Ae+LNfTvqntg+GxdAih4GPXzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Alim,

> Hello,
> 
> On Thu, Oct 8, 2015 at 11:04 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> > Thermal core could not read the temperature after registering the
> > thermal sensor with thermal_zone_of_sensor_register() because the
> > driver was not yet initialized.
> >
> > The call trace looked like:
> >     exynos_tmu_probe()
> >         thermal_zone_of_sensor_register()
> >             of_thermal_set_mode()
> >                 thermal_zone_device_update()
> >                     exynos_get_temp()
> >                         if (!data->tmu_read) return -EINVAL;
> >         exynos_map_dt_data()
> >             data->tmu_read = ...
> >
> > This produced an error in dmesg:
> > thermal thermal_zone0: failed to read out thermal zone (-22)
> >
> > Register the thermal_zone_device later, after parsing Device Tree
> > and enabling necessary clocks, but before calling
> > exynos_tmu_initialize() which uses the registered
> > thermal_zone_device.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Fixes: 3b6a1a805f34 ("thermal: samsung: core: Exynos TMU rework to
> > use device tree for configuration") ---
> Patch looks good to me.
> 
> Before this patch I was getting below on exynos5800 board:
> [    2.648629] thermal thermal_zone0: failed to read out thermal zone
> (-22) [    2.653906] 10060000.tmu supply vtmu not found, using dummy
> regulator [    2.660521] thermal thermal_zone1: failed to read out
> thermal zone (-22) [    2.666985] 10064000.tmu supply vtmu not found,
> using dummy regulator [    2.673658] thermal thermal_zone2: failed to
> read out thermal zone (-22) [    2.680093] 10068000.tmu supply vtmu
> not found, using dummy regulator [    2.686901] thermal
> thermal_zone3: failed to read out thermal zone (-22) [    2.693187]
> 1006c000.tmu supply vtmu not found, using dummy regulator
> [    2.699914] thermal thermal_zone4: failed to read out thermal zone
> (-22) [    2.706332] 100a0000.tmu supply vtmu not found, using dummy
> regulator
> 
> 
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> 
> Tested on exynos5800 peach board, so
> Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
> 
> 
> >  drivers/thermal/samsung/exynos_tmu.c | 27 +++++++++++++++++--------
> --
> >  1 file changed, 17 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
> > b/drivers/thermal/samsung/exynos_tmu.c index
> > 23f4320f8ef7..bc71a61f0c4a 100644 ---
> > a/drivers/thermal/samsung/exynos_tmu.c +++
> > b/drivers/thermal/samsung/exynos_tmu.c @@ -1289,13 +1289,6 @@
> > static int exynos_tmu_probe(struct platform_device *pdev)
> > platform_set_drvdata(pdev, data); mutex_init(&data->lock);
> >
> > -       data->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0,
> > data,
> > -
> > &exynos_sensor_ops);
> > -       if (IS_ERR(data->tzd)) {
> > -               pr_err("thermal: tz: %p ERROR\n", data->tzd);
> > -               return PTR_ERR(data->tzd);
> > -       }
> > -
> >         /*
> >          * Try enabling the regulator if found
> >          * TODO: Add regulator as an SOC feature, so that regulator
> > enable @@ -1365,21 +1358,36 @@ static int exynos_tmu_probe(struct
> > platform_device *pdev) break;
> >         };
> >
> > +       /*
> > +        * data->tzd must be registered before calling
> > exynos_tmu_initialize(),
> > +        * requesting irq and calling exynos_tmu_control().
> > +        */
> > +       data->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0,
> > data,
> > +
> > &exynos_sensor_ops);
> > +       if (IS_ERR(data->tzd)) {
> > +               ret = PTR_ERR(data->tzd);
> > +               dev_err(&pdev->dev, "Failed to register sensor:
> > %d\n", ret);
> > +               goto err_sclk;
> > +       }
> > +
> >         ret = exynos_tmu_initialize(pdev);
> >         if (ret) {
> >                 dev_err(&pdev->dev, "Failed to initialize TMU\n");
> > -               goto err_sclk;
> > +               goto err_thermal;
> >         }
> >
> >         ret = devm_request_irq(&pdev->dev, data->irq,
> > exynos_tmu_irq, IRQF_TRIGGER_RISING | IRQF_SHARED,
> > dev_name(&pdev->dev), data); if (ret) {
> >                 dev_err(&pdev->dev, "Failed to request irq: %d\n",
> > data->irq);
> > -               goto err_sclk;
> > +               goto err_thermal;
> >         }
> >
> >         exynos_tmu_control(pdev, true);
> >         return 0;
> > +
> > +err_thermal:
> > +       thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
> >  err_sclk:
> >         clk_disable_unprepare(data->sclk);
> >  err_clk:
> > @@ -1390,7 +1398,6 @@ err_clk_sec:
> >  err_sensor:
> >         if (!IS_ERR_OR_NULL(data->regulator))
> >                 regulator_disable(data->regulator);
> > -       thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
> >
> >         return ret;
> >  }
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 

Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Tested-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
