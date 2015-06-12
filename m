From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V2] Report interrupt(s) that caused system wakeup
Date: Fri, 12 Jun 2015 10:58:54 -0700
Message-ID: <1434131935-7015-1-git-send-email-alexandra.yates@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43513 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797AbbFLSAK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Jun 2015 14:00:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, peterz@infradead.org, Alexandra Yates <alexandra.yates@linux.intel.com>

Please review the attached patch.
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

