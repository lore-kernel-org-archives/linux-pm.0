From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Wed, 27 May 2009 19:06:25 +0900
Message-ID: <20090527100625.29671.43166.sendpatchset__27130.4494621747$1243419035$gmane$org@rx1.opensource.se>
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
To: linux-pm@lists.linux-foundation.org
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

PM: Runtime platform device power management

[PATCH 01/04] Driver Core: Add platform device arch data
[PATCH 02/04] Driver Core: Add idle and wakeup functions
[PATCH 03/04] PM: Add platform bus runtime dev_pm_ops
[PATCH 04/04] sh: Runtime platform device PM mockup

These patches extend platform device and driver interfaces to
allow architectures to implement platform device runtime pm.

Upstream runtime power management needs to be improved to fully
make use of hardware power saving features found on embedded
platforms and in common SoCs.

For runtime power management we today have cpuidle, the clock
framework and qos. This allows the cpu core to enter various
forms of deep sleep, and for devices we may stop clocks to save
power. Modern SoCs however allow disabling of power to parts of
the chip, and we have no upstream interface to handle that today.

I propose adding the following simple platform device functions:
 - platform_device_wakeup()
 - platform_device_idle()

The idle function is used by the platform driver to let the 
architecture power management code know that from now on the
device is in idle state. When the device is marked as idle
the architecture specific runtime power management may decide
to do various levels of device power management, ranging from
stopping clocks to turning off power. The dev_pm_ops callbacks
may be invoked by the runtime pm code to save and restore state
whenever the device is marked as idle.

The wakeup function is used by the platform driver to notify the
architecture code that the driver wants to make use of the hardware
device. If the device has been put in sleep then it needs to be
woken up. This wakeup call may invoke dev_pm_ops callbacks.

Have a look at the last patch for a SuperH mockup that shows how
it all fits together. We need this or a similar interface to be able
to enter deep sleep states on SuperH. I believe other architectures
have similar requirements.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/Kconfig                               |    9 +
 arch/sh/Kconfig                            |    3 
 arch/sh/boards/mach-migor/setup.c          |    9 +
 arch/sh/include/asm/device.h               |    6 
 arch/sh/include/cpu-sh4/cpu/sh7722.h       |   14 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c     |   31 ++++
 arch/sh/kernel/cpu/shmobile/pm.c           |  118 +++++++++++++++++
 drivers/base/platform.c                    |  193 +++++++++++++++++++++++++++-
 drivers/clocksource/sh_cmt.c               |    2 
 drivers/clocksource/sh_tmu.c               |    2 
 drivers/i2c/busses/i2c-sh_mobile.c         |    2 
 drivers/media/video/sh_mobile_ceu_camera.c |    2 
 drivers/video/sh_mobile_lcdcfb.c           |    4 
 include/linux/platform_device.h            |   21 +++
 14 files changed, 415 insertions(+), 1 deletion(-)
