From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 1/4] thermal: Add driver for Armada 370/XP SoC thermal
 management
Date: Tue, 26 Mar 2013 05:59:25 -0300
Message-ID: <20130326085924.GA2454@localhost>
References: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364225229-2857-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <4D68720C2E767A4AA6A8796D42C8EB59C587D8@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50896 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400Ab3CZI7b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Mar 2013 04:59:31 -0400
Content-Disposition: inline
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59C587D8@BGSMSX101.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, "Zhang, Rui" <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>

Hi Durgadoss,

On Mon, Mar 25, 2013 at 05:27:24PM +0000, R, Durgadoss wrote:
[...]
> > +static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
> > +{
> > +	unsigned long reg;
> > +
> > +	/* ??? */
> > +	reg =3D readl_relaxed(priv->control);
> > +	reg |=3D PMU_TDC0_OTF_CAL_MASK;
> > +	writel(reg, priv->control);
> > +
> > +	/* Reference calibration value */
> > +	reg &=3D ~PMU_TDC0_REF_CAL_CNT_MASK;
> > +	reg |=3D (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
> > +	writel(reg, priv->control);
>=20
> I see these two blocks of code being the same for the below
> function as well. Any specific reason for not making this block=20
> as a common function and calling it from both the=20
> _init_sensor functions ?
>=20

I think it's more clear if we define one init_sensor function per SoC.
The common code is really little and factor that out seems to me like
too much modularization.

> > +
> > +	/* Reset the sensor */
> > +	reg =3D readl_relaxed(priv->control);
> > +	writel((reg | PMU_TDC0_SW_RST_MASK), priv->control);
> > +
> > +	writel(reg, priv->control);
> > +
> > +	/* Enable the sensor */
> > +	reg =3D readl_relaxed(priv->sensor);
> > +	reg &=3D ~PMU_TM_DISABLE_MASK;
> > +	writel(reg, priv->sensor);
> > +}
> > +
> > +static void armada370_init_sensor(struct armada_thermal_priv *priv=
)
> > +{
> > +	unsigned long reg;
> > +
> > +	/* ??? */
> > +	reg =3D readl_relaxed(priv->control);
> > +	reg |=3D PMU_TDC0_OTF_CAL_MASK;
> > +	writel(reg, priv->control);
> > +
> > +	/* Reference calibration value */
> > +	reg &=3D ~PMU_TDC0_REF_CAL_CNT_MASK;
> > +	reg |=3D (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
> > +	writel(reg, priv->control);
> > +
> > +	/* ??? */
> > +	reg &=3D ~PMU_TDC0_START_CAL_MASK;
> > +	writel(reg, priv->control);
> > +
> > +	/* FIXME: Why do we need this delay? */
> > +	mdelay(10);
> > +}
> > +
> > +static bool armada_is_valid(struct armada_thermal_priv *priv)
> > +{
> > +	unsigned long reg =3D readl_relaxed(priv->sensor);
> > +
> > +	return (reg >> THERMAL_VALID_OFFSET) & THERMAL_VALID_MASK;
> > +}
> > +
> > +static int armada_get_temp(struct thermal_zone_device *thermal,
> > +			  unsigned long *temp)
> > +{
> > +	struct armada_thermal_priv *priv =3D thermal->devdata;
> > +	unsigned long reg;
> > +
> > +	/* Valid check */
> > +	if (priv->ops->is_valid && !priv->ops->is_valid(priv)) {
> > +		dev_err(&thermal->device,
> > +			"Temperature sensor reading not valid\n");
> > +		return -EIO;
> > +	}
> > +
> > +	reg =3D (readl_relaxed(priv->sensor) >> THERMAL_TEMP_OFFSET) &
>=20
> Can we have the readl_relaxed call as a separate statement ?
>=20

Why would we want that? Do you think it'll be more readable?

> > +		THERMAL_TEMP_MASK;
> > +	*temp =3D (3153000000UL - (10000000UL*reg)) / 13825;
>=20
> If I substitute 1 for 'reg' I get  227341.7721...=20
> Does this mean the temperature is 227 C ??
>=20

Yes, I guess so.

> If you have the info, can you add a comment on what is the
> valid range that 'reg' can take ?
>

No, I don't have the info. I guess that the valid range 'reg'
can take are the values that span a temperature between 25 =C2=BAC (or
lower if it's winter) and when your CPU is on fire :-)

> Also, Is the resulting temperature
> in MillidegreeCelsius ? If so, please add a comment saying so.
>=20

Yes, the resulting temperature is in millidegree celsius,
as required by the thermal framework:

Documentation/thermal/sysfs-api.txt

Thanks for the review!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
