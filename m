From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply changes for 4.5-rc
Date: Thu, 25 Feb 2016 01:31:12 +0100
Message-ID: <20160225003112.GA10250@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34831 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbcBYAbQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Feb 2016 19:31:16 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 81f70ba233d5f660e1ea5fe23260ee323af5d53a:

  Linux 4.5-rc5 (2016-02-20 13:39:35 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.5-rc

for you to fetch changes up to 9aafabc7fece13c8e2a1f680908c73ee19f0f79b:

  power: bq27xxx_battery: Restore device name (2016-02-21 20:49:34 +0100)

----------------------------------------------------------------
power supply fixes for the v4.5 series

Add a regression fix for changed sysfs path of
bq27xxx_battery and update MAINTAINERS file.

----------------------------------------------------------------
Ivaylo Dimitrov (1):
      power: bq27xxx_battery: Restore device name

Sebastian Reichel (1):
      MAINTAINERS: update bq27xxx driver

 MAINTAINERS                           | 10 ++++++++--
 drivers/power/bq27xxx_battery_i2c.c   | 37 ++++++++++++++++++++++++++++++++---
 include/linux/power/bq27xxx_battery.h |  1 +
 3 files changed, 43 insertions(+), 5 deletions(-)

-- Sebastian

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWzktFAAoJENju1/PIO/qaTSIP/3ayKFnS/6yUwUvoKOErw2Gt
GuW3ip2Bo1HMXkQ+IvUxk5IgNfNMd3Hce749c6+UmnDe9vSPR7MUIrY0V5ht6zf/
tvUWx5murzXBRswXHiztX86u3HEwka/R43kM0SDZmNNh8+pmlzrZu5hbQJy3NA99
NpnfqO81nVG9Ycfsa1Sk76kQmzSAN4iIt5JRCE4bEKh7l13I6kaNX8i/E2XuTsDj
zD/mZGEYiWJ/n9MCgXd+VX0vF0TnMiBfi1edQ6jpTqkS3ebIEMYYQ7FBa7ih5wJU
5Gq/GxUCFwuE/iux5kw7UZi7IwP2ISpIVVHkAgdOGWcXLSyQSdx5KCGGAEzsvGON
SOd3I63SiSR+47gW8EZT5PX1rbUQna+DFAG5S0Y4TIJ8/8XKeTiMiCbLilHXywJz
xYbDQVmi9/WHPgHBBdgEf0M4a8shn7fq3KKcdIXUVSQnSKB0WKxB3kBFyKKgOqfT
6ODWKwlU26WU2UqIXHiO3SKfPHxtux3enpOS0V0R3Ggl5ZnMkz6d8H7nttQHM2hL
X4mZ2LDjFSu0gAwqr9PjBeNxVm1sFpWfgZRsXvSur7DeByaxVywB+36iZT/o6Gmm
FuZ7YyuY/wFWJK1ybhxet3RqGw9KFS78iHymJ4ALuwSaMstDOPFsSd28ry3viwsk
vLtiwHkKsCMgmU70IwKN
=YlmY
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
