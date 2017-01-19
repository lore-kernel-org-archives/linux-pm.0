From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v5 0/2] cpufreq: brcmstb-cpufreq: CPUfreq driver for older
 Broadcom STB SoCs
Date: Wed, 18 Jan 2017 16:29:31 -0800
Message-ID: <20170119002933.7529-1-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Markus Mayer <mmayer@broadcom.com>, Linux Clock List <linux-clk@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

This CPUfreq driver provides basic frequency scaling for older Broadcom
STB SoCs that do not use AVS firmware with DVFS support. There is no
support for voltage scaling.

v4 of this patch can be found at: https://patchwork.kernel.org/patch/9482357/

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

 .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    |  27 ++
 MAINTAINERS                                        |   1 +
 drivers/cpufreq/Kconfig.arm                        |  12 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/brcmstb-cpufreq.c                  | 377 +++++++++++++++++++++
 5 files changed, 418 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
 create mode 100644 drivers/cpufreq/brcmstb-cpufreq.c

-- 
2.7.4
