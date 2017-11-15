From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power-supply changes for 4.15
Date: Wed, 15 Nov 2017 13:38:04 +0100
Message-ID: <20171115123804.c56jqazszmgyepmo@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="txgplteh6qdx6apa"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932619AbdKOMiH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Nov 2017 07:38:07 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--txgplteh6qdx6apa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Just a couple of small things coming in from the power-supply
subsystem for 4.15-rc1. A few other subsystems modified files in
the power-supply directory this time. I'm aware of the following:

 * sbs-manager (new driver) via i2c tree
 * timer conversion from Kees Cook via his tree
 * extcon API change via extcon tree

As far as I can see all patches modify different files and Stephen
Rothwell did not mention any merge problems in linux-next.

-- Sebastian

The following changes since commit 0b07194bb55ed836c2cc7c22e866b87a14681984:

  Linux 4.14-rc7 (2017-10-29 13:58:38 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.15

for you to fetch changes up to 838c8afa67f98014970c9f56107805e767ed87ad:

  power: supply: cpcap-charger: fix incorrect return value check (2017-11-13 11:56:12 +0100)

----------------------------------------------------------------
power supply and reset changes for the v4.15 series

* Misc. minor fixes

----------------------------------------------------------------
Aishwarya Pant (1):
      power: supply: replace pr_* with dev_*

Colin Ian King (2):
      power: supply: generic-adc-battery: remove redundant variable pdata
      power: supply: pcf50633-charger: remove redundant variable charging_start

Markus Elfring (1):
      power: supply: max8997: Improve a size determination in probe

Pan Bian (1):
      power: supply: cpcap-charger: fix incorrect return value check

 drivers/power/supply/cpcap-charger.c       | 2 +-
 drivers/power/supply/generic-adc-battery.c | 2 --
 drivers/power/supply/max8997_charger.c     | 3 +--
 drivers/power/supply/pcf50633-charger.c    | 2 --
 drivers/power/supply/power_supply_core.c   | 2 +-
 drivers/power/supply/twl4030_charger.c     | 2 +-
 6 files changed, 4 insertions(+), 9 deletions(-)

--txgplteh6qdx6apa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMNSkACgkQ2O7X88g7
+prRjg/+PtiZr9TJ7bJo740y9WPupPm9rD4s5AYR4Q1Je67UvF4gt2mlGqCs2dKI
Q8Ewd+gQCgwHvlY6XHK2XRQTcHC7RIjyE3DumJ9DEuA5PKp41PDHeJGwmn4tDfZH
h5R06d+lE6Rg9FBqDBeF10uAQtylyQCYSMHXFAK5ReYneFszeahFhVtFA2kWZirH
ipOdt4cYVu7P0iB7f54QqWoj6MQcUh01czgsLqgRRDH/qBx0V/jcMC+y36uSGVxq
aGl9lZbRBMzLzOibLN3buTt0dsUl9jTV3Nh0zYtRH5hDhYbg477oqnJCRCMsQ9l6
LFLwsTd13v1+eAHLueK9FUFfdVEWU2oTuzvj7nX3z3VEv6CWBfthCWfwCSLA1gUy
tK1SfUKF2rpL9fEQTs4n/BWM6uVeTtEFuHYbbJANkdKZxNqsLWk9gNTYy3sEihS+
OZ+GxmssIULJi9KGIxM527OejNUtYdlZFvFzR9BGilIGg0FMnOJUZNpfuy6tUwgT
lmm1Tw1WO78oHZEun5ya/0yvGch9MbK/PHD6xyvlM5xVhywZWDzi0+8bRIxgVTu3
C89yrFpVtLp0omxRIsRjpXvaOE60Kt+B2+0DAN/PKXI+xis3qIgxGfMGIX71J7LL
W8Qatc5EvIiMEQidJRjFqKFyf3VeH+3mVAWvvp9ogQTbd/8un2A=
=DW3W
-----END PGP SIGNATURE-----

--txgplteh6qdx6apa--
