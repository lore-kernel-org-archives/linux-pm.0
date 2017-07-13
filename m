From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power-supply changes for 4.13 (part 2)
Date: Thu, 13 Jul 2017 12:22:32 +0200
Message-ID: <20170713102232.dhwcq2e6ml4ijhnc@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tg5fjojqgctmbki7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbdGMKWg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jul 2017 06:22:36 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--tg5fjojqgctmbki7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I have two more fixes for the power-supply subsystem.

The following changes since commit bfa953d336cdd713f6968c85ca820ef22333dc35:

  power: supply: sbs-battery: Don't needlessly set CAPACITY_MODE (2017-06-15 16:52:04 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.13-2

for you to fetch changes up to 7bb5a650f3471e4052e1692b29b0f3d3ca099c47:

  power: supply: twl4030-charger: add deferred probing for phy and iio (2017-07-03 19:15:22 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.13 series (part 2)

* two fixes for twl4030-charger

----------------------------------------------------------------
H. Nikolaus Schaller (2):
      power: supply: twl4030-charger: move irq allocation to just before irqs are enabled
      power: supply: twl4030-charger: add deferred probing for phy and iio

 drivers/power/supply/twl4030_charger.c | 43 ++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 15 deletions(-)

--tg5fjojqgctmbki7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllnSeUACgkQ2O7X88g7
+pq8dg//ZSEdV3ksReNiIQZf+S2oC6pS6p/saPk+4OHxrjJ7KVYzt9PzwmLnXYTQ
bDsG6Kp4o/Kw5rzh8T76mpaLMzI3uQG15lnEpsWaW/z6oXeB+37iYuLp6AMQt0uy
/w0wywNGVyzJ8wNoxM+j+utPoBhsOkAoYU8BwPMx1zj9FO22MuZLtPyLaoczCxYX
a7GSCn7Gyv7NaflkEl+VQermEgTANZ1D/FR2m9bv2UmokFk98/qelWtJawVAb2/c
671LTiOjayuPisomXbgm+8c2Buj31P+BJ89yGDvHeoWQ9nQCeYvXqNbF7A60OP3c
e5x8e5i0v01WtU7ACRazMuSI4MbGeDDqhGCXbR6blPh99HpmFP5ttmbmbEnYSfUW
w3Fw+KsMQWMs5EUpKATMAvCLLNaeOejcx425bYgie5XWWNFHvW85X0t+StI8UKno
AgbkADJOktIty8yujrQ7RmN6GQ9+u0/DTtWQjMvjvVDo1SWw8A02ivv3/BA5nVa3
snJ422LXso6WXRSapsktfuDol2m7bHGyCClg9C2fKGX8UFJVTZdQ2IgUiN9BIEL8
ivAIVn52zzr9Tu1vJKmB7wGVIrbi9oT4UVP/3lFAwz0FP6Rt87YrrCtXb/tPyzTw
nYqON1GAxLJo53Is93CwiOvUeLlRgS/0BziFp0R5Gi+FtL+6Te4=
=Fwbq
-----END PGP SIGNATURE-----

--tg5fjojqgctmbki7--
