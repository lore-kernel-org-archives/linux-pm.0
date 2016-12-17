From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: max77693_charger: Better sysfs creation and using
 devm APIs
Date: Sat, 17 Dec 2016 17:04:46 +0100
Message-ID: <20161217160446.hakmgpqp5hvb6h5k@earth>
References: <1481273498-4957-1-git-send-email-s.ritolia@samsung.com>
 <20161210074854.GB2991@kozik-lap>
 <CADeeJYCSaqW+dayookXKVtWaEKrtHKKixBmXY3gQa86v-s7b8w@mail.gmail.com>
 <20161210195627.GA22744@kozik-lap>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fkrkv5ld7mfi6rv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753384AbcLQQEv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Dec 2016 11:04:51 -0500
Content-Disposition: inline
In-Reply-To: <20161210195627.GA22744@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Srikant Ritolia <srikant.ritolia@gmail.com>, Srikant Ritolia <s.ritolia@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, d.wadhawan@samsung.com, vidushi.koul@samsung.com


--2fkrkv5ld7mfi6rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 10, 2016 at 09:56:27PM +0200, Krzysztof Kozlowski wrote:
> On Sat, Dec 10, 2016 at 07:49:25PM +0530, Srikant Ritolia wrote:
> > On Sat, Dec 10, 2016 at 1:18 PM, Krzysztof Kozlowski <krzk@kernel.org> =
wrote:
> > > On Fri, Dec 09, 2016 at 02:21:38PM +0530, Srikant Ritolia wrote:
>  >
> > >>                                               &max77693_charger_desc,
> > >>                                               &psy_cfg);
> > >>       if (IS_ERR(chg->charger)) {
> > >>               dev_err(&pdev->dev, "failed: power supply register\n");
> > >>               ret =3D PTR_ERR(chg->charger);
> > >> -             goto err;
> > >
> > > Missing sysfs cleanup.
> > >
> > > Best regards,
> > > Krzysztof
> > >
> >=20
> > Thanks for pointing this out.
> > To overcome this I will use sysfs_create_group after devm_power_supply_=
register.
> > Then I would not need to do this sysfs cleanup on failure of power
> > supply register.
>=20
> I am not sure if this is good idea. This patch does not bring any
> particular noticeable benefit except less lines of code. It is not worth
> breaking things just for that reason...

I like less lines of code. How does the changed registration order
break anything? The changed registration order makes sense anyways,
since it then matches the (reversed) removal order.

-- Sebastian

--2fkrkv5ld7mfi6rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVYhwACgkQ2O7X88g7
+pq3+BAAj/bR9UOjhASLzUNEu8gO2peYHmG5ZNGPOBPIY1lpWKhczJYoa6sKfLvr
b6dhNNCPBTHhiogUNq7J8Hg+8XFyBlq4J3a1kKZSKlXpGPRXXi/48r5i4IHC0DIg
gOTXCiLt5V5W2hLascwvk7KuuNu3bDxydm2xwM47PiFX+Z1Orh/eesP8b4atT+7+
ZoAnW5DUh4mSsjvf7MH5/HqD/JnGtiMI52km9fVBdV/GHWxCyI4eHi+JChgLp381
GhkOGrG6EyJgcfNOqV8hwLd85yaOEx5OLo8uIY4PvYxDQRgwhUEeMXfLHv3tQlii
+4w6iN7uL5uydAvM7t5tM5YgCxmnWFYuYR08TPt7mL/rkupW27twyc37pcCIXIZF
2G0bZrPihAkIj3utDLQE4mYBRJzVQPM5SqgNV0daackuypV51Ojs5CoaoRZBb780
TIDk0jMmUojsQCJZ1s0GaYuGNTSpwDrZtB/YLv89hQgJSwtZiQ8gVd4flEfj1rKw
HtvkznR2z2zHd1oc5TmuhyPYrMNRaJymt2fOHgBIepqe5BXVepOtsG5GtNzDn41t
7gZgj5rCLjUsNkgRryV8z5kaootEmXL+zSw3F5OZRNk/6k5a/Db8844OEhvFjljw
Uy0IzZlMtchMHvTRrAIxcnmeSECculOCHUxJK5SR4l9jggpKfko=
=v/7i
-----END PGP SIGNATURE-----

--2fkrkv5ld7mfi6rv--
