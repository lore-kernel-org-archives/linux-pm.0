From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v4 09/12] thermal: qoriq: Enable all sensors before
 registering them
Date: Thu, 18 Apr 2019 13:02:24 -0700
Message-ID: <CAHQ1cqFW0XVe4e695pgs6mDvOvJ28VXwkzAwsFtZbc3E+PUVzQ@mail.gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-10-andrew.smirnov@gmail.com> <8233019b-988b-05d5-6b7c-55652da8b3cd@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8233019b-988b-05d5-6b7c-55652da8b3cd@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, dl-linux-imx <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 16, 2019 at 10:09 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/04/2019 10:27, Andrey Smirnov wrote:
> > Tmu_get_temp will get called as a part of sensor registration via
> > devm_thermal_zone_of_sensor_register(). To prevent it from retruning
> > bogus data we need to enable sensor monitoring before that. Looking at
> > the datasheet (i.MX8MQ RM) there doesn't seem to be any harm in
> > enabling them all, so, for the sake of simplicity, change the code to
> > do just that.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> > Cc: linux-imx@nxp.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/qoriq_thermal.c | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index 9774323a17bf..abbbfe88422e 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -23,6 +23,7 @@
> >  #define TMR_DISABLE  0x0
> >  #define TMR_ME               0x80000000
> >  #define TMR_ALPF     0x0c000000
> > +#define TMR_MSITE_ALL        GENMASK(15, 0)
> >
> >  #define REGS_TMTMIR  0x008   /* Temperature measurement interval Register */
> >  #define TMTMIR_DEFAULT       0x0000000f
> > @@ -61,28 +62,28 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
> >  static int qoriq_tmu_register_tmu_zone(struct device *dev,
> >                                      struct qoriq_tmu_data *qdata)
> >  {
> > -     int id, sites = 0;
> > +     int id, ret;
> > +
> > +     regmap_write(qdata->regmap, REGS_TMR,
> > +                  TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
> >
> >       for (id = 0; id < SITES_MAX; id++) {
> >               struct thermal_zone_device *tzd;
> >
> >               tzd = devm_thermal_zone_of_sensor_register(dev, id,
> >                                                          qdata, &tmu_tz_ops);
> > -             if (IS_ERR(tzd)) {
> > -                     if (PTR_ERR(tzd) == -ENODEV)
> > -                             continue;
> > -                     else
> > -                             return PTR_ERR(tzd);
> > +             ret = PTR_ERR_OR_ZERO(tzd);
> > +             switch (ret) {
> > +             case -ENODEV:
> > +                     continue;
> > +             case 0:
>
> Why not simply:
>
>         if (!IS_ERR(tzd) || PTR_ERR(tzd) == -ENODEV)
>                 continue;
>
>         regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
>
>         return PTR_ERR(tzd);
>
> ?

Seemed like less typing and smaller diff for following patch that adds
hwmon sensor registration. I can probable make "if" work kind of the
same, so I'll change that. I do dislike that you had to use *_ERR
macro three times though, so I'll stick with PTR_ERR_OR_ZERO.

Thanks,
Andrey Smirnov
