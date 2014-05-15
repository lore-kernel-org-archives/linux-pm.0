From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: samsung: Only update available threshold limits
Date: Thu, 15 May 2014 16:45:28 +0800
Message-ID: <1400143528.2273.30.camel@rzhang1-toshiba>
References: <1397453895-6688-1-git-send-email-tushar.behera@linaro.org>
	 <CADGdYn719UzdPd3fVWrPi=mTnKvKy3O5bPHZcn8xCFjrAWp7yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADGdYn719UzdPd3fVWrPi=mTnKvKy3O5bPHZcn8xCFjrAWp7yA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kachhap <amit.kachhap@gmail.com>
Cc: Tushar Behera <tushar.behera@linaro.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

On =E5=9B=9B, 2014-04-24 at 11:48 +0530, Amit Kachhap wrote:
> On 4/14/14, Tushar Behera <tushar.behera@linaro.org> wrote:
> > Currently the threshold limits are updated in 2 stages, once for al=
l
> > software trigger levels and again for hardware trip point.
> I guess the first stage is bootloader as could not find this in this =
file.
> Anyways the changes looks fine to me.
>=20
> Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

applied.

thanks,
rui
>=20
> >
> > While updating the software trigger levels, it overwrites the thres=
hold
> > limit for hardware trip point thereby forcing the Exynos core to is=
sue
> > an emergency shutdown.
> >
> > Updating only the required fields in threshold register fixes this =
issue.
> >
> > Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> > ---
> > Based on v3.15-rc1.
> >
> >  drivers/thermal/samsung/exynos_tmu.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
> > b/drivers/thermal/samsung/exynos_tmu.c
> > index 0d96a51..ffccc89 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -225,6 +225,8 @@ skip_calib_data:
> >  			trigger_levs++;
> >  	}
> >
> > +	rising_threshold =3D readl(data->base + reg->threshold_th0);
> > +
> >  	if (data->soc =3D=3D SOC_ARCH_EXYNOS4210) {
> >  		/* Write temperature code for threshold */
> >  		threshold_code =3D temp_to_code(data, pdata->threshold);
> > @@ -249,6 +251,7 @@ skip_calib_data:
> >  				ret =3D threshold_code;
> >  				goto out;
> >  			}
> > +			rising_threshold &=3D ~(0xff << 8 * i);
> >  			rising_threshold |=3D threshold_code << 8 * i;
> >  			if (pdata->threshold_falling) {
> >  				threshold_code =3D temp_to_code(data,
> > @@ -281,6 +284,7 @@ skip_calib_data:
> >  			}
> >  			if (i =3D=3D EXYNOS_MAX_TRIGGER_PER_REG - 1) {
> >  				/* 1-4 level to be assigned in th0 reg */
> > +				rising_threshold &=3D ~(0xff << 8 * i);
> >  				rising_threshold |=3D threshold_code << 8 * i;
> >  				writel(rising_threshold,
> >  					data->base + reg->threshold_th0);
> > --
> > 1.7.9.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sam=
sung-soc"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
