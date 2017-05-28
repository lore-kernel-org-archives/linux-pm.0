From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL][RESEND] Thermal SoC management fixes for v4.12-rc3
Date: Sun, 28 May 2017 09:14:54 -0700
Message-ID: <20170528161451.GA11662@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

I know this is (very) late, but please consider these six fixes for next rc3.
I tried sending these via Rui, but I think I missed the window to get
him still in office, so I am sending directly to you.

Changelog in this pull:
- Fixes on TI SoC driver, Broadcom, qoriq.
- Small sparse warn fix on thermal core.

On top of my local test, these went through linux-next and kerneci.

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

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZKvd0AAoJEA6VkvSQfF5T4KEQALxOZsbK5fjP5nESqzKyhRPy
oqxgBsJcYmisMrVaCgnwocWTuMqiIYnbof8bwpdEUhL0FyP03Jz/8v4Q6tCvwiyV
RaoGM3fWyFjXK4F/5TloW5Q9aC8gof3wwSKhYJiyHZKuGlkYllikmWnYwGK7cmem
fd7wtlVxQuywjJIRbMnYS0VdzVjwQXYySp024JYhrWb4WmlHlrQ89LrxF25nmiso
p2e4TauNVeUxEtT65Dpos27B8KgwQLcfsdJuwGdGdxyzzXPujgKoYG4AcE7MQd2t
6W/DcfwIJ1n626stJsAxEaRlHNC2+w7wYKmJsH0JEkM+m478kGV2igCV8vPmpPjR
U3oIQ0XudIArZkX1cEHoaNdtG8Wb+B2H7wedVGY7jUmUXnu3OPvK+i/Z6l6rls9y
VCbcNLFQ6MyFURzko6XZGZYPkeAk35q9caTgixQnG7bBzcHzHR0QWvl4pzVzfVIv
VSDJSCGCVGb2Wn+qa661hLPaBIUMOlInS26T6vJjzCN6KmWP45Kx9upuqSRN5OYh
qyDVoCr4wcqauA7d6MAoEwjun+TzYa/acVaFmHFcWN/Kxr1bX4HNyJ3orCw4IC7r
K6DUj102c1h7IsukNAHYBJjG2cXfBn8hISLgYfyo1bTd4KhQyTiJgrLZfSK1Wtg8
1EW1/P0T5GNOntx3rvgu
=Q2vq
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
