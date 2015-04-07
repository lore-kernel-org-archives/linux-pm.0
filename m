From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 04/13] thermal: Fix not emulating critical temperatures
Date: Mon, 6 Apr 2015 19:08:30 -0700
Message-ID: <20150407020829.GD4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-5-git-send-email-s.hauer@pengutronix.de>
 <CADGdYn5vaPu4+yhjs5c3QuCnz-LtL2Z2qRENjsizpO6D1gVOSg@mail.gmail.com>
 <20150327052318.GO9742@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35946 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbbDGCIX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 22:08:23 -0400
Content-Disposition: inline
In-Reply-To: <20150327052318.GO9742@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: amit daniel kachhap <amit.daniel@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, LAK <linux-arm-kernel@lists.infradead.org>


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2015 at 06:23:18AM +0100, Sascha Hauer wrote:
> Hi Amit,
>=20
> On Fri, Mar 27, 2015 at 08:35:50AM +0530, amit daniel kachhap wrote:
> > Hi Sascha,
> >=20
> > > -#ifdef CONFIG_THERMAL_EMULATION
> > > -       if (!tz->emul_temperature)
> > > -               goto skip_emul;
> > > -
> > > -       for (count =3D 0; count < tz->trips; count++) {
> > > -               ret =3D tz->ops->get_trip_type(tz, count, &type);
> > > -               if (!ret && type =3D=3D THERMAL_TRIP_CRITICAL) {
> > > -                       ret =3D tz->ops->get_trip_temp(tz, count, &cr=
it_temp);
> > > -                       break;
> > > -               }
> > > -       }
> > > -
> > > -       if (ret)
> > > -               goto skip_emul;
> > >
> > > -       if (*temp < crit_temp)
> > I guess this check is confusing. Actually instead of returning
> > emulating temperature it is returning actual temperature. But the
> > important thing to look here is that actual temperature is higher than
> > critical temperature. So this check prevents the user from suppressing
> > the critical temperature and hence prevents from burning up the chip.
>=20
> Indeed the check is confusing, but now it makes perfectly sense. I'll
> look at the patch again and maybe turn into a patch just adding a
> comment to clarify this.

That will be great. Thanks Sascha.

>=20
> Sascha
>=20
> --=20
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVIzwYAAoJEMLUO4d9pOJW0/oH/36cxmH1HKxZFDpda/YQmmHH
PV/y5NEKAMvY+X1kjw+l68YLiIUfwUgmHkrnd4WFuMTr8QoqFk7PCrvYiFJO5WwX
ridmdrORlizS7g5WAgOXrqqSxNXC16nkNwQ9BeRLJvGLMb9jhmqRdVO+gy6hjoCQ
+5TWAgxTkNpZhD1bMzumwXFQ1WnxbnPsXeAtWrT5wa0/bOvN7qyp+4SH+tbHbB6P
9BC5yykMyXSt3lBQqGchjV4MaQwF0tlh0TcMta4UOAC/oxvQdK/Hg7O06y/Cd5IA
iXx2uUDPcP+Jl0MvxH9fw88YW2//8DNnxquWX/YlHgeR83yPPhJhJTRFXTEL7j8=
=SmFu
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
