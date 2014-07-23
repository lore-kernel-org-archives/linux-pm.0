From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 00/16] cpuidle for Marvell Armada 370 and 38x
Date: Wed, 23 Jul 2014 15:00:37 +0200
Message-ID: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40654 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751143AbaGWNA5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 09:00:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hello,

Here comes the third version of the cpuidle support for Armada 370 and
Armada 38x.

We are hoping to see this patch series merged for 3.17.

Most patches are touching only arch/arm/mach-mvebu/ code so they
should be handled by the mvebu maintainers. However, patches 11-13 are
touching the mvebu cpuidle driver, with a possible issue on patch 11,
which touches both the cpuidle driver and the mach-mvebu code in order
to rename the driver without breaking functionality (if needed, we can
decide to split the commits, it would break functionality temporarly,
but not buildability).

Changes since v2
================

 * According to the discussion with Daniel Lezcano (cpuidle
   maintainer) and Arnd Bergmann, changed the cpuidle-mvebu-v7 driver
   to actually register three separate cpuidle platform driver, one
   per-SoC. This way, we don't need special platform data to convey
   the SoC type being used, as this information is already available
   by looking at the driver name.

   This change impacts the patches "cpuidle: mvebu: rename the driver
   from armada-370-xp to mvebu-v7", "cpuidle: mvebu: add Armada 370
   support", "cpuidle: mvebu: add Armada 38x support", "ARM: mvebu:
   add cpuidle support for Armada 370" and "ARM: mvebu: add cpuidle
   support for Armada 38x". Other patches are unchanged. The patch
   "cpuidle: mvebu: make the cpuidle driver capable of handling
   multiple SoCs" was no longer needed, so it has been removed.

Changes since v1
================

 * Series rebased on top of mvebu/fixes + mvebu/soc to take into
   account the conflicts with the changes already merged on the PMSU
   code.

 * Adjusted the fix that sorts the #include statements in pmsu.c by
   alphabetic order to really use the alphabetic order.

 * Various improvements to the implementation of the common function
   for the boot address workaround:

    - Main function renamed from mvebu_boot_addr_wa() to
      mvebu_setup_boot_addr_wa().
    - Both target and attribute of the crypto SRAM MBus window are now
      passed as arguments.
    - Use appropriate types for arguments.
    - Add error checking for ioremap() call.
    - Use __raw_writel() instead of direct pointer dereference
    - Fix the assembly code to work properly in big-endian
      configurations.

 * Misc small fixes in the migration of the Armada 375 SMP code to use
   the common function for the boot address workaround: use correct
   types, split in a separate function to reduce the indentation
   level, use better naming for macros, etc.

 * Re-organized the commits by grouping several patches that were
   separate before, to for example have a single patch to introduce
   the cpuidle support on Armada 370.

 * Move back into the cpuidle driver the list of the cpuidle states
   for each SoC.

 * Numerous other small typos and improvements.

Thanks,

Thomas

Gregory CLEMENT (14):
  ARM: mvebu: split again armada_370_xp_pmsu_idle_enter() in PMSU code
  ARM: mvebu: sort the #include of pmsu.c in alphabetic order
  ARM: mvebu: add a common function for the boot address work around
  ARM: mvebu: use the common function for Armada 375 SMP workaround
  ARM: mvebu: rename the armada_370_xp symbols to mvebu_v7 in pmsu.c
  ARM: mvebu: make the cpuidle initialization more generic
  ARM: mvebu: use a local variable to store the resume address
  ARM: mvebu: make the snoop disabling optional in
    mvebu_v7_pmsu_idle_prepare()
  ARM: mvebu: export the SCU address
  ARM: mvebu: add CA9 MPcore SoC Controller node
  cpuidle: mvebu: rename the driver from armada-370-xp to mvebu-v7
  ARM: mvebu: add cpuidle support for Armada 370
  ARM: mvebu: add cpuidle support for Armada 38x
  ARM: mvebu: defconfig: enable cpuidle support in mvebu_v7_defconfig

Thomas Petazzoni (2):
  cpuidle: mvebu: add Armada 370 support
  cpuidle: mvebu: add Armada 38x support

 .../bindings/arm/armada-380-mpcore-soc-ctrl.txt    |  14 ++
 arch/arm/boot/dts/armada-38x.dtsi                  |   5 +
 arch/arm/configs/mvebu_v7_defconfig                |   2 +
 arch/arm/mach-mvebu/armada-370-xp.h                |   1 -
 arch/arm/mach-mvebu/board-v7.c                     |   9 +-
 arch/arm/mach-mvebu/common.h                       |   2 +
 arch/arm/mach-mvebu/headsmp-a9.S                   |  15 --
 arch/arm/mach-mvebu/platsmp-a9.c                   |  42 +---
 arch/arm/mach-mvebu/platsmp.c                      |   2 +-
 arch/arm/mach-mvebu/pmsu.c                         | 273 ++++++++++++++++++---
 arch/arm/mach-mvebu/pmsu.h                         |   5 +
 arch/arm/mach-mvebu/pmsu_ll.S                      |  36 +++
 arch/arm/mach-mvebu/system-controller.c            |  31 +++
 drivers/cpuidle/Kconfig.arm                        |  12 +-
 drivers/cpuidle/Makefile                           |   2 +-
 drivers/cpuidle/cpuidle-armada-370-xp.c            |  93 -------
 drivers/cpuidle/cpuidle-mvebu-v7.c                 | 150 +++++++++++
 17 files changed, 500 insertions(+), 194 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
 delete mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
 create mode 100644 drivers/cpuidle/cpuidle-mvebu-v7.c

-- 
2.0.0

