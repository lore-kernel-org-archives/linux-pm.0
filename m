From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v4.16-rc1 #1
Date: Wed, 10 Jan 2018 11:22:48 -0800
Message-ID: <20180110192247.GA3837@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35491 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeAJTWn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jan 2018 14:22:43 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hello Rui,

Please pull the changes for thermal-soc for coming v4.16-rc1.
Changelog:
 - ARMADA thermal driver gains support for AP806 and CP110
 - rcar gains support for r8z7743
 - Fixes on other drivers: hisi, mtk, imx.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

for you to fetch changes up to d0ecbbbe518e1b256fcda1770ec06a5a1a058567:

  thermal/drivers/hisi: Remove bogus const from function return type (2018-01-02 10:44:58 -0800)

----------------------------------------------------------------
Baruch Siach (4):
      dt-bindings: thermal: Describe Armada AP806 and CP110
      thermal: armada: Use msleep for long delays
      thermal: armada: Add support for Armada AP806
      thermal: armada: Add support for Armada CP110

Biju Das (1):
      dt-bindings: thermal: rcar: Add device tree support for r8a7743

Geert Uytterhoeven (1):
      thermal/drivers/hisi: Remove bogus const from function return type

Matthias Brugger (1):
      thermal: mtk: Cleanup unused defines

Miquel Raynal (7):
      thermal: armada: Simplify the check of the validity bit
      thermal: armada: Clarify control registers accesses
      thermal: armada: Use real status register name
      thermal: armada: Update Kconfig and module description
      thermal: armada: Change sensors trim default value
      thermal: armada: Wait sensors validity before exiting the init callback
      thermal: armada: Give meaningful names to the thermal zones

Nicolin Chen (1):
      thermal: tegra: remove forward declarations

Uwe Kleine-König (4):
      thermal: imx: Use better parameter names than "val"
      thermal: imx: improve comments describing algorithm for temp calculation
      thermal: imx: use consistent style to write temperatures
      thermal: imx: update to new formula according to NXP AN5215

 .../devicetree/bindings/thermal/armada-thermal.txt |  37 ++-
 .../devicetree/bindings/thermal/rcar-thermal.txt   |   1 +
 drivers/thermal/Kconfig                            |   4 +-
 drivers/thermal/armada_thermal.c                   | 253 +++++++++++++++------
 drivers/thermal/hisi_thermal.c                     |   2 +-
 drivers/thermal/imx_thermal.c                      |  74 +++---
 drivers/thermal/mtk_thermal.c                      |   9 +-
 drivers/thermal/tegra/soctherm.c                   | 103 ++++-----
 8 files changed, 297 insertions(+), 186 deletions(-)
