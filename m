From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/3][v2] Fix incorrect using of acpi irq
Date: Sun, 25 Oct 2015 01:02:07 +0800
Message-ID: <1445706127-20110-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: rui.zhang@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

This series of patches are trying to convert codes who use
acpi_gbl_FADT.sci_interrupt incorrectly to use the right irq
mapped by acpi_gsi_to_irq.

Chen Yu (3):
  ACPI: Using correct irq when uninstalling acpi irq handler
  ACPI: Using correct irq when waiting for events
  ACPI / PM: Fix incorrect wakeup irq setting before suspend-to-idle

 drivers/acpi/osl.c   | 14 +++++++++-----
 drivers/acpi/sleep.c |  6 ++++--
 include/linux/acpi.h |  6 ++++++
 3 files changed, 19 insertions(+), 7 deletions(-)

-- 
1.8.4.2

