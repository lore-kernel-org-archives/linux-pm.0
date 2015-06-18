From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V4] Report interrupt(s) that caused system wakeup
Date: Wed, 17 Jun 2015 18:08:40 -0700
Message-ID: <1434589721-15018-1-git-send-email-alexandra.yates@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30715 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbbFRBHi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Jun 2015 21:07:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, peterz@infradead.org, Alexandra Yates <alexandra.yates@linux.intel.com>

Hi Rafael,

Please accept this patch.

Thank you,
Alexandra.

Alexandra Yates (1):
  Report interrupt(s) that caused system wakeup

 Documentation/ABI/testing/sysfs-power | 11 +++++++++++
 drivers/base/power/wakeup.c           | 31 +++++++++++++++++++++++++++++++
 include/linux/irq.h                   |  7 +++++++
 include/linux/suspend.h               |  1 +
 kernel/irq/pm.c                       |  2 ++
 kernel/power/main.c                   | 23 +++++++++++++++++++++++
 6 files changed, 75 insertions(+)

-- 
1.9.1

