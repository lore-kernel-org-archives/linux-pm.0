From: Sebastian Reichel <sre@kernel.org>
Subject: Re: low capacity signalling
Date: Thu, 11 May 2017 23:10:36 +0200
Message-ID: <20170511211036.iyjgzld4aqxvtkvt@earth>
References: <CANMsd00fsbaDwZkBVGcigPfdyOhP-F2Y3Q0ggCqS+pFy6+iy9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rh6lad4zsgiy5mxi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752657AbdEKVUX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 May 2017 17:20:23 -0400
Content-Disposition: inline
In-Reply-To: <CANMsd00fsbaDwZkBVGcigPfdyOhP-F2Y3Q0ggCqS+pFy6+iy9Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: linux-pm@vger.kernel.org


--rh6lad4zsgiy5mxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Thu, May 11, 2017 at 08:55:21PM +0530, Ryan wrote:
> I want to write a Linux Application which shutdowns the system
> using poweroff command when the battery capacity is around 10%.
>=20
> How can the battery monitor chip signal to the application.
>=20
> I want to avoid polling. How can a driver implement such a feature
> in an optimised way.

If you listen to uevent messages from the battery you can avoid
polling. Events will be sent when the driver calls power_supply_changed().

-- Sebastian

--rh6lad4zsgiy5mxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkU00kACgkQ2O7X88g7
+pq9AQ//SVlHL6xr3da/WU/OqB4IZCTpYajNWuHcBSk5Nr0TbLFhKRYvD4xN/zsC
t2Ob7Kev9jkMM9deLu4GEFt1swdfpZH6ldqZW5XOl0R3tNj+TU++y3KAybq4umMN
0sIS0pFZSKIFX+xzvvb2TtMBxOLjmygob9yse0UOHPOdJD9op1Qcs2nGBNwjW9lU
BSyff/hEDIuedIvJkd2P+CDKkwMMnQ8qTHEI+iczmNfy/zfyd6Z3dipGonlLNwx8
HeGKex3Cg0a7c4pUBghP5Tw3POx5woWOxdkmjW87e5E1axzXnTeaw+1k7HGOIZ3I
bF+5ouSApfsW7RxGLu2LosSK3hR+Pik/G6EtQ7UmuaAYpEsSinTTRJqFBWuSv8vc
cqXIMUSjb+LpESpa3FQqfm6XmQvSeXCBX2OWLpbqTzOIdli3dV5rdDAuvtsGHBXO
CGBEOl2F5T0jkH3VL9dxyjRPKtZL/dc8O5DqXKCR8ZktU4TOPTiLeEboBWf78GDw
brPWxuV217l4OmeNjPFGMT3n1FUjKnAqKCBal9E0NOhUeswbJQJMPywVhq8dmTJV
4I0x4/WIUfe5s/oD5Wz0k3a6D/4QmW8YtjhoC5UK7ihznifwhm0tOjq9wkq5Meig
vB0MZtXjatYXVosknwWR2jyo/33X4x3JeQSrioOJZK44DzAP6Do=
=fsdT
-----END PGP SIGNATURE-----

--rh6lad4zsgiy5mxi--
