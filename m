From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal management updates for v4.5-rc4
Date: Sat, 13 Feb 2016 09:52:07 -0800
Message-ID: <20160213175205.GA19191@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Please, consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal Management updates for v4.5-rc4 with top-most

a53b8394ec3c67255928df6ee9cc99dd1cd452e3:

  thermal: cpu_cooling: fix out of bounds access in time_in_idle (2016-02-11 07:13:29 -0800)

on top of commit 765bdb406de4b6132e349c5d4e077866536a9cc0:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2016-02-08 10:32:30 -0800)

Specifics in this pull request:
- Compilation fixes on SPEAR, and U8500 thermal drivers.
- RCAR thermal driver now recognizes OF-thermal based thermal zones.
- Small code rework on OF-thermal.
- These change have been CI tested using KernelCI bot [1,2]. \o/

I am taking over on Rui's behalf while he is out. Happy New Chinese Year!

[1] - https://kernelci.org/build/evalenti/kernel/v4.5-rc3-16-ga53b8394ec3c/
[2] - https://kernelci.org/boot/all/job/evalenti/kernel/v4.5-rc3-16-ga53b8394ec3c/

BR,

Eduardo Valentin

----------------------------------------------------------------
Arnd Bergmann (3):
      thermal: spear: use __maybe_unused for PM functions
      thermal: allow spear-thermal driver to be a module
      thermal: allow u8500-thermal driver to be a module

Javi Merino (1):
      thermal: cpu_cooling: fix out of bounds access in time_in_idle

Kuninori Morimoto (1):
      thermal: rcar: enable to use thermal-zone on DT

Laxman Dewangan (1):
      thermal: of: use for_each_available_child_of_node for child iterator

 .../devicetree/bindings/thermal/rcar-thermal.txt   | 37 +++++++++++++++++-
 drivers/mfd/db8500-prcmu.c                         |  3 ++
 drivers/thermal/Kconfig                            |  6 +--
 drivers/thermal/cpu_cooling.c                      | 14 ++++---
 drivers/thermal/of-thermal.c                       | 18 ++-------
 drivers/thermal/rcar_thermal.c                     | 45 +++++++++++++++++++---
 drivers/thermal/spear_thermal.c                    |  6 +--
 7 files changed, 94 insertions(+), 35 deletions(-)
