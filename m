From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v2 0/4] cpufreq: bmips-cpufreq: Add CPUfreq driver for Broadcom's BMIPS SoCs
Date: Mon,  6 Feb 2017 13:51:15 -0800
Message-ID: <20170206215119.87099-1-code@mmayer.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:59777 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdBFVvs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 16:51:48 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Markus Mayer <mmayer@broadcom.com>

This series adds a CPUfreq driver for the BMIPS SoCs. In the first
iteration only BMIPS5xxx SoCs are supported.

The very first patch contains updates to bmips_stb_defconfig that are
unrelated to this series. Looks like bmips_stb_defconfig hasn't been
updated in a while. I didn't want to mix those changes with the CPUfreq
related ones, so that patch now comes first in the series and is
independent of the CPUfreq related changes to bmips_stb_defconfig
(patch 4/4).

This series is based on pm/linux-next.

Changes since v1:
  - based on pm/linux-next rather than 4.10-rc1
  - sanitized bmips_stb_defconfig by running "make savedefconfig"; this
    also lead to an additional patch (1/4), which contains non-CPUfreq
    related updates that "make savedefconfig" performed
  - use gobal variable to store driver data rather than policy->driver_data
  - got rid of some code as a result of using said global variable
  - kzalloc -> kmalloc
  - removed policy->freq_table = NULL;

Markus Mayer (4):
  MIPS: BMIPS: Update defconfig
  BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
  cpufreq: bmips-cpufreq: CPUfreq driver for Broadcom's BMIPS SoCs
  MIPS: BMIPS: enable CPUfreq

 arch/mips/Kconfig                     |   2 +
 arch/mips/configs/bmips_stb_defconfig |  16 +--
 drivers/cpufreq/Kconfig               |  10 ++
 drivers/cpufreq/Makefile              |   1 +
 drivers/cpufreq/bmips-cpufreq.c       | 195 ++++++++++++++++++++++++++++++++++
 5 files changed, 218 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpufreq/bmips-cpufreq.c

-- 
2.7.4

