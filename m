From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] thermal: exynos: Disable the regulator on probe failure
Date: Mon, 06 Jul 2015 17:05:03 +0200
Message-ID: <20150706170503.58b9dcd1@amdc2363>
References: <1433727349-23330-1-git-send-email-k.kozlowski@samsung.com>
 <20150608181459.454c9067@amdc2363>
 <CAJKOXPfwSB03YQZA2HZHJLebxq7WTK2fObxHNegdYO+3MM_pfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <CAJKOXPfwSB03YQZA2HZHJLebxq7WTK2fObxHNegdYO+3MM_pfw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

> 2015-06-09 1:14 GMT+09:00 Lukasz Majewski <l.majewski@samsung.com>:
> > Hi Krzysztof,
> >
> >> During probe the regulator (if present) was enabled but not
> >> disabled in case of failure. So an unsuccessful probe lead to
> >> enabling the regulator which was actually not needed because the
> >> device was not enabled.
> >>
> >> Additionally each deferred probe lead to increase of regulator
> >> enable count so it would not be effectively disabled during
> >> removal of the device.
> >
> > Thanks for catching this.
> >
> >>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Fixes: 498d22f616f6 ("thermal: exynos: Support for TMU regulator
> >> defined at device tree") Cc: <stable@vger.kernel.org>
> >>
> >> ---
> >>
> >> I am not entirely convinced that this should go to stable. Leaving
> >> a regulator enabled in case of probe failure (no exynos TMU
> >> device) or after deferred probe (regulator won't be disabled
> >> during device removal) is not a critical issue, just leaks power.
> >> ---
> >>  drivers/thermal/samsung/exynos_tmu.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/thermal/samsung/exynos_tmu.c
> >> b/drivers/thermal/samsung/exynos_tmu.c index
> >> 531f4b179871..13c3aceed19d 100644 ---
> >> a/drivers/thermal/samsung/exynos_tmu.c +++
> >> b/drivers/thermal/samsung/exynos_tmu.c @@ -1392,6 +1392,8 @@
> >> err_clk_sec: if (!IS_ERR(data->clk_sec))
> >>               clk_unprepare(data->clk_sec);
> >>  err_sensor:
> >> +     if (!IS_ERR_OR_NULL(data->regulator))
> >> +             regulator_disable(data->regulator);
> >>       thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
> >>
> >>       return ret;
> >
> > Acked-by: Lukasz Majewski <l.majewski@samsung.com>
> >
> > I will test it and afterwards add to samsung-thermal tree.
>=20
> Hi =C5=81ukasz,
>=20
> I can't find this patch in v4.2-rc1 or your tree. What happened?
>=20
> Best regards,
> Krzysztof

Applied to linux-samsung-thermal.git

Thanks for fix and sorry for the delay.
--=20
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
