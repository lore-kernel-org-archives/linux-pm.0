From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v6 0/2] cpufreq: brcmstb-cpufreq: CPUfreq driver for older Broadcom STB SoCs
Date: Wed,  1 Feb 2017 15:26:36 -0800
Message-ID: <20170201232638.74396-1-code@mmayer.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:34386 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdBAX07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2017 18:26:59 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Clock List <linux-clk@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Markus Mayer <mmayer@broadcom.com>

This CPUfreq driver provides basic frequency scaling for older Broadcom
STB SoCs that do not use AVS firmware with DVFS support. There is no
support for voltage scaling.

v5 of this patch can be found at: https://lkml.org/lkml/2017/1/18/1093

Changes since v5:
  - Removed DT properties div-table and div-shift-width (Stephen Boyd)
  - Renamed node from cpu-clk-div@... to clock-controller@... (Rob Herring)
  - No code changes

v4 of this patch can be found at: https://lkml.org/lkml/2016/12/20/670

Changes since v4:
  - Simplified (and hopefully clarified) binding document
  - No code changes

v3 of this patch can be found at: https://lkml.org/lkml/2016/11/22/747

Changes since v3:
  - added binding document
  - got rid of calls to __clk_lookup(), using devm_clk_get() instead
  - re-worked clock lookup code a bit, along with switching to devm_clk_get()
  - get_frequencies() became a void function, removing the need for some
    error checking
  - fixed CONFIG_ARM_BRCM_AVS_CPUFREQ typo
  - fixed MODULE_DEVICE_TABLE declaration


Markus Mayer (2):
  dt-bindings: brcm: clocks: add binding for brcmstb-cpu-clk-div
  cpufreq: brcmstb-cpufreq: CPUfreq driver for older Broadcom STB SoCs

 .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    |  22 ++
 MAINTAINERS                                        |   1 +
 drivers/cpufreq/Kconfig.arm                        |  12 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/brcmstb-cpufreq.c                  | 377 +++++++++++++++++++++
 5 files changed, 413 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
 create mode 100644 drivers/cpufreq/brcmstb-cpufreq.c

-- 
2.7.4

