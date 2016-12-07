From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v4 2/4] thermal: rcar_gen3_thermal: Add R-Car Gen3
 thermal driver
Date: Wed, 7 Dec 2016 10:06:27 +0100
Message-ID: <20161207090627.GB1724@katana>
References: <20161201220442.22057-1-wsa+renesas@sang-engineering.com>
 <20161201220442.22057-3-wsa+renesas@sang-engineering.com>
 <20161207010119.GB12562@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161207010119.GB12562@localhost.localdomain>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>
List-Id: linux-pm@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Would you please check the following from checkpatch too?

I saw them and chose to ignore them. I am not strict with those warnings
within the i2c subsystem as well. I can change the series if your mileage
varies, of course.

> WARNING: please write a paragraph that describes the config symbol fully
> #82: FILE: drivers/thermal/Kconfig:248:
> +config RCAR_GEN3_THERMAL

I can make up something.

> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Is this mandatory?

> CHECK: struct mutex definition without comment
> #186: FILE: drivers/thermal/rcar_gen3_thermal.c:75:
> +	struct mutex lock;

Can change, but if there is only one lock, I don't really see much
benefit from this check.

> WARNING: line over 80 characters
> #204: FILE: drivers/thermal/rcar_gen3_thermal.c:93:
> +static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *t=
sc, u32 reg)
>=20
> CHECK: Alignment should match open parenthesis
> #210: FILE: drivers/thermal/rcar_gen3_thermal.c:99:
> +static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc =
*tsc,
> +				     u32 reg, u32 data)

I have those warnings (80 chars and open parens) ignored by default but
if you think it makes the code more readable, I'll change it.

> > +static void _linear_coefficient_calculation(struct rcar_gen3_thermal_t=
sc *tsc,
> > +					    int *ptat, int *thcode)
> > +{
> > +	int tj_2;
> > +	s64 a1, b1;
> > +	s64 a2, b2;
> > +	s64 a1_num, a1_den;
> > +	s64 a2_num, a2_den;
> > +
> > +	tj_2 =3D (CODETSD((ptat[1] - ptat[2]) * 137)
> > +		/ (ptat[0] - ptat[2])) - CODETSD(41);
> > +
> > +	/* calculate coefficients for linear equation */
> > +	a1_num =3D CODETSD(thcode[1] - thcode[2]);
> > +	a1_den =3D tj_2 - TJ_3;
> > +	a1 =3D (10000 * a1_num) / a1_den;
> > +	b1 =3D (10000 * thcode[2]) - ((a1 * TJ_3) / 1000);
> > +
> > +	a2_num =3D CODETSD(thcode[1] - thcode[0]);
> > +	a2_den =3D tj_2 - TJ_1;
> > +	a2 =3D (10000 * a2_num) / a2_den;
> > +	b2 =3D (10000 * thcode[0]) - ((a2 * TJ_1) / 1000);
> > +
> > +	tsc->coef.a1 =3D DIV_ROUND_CLOSEST(a1, 10);
> > +	tsc->coef.b1 =3D DIV_ROUND_CLOSEST(b1, 10);
> > +	tsc->coef.a2 =3D DIV_ROUND_CLOSEST(a2, 10);
> > +	tsc->coef.b2 =3D DIV_ROUND_CLOSEST(b2, 10);
>=20
> What is a a1, b1, a2, b2 typical values?
>=20
> are you sure they do not fit into int? Looks like you start from pretty s=
mall values,
> but multiply by 10^3 on num and den to get better precision?

Typical values are a few thousand. a1_num uses CODETSD which multiplies
by 1000 and makes it a million. a1 then multiplies again by 10000 which
makes it 10 billion. No int.

I am quite sure the formulas can be rearranged to fit into an int. As
mentioned before, I hoped we could start with the already tested
formulas since documentation on them is sparse.

> > +static int _linear_temp_converter(struct equation_coefs *coef,
> > +					int temp_code)
> > +{
> > +	int temp, temp1, temp2;
> > +
> > +	temp1 =3D MCELSIUS((CODETSD(temp_code) - coef->b1)) / coef->a1;
> > +	temp2 =3D MCELSIUS((CODETSD(temp_code) - coef->b2)) / coef->a2;
>=20
> aren't we overflowing the result of this 64 bit math assigned into an int?

The division ensures that we get an int. Hmmm, not very pretty, I agree.

Sigh, maybe it is better to refactor the formulas before submitting
upstream :/

Regards,

   Wolfram


--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYR9ETAAoJEBQN5MwUoCm2+Q8P/RNQqymkhR3GD4WiPTfBwqjW
iDUDp8VH8NNBnXSdaRC1Ics3VAoMFouezEsgdLeOrRmOx0krBzybJv4V90Abq19g
kWAZMNsao0gZKCGtVR1/Y20m11adUMHldcj2E8iZCAIkr4YRFcTItm50wYsWHgNS
M5ezYkPSQ+tyttVdOZjXay2GFbhFQFTNZYfzeYiAiOChulO5hAnaa1u96kJD3uTH
Sg0UIRmPOOnV66tX+/u3qO+JxkXmWJ5kOR/wwX68/y9CQ6iBZXa0V0tn6v00iD3M
QodAYB7ujsa8yXDQ+xLl9tZq3cW1mVIOmISlLnGClgX11ll9598lw0APhelgKIV9
vs8kQ+GmUOkoeJLXfQaQ7FcaplyjJG8oiotT1mekmIf/loQYVwtGrlTbdo1oKkGo
koTIBhuXeO6+BjcTm9AvJ1b5/Dd7FjvqZHT9tdZn2iN7xTEQFNCIY13Pw5Tb+ivs
7D7Xvkdm2U5Ae0NV944DKngyWG2Wc9h2zr49x9FLfAzxKzv9A9Da4YyEwyMk8tw/
X6BoWH2+Hnf3plAcMbBLAyjHZLAUfJiMpXtsOk+y0/T6wj+0y2a0842d5Gz7gJuq
2bZ1PnZanzDtVIGy8nu2B3RXlR7rFtjQ1+Pkn/t601rL2pfPoEvCI3RzbxCXIv5f
srNduiwMmo6+LgUkxNIX
=mT75
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
