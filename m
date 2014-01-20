From: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: [PATCH 0/5] Enabling the asynchronous threads for other phases
Date: Mon, 20 Jan 2014 16:44:34 +0800
Message-ID: <1390207479-26064-1-git-send-email-chuansheng.liu@intel.com>
References: <y>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58889 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbaATIxZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Jan 2014 03:53:25 -0500
In-Reply-To: <y>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, gregkh@linuxfoundation.org, pavel@ucw.cz, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, zhuangzhi.li@intel.com

Hello,

This patch series are for enabling the asynchronous threads for the phases
resume_noirq, resume_early, suspend_noirq and suspend_late.

Just like commit 5af84b82701a and 97df8c12995, with async threads it will
reduce the system suspending and resuming time significantly.

With these patches, in my test platform, it saved 80% time in resume_noirq
phase.

Has done the suspend-resume stress test for a long time, please help to
review.

Best Regards,

[PATCH 1/5] PM: Adding two flags for async suspend_noirq and
[PATCH 2/5] PM: Enabling the asynchronous threads for resume_noirq
[PATCH 3/5] PM: Enabling the asyncronous threads for resume_early
[PATCH 4/5] PM: Enabling the asyncronous threads for suspend_noirq
[PATCH 5/5] PM: Enabling the asyncronous threads for suspend_late

 drivers/base/power/main.c |  240 ++++++++++++++++++++++++++++++++++++---------
 include/linux/pm.h        |    2 +
 2 files changed, 197 insertions(+), 45 deletions(-)

