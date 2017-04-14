From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V5 2/2] thermal: broadcom: add Northstar thermal driver
Date: Fri, 14 Apr 2017 08:16:16 -0700
Message-ID: <20170414151613.GA24429@localhost.localdomain>
References: <20170331201124.656-1-zajec5@gmail.com>
 <20170403154829.29780-1-zajec5@gmail.com>
 <20170403154829.29780-2-zajec5@gmail.com>
 <20170407044218.GA12447@localhost.localdomain>
 <6dd2617d-a8a8-d7a4-53a4-7ebcb274573c@milecki.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33901 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbdDNPQV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 11:16:21 -0400
Content-Disposition: inline
In-Reply-To: <6dd2617d-a8a8-d7a4-53a4-7ebcb274573c@milecki.pl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Jon Mason <jon.mason@broadcom.com>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rafal,

On Fri, Apr 14, 2017 at 02:16:36PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 04/07/2017 06:42 AM, Eduardo Valentin wrote:
> >On Mon, Apr 03, 2017 at 05:48:29PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> >>From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >>
> >>Northstar is a SoC family commonly used in home routers. This commit
> >>adds a driver for checking CPU temperature. As Northstar Plus seems to
> >>also have this IP block this new symbol gets ARCH_BCM_IPROC dependency.
> >>
> >>Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >>Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> >
> >If no objection, I am applying this series.
>=20
> Cool, hopefully there aren't any more objections :) Once applied should I
> expect this in
> https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-therma=
l.git/log/?h=3Dnext
> ?

They were already applied, but in my #linus branch. Now they are also in
my #next branch. The #linus branch goes to the coming merge window. The
#next branch goes to linux-next testing. Your change is now on
linux-next test, kernelci testing, and for the coming merge windown.

>=20
> That would allow me to move bcm2835_thermal.c to the broadcom subdir.
>=20
>=20

Please send the patch.

> >>+const struct thermal_zone_of_device_ops ns_thermal_ops =3D {
> >
> >minor correction here:
> >
> >-const struct thermal_zone_of_device_ops ns_thermal_ops =3D {
> >+static const struct thermal_zone_of_device_ops ns_thermal_ops =3D {
> >
> >but I am applying this already in my tree.
> >
> >>+	.get_temp =3D ns_thermal_get_temp,
> >>+};
>=20
> Thank you!

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY8Oe3AAoJEA6VkvSQfF5T5RMQALczUcIjwYZV6Zwvdpvukovq
tw2ZDDnUTvfwuaOUv7WqKCovIGvVb2cATaDfZwZlcCO6yQM4s0N1pQ6kmVR23V7Q
XmMXbKaKoE7H1M/saUGdnYixmumsxmP1KGXPykC/28qPVWDWRe80qxfMEgHpkzgo
bKKc0DhPsNuOQET04VMpTGLENygbooo1WYF84cq/+W+wUzQqO3oDZtty/30kLWwe
prnjDvNLO2OXkYklY0lqlb/oisdEN2nOQ74hG8V3x0yLJh0aj80Zem8CpAKVr0v9
2oxSUjouLZ42EG2hFGx6c6+dDY3lRZj19l5LmwQ6mC2omfoG/zIVQkAYLcmHHHJc
x3DGChB+2fL7FC6m6iMGE7ftgHIrUcF3vHTPdvwg0mqSsIq1V8VpFb965ykS/IZ8
eqRV9xkbwZbBMp0Kx0fxtOYmhe1Q9By3V/79oMC7UmB6oJUXJE7ufoKmlFpoJEwF
XLfpnyjw3BaSRCCJIcaDxTv33Pe0vSOblILziA7WIOi2cN13x3TRRlK5Af1Zt8DZ
2ttM2CzYfmnOaZxQCwlQazm4ePS+D1cB1/GjSPqr65h9UslHs8JRoVADJatwzUr/
BUUn4hJUthl9wwTjO29PVmhaUOQzMtC6MBVIps1Ek3KE4j95Jck4/cKveTx89Tg5
y9a35hIHgfKYHb5m3EGh
=R456
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
