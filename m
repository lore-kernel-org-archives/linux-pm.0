From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/4] power: Add Qualcomm SMBB driver
Date: Mon, 27 Jul 2015 16:06:22 +0200
Message-ID: <20150727140622.GB12993@earth>
References: <1434662025-9485-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1434662025-9485-4-git-send-email-bjorn.andersson@sonymobile.com>
 <20150725154159.GA17373@earth>
 <20150726010414.GK4753@usrtlx11787.corpusers.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150726010414.GK4753@usrtlx11787.corpusers.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>
List-Id: linux-pm@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 25, 2015 at 06:04:14PM -0700, Bjorn Andersson wrote:
> On Sat 25 Jul 08:42 PDT 2015, Sebastian Reichel wrote:
> >  * battery-charge-control-limit
> >=20
> > It's unclear, what this property is used for. Is the limit only
> > for "normal" charging or also for fast charging?
> >=20
>=20
> This is described as the current limit during fast charging. However,
> "fast charging" is the normal state.
>=20
> I think the most consistent (regards documentation and other properties)
> would be:
>=20
>  qcom,fast-charge-current-limit

So what's the difference to "fast-charge-safe-current"?

> >  * minimum-input-voltage
> >=20
> > Add a vendor prefix to this property.
> >=20
>=20
> Shouldn't they all have a vendor prefix?

Some of the properties are quite generic and used on multiple
chips, so we may create a power_supply/battery-fuel-gauge.txt
and power_supply/battery-charger.txt with generic bindings.

I'm fine with just adding vendor prefixed properties for all
instances, though.

> Thanks for the review, I'll update the patches accordingly and
> will send out v2 (and make sure you get the dt binding document
> as well).

OK, thanks.

-- Sebastian

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVtjrbAAoJENju1/PIO/qa7eAP/i3ZBGawaby2Nx7cbY9Fp5r/
Dtc+E2Yc8qVjm03X7Agmje3Z8vrv+WxHxd4KVQykbQFS7UvBIsvICn41YwbmdwjP
SMcTiT0Y/q6VQMmkTh+9lX6CpsHFMWeDd3u5qgl4gPbZir5p+pgz5lfLJBM72VTt
ynstkojKjds2FeU2Dvj2m4yegtI8l/KUDBlQCIYqX+Knb/D5aIeSjFTJWHESbjRD
N3qnFKWupVUozmLlpwF+/RWYwRHRDywI5YoztNlumQMWZFgZVckf5dsI/UOt2s+m
M/Xk43PtWvZWQ89erdUfznaguhGPa+le09gXJ7VZXwzGlyfql3jkeCCmIsENK+U8
cNEChMKk8gS0B4c1skAR0kCVxKxEtsQlul6Qtwuv1g2KMf8OY/9RioTAzaZcQAXv
FIRoLd56a1SavQxun0R7wbYD77MrHKcqaibGvKHSp+mYyAPlSKVYKijxqkZ/tAAH
tpE2Nc+I6Jw5aBIbj+l0u4ymDNjbH4BDQibI1PrwDmSRuM/TDmyvhX5qXRfAxGLq
Jcm2/zFDPuVPtdjB0rOSXXtysvhMzlC7KEVuZ+ABXZ75wBBX0Obuil68gFklMQa4
7ejjyLRYm+t7ui+GNZIOCyQ0fyGl3maf5QAeqXkEQq2MJ9ziHHl9wq63izmsADq1
ipPGubvYfId8iwjN37nl
=hOzE
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
