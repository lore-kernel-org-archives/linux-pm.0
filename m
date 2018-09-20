From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 2/2] power: supply: Add Spreadtrum SC27XX fuel gauge unit
 driver
Date: Thu, 20 Sep 2018 02:36:30 +0200
Message-ID: <20180920003630.ygvjnuutmd5n2vre@earth.universe>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
 <1295864a38810a6db6c97e298c6663ae2b1350c1.1536736399.git.baolin.wang@linaro.org>
 <20180916143552.3oxjqpo6vravh5cy@earth.universe>
 <CAMz4kuJcA-Oo1vTtW=gf_oFmZ3TmgNxYPxO5wuWpy0Kcg2LFDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x26i7pb5xajtvdfn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4kuJcA-Oo1vTtW=gf_oFmZ3TmgNxYPxO5wuWpy0Kcg2LFDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org


--x26i7pb5xajtvdfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 17, 2018 at 12:01:51PM +0800, Baolin Wang wrote:
[...]
> >> +static int sc27xx_fgu_parse_dt(struct sc27xx_fgu_data *data,
> >> +                            struct device_node *np)
> >> +{
> >> +     const __be32 *list;
> >> +     int i, len, size, ret;
> >> +
> >> +     ret =3D of_property_read_u32(np, "reg", &data->base);
> >> +     if (ret) {
> >> +             dev_err(data->dev, "failed to get fgu address\n");
> >> +             return ret;
> >> +     }
> >> +
> >> +     data->gpiod =3D devm_gpiod_get_optional(data->dev, "bat-detect",=
 GPIOD_IN);
> >> +     if (IS_ERR(data->gpiod)) {
> >> +             dev_err(data->dev, "failed to get battery detection GPIO=
\n");
> >> +             return PTR_ERR(data->gpiod);
> >> +     }
> >
> > According to the binding (and the remaining code!) this gpio is not
> > optional.
>=20
> Yes, they are not optional. If we can not get the detection GPIO, we
> will return errors. So am I missing something else?
>=20
> Thanks for your comments.

devm_gpiod_get_optional =3D> devm_gpiod_get

The _optional variant will return NULL if the GPIO is not specified in DT.
The variant without _optional will return an error instead.

-- Sebastian

--x26i7pb5xajtvdfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlui64oACgkQ2O7X88g7
+pp72w/+PBMhziS4xo8Gk9wXxqq8FX5e54kd0AfV1i2CCeS5IG4vq6IoynmZ4EQv
MVS3HdeX9LMZLoR1J2Me4U4yyyF77sLg3CBwiqdskj6nbukvlWFeyAutQcZ/eDod
I9mNwK1oa0RvuItT6vfaAP9XZvnhqh3tze+TvPctpSG/bIXnmbY9Cla+MFnk6A2D
logiPxnBWJoRQGZGZwwgD+iRZ1fM3k7WxoL+Qg4TE2ij0k82rjxS2zYNp75J8eFd
0tlOgnAVTJRtmbZimaJComDBAbMxelD52/Pip/QCXIPfgxAh9zymnUMPGMZVEwNx
rqKfusukexOq8VUOMadZvhaoUAVHhzuRGnmV+qdjZ+eldhHir2XXv+q6av+pscl4
HBUKIfgbXDPX31Dbneo/AUfrhTbJzo6Hsaljy5HUsYLs1c2osm81ummcaivapfwE
cy79x1afz5mMEhQV0MgJXECLzL0MGGIUxlY2jxUYKp/n36NAWhkksCM3y70O9ZyQ
dmOp8QAm90j72byIjzsZxfHhfsnmwbYMdBCWP2l2nlBaVN+TQZMpYiRzQif/HQwq
DXk+r07RUwvilJSA3KZH/7ZgV8r4NE2jaqzW2Uh+GFuLgsimS0u3HBi6WkoJENhe
tf3cbDoADfGJ3QK+qj9OXLSQmEPmE9Xg0mV7vytj4tD6+bMZKdg=
=Ikka
-----END PGP SIGNATURE-----

--x26i7pb5xajtvdfn--
