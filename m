From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 8/8] power: bq27xxx_battery: Cleanup health checking
Date: Thu, 23 Jul 2015 10:06:33 -0700
Message-ID: <1437671193.26573.10.camel@perches.com>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
	 <1437601920-13045-9-git-send-email-afd@ti.com>
	 <20150723162212.GI29125@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150723162212.GI29125@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2015-07-23 at 18:22 +0200, Pali Roh=E1r wrote:
> On Wednesday 22 July 2015 16:52:00 Andrew F. Davis wrote:
> > Reorganize the logic checking battery health and under temperature
> > condition checking.
[]
> > diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xx=
x_battery.c
[]
> > @@ -624,10 +626,34 @@ static int bq27xxx_battery_read_pwr_avg(struc=
t bq27xxx_device_info *di)
> >   */
> >  static int bq27xxx_battery_overtemp(struct bq27xxx_device_info *di=
, u16 flags)
> >  {
> > -	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27541)
> > +	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27541 || di->chi=
p =3D=3D BQ27545)
> >  		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
> > +	if (di->chip =3D=3D BQ27530 || di->chip =3D=3D BQ27421)
> > +		return flags & BQ27XXX_FLAG_OT;
> > +
> > +	return false;

Maybe this int function should be bool or return 0
instead of false.

> > +static int bq27xxx_battery_undertemp(struct bq27xxx_device_info *d=
i, u16 flags)
> > +{
> > +	if (di->chip =3D=3D BQ27530 || di->chip =3D=3D BQ27421)
> > +			return flags & BQ27XXX_FLAG_UT;
> > +
> > +	return false;
> > +}

Here too

> > +
> > +/*
> > + * Returns true if a low state of charge condition is detected
> > + */
> > +static int bq27xxx_battery_dead(struct bq27xxx_device_info *di, u1=
6 flags)
> > +{
> > +	if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010)
> > +		return flags & (BQ27000_FLAG_EDV1 | BQ27000_FLAG_EDVF);
> >  	else
> > -		return flags & BQ27XXX_FLAG_OTC;
> > +		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
> >  }

and here
