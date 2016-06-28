From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply changes for 4.7-rc
Date: Tue, 28 Jun 2016 02:42:50 +0200
Message-ID: <20160628004250.GB24501@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57246 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbcF1Amz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jun 2016 20:42:55 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.7-rc

for you to fetch changes up to 362761299eea7dfc3a4870551de36e08758b9254:

  power_supply: tps65217-charger: Fix NULL deref during property export (2016-06-16 15:54:11 +0200)

----------------------------------------------------------------
Power Supply Fixes for 4.7 cycle
----------------------------------------------------------------
Marcin Niestroj (1):
      power_supply: tps65217-charger: Fix NULL deref during property export

Rhyland Klein (1):
      power_supply: power_supply_read_temp only if use_cnt > 0

 drivers/power/power_supply_core.c | 27 ++++++++++++++++-----------
 drivers/power/tps65217_charger.c  |  6 +++++-
 2 files changed, 21 insertions(+), 12 deletions(-)

-- Sebastian

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXccgKAAoJENju1/PIO/qa1uIP/3I2qs2H3Uk48KWtuF2KgKBM
CXO+qIrkMkIvswUG2Yxc7qjNvq5hz4lAZPnt3dlGg/CojONuS30pAFEspKE8ktRD
+8exsujDeke2Q6+urEinkbiryMZw2/50tW0IdS8YKJB+CsF2WK3IvIPruICtG8bn
H4uMXCtMEU1EiGY1zIETqed/NpfadrCpsG+1n+Ix5/54rj3CLCw6ksH84t/w+Cok
4+7JZvDnCglyxccplp3gFde78K93BryzwUbe6S3oiu9qaIWvKmHXas/OzLHjGMNe
FxbVVdstqsiC4QwoS9ypliv1IVv81APiRuVNpk7hnWvg1zkfKrK1f2g9B4iZ6tMN
DPJOUcv+UhAAPz39qYTQoMBhKJnc5aF2afPXxwj1sOvkYp2H5hTqZCzTFgPfBSVR
PikkdVecfEACmC6ISrMMka3+NqYZQeVKWZKmJ9dvfhvpTXXGJILP0e9M3IQ+VUiE
xezeaEVpJXHds3uqVrpOY8UlYammdvRLG0ZRcKMi9g7KXvMekmj6ZEjgnH+q2vDf
/TSXD4JyI4BaQaTiejpx7B+k+x8iSJ9kriwEtVf1/xXD0YEwrZcambuh4QchpgYt
juF5APsYctOhzlRhJRfY0A2yWL7Rnfl/4FStD1CzAz5JHU5ZVdQ+9+tI6pI26ZhZ
TKsFiFyxcpWAoON9cPcd
=P+M1
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
