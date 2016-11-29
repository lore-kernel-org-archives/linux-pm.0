From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v3 2/4] thermal: rcar_gen3_thermal: Add R-Car Gen3
 thermal driver
Date: Tue, 29 Nov 2016 19:55:13 +0100
Message-ID: <20161129185513.GB3378@katana>
References: <20161128210924.2921-1-wsa+renesas@sang-engineering.com>
 <20161128210924.2921-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdW=Ap6ENtN0_Q=MHkhGLy0WuJUPtdb7n34yNAw1rXR4Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW=Ap6ENtN0_Q=MHkhGLy0WuJUPtdb7n34yNAw1rXR4Fw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>
List-Id: linux-pm@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

thanks for the prompt review!

> > +/* Structure for thermal temperature calculation */
> > +struct equation_coefs {
> > +       long a1;
> > +       long b1;
> > +       long a2;
> > +       long b2;
>=20
> Why long? Long has a different size for 32-bit and 64-bit platforms.
> I know this is a driver for arm64, but if you need 64-bits, you want to m=
ake
> this clear using s64, or long long.

I'll check if int will do.

> > +static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_ts=
c *tsc,
> > +                                    u32 reg, u32 data)
> > +{
> > +       iowrite32(data, tsc->base + reg);
> > +}
>=20
> ... so using the "convenience" wrappers is more (typing) work than using
> io{read,write}32() directly?

TBH I don't favor such macros, but since they are in quite some Renesas
drivers, I kept them in the first take for consistency reasons.

> > +       tj_2 =3D (CODETSD((ptat[1] - ptat[2]) * 137)
> > +               / (ptat[0] - ptat[2])) - CODETSD(41);
>=20
> Isn't "* 1000" easier to read then CODETSD()?

Probably. I'd think there can be done even more to make this code a tad
more readable. For the first take, I'd like to keep these formulas,
though. They come from the BSP and are the only documentation about how
to calculate the temperature which we currently have. Changing them
will obsolete all the testing done so far.


> > +       /* calculate coefficients for linear equation */
> > +       a1_num =3D CODETSD(thcode[1] - thcode[2]);
> > +       a1_den =3D tj_2 - TJ_3;
> > +       a1 =3D (10000 * a1_num) / a1_den;
> > +       b1 =3D (10000 * thcode[2]) - ((a1 * TJ_3) / 1000);
>=20
> Rounding needed for / 1000?

Ditto.

> > +static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> > +{
> > +       struct rcar_gen3_thermal_priv *priv;
> > +       struct device *dev =3D &pdev->dev;
> > +       struct resource *res;
> > +       struct thermal_zone_device *zone;
> > +       int ret, i;
>=20
> unsigned int i;

I'll likely produce more bugs if 'i' is not an int ;)

>=20
> > +       const struct rcar_gen3_thermal_data *match_data =3D of_device_g=
et_match_data(dev);
> > +
> > +       /* default values if FUSEs are missing */
> > +       int ptat[3] =3D { 2351, 1509, 435 };
>=20
> unsigned?
>=20
> > +       int thcode[TSC_MAX_NUM][3] =3D {
>=20
> unsigned?

Had that before, didn't work. Since the calculation involves
substraction with other ints, I prefer to have them all the same type as
the fix.

> > +               tsc =3D devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
> > +               if (!tsc)
> > +                       return -ENOMEM;
>=20
> Missing pm_runtime_put() etc.?
>=20
> ret =3D -ENOMEM;
> goto error_unregister;

Yes!

Regards,

   Wolfram


--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPc8RAAoJEBQN5MwUoCm2B+IQALLQ8iKaP4/EgZz6eD3qINHb
jrVHQn18o+vGqYrzugFkJCv8uTrjKCs3IV+qUuJl/kiocmGejg0WmXLW0ieVxQyY
1SXDc+EyrBQnXuacywHHkWKlgsTi6sSxFzTjMSSnEPDK6WahF23qLdXuYHghkkpa
t5vbZTy4T9UxEOR03Ld8e7AOwutA3Ltu2ZmrvFCopWDsCWPN6C9DI0XtJSiqlVwu
SxLSlMvn7GPTgHyoncQsKIAniyyb9pkECiomd2aibhTzjxrnyZmui2a2iSUhqgyv
yY1WxJo1tCh4KXDFFTWRIAfEMFaHTnMinLXPYk1koaDD/eeIQeP6ZZnqn7rc74uo
ttccUzyWsFojnBinDm1jhg+tVr62DREmHB1nh4D4XZkInXLKJPWbZxXf+dxY4fkO
fDxNDjs6N/smoZnpZIBZQRkFGeNE6Ev0ijGYntm3APoEHKPtrZvX2o0qHnvuP0Sb
YnfrPobuhW1bXZqm/GsD0Df297i7CangpWamVl4XiJX4DclzgU2yJSktIwYv6h6A
v8nlIKCz1GyGkhtaIZdsSI7iXwSoqHi6SjMtcUdP+CX+O5qe7PIe5i9e2m9BO2cq
VTsxSEMwAlZ9o0FzoQagQN82QJXZbpVWFBezfewxN+MZSACJfCRvbZrr7RBPs5ma
LA2iMXPMeqgNphB+blk4
=iaXa
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
