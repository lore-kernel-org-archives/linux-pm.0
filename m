From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 0/5] devfreq: Support resource management functions and code
 clean
Date: Fri, 09 May 2014 16:43:06 +0900
Message-ID: <1399621391-27228-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45721 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbaEIHnQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 03:43:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, jkosina@suse.cz, labbe.montjoie@gmail.com, a.kesavan@samsung.com, sreekumar.c@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patchset fix devfreq_remove_device() to remove duplicate function call
of _remove_devfreq() and add following functions for the resource management
of devfreq device and simpify the control of resource on exynos4_bus/exynos5_bus
driver.
- devm_devfreq_add_device
- devm_devfreq_remove_device
- devm_devfreq_register_opp_notifier
- devm_devfreq_unregister_opp_notifier

Changes from v1:
- Remove empty function (exynos5_init_exit) and propogate the return value
  without additonal local variable if failed to call devm_devfreqw_add_device
  in exynos5_busfreq.c.
- Fix return value from -ENOMEM to -ENOSYS in devm_devfreq_add_device() inline
  function.
- Fix minor coding style of devm_devfreq_dev_match()

Chanwoo Choi (5):
  devfreq: Fix devfreq_remove_device() to improve the sequence of resource free
  devfreq: Add resource-managed function for devfreq device
  devfreq: Add devm_devfreq_{register,unregister}_opp_notfier function
  devfreq: exynos4: Use devm_devfreq_* function using device resource management
  devfreq: exynos5: Use devm_devfreq_* function using device resource management

 drivers/devfreq/devfreq.c            | 125 ++++++++++++++++++++++++++++++++---
 drivers/devfreq/exynos/exynos4_bus.c |  19 ++----
 drivers/devfreq/exynos/exynos5_bus.c |  29 +++-----
 include/linux/devfreq.h              |  35 +++++++++-
 4 files changed, 161 insertions(+), 47 deletions(-)

-- 
1.8.0

