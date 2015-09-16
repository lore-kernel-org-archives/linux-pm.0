From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH REPOST v6 0/8] ARM64: juno: add SCPI mailbox protocol, clock and CPUFreq support
Date: Wed, 16 Sep 2015 18:16:31 +0100
Message-ID: <1442423799-23892-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@kernel.org>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi ARM-SoC guys,

Olof had confused this with PSCI[0]. I assume the confusion is now
resolved ? I have now rebased the series on top of v4.3-rc1 and just
resending them again.

Please pull this series for v4.4

You can access it from:
	git://linux-arm.org/linux-skn.git juno_dvfs

BUT the ARM external git repository is still unreliable and hence I am
avoiding pull request. Can I request to pull it from the mails directly
instead ? Extremely sorry for the inconvenience.

Regards,
Sudeep

This patch series adds support for:
  1. SCPI(System Control and Power Interface) mailbox protocol driver.
     It uses ARM MHU mailbox controller driver on Juno but can work with
     any mailbox controllers using standard mailbox APIs
  2. Add support for clocks provided by SCP firmware through the SCPI
     interface
  3. Using the existing arm_big_little cpufreq driver and the newly
     added SCPI clock driver, it also adds support for CPU DVFS on
     ARM64 JUNO development platforms.

The SCPI protocol document is available @[1]

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/364229.html
[1] http://infocenter.arm.com/help/topic/com.arm.doc.dui0922b/index.html
v1: https://lkml.org/lkml/2015/4/27/232
v2: https://lkml.org/lkml/2015/5/14/470
v3: https://lkml.org/lkml/2015/5/27/220
v4: https://lkml.org/lkml/2015/6/8/178
v5: https://lkml.org/lkml/2015/7/23/270
v6: https://lkml.org/lkml/2015/7/31/692

Cc: devicetree@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-pm@vger.kernel.org

Sudeep Holla (8):
  Documentation: add DT binding for ARM System Control and Power
    Interface(SCPI) protocol
  firmware: add support for ARM System Control and Power Interface(SCPI)
    protocol
  clk: add support for clocks provided by SCP(System Control Processor)
  clk: scpi: add support for cpufreq virtual device
  cpufreq: arm_big_little: add SCPI interface driver
  arm64: dts: add SRAM, MHU mailbox and SCPI support on Juno
  arm64: dts: add CPU topology on Juno
  arm64: dts: add clock support for all the cpus

 Documentation/devicetree/bindings/arm/arm,scpi.txt | 150 +++++
 MAINTAINERS                                        |  10 +
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  54 ++
 arch/arm64/boot/dts/arm/juno-r1.dts                |  32 +
 arch/arm64/boot/dts/arm/juno.dts                   |  32 +
 drivers/clk/Kconfig                                |  10 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-scpi.c                             | 325 ++++++++++
 drivers/cpufreq/Kconfig.arm                        |  10 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/scpi-cpufreq.c                     | 124 ++++
 drivers/firmware/Kconfig                           |  19 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/arm_scpi.c                        | 711 +++++++++++++++++++++
 include/linux/scpi_protocol.h                      |  61 ++
 15 files changed, 1541 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.txt
 create mode 100644 drivers/clk/clk-scpi.c
 create mode 100644 drivers/cpufreq/scpi-cpufreq.c
 create mode 100644 drivers/firmware/arm_scpi.c
 create mode 100644 include/linux/scpi_protocol.h

-- 
1.9.1

