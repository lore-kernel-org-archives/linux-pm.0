From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 3/3] PM: i2c-designware-platdrv: Suspend/resume at the
 late/early stages
Date: Thu, 5 Oct 2017 13:00:54 +0200
Message-ID: <20171005110053.2oxmz25ucnpoxjrk@ninjato>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan>
 <3958866.l2qnKDbinI@aspire.rjw.lan>
 <65494652.vEfz4tCBDb@aspire.rjw.lan>
 <7572899.CfQ69SdO4W@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="73evo3vnpt6mv5jd"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7572899.CfQ69SdO4W@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Rajat Jain <rajatja@google.com>
List-Id: linux-pm@vger.kernel.org


--73evo3vnpt6mv5jd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2017 at 01:30:51AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> As reported by Rajat Jain, there are problems when ACPI operation
> region handlers or similar, called at the ->resume_early() time, for
> I2C client devices try to access an I2C controller that has already
> been suspended at that point.  To avoid that, move the suspend/resume
> of i2c-designware-platdrv to the late/early stages, respectively.
>=20
> While at it, avoid resuming the device from runtime suspend in the
> driver's ->suspend callback which isn't particularly nice.  [A better
> approach would be to make the driver track the PM state of the device
> so that it doesn't need to resume it in ->suspend, so implement it.]
>=20
> First, drop dw_i2c_plat_suspend() added by commit a23318feeff6 (i2c:
> designware: Fix system suspend) and rename dw_i2c_plat_runtime_suspend()
> back to dw_i2c_plat_suspend().
>=20
> Second, point the driver's ->late_suspend and ->early_resume
> callbacks, rather than its ->suspend and ->resume callbacks,
> to dw_i2c_plat_suspend() and dw_i2c_plat_resume(), respectively,
> so that they are not executed in parallel with each other, for
> example if runtime resume of the device takes place during system
> suspend.
>=20
> Finally, add "suspended" and "skip_resume" flags to struct dw_i2c_dev
> and make dw_i2c_plat_suspend() and dw_i2c_plat_resume() use them to
> avoid suspending or resuming the device twice in a row and to avoid
> resuming a previously runtime-suspended device during system resume.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Johannes Stezenbach <js@sig21.net>
> Tested-by: Rajat Jain <rajatja@google.com>

Applied to for-next, thanks!


--73evo3vnpt6mv5jd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnWEOUACgkQFA3kzBSg
KbYxQQ/8C+AcBagRN7uTok0wINHEcCdOk/W8/Z+cbmtBvMtbpiBbS19op9Pi43+8
av+WC+XtJ6BjiI3/xlDOlteZTHlN/c+7XUqL52RBgwyeeL9u70QjQuUv8Bt3tPsq
HQ4V8k1ptsZFqt0G7TQ4KTkhtelxKgoSxggFw696lIeHTyg98oxjdEmMN/BbJgnL
zUfAIRgZmJMguY8GOvI74u41gP5vEBY3ViQy1np9qF8Es20nml2ix1whVwjgxbbA
/Rdo7Qspc1o82lL/ymEjkRMMmAybPC1s9OuDa2Xs8TSqflpaaFCeZmNSIgIkTPgO
B3v7h/2ScQd3ami+djUHIgRxnlproW0f/GL8pB8EzkqI33fUN8UZPcxxf9SF1qby
htb5bRufKr1kEbkwpGJ1PbUp0Uy3gf7n5JP/09WW4sUn1oVEf7m70390iyNzeBQl
nDOfMhsRBi3BCGds6LhjbahVOkSkrDQLCnMBEcdTrzDrdXIYxpNdsRbscA55xT8S
2pLzMRM9quhSxtyNKJVjYOns7AYi0pJbMPbEtvL6uxAmM2IgoXdB0wUjw4DU4ESu
5Wn/EgaRLIlVzypj/ITnXfkqbIpMza6Xmij6vFEMn44gCjvbZcXbRJfetgK0Nn2M
qSfuPTyX7bvZvmphaqA4NDdN0HxSPGaILyc7N33piEkzZ0xo1J8=
=y9Ii
-----END PGP SIGNATURE-----

--73evo3vnpt6mv5jd--
