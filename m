From: "edubezval@gmail.com" <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v3.19-rc5
Date: Tue, 13 Jan 2015 15:55:58 -0400
Message-ID: <CAC-25o8q1bDOJ0_D=yaVv-w_=q9b1NE_T9oaKH3e66Cqfu8w0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
fixes

to receive Thermal SoC Management updates for v3.19-rc5 with top-most

ee853addd9fedb116bd34a18f11dd5959fcf0428:

  thermal: rcar: Spelling/grammar: s/drier use .../driver uses ...s/
(2015-01-12 16:48:10 -0400)

on top of commit 5e0f872c7d7e371fbdf09e864eddd24bddfda8fe:

  Merge branch 'upstream' of
git://git.infradead.org/users/pcmoore/audit (2014-12-31 14:52:18
-0800)

Specifics:

- Minor fixes on drivers' side: IMX and RCAR.
- Update TI SoC thermal maintainer entry.
- type qualifier fix in OF thermal.
- Updated documentation of OF cpufreq cooling register.

BR,

Eduardo Valentin

----------------------------------------------------------------
Anson Huang (1):
      Thermal: imx: add clk disable/enable for suspend/resume

Eduardo Valentin (1):
      MAINTAINERS: update ti-soc-thermal status

Geert Uytterhoeven (2):
      thermal: of: Remove bogus type qualifier for of_thermal_get_trip_points()
      thermal: rcar: Spelling/grammar: s/drier use .../driver uses ...s/

Javi Merino (1):
      Documentation: thermal: document of_cpufreq_cooling_register()

Nishanth Menon (1):
      MAINTAINERS: Add linux-omap to list of reviewers for TI Thermal

Yoshihiro Shimoda (2):
      thermal: rcar: fix ENR register value
      thermal: rcar: change type of ctemp in rcar_thermal_update_temp()

 Documentation/thermal/cpu-cooling-api.txt | 15 +++++++++++++--
 MAINTAINERS                               |  3 ++-
 drivers/thermal/imx_thermal.c             |  2 ++
 drivers/thermal/of-thermal.c              |  2 +-
 drivers/thermal/rcar_thermal.c            | 17 +++++++++++------
 drivers/thermal/thermal_core.h            |  4 ++--
 6 files changed, 31 insertions(+), 12 deletions(-)
