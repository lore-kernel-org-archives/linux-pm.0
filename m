From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 3/3] thermal: allow u8500-thermal driver to be a module
Date: Tue, 9 Feb 2016 14:10:27 -0800
Message-ID: <20160209221026.GD28102@localhost.localdomain>
References: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
 <1453740264-1972562-4-git-send-email-arnd@arndb.de>
 <20160127073300.GJ3368@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35014 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568AbcBIWKa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 17:10:30 -0500
Content-Disposition: inline
In-Reply-To: <20160127073300.GJ3368@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, spear-devel@list.st.com, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2016 at 07:33:00AM +0000, Lee Jones wrote:
> On Mon, 25 Jan 2016, Arnd Bergmann wrote:
>=20
> > When the thermal subsystem is a loadable module, the u8500 driver
> > fails to build:
> >=20
> > drivers/thermal/built-in.o: In function `db8500_thermal_probe':
> > db8500_thermal.c:(.text+0x96c): undefined reference to `thermal_zone_de=
vice_register'
> > drivers/thermal/built-in.o: In function `db8500_thermal_work':
> > db8500_thermal.c:(.text+0xab4): undefined reference to `thermal_zone_de=
vice_update'
> >=20
> > This changes the symbol to a tristate, so Kconfig can track the
> > dependency correctly.
> >=20
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/mfd/db8500-prcmu.c | 3 +++
> >  drivers/thermal/Kconfig    | 4 ++--
> >  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> As this touches a core Thermal file, I think it's better off going in
> via that tree.  If that's a problem, I can take it with the relevant
> Acks.
>=20
> Acked-by: Lee Jones <lee.jones@linaro.org>


Thanks, I am adding to linux-next to see how it goes.



--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWumPQAAoJEMLUO4d9pOJWz4sH/Rjb+aD0dqe1DKOsGE0xD+K3
VCOCW+bFgLa7oKD2G8KGYQDbANUhG702eY80s8TwYFvpp78KAvcYuVwSwXx05pkU
24qr/dWg4j9parZW4Nzbbk9nBbH6gobx3SocGm/WEvyTs0LsA+UBtzFNdTYY5ZQz
Ujy4KOCHHXFVl5yjyHmFdplEaPD/c/QEjhNA1Dmzz4mS5hEgXslnIPk4oZwwTnic
dwEhXIl0xWJY/zSt0rv5gK6DyUqO9d0uIHbLD7cD7ixi0QEBnj24a9BPtiqhsXks
w06TDX2D6cvgEXnhPKr6xcIoWKVLK/AHS2mK7hUUggVYsg06s0aYiqQB0x8bw6w=
=7kl9
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
