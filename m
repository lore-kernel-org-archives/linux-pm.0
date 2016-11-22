From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/5] power: supply: tps65217: Move IRQ related operation
 into single function
Date: Tue, 22 Nov 2016 17:56:06 +0100
Message-ID: <20161122165606.jwx5he6tbnv2y7ad@earth>
References: <20161115131855.4175-1-woogyom.kim@gmail.com>
 <20161115131855.4175-2-woogyom.kim@gmail.com>
 <20161122164911.mz3igcnpps5bcjdn@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwjka3r6al6sw7nr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753149AbcKVQ4L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 11:56:11 -0500
Content-Disposition: inline
In-Reply-To: <20161122164911.mz3igcnpps5bcjdn@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--pwjka3r6al6sw7nr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 22, 2016 at 05:49:11PM +0100, Sebastian Reichel wrote:
> On Tue, Nov 15, 2016 at 10:18:51PM +0900, Milo Kim wrote:
> > TPS65217 charger driver handles the charger interrupt through the IRQ or
> > polling. Both cases can be requested in single function.
> >=20
> > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> > ---
> >  drivers/power/supply/tps65217_charger.c | 70 ++++++++++++++++++-------=
--------
> >  1 file changed, 38 insertions(+), 32 deletions(-)
>=20
> I don't see the advantage of this. It's more lines of codes than
> before and does not really increase readability.

Ok it makes sense with changes from PATCH 3. Please add a note to
the commit description, that this prep-work for introducing more
irqs.

-- Sebastian

--pwjka3r6al6sw7nr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg0eKYACgkQ2O7X88g7
+pprKA/+PwhxX4m9VNpkIN5sEMuxAVhvudd2v9Ij9xcpwlsUSWmbqd0eUa4g40fY
JHva9CEf1vVzy0acHKHXj4kG20bWJ958LMp2SFoo1KpSJ+P/2eCum+LzYyiWbDdV
+zattHTq0mMQzz0LOD1WIuFObthNNkzWIy1PiW4L50845A6yjN6MYKD4IV2iVkUK
HYWiAHmM19sbFSoHe7JcZutND0t2L+fKRQjtBdswWcM/jn9ifcTbKtGNTQTkKGLv
DLP29yXEzq2BQD3td8piPiL59/818MOsYhBzY8fppPFeqT/OgxfMBpGJ3Gz4GgYu
RoQvTetSTMR18t0BMFjBMpdBc2DRO6FnNR0h/djYOv/AxHCsKgFMGXG+uI3wo4/T
Q5QlRlIUTPJ/rf813TiaI8Yvv/+8Kh2XihobjSOhOqUROG02lzSoRxeLZTWZHDff
lyTSO0c38dPvdfpPircNZVZyRbyaTgZfJL4KFCmzc4lorQh0OiFQ1ImQtDsYODrt
eE5hl7Q/Sa1LKyAy9XZP5qnUVOgjmroNvn0OAMLpAu9Zdd6yRQY/ak10XFEv7CiR
ooiXpGYN0PkuZQ2lmtrMZZ0D7ClZaYVgutPdwqZ8WdEW3IHLOEnpPZzcedfeYWta
HB1aYrVKDfgUYcls5ldzlCdm1cxTOdk0UFmwz9982rNzAMll+cg=
=gw8i
-----END PGP SIGNATURE-----

--pwjka3r6al6sw7nr--
