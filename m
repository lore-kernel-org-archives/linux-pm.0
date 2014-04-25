From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/5] devfreq: Support resource management functions and code
 clean
Date: Fri, 25 Apr 2014 18:08:09 +0900
Message-ID: <1398416894-6782-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:13336 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbaDYJIW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Apr 2014 05:08:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, cw00.choi@samsung.com, jkosina@suse.cz, labbe.montjoie@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This patchset fix devfreq_remove_device() to remove duplicate function call
of _remove_devfreq() and add following functions for the resource management
of devfreq device and simpify the control of resource on exynos4_bus/exynos5_bus
driver.
- devm_devfreq_add_device
- devm_devfreq_remove_device
- devm_devfreq_register_opp_notifier
- devm_devfreq_unregister_opp_notifier

Chanwoo Choi (5):
  devfreq: Fix devfreq_remove_device() to improve the sequence of resource free
  devfreq: Add resource-managed function for devfreq device
  devfreq: Add devm_devfreq_{register,unregister}_opp_notfier function
  devfreq: exynos4: Use devm_devfreq_* function using device resource management
  devfreq: exynos5: Use devm_devfreq_* function using device resource management

 drivers/devfreq/devfreq.c            | 125 ++++++++++++++++++++++++++++++++---
 drivers/devfreq/exynos/exynos4_bus.c |  19 ++----
 drivers/devfreq/exynos/exynos5_bus.c |  23 +++----
 include/linux/devfreq.h              |  35 +++++++++-
 4 files changed, 161 insertions(+), 41 deletions(-)

-- 
1.8.0

