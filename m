From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Fix system suspend
Date: Mon, 14 Aug 2017 21:07:44 +0200
Message-ID: <20170814190744.w2weg7wx3i77soss@ninjato>
References: <1502285302-21552-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fbx7spal7bqeask2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502285302-21552-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "# v4 . 4+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--fbx7spal7bqeask2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 03:28:22PM +0200, Ulf Hansson wrote:
> The commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming
> during system suspend"), may suggest to the PM core to try out the so
> called direct_complete path for system sleep. In this path, the PM core
> treats a runtime suspended device as it's already in a proper low power
> state for system sleep, which makes it skip calling the system sleep
> callbacks for the device, except for the ->prepare() and the ->complete()
> callbacks.
>=20
> However, the PM core may unset the direct_complete flag for a parent
> device, in case its child device are being system suspended before. In th=
is
> scenario, the PM core invokes the system sleep callbacks, no matter if the
> device is runtime suspended or not.
>=20
> Particularly in cases of an existing i2c slave device, the above path is
> triggered, which breaks the assumption that the i2c device is always
> runtime resumed whenever the dw_i2c_plat_suspend() is being called.
>=20
> More precisely, dw_i2c_plat_suspend() calls clk_core_disable() and
> clk_core_unprepare(), for an already disabled/unprepared clock, leading to
> a splat in the log about clocks calls being wrongly balanced and breaking
> system sleep.
>=20
> To still allow the direct_complete path in cases when it's possible, but
> also to keep the fix simple, let's runtime resume the i2c device in the
> ->suspend() callback, before continuing to put the device into low power
> state.
>=20
> Note, in cases when the i2c device is attached to the ACPI PM domain, this
> problem doesn't occur, because ACPI's ->suspend() callback, assigned to
> acpi_subsys_suspend(), already calls pm_runtime_resume() for the device.
>=20
> It should also be noted that this change does not fix commit 8503ff166504
> ("i2c: designware: Avoid unnecessary resuming during system suspend").
> Because for the non-ACPI case, the system sleep support was already broken
> prior that point.
>=20
> Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied to for-current, thanks!


--fbx7spal7bqeask2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmR9QAACgkQFA3kzBSg
KbYjixAArbWkigg9/TdTcqEsvukJsgkwSBbwzwTQa/qEdw/2iILOOtf4cY7KSpki
t0PvUyHdW7qO6++OfcaW7a+v9l/WlVYsVw288HTdo+vzFm8LYARqrYftYHd6YMHT
YKxNnsM2rtU/xqCwrl+Osa6KNsd8mES26tIRhH7f4y3Si737/hrEZLqqSqWxDM6h
5hfHJkg6JvYuW8tPB6i2/nMSKQmCIPylmFndCidaUMzsbBFvksBlMfCLFdrk/RRl
nu5GnGUno+23BfSXxTejcwPbNVGtNSWE8tT4x4CuLwBlFWVldSPzCcKzd8UPmpz1
dsx5vfJWz+aHgaye2Gi4cOxkvfNXynO+FN4XZVpmov520D+PQEdDUIjAw0rpUDpt
B8EX1QRjnJuHNDJveZdrxeH+evAdsF6p80W9/wnOfJIVhpdkS4RDx4leq7NkZtEG
3xJez4BXxADLWtSUFpwi4K/yBe/u5z9cHWsVecAyRkWKrmGGRMcp2ESkT/zk99if
wATR9Q5JFOrL1vKdhZ4ZHc8lHM364/oJ3jtKjw3IGwyIdMHgjgx6E2iDwqoEm5xy
eu+P1v/KXJB/RQ/KNim5cVZk+clf5jwAo4Lq0QKjRVsCPZs9uBpuaXdyILwrWuS5
2kRwV6hn+2NDhZNwRax99jiDJByUHhFpFJ1sFjV9thbbEV7Lf7c=
=Dt1j
-----END PGP SIGNATURE-----

--fbx7spal7bqeask2--
