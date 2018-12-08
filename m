From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management fixes for v4.20-rc6
Date: Sat, 8 Dec 2018 13:28:48 -0800
Message-ID: <20181208212847.GA3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Consider pulling the following patches containing fixes on thermal soc.

The following changes since commit 0072a0c14d5b7cb72c611d396f143f5dcd73ebe2:

  Merge tag 'media/v4.20-4' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2018-12-03 11:29:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to 1aea7aee805e3d1288f9f1fa4484964b51664960:

  thermal: broadcom: constify thermal_zone_of_device_ops structure (2018-12-05 06:47:46 -0800)

Specifics:
 - Fixes on armada and broadcom thermal drivers.

BR,

Eduardo

----------------------------------------------------------------
Julia Lawall (2):
      thermal: armada: constify thermal_zone_of_device_ops structure
      thermal: broadcom: constify thermal_zone_of_device_ops structure

Russell King (2):
      thermal: armada: fix legacy validity test sense
      thermal: armada: fix legacy resource fixup

Stefan Wahren (1):
      thermal: bcm2835: Switch to SPDX identifier

 drivers/thermal/armada_thermal.c           | 28 +++++++++++++---------------
 drivers/thermal/broadcom/bcm2835_thermal.c | 11 +----------
 drivers/thermal/broadcom/brcmstb_thermal.c |  2 +-
 3 files changed, 15 insertions(+), 26 deletions(-)
