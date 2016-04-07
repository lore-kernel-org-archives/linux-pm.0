From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v9 2/4] gadget: Support for the usb charger framework
Date: Thu, 07 Apr 2016 07:58:46 +0300
Message-ID: <878u0q10c9.fsf@intel.com>
References: <cover.1459494743.git.baolin.wang@linaro.org> <13c2f4fb71958bf9a5527acbed8b8b60dc569656.1459494744.git.baolin.wang@linaro.org> <20160406071956.GA21101@shlinux2.ap.freescale.net> <CAMz4kuJkf0Q1JKdc5W8EcDBvr6MccTcdZa-Pse_Z4pFwySTSDA@mail.gmail.com> <AM4PR04MB2130F58AA1018FFD367C89E0899F0@AM4PR04MB2130.eurprd04.prod.outlook.com> <871t6j2ai2.fsf@intel.com> <AM4PR04MB213054CF3F597CE2E6FE976F899F0@AM4PR04MB2130.eurprd04.prod.outlook.com> <87oa9m28x0.fsf@intel.com> <AM4PR04MB2130E03385128C1CD22553E7899F0@AM4PR04MB2130.eurprd04.prod.outlook.com> <87egai261g.fsf@intel.com> <20160407030350.GB10672@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56790 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbcDGFAp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Apr 2016 01:00:45 -0400
In-Reply-To: <20160407030350.GB10672@shlinux2.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Jun Li <jun.li@nxp.com>, Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen@gmail.com> writes:
>> >> > In below change of usb_gadget_vbus_draw(), already can get charger
>> >> > type via usb_charger_get_type().
>> >> >
>> >> > static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget,
>> >> > unsigned mA)  {
>> >> > +       enum usb_charger_type type;
>> >> > +
>> >> > +       if (gadget->charger) {
>> >> > +               type =3D usb_charger_get_type(gadget->charger);
>> >> > +               usb_charger_set_cur_limit_by_type(gadget->charger, =
type,
>> >> mA);
>> >> > +       }
>> >> > +
>> >> >         if (!gadget->ops->vbus_draw)
>> >> >                 return -EOPNOTSUPP;
>> >> >         return gadget->ops->vbus_draw(gadget, mA);
>> >> >
>> >> > Could you detail in what situation gadget->ops-> get_charger_type()=
 is
>> >> used?
>> >>=20
>> >> isn't it right there in the code ? Isn't usb_gadget_vbus_draw() calli=
ng
>> >> it ? What did I miss here ?
>> >
>> > Well, that's true, so my real meaning is why gadget need get charger t=
ype
>> > via another new api gadget->ops->get_charger_type().
>>=20
>> because of semantics. usb_gadget_vbus_draw() is *only* supposed to
>> connect a load across vbus and gnd so some battery can be charged. Also,
>> we need to abstract away this ->get_charger_type() operation because it
>> might be different for each UDC.
>
> In this patch set, there are two ->get_charger_type in below two
> structures, as my understanding, get_charger_type at struct usb_charger
> can be implemented at UDC drivers; But I don't see necessary we
> need to implement get_charger_type for usb_gadget_ops at UDC drivers
> again. What do you think?

I had missed that completely, nice catch. I agree with you, there should
be one place where this is implemented and struct usb_charger sounds
like it is that place.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBekHAAoJEIaOsuA1yqREhTcP/0Xk/dMd66DA8k9VrhBo9uNV
sD/o/RaW10oYi7zvnVVDY3NJC4eNSJdPckmdQ+EobqKJvjir4xO9nUrRJnlp7CuJ
NvKUUXcVGnhT5yfD4Y+nFy8IEgLVzYYYLNBKI7e9lBRG/7IFlvaSz18J2yWeOLiM
ytLO/Wu8qOGWjUtMSVEKbR8DVLqyQsEn/ZPbbKshdvcI0BDdN7b4b/u5ztGDCrhM
d0SxwuNoH1OgOOP+3Ds83dX10f12jv+G2ZqDsmOAzAONyyGO1EVnKpVy4MOt8Fpd
l2Y0M/y+8SvtUZR+uFWUKOGaQao1SQY7poq0G0s1km9bWf/Sbaux3QfIiePjkyU/
YhQSuUZs5xRvIubEpha2aPijjvM6s2tWEX9qUHvBuNzbySMSf0FtYcfX2Mpi1fto
wHRcdqAoBperMhgNY3slmTuZbqCfSY/hNT5PuQ4UBZbXxGHPp8n/VvqARwTTm3AH
+WfRoM6CGQzQdUQd4pna7eQ11PXW0Fyot+9WsQ3+2zvytUIZAcIbRdprv6CUpnax
Nt9X5EpKYr04JpFT3KsIfJHi1ljGA4jsagfIcfM960gpVDpfgvbSWrjO8PGGn6Bb
YXkve7AbMaPYK6lOMqiUe9lM9fWhkuGOfr3gaMBJxfD1y5utnC4B2OiCfdb581ZT
3UmShVSCLxrmctxj5qh+
=aSUB
-----END PGP SIGNATURE-----
--=-=-=--
