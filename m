From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v1 01/13] regmap: regmap-irq: Add main status
 register support
Date: Wed, 23 Jan 2019 15:55:31 +0000
Message-ID: <20190123155531.GC7503@sirena.org.uk>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <a5a3cdb00b9181897fc675f4a6900064d9289fdc.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a5a3cdb00b9181897fc675f4a6900064d9289fdc.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 11:42:24AM +0200, Matti Vaittinen wrote:

> There is bunch of devices with multiple logical blocks which
> can generate interrupts. It's not a rare case that the interrupt
> reason registers are arranged so that there is own status/ack/mask
> register for each logical block. In some devices there is also a
> 'main interrupt register(s)' which can indicate what sub blocks
> have interrupts pending.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-irq-main-status

for you to fetch changes up to a2d21848d9211dad5e786aa7368709ca8938834e:

  regmap: regmap-irq: Add main status register support (2019-01-23 15:52:15 +0000)

----------------------------------------------------------------
regmap: Main status register support

Add support for a main status register, used by chips on slower buses
with many interrupt sources to improve performance in interrupt
handling.

----------------------------------------------------------------
Matti Vaittinen (1):
      regmap: regmap-irq: Add main status register support

 drivers/base/regmap/regmap-irq.c | 99 ++++++++++++++++++++++++++++++++++++++--
 include/linux/regmap.h           | 31 +++++++++++++
 2 files changed, 126 insertions(+), 4 deletions(-)

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxIjnIACgkQJNaLcl1U
h9A6Dwf6A9lsIBpD+TiAoijbdEzoXqd/cmk7XgSy/A667LTDjzbi5yBhrjhOGwkz
83o5oE/oS6bba5hgVls8QO4C3sGrPhdtDPF+Q6LpGS4uNxq/o6Mv3KRbZU8RAPzZ
F0znv/m2UqJa67vx20iiS72+oZEyFfuaihQRjMBP+nP4nFu/dmnmLZegh3h6R/z6
xliTfo5ljMjCb2h379hdmlbv4FUJ9d4A7ARvs49AB6Wt/br0WWVdINBPQiVRWYY7
bTLeY9HglV2z2UL72NNMRU5ie1vhiLGDwCkEbiVWVXscay3sLl3xyBUJHFfLbc4D
kIE6YXfIVU52U/5gIucvj4wN2qz+Qg==
=kp0o
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
