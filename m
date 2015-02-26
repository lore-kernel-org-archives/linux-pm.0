From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 0/2] cpufreq: hisilicon acpu support
Date: Thu, 26 Feb 2015 21:21:37 +0800
Message-ID: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:40715 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbbBZNWU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 08:22:20 -0500
Received: by paceu11 with SMTP id eu11so13939822pac.7
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2015 05:22:20 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dan Zhao <dan.zhao@hisilicon.com>, zhenwei.wang@hisilicon.com, mohaoju@hisilicon.com
Cc: Leo Yan <leo.yan@linaro.org>

This series adds support for hisilicon acpu cpufreq driver, which
has been tested on Linaro's 96board "hikey" with hi6220 SoC.

Leo Yan (2):
  cpufreq: hisilicon: add acpu driver
  dt-bindings: cpufreq: document for hisilicon acpu driver

 .../bindings/cpufreq/cpufreq-hisi-acpu.txt         | 112 +++++++
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/hisi-acpu-cpufreq.c                | 324 +++++++++++++++++++++
 4 files changed, 446 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-hisi-acpu.txt
 create mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c

-- 
1.9.1

