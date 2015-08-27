From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V6] Report interrupt(s) that caused system wakeup
Date: Thu, 27 Aug 2015 13:00:42 -0700
Message-ID: <1440705643-3092-1-git-send-email-alexandra.yates@linux.intel.com>
References: <[PATCH V6] Report interrupt(s) that caused system wakeup>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43531 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbbH0T7A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 15:59:00 -0400
In-Reply-To: <[PATCH V6] Report interrupt(s) that caused system wakeup>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, rjw@rjwysocki.net, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org
Cc: ayates1 <alexandra.yates@intel.com>

From: ayates1 <alexandra.yates@intel.com>

Hi Rafael, 

The current patch reflects the changes requested by Thomas Gleixner.  

Please accept my patch. 

Thank you, 
Alexandra. 

Alexandra Yates (1):
  Report interrupt(s) that caused system wakeup

 Documentation/ABI/testing/sysfs-power | 11 +++++++++++
 drivers/base/power/wakeup.c           | 33 ++++++++++++++++++++++++++++++++-
 include/linux/suspend.h               |  5 +++--
 kernel/irq/pm.c                       |  2 +-
 kernel/power/main.c                   | 23 +++++++++++++++++++++++
 5 files changed, 70 insertions(+), 4 deletions(-)

-- 
1.9.1

