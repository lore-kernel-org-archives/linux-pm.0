From: kbuild test robot <fengguang.wu@intel.com>
Subject: ERROR: "devfreq_monitor_resume" undefined!
Date: Wed, 28 Nov 2012 08:01:52 +0800
Message-ID: <50b55470.8yQB+TYqddithSLm%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:29923 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab2K1ACY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 27 Nov 2012 19:02:24 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-pm@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   0917293958d5d33213a23125ce5d9c7a852469d6
commit: 883d588e556347c4b3221ac492a8acd8a75e730a PM / devfreq: remove compiler error when a governor is module
date:   2 days ago
config: make ARCH=m68k allmodconfig

All error/warnings:

ERROR: "devfreq_monitor_resume" undefined!
ERROR: "devfreq_monitor_suspend" undefined!
ERROR: "devfreq_interval_update" undefined!
ERROR: "devfreq_monitor_stop" undefined!
ERROR: "devfreq_monitor_start" undefined!

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
