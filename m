From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management fixes for v4.20-rc7
Date: Thu, 13 Dec 2018 12:01:49 -0800
Message-ID: <20181213200146.GA15849@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Consider pulling the following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to 99c47fcd4daa2b9a1348872ba49226dcdc58cb40:

  thermal: stm32: Fix stm_thermal_read_factory_settings (2018-12-10 20:15:28 -0800)

Specifics:
- Fixes on STM and HISI thermal drivers

BR,

Eduardo 

----------------------------------------------------------------
Daniel Lezcano (2):
      thermal/drivers/hisi: Fix wrong platform_get_irq_byname()
      thermal/drivers/hisi: Fix number of sensors on hi3660

David HERNANDEZ SANCHEZ (2):
      thermal: stm32: read factory settings inside stm_thermal_prepare
      thermal: stm32: Fix stm_thermal_read_factory_settings

 drivers/thermal/hisi_thermal.c   |  4 ++--
 drivers/thermal/st/stm_thermal.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)
