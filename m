From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v10 8/8] power: bq27xxx_battery_i2c: Add I2C bulk
 read/write functions
Date: Thu, 16 Mar 2017 00:03:59 +0100
Message-ID: <20170315230359.xvrvlcrjs3p6apjc@earth>
References: <20170315192653.26799-1-liam@networkimprov.net>
 <20170315192653.26799-9-liam@networkimprov.net>
 <20170315221414.mcig3c6bp44bitcu@earth>
 <CAKvHMgSuvFjD39nv9cfkEs4U+79F=K_DBuBPcAqqvDejszeGfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="imxuhosxz5wukxdo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752035AbdCOXEQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 19:04:16 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgSuvFjD39nv9cfkEs4U+79F=K_DBuBPcAqqvDejszeGfQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>


--imxuhosxz5wukxdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2017 at 03:34:23PM -0700, Liam Breck wrote:
> On Wed, Mar 15, 2017 at 3:14 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Wed, Mar 15, 2017 at 12:26:53PM -0700, Liam Breck wrote:
> >> From: Matt Ranostay <matt@ranostay.consulting>
> >>
> >> write(), read_bulk(), write_bulk() are required by bq27xxx_battery
> >> power_supply_battery_info code.
> >>
> >> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> >
> > This is required by the previous patch, so your order is not bisect
> > safe. Please just merge it with Patch 5.
>=20
> It is bisect-safe; bq27xxx_battery only uses the functions if available.

ok.

> Patch 5 could be merged with 7. But the I2C implementation should be
> separate from the header.

Please at least move the patches together.

-- Sebastian

--imxuhosxz5wukxdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJyF8ACgkQ2O7X88g7
+ppP5g//Xr0qdqc2lXOW3I/tLHuKI/7MS4m6w1AqtiFI+9Q/nxRkukQtu7K+7lnu
Hcr6Uc+q55k39QOxjo1uLHvo8jBww9KLfO7YNI/UA/h92OaILqMQtie9KyUQBWFY
P/LRqZoIEgMyqPAs8egLumnmkQNqsZapiou1ZKbbmUIN9HG76W/sSWqLlUzJpqPo
+D9HCE9ywMdZrDLd58WbQnzLB35WjL5RYGjMJBkOCVJW4P3ocQp7eK/C35/brVl8
BAEc/f+Tl8JE1l1HXk2F43amIAlJDGg4aPdaNsylVYZjJVYNR09wHmvsXpf+IuDF
eri8VS5Sa0JAgWbUlAm9V84MZYW7rKZ/j3/GCS5JeHQs79LbbvcRBRlPJmzgtc4Z
s3VFUF7euDyzdHDzN7wQIaxETyDiRv9ZI+rFOgFEz5a+VnJRqExuwKUhnwglVwmx
Oo/PVD7IVe/HyeX54D2JH5aDNaRc2zG3XnSzChNyhdiGaDgDmFGnPDMDm81vC4vH
Jkwp1yc3mn9R6Gbb3c+VT7HC7G1ksRTk+ABgK1fr5P2oLkLcnwEgJNhxEVwQBHbl
Ox18jDa2+vq54ZLFmdgy2YNnNadekBI4l/7Yj/zi6MIIIzg9YO2oKfqkOvUoPUFO
b7exY9VsjGVt1Swjy0jIPo2lAyStuaMFIAuLAqbtQOMdaaoX3mg=
=yo/e
-----END PGP SIGNATURE-----

--imxuhosxz5wukxdo--
