From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/2] Support cpufreq driver for Exynos3250
Date: Fri, 18 Apr 2014 11:20:32 +0900
Message-ID: <1397787634-9334-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:12182 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbaDRCUd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Apr 2014 22:20:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: kgene.kim@samsung.com, kyungmin.park@samsung.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patchset support cpufreq driver for Exynos3250 which uses the Cortex-A7
dual cores and has a target speed of 1.0 GHz and code clean using dev_err/info
instead of pr_err/info function.

This patchset has a dependency on following patchset[1] to support Exynos3250:
[1] https://lkml.org/lkml/2014/4/17/669

Chanwoo Choi (2):
  cpufreq: exynos: Use dev_err/info function instead of pr_err/info
  cpufreq: exynos: Add new Exynos3250 cpufreq driver

 drivers/cpufreq/Kconfig.arm          |  11 +++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/exynos-cpufreq.c     |  25 +++---
 drivers/cpufreq/exynos-cpufreq.h     |  18 ++++
 drivers/cpufreq/exynos3250-cpufreq.c | 158 +++++++++++++++++++++++++++++++++++
 5 files changed, 203 insertions(+), 10 deletions(-)
 create mode 100644 drivers/cpufreq/exynos3250-cpufreq.c

-- 
1.8.0

