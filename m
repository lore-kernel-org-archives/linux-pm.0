From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 0/4] Thermal:exynos: Thermal Measurement Unit fix and
 Samsung SoCs support
Date: Thu, 25 Apr 2013 14:30:41 +0200
Message-ID: <1366893045-31586-1-git-send-email-l.majewski@samsung.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, t.figa@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch series provide various fixes for TMU block.
First of all it fixes a problem with get_cpu_frequency() lockup at cpu_cooling.c. 

Secondly a proper regulator definition (VDD_TS) has been added.
Moreover device tree definitions and documentation entry are now in place.

Dependencies (those patches shall be applied on top of):
- "clk: exynos4: Add clock entries for TMU"
- "Thermal: exynos: Add clk_{un}prepare APIs"
- "Thermal: exynos: Add compatible string for exynos4412"


Lukasz Majewski (4):
  ARM: dts: thermal: exynos4: TMU device tree support for Exynos4412
    targets
  Thermal: exynos: Support for TMU regulator defined at device tree
  ARM: dts: thermal: exynos4: Add documentation for Exynos SoC thermal
    bindings
  ARM:TMU:fix: Avoid lockup when first frequency table entry is
    CPUFREQ_ENTRY_INVALID

 .../devicetree/bindings/thermal/exynos-thermal.txt |   25 ++++++++++++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi                  |   10 ++++++++
 drivers/thermal/cpu_cooling.c                      |    3 +--
 drivers/thermal/exynos_thermal.c                   |   19 +++++++++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt

-- 
1.7.10.4
