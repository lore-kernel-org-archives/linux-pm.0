From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH 1/2] thermal: exynos: Reorder exynos_map_dt_data() function
Date: Fri, 30 Jan 2015 20:36:39 +0530
Message-ID: <CAM4voa=aEZbCx5KDoZW1NgindOeM8UZshU5ioFjiux3aoqHYFA@mail.gmail.com>
References: <1421667844-13627-1-git-send-email-l.majewski@samsung.com>
	<1421667844-13627-2-git-send-email-l.majewski@samsung.com>
	<CAM4voakDBLbshW3EvFN4YRx1o1ApMLJVZ2ZQ0Bb6NwhmoT8WFA@mail.gmail.com>
	<20150122100124.65e7a19e@amdc2363>
	<CAM4voani1xcgRU3e11_pnYw4d7Yj=QOKun8g_DywmxDxOwEgRQ@mail.gmail.com>
	<20150129230616.GJ29837@developer.amazonguestwifi.org>
	<20150130091422.669930c8@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150130091422.669930c8@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On Fri, Jan 30, 2015 at 1:44 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Eduardo, Abhilash,
>
>> On Thu, Jan 22, 2015 at 06:02:07PM +0530, Abhilash Kesavan wrote:
>> > Hi Lukasz,
>> >
>> > On Thu, Jan 22, 2015 at 2:31 PM, Lukasz Majewski
>> > <l.majewski@samsung.com> wrote:
>> > > Hi Abhilash,
>> > >
>> > >> Hi Lukasz,
>> > >>
>> > >> On Mon, Jan 19, 2015 at 5:14 PM, Lukasz Majewski
>> > >> <l.majewski@samsung.com> wrote:
>> > >> > The exynos_map_dt_data() function must be called before
>> > >> > thermal_zone_of_sensor_register(), and hence provide tmu_read()
>> > >> > function, before it is needed.
>> > >> >
>> > >> > This change is driven by adding support for enabling
>> > >> > thermal_zoneX when it is properly initialized.
>> > >> >
>> > >> > One can read the mode of operation
>> > >> > at /sys/class/thermal/thermal_zone0/mode Such functionality was
>> > >> > missing in the of-thermal.c code.
>> > >> >
>> > >> > Reported-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> > >> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>> > >> > ---
>> > >> >  drivers/thermal/samsung/exynos_tmu.c | 7 ++++---
>> > >> >  1 file changed, 4 insertions(+), 3 deletions(-)
>> > >> >
>> > >> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
>> > >> > b/drivers/thermal/samsung/exynos_tmu.c index 9d2d685..5d946ab
>> > >> > 100644 --- a/drivers/thermal/samsung/exynos_tmu.c
>> > >> > +++ b/drivers/thermal/samsung/exynos_tmu.c
>> > >> > @@ -975,15 +975,16 @@ static int exynos_tmu_probe(struct
>> > >> > platform_device *pdev) platform_set_drvdata(pdev, data);
>> > >> >         mutex_init(&data->lock);
>> > >> >
>> > >> > +       ret = exynos_map_dt_data(pdev);
>> > >> > +       if (ret)
>> > >> > +               goto err_sensor;
>> > >> > +
>> > >> >         data->tzd =
>> > >> > thermal_zone_of_sensor_register(&pdev->dev, 0, data,
>> > >> > &exynos_sensor_ops); if (IS_ERR(data->tzd)) {
>> > >> >                 pr_err("thermal: tz: %p ERROR\n", data->tzd);
>> > >> >                 return PTR_ERR(data->tzd);
>> > >> >         }
>> > >> > -       ret = exynos_map_dt_data(pdev);
>> > >> > -       if (ret)
>> > >> > -               goto err_sensor;
>> > >> >
>> > >> >         pdata = data->pdata;
>> > >>
>> > >> I have been testing this along with your v5 patch set and am
>> > >> seeing incorrect temperature being reported at boot-up on
>> > >> exynos7.
>> > >
>> > > Does it show a maximal temperature value (0x1FF)?
>> >
>> > I did not print the current temperature register, but I remember the
>> > message showing ~105C. Will give you the register value when I test
>> > with more debug prints tomorrow.
>> >
>> > >
>> > >>  It looks
>> > >> like exynos_tmu_read gets called from
>> > >> thermal_zone_of_device_update during boot-up, now that we have
>> > >> it populated early. However, as the tmu initialization function
>> > >> has not been called yet it returns a wrong value. Does that
>> > >> sound correct ?
>> > >
>> > > No, this is a mistake. However, I'm wondering why on Exynos4/5
>> > > this error didn't show up...
>> >
>> > I have been lowering the software trip point temperature in the
>> > exynos7 dts file (to 55C) for testing purposes. Hence, when the
>> > temperature is read incorrectly as ~105C the board trips at boot-up
>
>                                         ^^^^ this is a very unusual
>                                         value - I had problems with
>                                         reading 0xFF values with
>                                         similar symptom (but this was
>                                         caused by lack of vtmu).
>
>> > itself. Maybe for exynos4/5 the incorrect value read during boot-up
>> > is in the non-tripping range and once the tmu is initialized later
>> > it continues to function properly thereafter ?
>> >
>> > >
>> > > The reordering is needed to be able to call set_mode callback at
>> > > of-thermal.c to set the mode.
>> > >
>> > > If this change causes problems, then another solution (probably
>> > > not so neat) must be found.
>> >
>> > Please let me know if you need any further details.
>
> Abhilash, could you provide more details (like relevant output from
> dmesg) and point me a list of patches which shall I apply to test this
> issue on Exynos4/5?
Sorry, I have not had the time to re-check this and provide you with
the current temperature register value. I will definitely do so on
Monday and also provide you the dmesg output. I applied the following
patches on linux-next:

bbf872d thermal: exynos: Add TMU support for Exynos7 SoC
b8190ac dts: Documentation: Add documentation for Exynos7 SoC thermal bindings
9330ec1 thermal: exynos: Reorder exynos_map_dt_data() function
4dd41c4 thermal: exynos: dts: Provide device tree bindings identical
to the one in exynos_tmu_data.c
a7b80b9 thermal: dts: exynos: Trip points and sensor configuration
data for Exynos5440
77d072e thermal: exynos: dts: Define default thermal-zones for Exynos4
964dd36 thermal: dts: Default trip points definition for Exynos5420 SoCs
c1d2f97 thermal: exynos: dts: Add default definition of the TMU sensor parameter
02a4496 arm: dts: Adding CPU cooling binding for Exynos SoCs
bfadff0 arm: dts: odroid: Enable TMU at Exynos4412 based Odroid U3 device
862764c arm: dts: odroid: Add LDO10 regulator node necessary for TMU on Odroid
c064731 arm: dts: trats: Enable TMU on the Exynos4210 trats device

Along with the above list I have a patch which adds the dt changes
required for exynos7 on similar lines as done for exynos4/exynos5. In
the exyno7 trip point dts file I have modified the cpu-crit-0
temperature to a low value of 55C for testing purposes.

>
>>
>> What is the status of this patch? Is it still required?
>
> It is strange, since on Exynos4/5 this works and some problems show up
> when run on Exynos7.

I would have expected the issue to show up on Exynos4/5 too. I will
test this on the 5420 based board I have on Monday.

Regards,
Abhilash
