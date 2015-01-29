From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] thermal: exynos: Reorder exynos_map_dt_data()
 function
Date: Thu, 29 Jan 2015 19:06:17 -0400
Message-ID: <20150129230616.GJ29837@developer.amazonguestwifi.org>
References: <1421667844-13627-1-git-send-email-l.majewski@samsung.com>
 <1421667844-13627-2-git-send-email-l.majewski@samsung.com>
 <CAM4voakDBLbshW3EvFN4YRx1o1ApMLJVZ2ZQ0Bb6NwhmoT8WFA@mail.gmail.com>
 <20150122100124.65e7a19e@amdc2363>
 <CAM4voani1xcgRU3e11_pnYw4d7Yj=QOKun8g_DywmxDxOwEgRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM4voani1xcgRU3e11_pnYw4d7Yj=QOKun8g_DywmxDxOwEgRQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 22, 2015 at 06:02:07PM +0530, Abhilash Kesavan wrote:
> Hi Lukasz,
> 
> On Thu, Jan 22, 2015 at 2:31 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > Hi Abhilash,
> >
> >> Hi Lukasz,
> >>
> >> On Mon, Jan 19, 2015 at 5:14 PM, Lukasz Majewski
> >> <l.majewski@samsung.com> wrote:
> >> > The exynos_map_dt_data() function must be called before
> >> > thermal_zone_of_sensor_register(), and hence provide tmu_read()
> >> > function, before it is needed.
> >> >
> >> > This change is driven by adding support for enabling thermal_zoneX
> >> > when it is properly initialized.
> >> >
> >> > One can read the mode of operation
> >> > at /sys/class/thermal/thermal_zone0/mode Such functionality was
> >> > missing in the of-thermal.c code.
> >> >
> >> > Reported-by: Abhilash Kesavan <a.kesavan@samsung.com>
> >> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> >> > ---
> >> >  drivers/thermal/samsung/exynos_tmu.c | 7 ++++---
> >> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
> >> > b/drivers/thermal/samsung/exynos_tmu.c index 9d2d685..5d946ab 100644
> >> > --- a/drivers/thermal/samsung/exynos_tmu.c
> >> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> >> > @@ -975,15 +975,16 @@ static int exynos_tmu_probe(struct
> >> > platform_device *pdev) platform_set_drvdata(pdev, data);
> >> >         mutex_init(&data->lock);
> >> >
> >> > +       ret = exynos_map_dt_data(pdev);
> >> > +       if (ret)
> >> > +               goto err_sensor;
> >> > +
> >> >         data->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0,
> >> > data, &exynos_sensor_ops);
> >> >         if (IS_ERR(data->tzd)) {
> >> >                 pr_err("thermal: tz: %p ERROR\n", data->tzd);
> >> >                 return PTR_ERR(data->tzd);
> >> >         }
> >> > -       ret = exynos_map_dt_data(pdev);
> >> > -       if (ret)
> >> > -               goto err_sensor;
> >> >
> >> >         pdata = data->pdata;
> >>
> >> I have been testing this along with your v5 patch set and am seeing
> >> incorrect temperature being reported at boot-up on exynos7.
> >
> > Does it show a maximal temperature value (0x1FF)?
> 
> I did not print the current temperature register, but I remember the
> message showing ~105C. Will give you the register value when I test
> with more debug prints tomorrow.
> 
> >
> >>  It looks
> >> like exynos_tmu_read gets called from thermal_zone_of_device_update
> >> during boot-up, now that we have it populated early. However, as the
> >> tmu initialization function has not been called yet it returns a wrong
> >> value. Does that sound correct ?
> >
> > No, this is a mistake. However, I'm wondering why on Exynos4/5 this
> > error didn't show up...
> 
> I have been lowering the software trip point temperature in the
> exynos7 dts file (to 55C) for testing purposes. Hence, when the
> temperature is read incorrectly as ~105C the board trips at boot-up
> itself. Maybe for exynos4/5 the incorrect value read during boot-up is
> in the non-tripping range and once the tmu is initialized later it
> continues to function properly thereafter ?
> 
> >
> > The reordering is needed to be able to call set_mode callback at
> > of-thermal.c to set the mode.
> >
> > If this change causes problems, then another solution (probably not so
> > neat) must be found.
> 
> Please let me know if you need any further details.

What is the status of this patch? Is it still required?

Cheers,

> 
> Thanks,
> Abhilash
