From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: Add msm tsens thermal sensor driver
Date: Sat, 31 Jan 2015 14:17:00 -0400
Message-ID: <20150131181658.GA17425@developer.hsd1.ca.comcast.net>
References: <1422331786-19620-1-git-send-email-nrajan@codeaurora.org>
 <20150129223946.GD29837@developer.amazonguestwifi.org>
 <1422607148.11083.10.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422607148.11083.10.camel@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Narendran Rajan <nrajan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Linux ARM MSM <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Siddartha Mohanadoss <smohanad@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2015 at 10:39:08AM +0200, Ivan T. Ivanov wrote:
>=20
> On Thu, 2015-01-29 at 18:39 -0400, Eduardo Valentin wrote:
> > On Mon, Jan 26, 2015 at 08:09:46PM -0800, Narendran Rajan wrote:
> > > TSENS supports reading temperature from multiple thermal
> > > sensors present in QCOM SOCs.
> > > TSENS HW is enabled only when the main sensor is requested.
> > > The TSENS block is disabled if the main senors is disabled
> > > irrespective of any other sensors that are being enabled.
> > > TSENS driver supports configurable threshold for temperature
> > > monitoring in which case it can generate an interrupt when specific
> > > thresholds are reached
> > >=20
> > > Based on code by Siddartha Mohanadoss and Stephen Boyd.
> > >=20
> > > Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > > Signed-off-by: Narendran Rajan=A0=A0<nrajan@codeaurora.org>
> >=20
> > I know this might not be completely related, but since you are sending
> > QCOM code, can you please check my comments on your PMIC thermal code?
> > https://patchwork.kernel.org/patch/5013021/
> >=20
> > Ivan seams to have disappeared.
>=20
>=20
>=20
> Mm no, sorry, just distracted by other tasks. PMIC thermal driver is in t=
he
> road map. I will try to accelerate rework.

Great news Ivan!

Let me know if you have doubts or need any support / extension on the OF
thermal API in order to get the PMIC thermal properly implemented.=20

>=20
> Regards,
> Ivan

Eduardo Valentin

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUzRwSAAoJEMLUO4d9pOJWHFsH+gMOYunabFeneRvmnuV1cBb4
MGgSuKi3horH3wFNN9ejAYpnI5YkebzFYfz6L/1rwn+0Ja9sqK8zZS5G/vpw1Gj/
OseCaW6gUWGbJmwSWImqnS/hRjlGJFwIASjDMnslkHqE8PjgtjtzwDEcEuufkI9v
U3vaegzFCV/fDZMHS0UGohsujLl/j+Jtpf7mn2tdO9//jh3x7DWtks2XkuTfYE5C
L2YlBibzfIHEAPnMjzhxX5q5WBamWcdTBbnWORGp7/GXuzZXwzT8vG7MxvuGLmLC
1Cf1OG3pLhZJ34PQV5kzgwNyWl7Bg6cI4UyqKW/kY5H+Ox4Ick73AXXIjgUafno=
=ZwWD
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
