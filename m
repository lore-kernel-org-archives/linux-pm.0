From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V3] Report interrupt(s) that caused system wakeup
Date: Tue, 16 Jun 2015 17:33:02 -0700
Message-ID: <1434501183-21930-1-git-send-email-alexandra.yates@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46043 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637AbbFQAcB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Jun 2015 20:32:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, peterz@infradead.org, Alexandra Yates <alexandra.yates@linux.intel.com>

This version removes accidental vim "i" command.
  
Thank you, 
Alexandra.

Alexandra Yates (1):
  Report interrupt(s) that caused system wakeup

 Documentation/ABI/testing/sysfs-power | 11 +++++++++++
 drivers/base/power/wakeup.c           | 27 +++++++++++++++++++++++++++
 include/linux/irq.h                   |  9 +++++++++
 include/linux/suspend.h               |  1 +
 kernel/irq/pm.c                       |  6 ++++++
 kernel/power/main.c                   | 23 +++++++++++++++++++++++
 6 files changed, 77 insertions(+)

-- 
1.9.1

