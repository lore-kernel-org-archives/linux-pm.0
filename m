From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v8 0/5] amba/dma: pl330: add Power Management support
Date: Mon, 20 Oct 2014 11:04:43 +0200
Message-ID: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47572 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbaJTJFW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Oct 2014 05:05:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi,


Changes since v7:
=================
1. Add reviewed-by Ulf Hansson (patches 3, 4 and 5).
2. Patch 2/5: Fix missing return in amba_pclk_prepare() (suggested by
   Ulf Hansson).
3. Rebased on next-20141020.

Changes since v6:
=================
1. Add patch 5 removing the amba_pclk_*able macros.
2. Patch 2/5: Remove IS_ERR, use static inline functions instead
   of macros.
3. Patch 4/5: Force runtime suspend/resume in system sleep
   callbacks. Put with autosuspend at end of probe instead of no_idle.
   Suggested by Ulf Hansson.

Changes since v5:
=================
1. Patch 1/4: Add Ulf Hansson's reviewed-by.
2. Patch 4/4: Use PM runtime autosuspend (suggested by Ulf Hansson).
3. Rebase on next-20140922. 

Changes since v4:
1. Patch 3/4: Explicitly initialize amba_device.irq_safe field after
   probing driver (suggested by Russell King).

Changes since v3:
1. Patch 1/4: Document new API in Documentation/power/runtime_pm.txt
   (pointed by Alan Stern).

Changes since v2:
1. Add patch 1 (PM / Runtime: Add getter for querying the IRQ safe option)
2. Add patch 2 (amba: Add helper macros for (un)preparing AMBA clock)
3. Patch 3/4: Rewrite the idea. If IRQ safe runtime PM is set then
   do not unprepare/prepare the clocks. Suggested by Russell King.
4. Patch 4/4: During system sleep unprepare the clock.

Changes since v1:
1. Add patch 1 (amba: Allow AMBA drivers to use their own runtime PM).
2. Patch 2/2: Apply Michal Simek's suggestions.
3. Patch 2/2: Fix atomic context safeness in pl330_issue_pending().


Description:
============
This patchset adds runtime and system PM to the pl330 driver.

The runtime PM of pl330 driver requires interrupt safe suspend/resume
callbacks which is in conflict with current amba bus driver.
The latter also unprepares and prepares the AMBA bus clock which
is not safe for atomic context.

The patchset solves this in patch 3/5 by handling clocks in different
way if device driver set interrupt safe runtime PM.

Any comments are welcome.


Tested on board with pl330 DMA driver:
 - Trats2 (Exynos4212)


TODO/ideas:
===========
Consider renaming existing pm_runtime_irq_safe() function to keep
up with naming convention after adding pm_runtime_is_irq_safe() in
patch 1/5.
This naming:
 - pm_runtime_irq_safe() as setter,
 - pm_runtime_is_irq_safe() as getter,
is contradictory to naming of other PM runtime functions, e.g.:
 - pm_runtime_set_active() as setter,
 - pm_runtime_active() as getter.
I didn't change the naming of pm_runtime_irq_safe() because I wanted
to minimize the impact of the patches.


Best regards,
Krzysztof Kozlowski


Krzysztof Kozlowski (5):
  PM / Runtime: Add getter for querying the IRQ safe option
  amba: Add helpers for (un)preparing AMBA clock
  amba: Don't unprepare the clocks if device driver wants IRQ safe
    runtime PM
  dma: pl330: add Power Management support
  amba: Remove unused amba_pclk_enable/disable macros

 Documentation/power/runtime_pm.txt |  4 ++
 drivers/amba/bus.c                 | 29 ++++++++++--
 drivers/dma/pl330.c                | 94 ++++++++++++++++++++++++++++++++++++--
 include/linux/amba/bus.h           | 13 ++++--
 include/linux/pm_runtime.h         |  6 +++
 5 files changed, 134 insertions(+), 12 deletions(-)

-- 
1.9.1

