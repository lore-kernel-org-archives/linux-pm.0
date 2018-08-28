From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.19-rc2
Date: Tue, 28 Aug 2018 16:06:53 -0700
Message-ID: <20180828230651.GA4974@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.19-rc2 with top-most

152395fd03d4ce1e535a75cdbf58105e50587611:

  thermal: of-thermal: disable passive polling when thermal zone is disabled (2018-08-20 12:00:40 -0700)

on top of commit 2ad0d52699700a91660a406a4046017a2d7f246a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-08-19 11:51:45 -0700)

Specifics:
- Minor fixes on OF thermal, qoriq, and rcar drivers.

On top of my local tests, here are the results from kernelCI:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.18-10727-g152395fd03d4/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.18-10727-g152395fd03d4/

BR,

Eduardo Valentin

----------------------------------------------------------------
Anson Huang (1):
      thermal: of-thermal: disable passive polling when thermal zone is disabled

Fabio Estevam (3):
      thermal: qoriq: Use devm_thermal_zone_of_sensor_register()
      thermal: qoriq: Simplify the 'site' variable assignment
      thermal: qoriq: Switch to SPDX identifier

Kuninori Morimoto (2):
      thermal: rcar_thermal: convert to SPDX identifiers
      thermal: rcar_gen3_thermal: convert to SPDX identifiers

 drivers/thermal/of-thermal.c        |  7 +++++--
 drivers/thermal/qoriq_thermal.c     | 27 ++++++++-------------------
 drivers/thermal/rcar_gen3_thermal.c | 11 +----------
 drivers/thermal/rcar_thermal.c      | 16 ++--------------
 4 files changed, 16 insertions(+), 45 deletions(-)
