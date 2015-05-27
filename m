From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v3 0/5] ARM64: juno: add SCPI mailbox protocol, clock and CPUFreq support
Date: Wed, 27 May 2015 10:53:13 +0100
Message-ID: <1432720398-5701-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series adds support for:
  1. SCPI(System Control and Power Interface) mailbox protocol driver.
     It uses ARM MHU mailbox controller driver on Juno but can work with
     any mailbox controllers using standard mailbox APIs
  2. Add support for clocks provided by SCP firmware through the SCPI
     interface
  3. Using the existing arm_big_little cpufreq driver and the newly
     added SCPI clock driver, it also adds support for CPU DVFS on
     ARM64 JUNO development platforms.

The SCPI protocol document is available @[1],[2]

I am not sure which tree would be appropriate to merge this. The
clock and cpufreq drivers depend on the SCPI protocol header.

Changes v2->v3:
	- Minor fix in SCPI driver and added Tixy's reviewed-by tag
	- Updated scpi clock driver to incorporate all the comments from
	  Stephen
	- Added Viresh's ack

Changes v1->v2:
	- Updated the token handling in scpi driver as per Tixy's
	  suggestion along with other review comments
	- Removed multiple drivers in scpi clock as Lorenzo suggested
	- Added free_opp_table in scpi-cpufreq as Viresh suggested
	- Separated the DT binding document
	- Moved SCPI protocol driver to drivers/firmware

Regards,
Sudeep

[1] http://community.arm.com/servlet/JiveServlet/download/8401-45-18326/DUI0922B_scp_message_interface.pdf
[2] https://wiki.linaro.org/ARM/Juno?action=AttachFile&do=get&target=DUI0922B_scp_message_interface.pdf
v1: https://lkml.org/lkml/2015/4/27/232
v2: https://lkml.org/lkml/2015/5/14/470

Sudeep Holla (5):
  Documentation: add DT binding for ARM System Control and Power
    Interface(SCPI) protocol
  firmware: add support for ARM System Control and Power Interface(SCPI)
    protocol
  clk: add support for clocks provided by SCP(System Control Processor)
  clk: scpi: add support for cpufreq virtual device
  cpufreq: arm_big_little: add SCPI interface driver

 Documentation/devicetree/bindings/arm/arm,scpi.txt | 121 ++++
 drivers/clk/Kconfig                                |  10 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-scpi.c                             | 299 +++++++++
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/scpi-cpufreq.c                     | 124 ++++
 drivers/firmware/Kconfig                           |  19 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/arm_scpi.c                        | 709 +++++++++++++++++++++
 include/linux/scpi_protocol.h                      |  62 ++
 11 files changed, 1356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.txt
 create mode 100644 drivers/clk/clk-scpi.c
 create mode 100644 drivers/cpufreq/scpi-cpufreq.c
 create mode 100644 drivers/firmware/arm_scpi.c
 create mode 100644 include/linux/scpi_protocol.h

--
1.9.1
