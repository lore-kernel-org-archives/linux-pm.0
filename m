From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 0/6] regulator: enable regulator support for i.MX23/i.MX28
Date: Wed, 29 Apr 2015 22:32:21 +0000
Message-ID: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:59792 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbD2Wdo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2015 18:33:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, fabio.estevam@freescale.com, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

This patch series adds on-chip regulator support to Freescale i.MX23 and i.MX28.
It's the result of the last discussion about cpufreq-dt support [1]. This series
doesn't contain cpufreq-dt support anymore because it violated a constraint
between VDDD voltage and EMI clock frequency (Thanks to Juergen Borleis 
for pointing out).

The cpufreq-dt support would be a further patch series.

Summary
=======

Patch 1,2,3 - enable syscon support and add driver for mxs power subsystem
Patch 4,5,6 - enable regulator support for i.MX23/i.MX28

The main use of mxs_power driver is to trigger probing of the underlying DT
child nodes like the on-chip regulators. The mxs-regulator driver provides
for instance the voltage scaling support.

A detailed description of the i.MX28 power subsystem is in the reference manual 
[2] and application note 4199 [3].

Changes since V1
================
- rebase on Linux 4.1-rc1
- remove cpufreq-dt support
- use syscon for register access as suggested by Mark Brown
- rework regulator ramp up handling as suggested by Mark Brown
- use real switching frequencies for DC-DC instead of clock settings
- add warning in case of invalid switching frequency as suggested by Mark Brown
- some code clean ups
- add ASCII art of regulators to binding doc
- add more comments to regulator driver
- add COMPILE_TEST to dependencies for mxs power as suggested by Sebastian Reichel
- make use of stmp_device.h

[1] - http://comments.gmane.org/gmane.linux.power-management.general/58287
[2] - http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf
[3] - http://cache.freescale.com/files/32bit/doc/app_note/AN4199.pdf

Stefan Wahren (6):
  DT: add binding for mxs power subsystem
  ARM: mxs: select syscon for platform
  power: mxs_power: add driver for mxs power subsystem
  DT: add binding for mxs on-chip regulators
  regulator: add mxs on-chip regulator driver
  ARM: dts: enable regulator support for i.MX23/i.MX28

 .../devicetree/bindings/power/mxs_power.txt        |   17 +
 .../bindings/regulator/mxs-regulator.txt           |   65 +++
 arch/arm/boot/dts/imx23.dtsi                       |   40 +-
 arch/arm/boot/dts/imx28.dtsi                       |   40 +-
 arch/arm/mach-mxs/Kconfig                          |    1 +
 drivers/power/Kconfig                              |    8 +
 drivers/power/Makefile                             |    1 +
 drivers/power/mxs_power.c                          |  136 +++++
 drivers/regulator/Kconfig                          |    8 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/mxs-regulator.c                  |  540 ++++++++++++++++++++
 11 files changed, 855 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/mxs_power.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mxs-regulator.txt
 create mode 100644 drivers/power/mxs_power.c
 create mode 100644 drivers/regulator/mxs-regulator.c

-- 
1.7.9.5

