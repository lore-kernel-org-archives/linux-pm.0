From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] sbs-battery: Add missing power class sysfs files
Date: Wed, 6 Aug 2014 02:40:42 +0200
Message-ID: <20140806004042.GA9957@earth.universe>
References: <1407152866-31790-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407152866-31790-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Simon Que <sque@chromium.org>, cychiang <cychiang@chromium.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2014 at 01:47:44PM +0200, Javier Martinez Canillas wrote:
> This series add the model_name, manufacturer and voltage_min_design
> files from the power supply monitor class sysfs interface that were
> missing for the sbs-battery driver. The commits were taken from the
> Chrome OS 3.8 downstream kernel and patches were squashed when they
> just fixed bugs introduced on previous commits that do the export.
>=20
> The patch-set was tested on a Exynos5420 based Peach Pit machine by
> confirming that the sysfs files existed and provide the right data:
>=20
> # cat /sys/class/power_supply/sbs-20-000b/{voltage_min_design,manufacture=
r,model_name}
> 7500000
> SANYO
> 4302A40
>=20
> Simon Que (1):
>   sbs-battery: add min design voltage to sbs-battery
>=20
> cychiang (1):
>   sbs-battery: export manufacturer and model name to sysfs
>=20
>  drivers/power/sbs-battery.c | 125 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 123 insertions(+), 2 deletions(-)
>=20
> Best regards,
> Javier

Both applied to battery.git's next-next branch. I modified the
author from the first commit (cychiang <cychiang@chromium.org>),
so that it's equal to the signed-off line (Cheng-Yi Chiang
<cychiang@chromium.org>).

-- Sebastian

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT4XmJAAoJENju1/PIO/qanVcQAKbt0SxgXCGSvdk8HKatkul0
glQpafA8PZuKQXDNGI31vmbnXbFjA7Zjn4U8kkb5mNf1E2FbyP7v6x9eOIjayE2m
/rET0d8jfn+T13ReN051qpAbWn5ESQzKzRGaPgahz4elnAMZoQM8tX1nLtbbk7HM
dEVk8s88Fxhi/etfI2Jx752dcMALRvqJnVe1o/hE8dRkdC+Rj2XQycFt9MQar1l6
Yr2cUTW8Dyxalv/enZOewoXc2prPShZg2Pl9w2sfmnWvUQFHw2mc+5aiD+RV2zuR
ehz2zCbppF6kGmhvM8x981EZH+/PUBqyjeFtSw3MCY/dgID6zIUNesBbuuGKfbzL
F1fHxTwCuJ6kNsytbW44zSF22br2a/K3r+HMg2m+ZHwP6oDSI2dF+Rymjx2ZyhSI
LaeOY66uVxpYCYe5n7LaR3PNM+Vuk8lJ1vY2+p8scpStrCnG43fu1DglfJ+jqmzX
44hhw1JsLhuz+0CtFmx3lm4aLs6pBCsKJlUFlfJqDRMzRqfxy/sReSCPTqMzJRD5
x1WAN6VdkyvxAz+DlsWmaDk7cUY2ZrJXw/SFKbt0r+Jx52kP61LgVNagBZJNX0sW
jb8B0Nnb0uSRKqQL0C36ZAhuEF+QrhthJkNMrePBVZ9yJLMSMoahI+9itD63dcIC
LJiLyX3rrWxrCZVDZttL
=nP2h
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
