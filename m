From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM updates for 2.6.32
Date: Mon, 14 Sep 2009 21:59:19 +0200
Message-ID: <200909142159.19474.rjw__9963.02117496288$1252958479$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management updates for 2.6.32 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

They include:

* The run-time PM framework, most basic bits to extend in future.
  It's functional, so subsystems can start using it right now,
  documentation is included (the upcoming sh-2.6 update contains some
  code depending on this already).

* Platform bus type support for run-time PM from Magnus Damm.

* Removal of the platform bus type's suspend_late()/resume_early()
  callbacks and converting the drivers that used them to struct
  dev_pm_ops.

* Rework of the hibernation freeing of memory (we're now almost
  ready to drop shrink_all_memory() altogether).

* A few bug fixes

 Documentation/power/runtime_pm.txt   |  378 +++++++++++++
 arch/arm/include/asm/device.h        |    3 +
 arch/arm/plat-omap/debug-leds.c      |   11 +-
 arch/arm/plat-omap/gpio.c            |   14 +-
 arch/ia64/include/asm/device.h       |    3 +
 arch/microblaze/include/asm/device.h |    3 +
 arch/powerpc/include/asm/device.h    |    3 +
 arch/sparc/include/asm/device.h      |    3 +
 arch/x86/include/asm/device.h        |    3 +
 drivers/base/dd.c                    |   11 +
 drivers/base/platform.c              |   84 ++--
 drivers/base/power/Makefile          |    1 +
 drivers/base/power/main.c            |  199 ++++---
 drivers/base/power/power.h           |   31 +-
 drivers/base/power/runtime.c         | 1011 ++++++++++++++++++++++++++++++++++
 drivers/block/floppy.c               |    9 +-
 drivers/dma/at_hdmac.c               |   19 +-
 drivers/dma/dw_dmac.c                |   15 +-
 drivers/dma/txx9dmac.c               |   15 +-
 drivers/i2c/busses/i2c-pxa.c         |   25 +-
 drivers/i2c/busses/i2c-s3c2410.c     |   25 +-
 drivers/pci/pci-driver.c             |   16 +-
 drivers/platform/x86/hp-wmi.c        |   15 +-
 drivers/usb/musb/musb_core.c         |   18 +-
 include/asm-generic/device.h         |    3 +
 include/linux/device.h               |    9 +-
 include/linux/platform_device.h      |    5 +-
 include/linux/pm.h                   |  115 ++++-
 include/linux/pm_runtime.h           |  114 ++++
 kernel/power/Kconfig                 |   14 +
 kernel/power/hibernate.c             |   21 +-
 kernel/power/main.c                  |   17 +
 kernel/power/power.h                 |    2 +-
 kernel/power/snapshot.c              |  412 +++++++++++----
 34 files changed, 2306 insertions(+), 321 deletions(-)

---------------

Albin Tonnerre (1):
      PM: Add convenience macro to make switching to dev_pm_ops less error-prone

Dan Williams (1):
      at_hdmac: Rework suspend_late()/resume_early()

Dmitry Torokhov (1):
      Driver Core: Make PM operations a const pointer

Frans Pop (2):
      floppy: Switch driver to dev_pm_ops
      hp-wmi: Switch driver to dev_pm_ops

Gerald Schaefer (1):
      PM / Hibernate / Memory hotplug: Always use for_each_populated_zone()

Magnus Damm (9):
      Driver Core: Add platform device arch data V3
      ARM: Rework omap suspend_late()/resume_early()
      DMA: Rework dw_dmac suspend_late()/resume_early()
      DMA: Rework txx9dmac suspend_late()/resume_early()
      I2C: Rework i2c-pxa suspend_late()/resume_early()
      I2C: Rework i2c-s3c2410 suspend_late()/resume() V2
      USB: Rework musb suspend()/resume_early()
      PM: Remove platform device suspend_late()/resume_early() V2
      PM: Run-time PM platform device bus support

Rafael J. Wysocki (5):
      PM: Introduce core framework for run-time PM of I/O devices (rev. 17)
      PM/Hibernate: Rework shrinking of memory
      PM/Hibernate: Do not release preallocated memory unnecessarily (rev. 2)
      PM/Hibernate: Do not try to allocate too much memory too hard (rev. 2)
      PM: Update kerneldoc comments in drivers/base/power/main.c

Thadeu Lima de Souza Cascardo (1):
      PM: Fix typo in label name s/Platofrm_finish/Platform_finish/

Wu Fengguang (1):
      PM: Trivial fixes

Xiaotian Feng (1):
      PM: Reset transition_started at dpm_resume_noirq
