From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: What's in suspend-2.6.git
Date: Sun, 13 Sep 2009 01:09:11 +0200
Message-ID: <200909130109.11291.rjw__6493.39941232956$1252796990$gmane$org@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This is a summary of the changes queued on the #linux-next branch
of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git

They are going to be pushed to Linus in the next couple of days, since I know
Paul is waiting for some of them to appear upstream.

PM developers, please speak up if there's anything obviously wrong or missing.


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

Rafael J. Wysocki (6):
      PM: Introduce core framework for run-time PM of I/O devices (rev. 17)
      PM/Hibernate: Rework shrinking of memory
      PM/Hibernate: Do not release preallocated memory unnecessarily (rev. 2)
      PM/Hibernate: Do not try to allocate too much memory too hard (rev. 2)
      PM / irq: Fix comment describing suspend_device_irqs()
      PM: Update kerneldoc comments in drivers/base/power/main.c

Thadeu Lima de Souza Cascardo (1):
      PM: Fix typo in label name s/Platofrm_finish/Platform_finish/

Wu Fengguang (1):
      PM: Trivial fixes

Xiaotian Feng (1):
      PM: Reset transition_started at dpm_resume_noirq

---------------

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
 kernel/irq/pm.c                      |    8 +-
 kernel/power/Kconfig                 |   14 +
 kernel/power/hibernate.c             |   21 +-
 kernel/power/main.c                  |   17 +
 kernel/power/power.h                 |    2 +-
 kernel/power/snapshot.c              |  412 +++++++++++----
 35 files changed, 2310 insertions(+), 325 deletions(-)

Thanks,
Rafael
