From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Update][PATCH v5 1/3] PM: i2c-designware-platdrv: Clean up PM
 handling in probe
Date: Thu, 5 Oct 2017 13:00:42 +0200
Message-ID: <20171005110042.6sl7lcyctjpuank2@ninjato>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan>
 <65494652.vEfz4tCBDb@aspire.rjw.lan>
 <2813826.3DA0fVXnVa@aspire.rjw.lan>
 <188302021.o3ml4PkeyZ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vczkhh6gzn7ufvki"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <188302021.o3ml4PkeyZ@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Rajat Jain <rajatja@google.com>
List-Id: linux-pm@vger.kernel.org


--vczkhh6gzn7ufvki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2017 at 11:10:06PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> The power management handling in dw_i2c_plat_probe() is somewhat
> messy and it is rather hard to figure out the code intention for
> the case when pm_disabled is set.  In that case, the driver doesn't
> enable runtime PM at all, but in addition to that it calls
> pm_runtime_forbid() as though it wasn't sure if runtime PM might
> be enabled for the device later by someone else.
>=20
> Although that concern doesn't seem to be actually valid, the
> device is clearly still expected to be PM-capable even in the
> pm_disabled set case, so a better approach would be to enable
> runtime PM for it unconditionally and prevent it from being
> runtime-suspended by using pm_runtime_get_noresume().
>=20
> Make the driver do that.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied to for-next, thanks!


--vczkhh6gzn7ufvki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnWENYACgkQFA3kzBSg
KbYZcRAAsDyr632MkjJsSQINk76uxfkOMABuxHqf8YzQw+YUL85NWjPZ6hMQY+ID
HeVjJFI4+y5xBZsOlasHLLAmSWH7h1lcFIghLs+wN6G3BgSeutVvBwrpiq964ETu
D7/2g8AZ6esQJPLF2lSomqVg/9GgX4y6BC4jQmN+XAeNI/ssoezVWOZdBTQyhy/b
sCSpzY6yqOzqXS53AVZI466vv5ZCKRYRc4KSxYIdN7fnQnseJy5WUhq+y2YiqSJ6
P3P92mrnylLPEHVdwEwoptSApDbMSumNGweOvNg33QRkkaXhaJ5GH/km4Oivd8zQ
p6PC44LQehkhJb3kxt7VQH2/FhU9Tu7BRWCNoIWSRh8IkX3Os9ZGYUTFEYzHIPdi
dCQBZD1ATw4VpDeAsE1u33ZKeeAsrOEq0TsX+u01+5nnlsm0U6cpXInGtreIqFkW
pA8KmnazKk6muQuIomcefhValkTH72idH9DdWfbO7XbO53DWMYSlVjsVNXgac8FJ
Syo1WQD+jC8uHtWtrNoCHN/uMZyBT52VnH4VvM1/UlQEa/us9DEKDB5MORaF9UfP
/A782GdysY1ztKYLOW6unTur1tWAYDX97FQ1L2fuprfcI4k2I00PPFwBMYzJlwpW
H5JKh3LK0FOUteVlRvdiWU8ak2nBKPnPqffqMRPIN9lTb3DxSWU=
=N1AZ
-----END PGP SIGNATURE-----

--vczkhh6gzn7ufvki--
