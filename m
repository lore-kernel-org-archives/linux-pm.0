From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH v5] Report interrupt(s) that caused system wakeup*
Date: Thu,  6 Aug 2015 20:47:03 -0700
Message-ID: <1438919224-7003-1-git-send-email-alexandra.yates@linux.intel.com>
References: <[PATCH V5] Report interrupt(s) that caused a system wakeup>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10121 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbbHGDpY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 6 Aug 2015 23:45:24 -0400
In-Reply-To: <[PATCH V5] Report interrupt(s) that caused a system wakeup>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

Hi Rafael, 

Please accept this patch. 

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

