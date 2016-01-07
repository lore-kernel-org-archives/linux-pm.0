From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Thu, 07 Jan 2016 15:12:00 +0200
Message-ID: <1452172320.30729.409.camel@linux.intel.com>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160107130743.GA9935@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:28504 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbcAGNLh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Jan 2016 08:11:37 -0500
In-Reply-To: <20160107130743.GA9935@kuha.fi.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Thu, 2016-01-07 at 15:07 +0200, Heikki Krogerus wrote:
> On Thu, Jan 07, 2016 at 02:06:01PM +0200, Andy Shevchenko wrote:
> > > From time to time we have to match a string in an array. Make a
> > > simple helper
> > for that purpose.
>=20
> Cool! If you make v2 out of these, could you patch the following
> while
> at it:

Yes, please, format as a usual patch and share with me. I will include
in v3 (actually I missed the numbering here, it should be v2 already).

>=20
> diff --git a/drivers/usb/common/common.c
> b/drivers/usb/common/common.c
> index e6ec125..a391c81 100644
> --- a/drivers/usb/common/common.c
> +++ b/drivers/usb/common/common.c
> @@ -64,18 +64,15 @@ EXPORT_SYMBOL_GPL(usb_speed_string);
> =C2=A0enum usb_device_speed usb_get_maximum_speed(struct device *dev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *maximum_s=
peed;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D device_property_re=
ad_string(dev, "maximum-speed",
> &maximum_speed);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D device_property_re=
ad_string(dev, "maximum-speed",
> &maximum_speed);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return USB_SPEED_UNKNOWN;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < ARRAY_SI=
ZE(speed_names); i++)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (strcmp(maximum_speed, speed_names[i]) =3D=3D 0=
)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0re=
turn i;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D match_string(speed=
_names, ARRAY_SIZE(speed_names),
> maximum_speed);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return USB_SPEED_UNKNOWN;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (ret < 0) ? USB_SPE=
ED_UNKNOWN : ret;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(usb_get_maximum_speed);
> =C2=A0
> @@ -109,13 +106,11 @@ static const char *const usb_dr_modes[] =3D {
> =C2=A0
> =C2=A0static enum usb_dr_mode usb_get_dr_mode_from_string(const char =
*str)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < ARRAY_SI=
ZE(usb_dr_modes); i++)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!strcmp(usb_dr_modes[i], str))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0re=
turn i;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D match_string(usb_d=
r_modes, ARRAY_SIZE(usb_dr_modes),
> str);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return USB_DR_MODE_UNKNOWN=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (ret < 0) ? USB_DR_=
MODE_UNKNOWN : ret;
> =C2=A0}
> =C2=A0
> =C2=A0enum usb_dr_mode usb_get_dr_mode(struct device *dev)
>=20
>=20
> Thanks,
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

