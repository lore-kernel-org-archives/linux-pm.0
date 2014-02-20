From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/8] PM / Sleep / Runtime: Fixup some driver's system suspend
Date: Thu, 20 Feb 2014 16:31:12 +0100
Message-ID: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:44279 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbaBTPb3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 10:31:29 -0500
Received: by mail-wi0-f180.google.com with SMTP id hm4so1920846wib.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2014 07:31:28 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Ulf Hansson <ulf.hansson@linaro.org>

Patch 1 -> 2:
These patches provides two new runtime PM helper functions which intend to be
used from system suspend/resume callbacks, to make sure devices are put into low
power state during system suspend and brought back to full power at system
resume.

The prerequisite is to have all levels of a device's runtime PM callbacks to be
defined through the SET_PM_RUNTIME_PM_OPS macro, which means these are available
for CONFIG_PM.

By using the new runtime PM helper functions especially the two scenarios below
will be addressed.

1) The PM core prevents .runtime_suspend callbacks from being invoked during
system suspend. That means even for a runtime PM centric subsystem and driver,
the device needs to be put into low power state from a system suspend callback.
Otherwise it may very well be left in full power state (runtime resumed) while
the system is suspended. By using the new helper functions, we make sure to walk
the hierarchy of a device's power domain, subsystem and driver.

2) Subsystems and drivers need to cope with all the combinations of
CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME. The two new helper functions smothly
addresses this.

Patch 3 -> 4:
Fixup system suspend for spi-pl022 driver, by using the new runtime PM helper
functions.

These patches is based upon the latest next-branch for spi-pl022 driver. They
will not apply to Rafael's linux-pm tree, but are included in this patchset for
reference and to receive comments/acks.

Patch 5:
Fixup system suspend for i2c-nomadik driver, by using the new runtime PM helper
functions.

This patch is based upon the latest next-branch for the i2c-nomadik driver. They
will not apply to Rafael's linux-pm tree, but are included in this patchset for
reference and to receive comments/acks.

Patch 6 -> 8:
Fixup system suspend for mmci driver, by using the new runtime PM helper
functions.


A final note, the amba bus has converted to use the SET_PM_RUNTIME_PM_OPS
which is needed for these patches to work with only CONFIG_PM_SLEEP and not
CONFIG_PM_RUNTIME. Anyway, the patches for the amba bus have recently been
applied by Russell and resides in his ARM tree.


Ulf Hansson (8):
  PM / Runtime: Fetch runtime PM callbacks using a macro
  PM / Sleep / Runtime: Add pm_runtime_suspend|resume_force functions
  spi: pl022: Let runtime PM callbacks be available for CONFIG_PM
  spi: pl022: Don't ignore power domain and amba bus at system suspend
  i2c: nomadik: Fixup system suspend
  mmc: mmci: Mask IRQs for all variants during runtime suspend
  mmc: mmci: Let runtime PM callbacks be available for CONFIG_PM
  mmc: mmci: Put the device into low power state at system suspend

 drivers/base/power/Makefile      |    3 +-
 drivers/base/power/runtime.c     |  143 +++++++++++++++++++++++++++-----------
 drivers/i2c/busses/i2c-nomadik.c |   14 ++--
 drivers/mmc/host/mmci.c          |   60 ++++------------
 drivers/spi/spi-pl022.c          |   58 ++++++----------
 include/linux/pm_runtime.h       |    4 ++
 6 files changed, 151 insertions(+), 131 deletions(-)

-- 
1.7.9.5

