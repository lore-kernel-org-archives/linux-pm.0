From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management fixes for v4.12-rc3
Date: Sat, 27 May 2017 17:39:39 -0700
Message-ID: <20170528003938.GA5083@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36644 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdE1Ajo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 May 2017 20:39:44 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rui,

I know this is late, but please send these six fixes for next rc3.

The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to a54c51863ed1294078a435151e625313b4365ac5:

  thermal: broadcom: ns-thermal: default on iProc SoCs (2017-05-23 20:09:34 -0700)

----------------------------------------------------------------
Colin Ian King (1):
      thermal: core: make thermal_emergency_poweroff static

Jon Mason (1):
      thermal: broadcom: ns-thermal: default on iProc SoCs

Markus Elfring (3):
      ti-soc-thermal: Use devm_kcalloc() in ti_bandgap_build()
      ti-soc-thermal: Delete error messages for failed memory allocations in ti_bandgap_build()
      ti-soc-thermal: Fix a typo in a comment line

Masahiro Yamada (1):
      thermal: qoriq: remove useless call for of_thermal_get_trip_points()

 drivers/thermal/broadcom/Kconfig            |  9 +++++----
 drivers/thermal/qoriq_thermal.c             |  3 ---
 drivers/thermal/thermal_core.c              |  2 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 14 +++++---------
 4 files changed, 11 insertions(+), 17 deletions(-)

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZKhxDAAoJEA6VkvSQfF5Te0kP/Alxs+IkQc/30vhrusHz4QLW
G2jF0wa34W81MEOZVsip04NJJt0uzHGDpwPVoubVqinodOXAlpuNsX66enjCWMqt
1EUsWxte7AprFAahj8kEylZox7hKTzKPa6IYFirF4oQL8PX6BWTW2jlyAJrs9XGC
B5rjNk5rofxOPAIyDKDRV1yqYLDkP9098v+9GIZbS3Nb6wXYduwusck8TFFQrG0X
6NkJKJXI+IVyztmPUGrfydYqkjV8juG43nO+Pwj93lIz+EORK2IwRbQBCw9dJ9nj
GqehVoMpf7SBjDfn2+Hl+IJPXRJz1l1NbfJwdUMsDUX5w8JCTT532Tj3hyP5Yv9O
x/K+YqYrkehbRfO2HDRnqsyM4AoW+spZno2ddcNDoUFF7DQ9kCmGXOLemCt1Bsfa
Cy5lCGe7Hh0egfHtXIM7QYbaKQLpnIQexDNZm/MM3Inw1Tw3G/63JitDoTeDUV2e
rupvAIrexxbZLDa6IhtcivSEgM6hkdmRWYIEGA13EBj/x2NDXmDWLU0lqTtMfTWb
AnNTM8Keykce0TtMdroODN/MoKRKPqehLVXaNzgM1LfQSYjFpYpnD+IgDp2ADwlj
beANoV142Wgk3L9Z3Y0kti7BKR4CG9ACwuupMNOCP+hUdVvfi6W8tVb7vKhM4bFm
AAQEcmynV5xMAc30ErQZ
=JkWa
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
