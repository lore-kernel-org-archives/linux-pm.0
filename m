From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply changes for 4.3-rc
Date: Thu, 17 Sep 2015 20:35:24 +0200
Message-ID: <20150917183523.GA3510@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51382 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbbIQSff (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Sep 2015 14:35:35 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b8889c4fc6ba03e289cec6a4d692f6f080a55e53:

  Merge tag 'tty-4.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty (2015-09-09 11:27:01 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.3-rc

for you to fetch changes up to e11fc21e756e662e465cac3da6547d438d0b1446:

  twl4030_charger: fix another compile error (2015-09-10 22:13:11 +0200)

----------------------------------------------------------------
power supply and reset fixes for the v4.3 series

 * twl4030-charger fixes

----------------------------------------------------------------
Grazvydas Ignotas (1):
      twl4030_charger: fix another compile error

Sebastian Reichel (1):
      Revert "twl4030_charger: correctly handle -EPROBE_DEFER from devm_usb_get_phy_by_node"

 drivers/power/twl4030_charger.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV+wfnAAoJENju1/PIO/qa9LsP/AoOzNlT6bDEY1tViS3FQxjY
pDJD6oPl65D3A8PtVBIiIBynF2cZgddDHQd7u9EdG9+4D/1pM6jyG7+IYmCKbKPq
jzsZd0TIO1Hz2FZJ347VXjkaLNGBzagdvZZRQzqg4PQ4MGXBFQJGTyk7tRMEW4q0
3NvSvKQeike2nmztQAim2s7lNYLcZhua1J9LKBlBLZjeNHK0Zr56R75OIJIl35X4
EUkf1TatYdrXQsJuqaZzHhEii1tof3ubxWyuoF3IV1n2TBdMpmn/rwqlgZ42K1HV
R2RnAjOcBf7kjMIw72/Qcv1ZVL6M0K1C3/Yn0Q3VVaMVJ02OA8TPrej1iBW41e/s
M7OxswFnqn8llMUUxKYiwFK7173knfynR33ixJ5pddFzCtaBmdzlheHVw6/lu955
k0lcPE5qhAcY7cJ4qiOygCzZs0quTU+OTQ72icbl31eRD1XAMkkA5Pq1EZMt10+A
nDcOuxhoRFkMSfFMzPceiylftRaqtUnzry5GSjh15lwkN97hHS2QrBFlf1q4ixv1
uHSAzhufUg3DE/VlYuT8Cn+52fLY2gO0b9KUNUd6K5QtJOxZnrgeqU3EKAUD1tDk
4Ac5DbRyLIPSqXxABCiwHSHNLmVpp0dTu52bMDZ+sAa6thKl8TblsYQ7FYpZhSGO
jjGtk2L5tNikVRnE0cDy
=9z9k
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
