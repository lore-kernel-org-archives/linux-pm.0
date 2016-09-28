From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2] Define positive return value to RPM_SUSPEND for runtime-suspended devices
Date: Wed, 28 Sep 2016 11:26:30 +0800
Message-ID: <cover.1475032126.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62628 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752805AbcI1DSf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Sep 2016 23:18:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

This patch set is to define the positive value returned
by device .prepare() callbacks, which is used to indicate
the devices are OK to remain in runtime-suspended during
system sleep. A precise return value would make the code
more readable.

Based on this definition, optimized the suspend process
in intel-lpss driver.

Chen Yu (2):
  PM / sleep: Return RPM_SUSPENDED to keep devices in runtime-suspended
  mfd: intel-lpss: Avoid resuming runtime-suspended lpss unnecessarily

 Documentation/power/devices.txt    | 8 ++++----
 Documentation/power/runtime_pm.txt | 2 +-
 drivers/base/power/main.c          | 8 ++++++--
 drivers/mfd/intel-lpss.c           | 9 +++++++++
 4 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.7.4

