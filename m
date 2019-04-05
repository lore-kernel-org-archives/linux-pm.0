From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v3 07/13] thermal: qoriq: Pass data to qoriq_tmu_calibration()
 directly
Date: Fri, 5 Apr 2019 11:04:49 -0700
Message-ID: <CAHQ1cqGfSS0PHaM+QcEMzhxXN5F9vQEE=nWseSoRKbrEmkFHag@mail.gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-8-andrew.smirnov@gmail.com> <fa3cf0ac-1015-4031-8cd4-cd5270e39fc7@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fa3cf0ac-1015-4031-8cd4-cd5270e39fc7@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, dl-linux-imx <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 4, 2019 at 1:12 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > We can simplify error cleanup code if instead of passing a "struct
> > platform_device *" to qoriq_tmu_calibration() and deriving a bunch of
> > pointers from it, we pass those pointers directly. This way we won't
> > be force to call platform_set_drvdata() as early in qoriq_tmu_probe()
> > and consequently would be able to drop the "err_iomap" error path.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> > Cc: linux-imx@nxp.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/qoriq_thermal.c | 22 +++++++++-------------
> >  1 file changed, 9 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index 24a2a57f61c9..a3ddb55740e4 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -139,16 +139,16 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
> >       return 0;
> >  }
> >
> > -static int qoriq_tmu_calibration(struct platform_device *pdev)
> > +static int qoriq_tmu_calibration(struct device *dev,
> > +                              struct qoriq_tmu_data *data)
> >  {
> >       int i, val, len;
> >       u32 range[4];
> >       const u32 *calibration;
> > -     struct device_node *np = pdev->dev.of_node;
> > -     struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
> > +     struct device_node *np = dev->of_node;
> >
> >       if (of_property_read_u32_array(np, "fsl,tmu-range", range, 4)) {
> > -             dev_err(&pdev->dev, "missing calibration range.\n");
> > +             dev_err(dev, "missing calibration range.\n");
> >               return -ENODEV;
> >       }
> >
> > @@ -160,7 +160,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
> >
> >       calibration = of_get_property(np, "fsl,tmu-calibration", &len);
> >       if (calibration == NULL || len % 8) {
> > -             dev_err(&pdev->dev, "invalid calibration data.\n");
> > +             dev_err(dev, "invalid calibration data.\n");
> >               return -ENODEV;
> >       }
> >
> > @@ -198,20 +198,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
> >       if (!data)
> >               return -ENOMEM;
> >
> > -     platform_set_drvdata(pdev, data);
> > -
> >       data->little_endian = of_property_read_bool(np, "little-endian");
> >
> >       data->regs = of_iomap(np, 0);
> >       if (!data->regs) {
> >               dev_err(dev, "Failed to get memory region\n");
> > -             ret = -ENODEV;
> > -             goto err_iomap;
> > +             return -ENODEV;
> >       }
> >
> >       qoriq_tmu_init_device(data);    /* TMU initialization */
> >
> > -     ret = qoriq_tmu_calibration(pdev);      /* TMU calibration */
> > +     ret = qoriq_tmu_calibration(dev, data); /* TMU calibration */
> >       if (ret < 0)
> >               goto err_tmu;
> >
> > @@ -222,14 +219,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
> >               goto err_iomap;
>
> s/goto err_iomap/goto err_tmu/ ?
>

Ugh, not sure how I missed this. Will fix. Thanks for catching this!

Thanks,
Andrey Smirnov
