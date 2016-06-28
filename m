From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: qcom_smbb: Make an extcon for usb cable detection
Date: Wed, 29 Jun 2016 01:47:45 +0200
Message-ID: <20160628234744.GA13733@earth>
References: <20160626055437.18516-1-stephen.boyd@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160626055437.18516-1-stephen.boyd@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 25, 2016 at 10:54:37PM -0700, Stephen Boyd wrote:
> On these PMICs the usb cable connection/disconnection is
> indicated by the usb-valid interrupt being high or low
> respectively. Let's make an extcon for that, so we can notify usb
> drivers of the cable state.
>=20
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

Thanks, queued.

-- Sebastian

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXcwyeAAoJENju1/PIO/qaXuAP/iEnn/SSKa3o2oIfEdfQwWV3
9CeU/Y5NHVTxe4ph7ZbbFOhtvGDMRWk9brZTI8L5X/Rwgdht3YUH1n0vtQ5bd/Or
O4sxg2RtFMf9hE1oWgE7skiTJzYuxEqT9WWJqcNa+q0uNYkEDN9GtRpEGOX2myhU
d/NO7mRYrnc09Wv1MsB1nNKZz9OA7KpO/3e9wLaApwvisgtDLWLA7QEVPv+7bvQy
OtWFSmRkxhJsIxWXjlkC+onacNO4xUC3JXUd45TEZMCDLTonfrgI9M6K2fGFRbtT
pRRBqAfFgpV26FPcHJfb+DDk6EoOi072aYi8AdNqYSUn8/szvNmExPe+SNWVZO1e
jGpBKXVOWdbPkInFR9OlvG6UFSkq/CithankALTscKcm2waTddRGTs9Vovikdofs
pskYBOYm1Y9mbdOSy9hJTdx1HVfkSuW6T1fLLX638VLYgz5WFer2K+fgoA3FSKt1
/rSxAlAkktExi1HmbIkVcVJ/etTZvxIaD8hfKHpv7NePNQqybOu0RmdAjD7PjQJ6
VJCjgXBcATV3PIzdb4dpJ5iQ9GxqReCZ/M6QT09RTC1DJqRgRqhwAeatNoxPZitE
ZDXW+AM5Y+2tHmhiFxB0EZ8M6wlfrtz6fFQ/tQUH66BHnf9vET/cPdVEE14vhUso
Eu/Va7pcp1ZKBImn0HxJ
=wDgD
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
