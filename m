From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/3] PM / mfd: intel-lpss: Push system sleep callbacks
 to late/early stages
Date: Mon, 25 Sep 2017 09:28:47 +0200
Message-ID: <20170925072847.nl2a6feqzrzdcxwz@ninjato>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan>
 <3958866.l2qnKDbinI@aspire.rjw.lan>
 <65494652.vEfz4tCBDb@aspire.rjw.lan>
 <4332008.kXBLY0K23i@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pl7ljgs3wpw2imz3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4332008.kXBLY0K23i@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rajat Jain <rajatja@google.com>
List-Id: linux-pm@vger.kernel.org


--pl7ljgs3wpw2imz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2017 at 01:20:35AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Push the system suspend/resume callbacks of intel-lpss to the late
> suspend/early resume stages to allow child device callbacks to be
> pushed to the late/early stages of suspend/resume too, so as to
> make it possible to avoid resuming the children if they are runtime-
> suspended during system suspend going forward.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Johannes Stezenbach <js@sig21.net>
> Tested-by: Rajat Jain <rajatja@google.com>

If this series shall go in via I2C, I'd need an ack from Lee for this
one. Also, I'd assume this should go in for v4.14 already?

> ---
>=20
> v3 -> v4: Added Tested-by tags.
>=20
> ---
>  drivers/mfd/intel-lpss.h |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> Index: linux-pm/drivers/mfd/intel-lpss.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/mfd/intel-lpss.h
> +++ linux-pm/drivers/mfd/intel-lpss.h
> @@ -38,12 +38,7 @@ int intel_lpss_resume(struct device *dev
>  #ifdef CONFIG_PM_SLEEP
>  #define INTEL_LPSS_SLEEP_PM_OPS			\
>  	.prepare =3D intel_lpss_prepare,		\
> -	.suspend =3D intel_lpss_suspend,		\
> -	.resume =3D intel_lpss_resume,		\
> -	.freeze =3D intel_lpss_suspend,		\
> -	.thaw =3D intel_lpss_resume,		\
> -	.poweroff =3D intel_lpss_suspend,		\
> -	.restore =3D intel_lpss_resume,
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(intel_lpss_suspend, intel_lpss_resume)
>  #else
>  #define INTEL_LPSS_SLEEP_PM_OPS
>  #endif
>=20
>=20

--pl7ljgs3wpw2imz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnIsCsACgkQFA3kzBSg
KbZPFg//eYcWi1vqAxPPz6OWnC0uTJ5n5KpI+9NQk00Ld7F7uD3hvEnNuxUo1iR9
SXM/GVWPFsHKpttyg2Y6yz5Sufc4te3XYdyAdEf3G2wwG7or9xdivHk48U+YPyiV
9YqUMDBbkk9hn9R+kMgzwAfxBaqeyA39a72gnpV49lwXaL54Kcj+OXSGaN5QhkRx
faulaOyaX4I0R68m/VzYQwSVTyci3AAu1wjJ4pOInMpVr4DFfc2myF/lnpr9e8PB
FzmFslYJHdAuvrPVskYAquIr5zjl6fOA5NXfUabc0mbVZRGjesRcj3wxddaMeHhN
bE49xZ4BYMu52YtcIEPg2uHDzNt+G5ogFyL/gEdVoOQs1IOafjQXk+WbsEHzEkEq
5EP7ebezl/5B9dRUfQWUfmv4HDBCdKUHD+8qeChO6EWtsfimwC/+av4nhUkTJrst
rNBSVIP06wu3cOZdTrK6Her67rC58NYbfA9Rx2QBVJiw6asThDKqPOaWqjvgbEqB
8JIEOTptVIhbduudMmwR0YAZADEsLpPCHeYAY8eSKMfjPDWkuNb6aAiLgZ/l2bb7
FHEoVPKe/S0OEI79joQ4AnWPuuLvNCwD4IVa7a6Cdt5V8n6R0/qhw7qBA7D8Rfq4
miPplxvZmhEaUrUTsc0jonfKOCtx3GEzRXgOCddw7yZxh+s1Wbs=
=vpD8
-----END PGP SIGNATURE-----

--pl7ljgs3wpw2imz3--
