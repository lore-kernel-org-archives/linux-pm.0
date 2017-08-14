From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Fix system suspend
Date: Mon, 14 Aug 2017 21:04:40 +0200
Message-ID: <20170814190440.jaznldtdpr7trvz4@ninjato>
References: <1502285302-21552-1-git-send-email-ulf.hansson@linaro.org>
 <1776600.GWYGTRKWSN@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p7m45mzjgk7zhkql"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50430 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbdHNTEm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Aug 2017 15:04:42 -0400
Content-Disposition: inline
In-Reply-To: <1776600.GWYGTRKWSN@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "# v4 . 4+" <stable@vger.kernel.org>


--p7m45mzjgk7zhkql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 10:43:22PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, August 9, 2017 3:28:22 PM CEST Ulf Hansson wrote:
> > The commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming
> > during system suspend"), may suggest to the PM core to try out the so
> > called direct_complete path for system sleep. In this path, the PM core
> > treats a runtime suspended device as it's already in a proper low power
> > state for system sleep, which makes it skip calling the system sleep
> > callbacks for the device, except for the ->prepare() and the ->complete=
()
> > callbacks.
> >=20
> > However, the PM core may unset the direct_complete flag for a parent
> > device, in case its child device are being system suspended before. In =
this
> > scenario, the PM core invokes the system sleep callbacks, no matter if =
the
> > device is runtime suspended or not.
> >=20
> > Particularly in cases of an existing i2c slave device, the above path is
> > triggered, which breaks the assumption that the i2c device is always
> > runtime resumed whenever the dw_i2c_plat_suspend() is being called.
> >=20
> > More precisely, dw_i2c_plat_suspend() calls clk_core_disable() and
> > clk_core_unprepare(), for an already disabled/unprepared clock, leading=
 to
> > a splat in the log about clocks calls being wrongly balanced and breaki=
ng
> > system sleep.
> >=20
> > To still allow the direct_complete path in cases when it's possible, but
> > also to keep the fix simple, let's runtime resume the i2c device in the
> > ->suspend() callback, before continuing to put the device into low power
> > state.
> >=20
> > Note, in cases when the i2c device is attached to the ACPI PM domain, t=
his
> > problem doesn't occur, because ACPI's ->suspend() callback, assigned to
> > acpi_subsys_suspend(), already calls pm_runtime_resume() for the device.
> >=20
> > It should also be noted that this change does not fix commit 8503ff1665=
04
> > ("i2c: designware: Avoid unnecessary resuming during system suspend").
> > Because for the non-ACPI case, the system sleep support was already bro=
ken
> > prior that point.
> >=20
> > Cc: <stable@vger.kernel.org> # v4.4+
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> Looks OK to me.

I read this as Acked-by. If so, using the real "Acked-by" tag would be
helpful because patchwork collects them automatically.


--p7m45mzjgk7zhkql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmR9D8ACgkQFA3kzBSg
Kbb+bQ//QFNzxQ9KcbeEMwx7vmVs9VGB1T7du/7Dnl8DOc1zhCgjm6V0Mv452OOu
nQcvHNP7v2VZNayamG4Q0464qbuH4qLrd0CNoqnI0g1a5EAxERSmWwUiWch3XO1E
fLny8OTGG8K0x5GDzvrXfVYFPrdZ4VHrXD33h0fFHiUmU2PmmegB4kv7MnqI48uV
ocJijwO0AwMzFFwUVu6e97HBJp3lrsUhiF9MaOmFkzI37zUpEIxnrBBTVx7ybN7F
duK0sTTEwPOEiR5P1uS4VXSxpmkipn7MaRzyKoirLr4QfHDbmLvPdNuGYdFSBZ+r
DGVEY9DlLSLadETIys79/OOnb1iRWOTzW9zFhIB1SSsTyLHZFwKeg8+nNTEwNJr6
8kugLicCsqobUnr+YVSlBgbglZSd3Up/DSS2ei1kja3Chg4lnta07cIInSil14fN
o+186UmFvh7hUwWEV4M9eV97exWdTElQUweB4XeBJfsbOse6c+3Xz4/pvhF2cJnp
ZlqTaXPPVafRzWKUXgBhUOu55+I0KFtLM7C/kkasD1UCDMGjOYpapokBG6jwgYFe
HgXlw7tK0N7sFDRuB+kuwYdSOxpP617TxLnCn7sfCc/M836ebXk1aJkDjysBas8s
yz3R7g5xwKWAhgwo3OKPebwY6tT3hYGtzdCqm8nzjdhsp2nzN3M=
=s/Ae
-----END PGP SIGNATURE-----

--p7m45mzjgk7zhkql--
