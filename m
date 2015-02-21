From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management and ACPI updates for 3.20-rc1
Date: Sat, 21 Feb 2015 05:05:41 +0100
Message-ID: <CAJZ5v0j3cvMNxmzm8eueY_iHKPE7WvseFdsH9uaaYRCiKJ9OVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-3.20-rc1-3

to receive one more batch of power management and ACPI updates for
v3.20-rc1 or v4.0-rc1 (whichever that will be) with top-most commit
3466b547e37b988723dc93465b7cb06b4b1f731f

 Merge branches 'pnp', 'pm-cpuidle' and 'pm-cpufreq'

on top of commit 99fa0ad92c4fd8b529c89b3640b42323984be761

 Merge tag 'suspend-to-idle-3.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

These are mostly fixes on top of the previously merged recent PM and
ACPI material.

First, one commit that broke the ACPI LPSS (Low-Power Subsystem) driver
on a Dell box is reverted and there are two stable-candidate fixes for
that driver.  Another fix cleans up two recently added ACPI EC messages
that look odd and the printk level of a noisy debug message in the core
ACPI resources handling code is reduced.

In addition to that we have two stable-candidate fixes for the s3c
cpufreq driver, two cpuidle powernv driver updates related to Device
Trees and a PNP subsystem cleanup that will allow us to get rid of some
old ugliness going forward.  Also there is a new blacklist entry for the
ACPI backlight code.

Specifics:

 - Revert a recent ACPI LPSS driver commit that prevented the touchpad
   driver from loading on Dell XPS13 (Jarkko Nikula).

 - Make the ACPI LPSS driver disable the I2C controllers and deassert
   SPI host controllers resets at startup on Intel BayTrail and Braswell
   SoCs in case they have been left in wrong states by the platform
   firmware which then may casuse fatal controller driver failures during
   resume from hibernation (Mika Westerberg).

 - Make two recently added ACPI EC messages look better (Scot Doyle).

 - Reduce the printk level of a recently added debug message related to
   ACPI resources that may become noisy in some cases (Rafael J Wysocki).

 - Add a new ACPI backlight blacklist entry for Samsung Series 9
   (900X3C/900X3D/900X3E/900X4C/900X4D) laptops where the native backlight
   interface doesn't work while the ACPI based one does (Jens Reyer).

 - Make the PNP sybsystem's core code use __request_region() followed by
   __release_region() instead of __check_region() which then will allow
   us to get rid of the latter as it has no more users (Jakub Sitnicki).

 - Fix a build breakage and an issue with two __init functions that may be
   called after initialization in the s3c cpufreq driver (Arnd Bergmann).

 - Make the powernv cpuidle driver read target_residency values for idle
   states from a Device Tree (as we have the suitable DT bindings for that
   now) and improve the parsing of the powermgmt DT node in that driver
   (Preeti U Murthy).

Thanks!


---------------

Arnd Bergmann (2):
      cpufreq: s3c: remove incorrect __init annotations
      cpufreq: s3c: remove last use of resume_clocks callback

Jakub Sitnicki (1):
      PNP: Switch from __check_region() to __request_region()

Jarkko Nikula (1):
      Revert "ACPI / LPSS: Remove non-existing clock control from
Intel Lynxpoint I2C"

Jens Reyer (1):
      ACPI / video: Disable native backlight on Samsung Series 9 laptops

Mika Westerberg (2):
      ACPI / LPSS: Always disable I2C host controllers
      ACPI / LPSS: Deassert resets for SPI host controllers on Braswell

Preeti U Murthy (2):
      cpuidle: powernv: Read target_residency value of idle states
from DT if available
      cpuidle: powernv: Avoid endianness conversions while parsing DT

Rafael J. Wysocki (1):
      ACPI / resources: Change pr_info() to pr_debug() for debug information

Scot Doyle (1):
      ACPI / EC: Remove non-standard log emphasis

---------------

 drivers/acpi/acpi_lpss.c          | 21 ++++++++--
 drivers/acpi/ec.c                 |  4 +-
 drivers/acpi/resource.c           |  2 +-
 drivers/acpi/video.c              |  9 +++++
 drivers/cpufreq/s3c2416-cpufreq.c |  4 +-
 drivers/cpufreq/s3c24xx-cpufreq.c | 10 +----
 drivers/cpuidle/cpuidle-powernv.c | 84 +++++++++++++++++++++++----------------
 drivers/pnp/resource.c            |  6 ++-
 8 files changed, 86 insertions(+), 54 deletions(-)
