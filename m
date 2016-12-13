From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv5 2/5] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal
 driver
Date: Tue, 13 Dec 2016 06:38:36 +0100
Message-ID: <20161213053835.GA1439@katana>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
 <20161212141805.14946-3-niklas.soderlund@ragnatech.se>
 <20161213035052.GA22105@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161213035052.GA22105@localhost.localdomain>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> > + *
> > + * The constants a and b are calculated using two triplets of int valu=
es PTAT
> > + * and THCODE. PTAT and THCODE can either be read from hardware or use=
 hard
> > + * coded values from driver. The formula to calculate a and b are take=
n from
> > + * BSP and sparsely documented and understood.
> > + *
>=20
> hmmm.. OK. that gets a bit more interesting.=20
>=20
> So you can get a and b queried from hardware. cool.
>=20
> but you can also get those hardcoded in the code. In that case, I would
> suggest hardcode them in DT, instead, using the coefficients property.

It is only the engineering samples which have the coeffs hardcoded. All
future revisions of the same SoC will have the values as fuses from
registers. Sadly, we won't have access to newer versions for a while. To
avoid having seperate DTSI per engineering sample revision, I planned
for using the new soc_device_match() mechanism which was introduced for
exactly such use cases.

> > +static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
> > +{
> > +	struct rcar_gen3_thermal_tsc *tsc =3D devdata;
> > +	int mcelsius, val1, val2;
> > +	u32 reg;
> > +
> > +	/* Read register and convert to mili Celsius */
> > +	mutex_lock(&tsc->lock);
> > +
> > +	reg =3D rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
> > +
> > +	val1 =3D SCALE_DIV(SCALE_INT(reg) - tsc->coef.b1, tsc->coef.a1);
> > +	val2 =3D SCALE_DIV(SCALE_INT(reg) - tsc->coef.b2, tsc->coef.a2);
>=20
> I see. there are actually two sensors here, and=20

Really? val1 and val2 are both based on 'reg'. Also, the datasheet
explicitly mentions 'three sensors in the LSI'.

Thanks for the fast response!

   Wolfram


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYT4lbAAoJEBQN5MwUoCm2wZkP/1vUew38z51XJKlGQ3oKBekS
0dlOmptmWOM85iEd5hzvipB7XHTRcfK/SN55SbTyooQOtb9FwxD0Ifga5BNyZ7SH
WAhoE5SipZhwKy2V4wYy7vq6xTWH7VdpTaJ37CfvgQYbPmqJ4XT/I3pbP0dUMCBr
GRhFvlNK1fRVNJ6kEyXpXSowmb+bDtHqWjEHTBTJvavV8xPXvK7v1UlVt0A+o/oy
nRjcrN0wG6jsT+e1xRQIhXddDEMYcLtjqL08D/OnWn5eKZDx4cdQgrQpT6n4ATFX
tKVY9e+XQgS/kRrUO+xwxvfINMKoj4w1OUiMqPTW+mbBntFNIcu/vuIsp+GVD91q
S/f1AY2FjznrofakF4IKfshVhKsfdcuDu+7OZ3xnU3/a3bv2n20hn/4eI92O9vqA
VoqdvOh+rdHz8FC9neJLs5D15bxgIL920Ix5VhtMZ4KHqXZV6bvnDbh0TRt/DApI
CRBwnTl2AOZlFAODBFPwHi87lGFW+5kdT70qE3LsNgrmBgwcNBvxQkrACOZDeTTW
dDVYDfHOes5nYQcnam4xp/jNFfffPg1VKwcsovRbgcWybG/W+bk2wx5F3gvHXLAo
wocRZ2IGqMRyEToNV21Qc6RH9Zf7M9NZHXw20qJurTlI029JMEZcAfWOFzZ0wmRK
0qcfHfdghbCz4wU706iN
=MO74
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
