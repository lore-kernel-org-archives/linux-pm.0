From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][RFC] PM / sleep: Expose DPM watchdog timeout to sysfs
Date: Thu, 11 Aug 2016 20:29:17 +0800
Message-ID: <cover.1470908324.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45181 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331AbcHKMV0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Aug 2016 08:21:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM List <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.de>, Benoit Goby <benoit@android.com>, Chen Yu <yu.c.chen@intel.com>

Recently we have a new report that, the harddisk can not
resume on time due to firmware issues, and got a kernel
panic because of DPM watchdog timeout. Since the default
timeout has once been modified from 12 to 60 seconds, we
might still encounter new case which requires a longer timeout,
so expose the value to sysfs and let the users decide which
value is appropriate, meanwhile this can also ease the debugging
process.

The first patch is to force DPM watchdog depending on CONFIG_PM_SLEEP,
thus the second patch which does the actual work, can use
CONFIG_DPM_WATCHDOG safely without checking CONFIG_PM_SLEEP.

Chen Yu (2):
  PM / sleep: Make DPM watchdog depend on PM_SLEEP
  PM / Sleep: Expose DPM watchdog timeout to sysfs

 drivers/base/power/main.c    |  4 +++-
 include/linux/sched/sysctl.h |  4 ++++
 kernel/power/Kconfig         |  2 +-
 kernel/sysctl.c              | 16 ++++++++++++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.7.4

