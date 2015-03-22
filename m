From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/7] power: enable cpufreq-dt support for i.MX23/i.MX28
Date: Sun, 22 Mar 2015 00:29:56 +0000
Message-ID: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:53863 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbCVAbY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2015 20:31:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shawn.guo@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
Cc: fabio.estevam@freescale.com, marex@denx.de, kernel@pengutronix.de, rjw@rjwysocki.net, viresh.kumar@linaro.org, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

This patch series adds cpufreq-dt support to Freescale i.MX23 and i.MX28.
It's the result of some discussions since August 2014 [1],[2],[3].

Summary
=======

Patch 1,2 - add driver for mxs power subsystem
Patch 3,4,5 - enable regulator support for i.MX23/i.MX28
Patch 6,7 - enable cpufreq-dt support for i.MX23/i.MX28

The main use of mxs_power driver is to trigger probing of the underlying DT
child nodes like the on-chip regulators. The mxs-regulator driver provides
for instance the voltage scaling support.

A detailed description of the MXS power subsystem is in the reference manual 
[4],[5].

Known issue
===========

The mxs clock driver provide the clock rate in Hz (454736842), but the 
operating points must be specified in kHz with less precision (454737).

So we get the following warning on boot [4]:

cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq: 454736 KHz
cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency changed to: 454737 KHz

Changes
=======
- rebase on next-20150320
- complete rewrite of regulator ops based on helper functions and imx-bootlets
- move DC-DC handling from mxs_power into mxs-regulator
- make DC-DC switching frequency a device tree property
- fix NULL pointer dereference in mxs_power_remove()
- add i.MX23 support
- add cpufreq-dt support

[1] - http://www.spinics.net/lists/arm-kernel/msg356455.html
[2] - https://lkml.org/lkml/2014/9/26/932
[3] - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304688.html
[4] - http://cache.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf
[5] - http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf
[6] - http://marc.info/?l=linux-pm&m=141225587213505&w=2

Stefan Wahren (7):
  DT: add binding for mxs power subsystem
  power: mxs_power: add driver for mxs power subsystem
  DT: add binding for MXS regulator
  regulator: add mxs regulator driver
  ARM: dts: enable regulator support for i.MX23/i.MX28
  ARM: mxs: register cpufreq-dt in pm init
  ARM: dts: add OPPs for i.MX23/i.MX28

 .../devicetree/bindings/power/mxs_power.txt        |   23 +
 .../bindings/regulator/mxs-regulator.txt           |   70 +++
 arch/arm/boot/dts/imx23.dtsi                       |   82 ++-
 arch/arm/boot/dts/imx28.dtsi                       |   82 ++-
 arch/arm/mach-mxs/pm.c                             |    6 +
 drivers/power/Kconfig                              |    8 +
 drivers/power/Makefile                             |    1 +
 drivers/power/mxs_power.c                          |  146 +++++
 drivers/regulator/Kconfig                          |    8 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/mxs-regulator.c                  |  624 ++++++++++++++++++++
 11 files changed, 1045 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/mxs_power.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mxs-regulator.txt
 create mode 100644 drivers/power/mxs_power.c
 create mode 100644 drivers/regulator/mxs-regulator.c

-- 
1.7.9.5

