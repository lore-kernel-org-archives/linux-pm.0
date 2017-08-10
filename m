From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/4] Switch Ux500 to use generic DT cpufreq
Date: Thu, 10 Aug 2017 14:52:17 +0200
Message-ID: <20170810125221.25818-1-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34943 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdHJMwa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2017 08:52:30 -0400
Received: by mail-lf0-f46.google.com with SMTP id t128so3019047lff.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2017 05:52:30 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

This series switches the Ux500 over to use the generic DT cpufreq.
A pretty nice cleanup.

Merge plan:

- Merge patch 1/4 into ARM SoC DTS branches separately.

- Merge the remaining three patches into the cpufreq tree
  with Lee's ACK on the second (MFD) patch.

This should make for a clean transition for v4.14.

Linus Walleij (4):
  ARM: dts: augment Ux500 to use DT cpufreq
  cpufreq: enable the DT cpufreq driver on the Ux500
  mfd: db8500-prcmu: Get rid of cpufreq dependency
  cpufreq: dbx500: Delete obsolete driver

 arch/arm/boot/dts/ste-dbx5x0.dtsi    |  15 ++---
 arch/arm/mach-ux500/Kconfig          |   1 +
 drivers/cpufreq/Kconfig.arm          |   9 ---
 drivers/cpufreq/Makefile             |   1 -
 drivers/cpufreq/cpufreq-dt-platdev.c |   5 ++
 drivers/cpufreq/dbx500-cpufreq.c     | 103 -----------------------------------
 drivers/mfd/db8500-prcmu.c           |  59 ++++++--------------
 7 files changed, 31 insertions(+), 162 deletions(-)
 delete mode 100644 drivers/cpufreq/dbx500-cpufreq.c

-- 
2.9.4
