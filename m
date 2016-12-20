From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v4 0/2] cpufreq: brcmstb-cpufreq: CPUfreq driver for older Broadcom STB SoCs
Date: Tue, 20 Dec 2016 14:55:28 -0800
Message-ID: <20161220225530.96699-1-code@mmayer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Clock List <linux-clk@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

This CPUfreq driver provides basic frequency scaling for older Broadcom
STB SoCs that do not use AVS firmware with DVFS support. There is no
support for voltage scaling.

v3 of this patch can be found here: https://lkml.org/lkml/2016/11/22/747

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

 .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    |  83 +++++
 MAINTAINERS                                        |   1 +
 drivers/cpufreq/Kconfig.arm                        |  12 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/brcmstb-cpufreq.c                  | 377 +++++++++++++++++++++
 5 files changed, 474 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
 create mode 100644 drivers/cpufreq/brcmstb-cpufreq.c

-- 
2.7.4
