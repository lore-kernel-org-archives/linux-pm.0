From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH v4 0/5] Enabling the asynchronous threads for other phases
Date: Tue, 18 Feb 2014 10:28:43 +0800
Message-ID: <1392690528-10024-1-git-send-email-chuansheng.liu@intel.com>
References: <y>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19699 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287AbaBRCiP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Feb 2014 21:38:15 -0500
In-Reply-To: <y>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, gregkh@linuxfoundation.org, len.brown@intel.com, pavel@ucw.cz
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, zhuangzhi.li@intel.com, chuansheng.liu@intel.com

Hello,

This patch series are for enabling the asynchronous threads for the phases
resume_noirq, resume_early, suspend_noirq and suspend_late.

Just like commit 5af84b82701a and 97df8c12995, with async threads it will
reduce the system suspending and resuming time significantly.

With these patches, in my test platform, it saved 80% time in resume_noirq
phase.

Best Regards,

---
V2:
 -- Based on Rafael's minor changes related to coding style, white space etc;
 -- Rafael pointed out the v1 series break the device parent-children
    suspending/resuming order when enabling asyncing, here using the
    dev completion to sync parent-children order;

V3:
 -- In patch v2 5/5, there is one missing "dpm_wait_for_children";

V4:
 -- Rafael pointed out that dpm_wait_for_children()/dpm_wait()
    should be put after some simple returning statement;

---

[PATCH v4 1/5] PM / sleep: Two flags for async suspend_noirq and
[PATCH v4 2/5] PM / sleep: Asynchronous threads for resume_noirq
[PATCH v4 3/5] PM / sleep: Asynchronous threads for resume_early
[PATCH v4 4/5] PM / sleep: Asynchronous threads for suspend_noirq
[PATCH v4 5/5] PM / sleep: Asynchronous threads for suspend_late

 drivers/base/power/main.c | 275 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
 include/linux/pm.h        |   2 ++
 2 files changed, 227 insertions(+), 50 deletions(-)

