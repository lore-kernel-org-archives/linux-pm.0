From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v5 0/8] Reset controller API to reset IP modules on i.MX5 and i.MX6
Date: Mon, 25 Mar 2013 18:06:21 +0100
Message-ID: <1364231189-12497-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35116 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272Ab3CYRHQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 13:07:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
reset lines to the GPU, VPU, IPU, and OpenVG IP modules.

The following patches add a simple API for devices to request being reset
by separate reset controller hardware and implements the reset signal
device tree binding proposed by Stephen Warren. Contrary to Tegra hardware,
the i.MX SRC contains self-deasserting reset registers, so I've included
both ops to manually assert/deassert a reset line, as well as a "reset"
operation that is supposed to assert the reset line and wait for it to
deassert.

The i.MX SRC is enhanced to provide a reset controller and the IPU driver
is made to request being reset by calling the device_reset(&pdev->dev)
convenience wrapper during probing.

Changes since v4:
 - removed flags parameter from .of_xlate / of_reset_simple_xlate
 - warn also if reset_spec->args_count > rcdev->of_reset_n_cells
 - unlock list mutex only after try_module_get
 - tighten devm_reset_control_match a bit

regards
Philipp

---
 .../devicetree/bindings/reset/fsl,imx-src.txt      |  49 ++++
 .../devicetree/bindings/reset/gpio-reset.txt       |  37 +++
 Documentation/devicetree/bindings/reset/reset.txt  |  75 ++++++
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |   3 +
 arch/arm/boot/dts/imx51.dtsi                       |   7 +
 arch/arm/boot/dts/imx53.dtsi                       |   7 +
 arch/arm/boot/dts/imx6q.dtsi                       |   1 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   4 +-
 arch/arm/mach-imx/Kconfig                          |   3 +
 arch/arm/mach-imx/mm-imx5.c                        |   2 +
 arch/arm/mach-imx/src.c                            |  69 ++++-
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   3 +
 drivers/reset/Kconfig                              |  26 ++
 drivers/reset/Makefile                             |   2 +
 drivers/reset/core.c                               | 297 +++++++++++++++++++++
 drivers/reset/gpio-reset.c                         | 208 +++++++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-common.c        |  12 +-
 include/linux/reset-controller.h                   |  51 ++++
 include/linux/reset.h                              |  17 ++
 20 files changed, 870 insertions(+), 5 deletions(-)

