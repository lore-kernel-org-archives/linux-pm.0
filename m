From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: axp288_charger: Fix unchecked return value
Date: Fri, 5 Apr 2019 16:04:16 +0200
Message-ID: <20190405140416.5drwsaciiipaa626@earth.universe>
References: <20190318161439.GA6245@embeddedor>
 <e42cdec8-911d-950a-8b06-3b1aefaba74c@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v4x564h5nq5jwjac"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e42cdec8-911d-950a-8b06-3b1aefaba74c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Chen-Yu Tsai <wens@csie.org>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--v4x564h5nq5jwjac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 18, 2019 at 06:32:35PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 18-03-19 17:14, Gustavo A. R. Silva wrote:
> > Currently there is no check on platform_get_irq() return value
> > in case it fails, hence never actually reporting any errors and
> > causing unexpected behavior when using such value as argument
> > for function regmap_irq_get_virq().
> >=20
> > Fix this by adding a proper check, a message reporting any errors
> > and returning *pirq*
> >=20
> > Addresses-Coverity-ID: 1443940 ("Improper use of negative value")
> > Fixes: 843735b788a4 ("power: axp288_charger: axp288 charger driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >   drivers/power/supply/axp288_charger.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supp=
ly/axp288_charger.c
> > index f8c6da9277b3..00b961890a38 100644
> > --- a/drivers/power/supply/axp288_charger.c
> > +++ b/drivers/power/supply/axp288_charger.c
> > @@ -833,6 +833,10 @@ static int axp288_charger_probe(struct platform_de=
vice *pdev)
> >   	/* Register charger interrupts */
> >   	for (i =3D 0; i < CHRG_INTR_END; i++) {
> >   		pirq =3D platform_get_irq(info->pdev, i);
> > +		if (pirq < 0) {
> > +			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
> > +			return pirq;
> > +		}
> >   		info->irq[i] =3D regmap_irq_get_virq(info->regmap_irqc, pirq);
> >   		if (info->irq[i] < 0) {
> >   			dev_warn(&info->pdev->dev,
> >=20
>=20
> Patch looks good to me:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

--v4x564h5nq5jwjac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynYGAACgkQ2O7X88g7
+pq8vA//eN4OarDl2zaxXoMbmcPg6MH8MglCdNeKSv17IjTlOmB0gqHWPL70L7VQ
0MQrw6xh6NAqpI7toux3uzNycRgddQBTV9WyDs6Ry8b7xrcV9QhweECuFOqypwJe
RQmn+zkHgl84O4UC5DR3mVnHpxVTryZ1wpL7mVxJIQuQki1tDJDcsSepniyBb70Y
1enxIVp/CXD5haKmXDHbVKn055RBye5aRa+iIgN/ng7ecJ0xBp4owqj1UU31i0MX
6Y+9F3j6+i9bKrLVjWzl1MQwnK0s1AE+XXy1jD05Pke5c6ffE012+683R4CWlugv
npaTgdfiEJvIYfFjW8zp+FJRSjxPgLxfPocv1c74ajIWjzmcHeKOhMvsSLtO5wfz
6XAQdWOIQiKVlyvhk8zkC9rkHJ2jvVYs0Nte9U0HCoGCGJ5SjW3QHFA8mX5pX2NH
SVyr3gOgVw2r1aIAW8+QZqawQ9TOcXuIKk9fjH/WwFR9yHy7Ozn42hgdJ/LnQtHP
5OKnwqKp9LWqffTj2Yt3w+dkhJcgHlPadidSetpATUt2JumfEBSYgL3s65jlF1m9
6taemwpXLHFoLvakJMM+iBjzhaPnrV/k6Rbx8c/uG8WFg0fQb0UZJVaU+2awrqmy
YTtHYPuYguprytU/Wy0repRDfeTE3pYEJcBp+MwHRcKsMphu/j8=
=QiiC
-----END PGP SIGNATURE-----

--v4x564h5nq5jwjac--
