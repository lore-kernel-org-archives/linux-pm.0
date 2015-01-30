From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 1/2] thermal: exynos: Reorder exynos_map_dt_data() function
Date: Fri, 30 Jan 2015 09:14:22 +0100
Message-ID: <20150130091422.669930c8@amdc2363>
References: <1421667844-13627-1-git-send-email-l.majewski@samsung.com>
 <1421667844-13627-2-git-send-email-l.majewski@samsung.com>
 <CAM4voakDBLbshW3EvFN4YRx1o1ApMLJVZ2ZQ0Bb6NwhmoT8WFA@mail.gmail.com>
 <20150122100124.65e7a19e@amdc2363>
 <CAM4voani1xcgRU3e11_pnYw4d7Yj=QOKun8g_DywmxDxOwEgRQ@mail.gmail.com>
 <20150129230616.GJ29837@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28602 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbbA3IOj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jan 2015 03:14:39 -0500
In-reply-to: <20150129230616.GJ29837@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Eduardo, Abhilash,

> On Thu, Jan 22, 2015 at 06:02:07PM +0530, Abhilash Kesavan wrote:
> > Hi Lukasz,
> > 
> > On Thu, Jan 22, 2015 at 2:31 PM, Lukasz Majewski
> > <l.majewski@samsung.com> wrote:
> > > Hi Abhilash,
> > >
> > >> Hi Lukasz,
> > >>
> > >> On Mon, Jan 19, 2015 at 5:14 PM, Lukasz Majewski
> > >> <l.majewski@samsung.com> wrote:
> > >> > The exynos_map_dt_data() function must be called before
> > >> > thermal_zone_of_sensor_register(), and hence provide tmu_read()
> > >> > function, before it is needed.
> > >> >
> > >> > This change is driven by adding support for enabling
> > >> > thermal_zoneX when it is properly initialized.
> > >> >
> > >> > One can read the mode of operation
> > >> > at /sys/class/thermal/thermal_zone0/mode Such functionality was
> > >> > missing in the of-thermal.c code.
> > >> >
> > >> > Reported-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > >> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > >> > ---
> > >> >  drivers/thermal/samsung/exynos_tmu.c | 7 ++++---
> > >> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >> >
> > >> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
> > >> > b/drivers/thermal/samsung/exynos_tmu.c index 9d2d685..5d946ab
> > >> > 100644 --- a/drivers/thermal/samsung/exynos_tmu.c
> > >> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > >> > @@ -975,15 +975,16 @@ static int exynos_tmu_probe(struct
> > >> > platform_device *pdev) platform_set_drvdata(pdev, data);
> > >> >         mutex_init(&data->lock);
> > >> >
> > >> > +       ret = exynos_map_dt_data(pdev);
> > >> > +       if (ret)
> > >> > +               goto err_sensor;
> > >> > +
> > >> >         data->tzd =
> > >> > thermal_zone_of_sensor_register(&pdev->dev, 0, data,
> > >> > &exynos_sensor_ops); if (IS_ERR(data->tzd)) {
> > >> >                 pr_err("thermal: tz: %p ERROR\n", data->tzd);
> > >> >                 return PTR_ERR(data->tzd);
> > >> >         }
> > >> > -       ret = exynos_map_dt_data(pdev);
> > >> > -       if (ret)
> > >> > -               goto err_sensor;
> > >> >
> > >> >         pdata = data->pdata;
> > >>
> > >> I have been testing this along with your v5 patch set and am
> > >> seeing incorrect temperature being reported at boot-up on
> > >> exynos7.
> > >
> > > Does it show a maximal temperature value (0x1FF)?
> > 
> > I did not print the current temperature register, but I remember the
> > message showing ~105C. Will give you the register value when I test
> > with more debug prints tomorrow.
> > 
> > >
> > >>  It looks
> > >> like exynos_tmu_read gets called from
> > >> thermal_zone_of_device_update during boot-up, now that we have
> > >> it populated early. However, as the tmu initialization function
> > >> has not been called yet it returns a wrong value. Does that
> > >> sound correct ?
> > >
> > > No, this is a mistake. However, I'm wondering why on Exynos4/5
> > > this error didn't show up...
> > 
> > I have been lowering the software trip point temperature in the
> > exynos7 dts file (to 55C) for testing purposes. Hence, when the
> > temperature is read incorrectly as ~105C the board trips at boot-up

					^^^^ this is a very unusual
					value - I had problems with
					reading 0xFF values with
					similar symptom (but this was
					caused by lack of vtmu).

> > itself. Maybe for exynos4/5 the incorrect value read during boot-up
> > is in the non-tripping range and once the tmu is initialized later
> > it continues to function properly thereafter ?
> > 
> > >
> > > The reordering is needed to be able to call set_mode callback at
> > > of-thermal.c to set the mode.
> > >
> > > If this change causes problems, then another solution (probably
> > > not so neat) must be found.
> > 
> > Please let me know if you need any further details.

Abhilash, could you provide more details (like relevant output from
dmesg) and point me a list of patches which shall I apply to test this
issue on Exynos4/5?

> 
> What is the status of this patch? Is it still required?

It is strange, since on Exynos4/5 this works and some problems show up
when run on Exynos7.

> 
> Cheers,
> 
> > 
> > Thanks,
> > Abhilash



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
