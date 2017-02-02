From: Markus Mayer <code@mmayer.net>
Subject: [PATCH 0/3] cpufreq: bmips-cpufreq: CPUfreq driver for Broadcom's BMIPS SoCs
Date: Wed,  1 Feb 2017 17:05:58 -0800
Message-ID: <20170202010601.75995-1-code@mmayer.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-so.shaw.ca ([64.59.136.138]:44872 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdBBBGJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2017 20:06:09 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Markus Mayer <mmayer@broadcom.com>

This series adds a CPUfreq driver for the BMIPS SoCs. In the first
iteration only BMIPS5xxx SoCs are supported.

This series is based on 4.10-rc1.

Markus Mayer (3):
  BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
  cpufreq: bmips-cpufreq: CPUfreq driver for Broadcom's BMIPS SoCs
  MIPS: BMIPS: enable CPUfreq

 arch/mips/Kconfig                     |   2 +
 arch/mips/configs/bmips_stb_defconfig |  10 ++
 drivers/cpufreq/Kconfig               |  10 ++
 drivers/cpufreq/Makefile              |   1 +
 drivers/cpufreq/bmips-cpufreq.c       | 205 ++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 drivers/cpufreq/bmips-cpufreq.c

-- 
2.7.4

