From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] thermal: Add QPNP PMIC temperature alarm driver
Date: Mon, 29 Sep 2014 16:54:25 +0300
Message-ID: <1411998865.5395.5.camel@iivanov-dev>
References: <1411651825-14240-1-git-send-email-iivanov@mm-sol.com>
	 <54254C4E.3070807@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54254C4E.3070807-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kiran Padwal <kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Collins <collinsd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2014-09-26 at 16:51 +0530, Kiran Padwal wrote:
> On Thursday 25 September 2014 07:00 PM, Ivan T. Ivanov wrote:
> > Add support for the temperature alarm peripheral found inside
> > Qualcomm plug-and-play (QPNP) PMIC chips.  The temperature alarm
> > peripheral outputs a pulse on an interrupt line whenever the
> > thermal over temperature stage value changes.  Implement an ISR
> > to manage this interrupt.
> >=20
>=20
> <snip>
>=20
> > + * This function updates the internal temp value based on the
> > + * current thermal stage and threshold as well as the previous sta=
ge
> > + */
> > +static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
> > +{
> > +	unsigned int stage;
> > +	int rc;
> > +	u8 reg;
> > +
> > +	rc =3D qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	stage =3D reg & STATUS_STAGE_MASK;
>=20
> During compilation, getting a waring as below,
>=20
> drivers/thermal/qpnp-temp-alarm.c: In function =E2=80=98qpnp_tm_updat=
e_temp_no_adc=E2=80=99:
> drivers/thermal/qpnp-temp-alarm.c:135:8: warning: =E2=80=98reg=E2=80=99=
 may be used uninitialized in this function [-Wmaybe-uninitialized]
>   stage =3D reg & STATUS_STAGE_MASK;

Could you share compiler version and options which you are using.
I am unable to trigger this warning. Looking code I can not=20
see how this could happen.

>=20
> > +
> > +	if (stage > chip->stage) {
> > +		/* increasing stage, use lower bound */
> > +		chip->temp =3D (stage - 1) * TEMP_STAGE_STEP +
> > +			     chip->thresh * TEMP_THRESH_STEP +
> > +			     TEMP_STAGE_HYSTERESIS + TEMP_THRESH_MIN;
> > +	} else if (stage < chip->stage) {
> > +		/* decreasing stage, use upper bound */
> > +		chip->temp =3D stage * TEMP_STAGE_STEP +
> > +			     chip->thresh * TEMP_THRESH_STEP -
> > +			     TEMP_STAGE_HYSTERESIS + TEMP_THRESH_MIN;
> > +	}
> > +
> > +	chip->stage =3D stage;
> > +
> > +	return 0;
> > +}
> > +
>=20
> <snip>
>=20
> > +
> > +#define QPNP_TM_PM_OPS	(&qpnp_tm_pm_ops)
> > +#else
> > +#define QPNP_TM_PM_OPS	NULL
> > +#endif
> > +
> > +static struct of_device_id qpnp_tm_match_table[] =3D {
>=20
> It must be static const struct of_device_id, because all OF functions=
 handle it as const.

Sure, will fix it.

Thank you,
Ivan

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
