From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v4 0/8] Reset controller API to reset IP modules on i.MX5 and i.MX6
Date: Tue, 26 Feb 2013 12:39:26 +0100
Message-ID: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54299 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab3BZLj6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Feb 2013 06:39:58 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

[Added Len, Pavel, Rafael, and linux-pm to Cc, as there might be some
 need for integration with the PM runtime infrastructure?]

The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
reset lines to the GPU, VPU, IPU, and OpenVG IP modules.

The following patches add a simple API for devices to request being reset
by separate reset controller hardware and implements the reset signal
device tree binding proposed by Stephen Warren. Contrary to Tegra hardware,
the i.MX SRC contains self-deasserting reset registers, so I've included
both ops to manually assert/deassert a reset line, as well as a "reset"
operation that is supposed to assert the reset line and wait for it to
deassert.
Also included is a GPIO reset controller driver that can handle reset
lines of external ICs connected to GPIOs.

The i.MX SRC is enhanced to provide a reset controller and the IPU driver
is made to request being reset by calling the device_reset(&pdev->dev)
convenience wrapper during probing.

I'm not sure how integration with the PM runtime should look like, since
there are quite different use cases for pulling a reset line. (Does the
device need to be reset once, or to be reset every time it comes out of
suspend? Or maybe the reset is just needed when the device gets stuck).

Changes since v3:
 - Addressed Stephen's concerns, adding id translation
   functionality and the missing devm_put_reset_controller
   to the core,
 - switched the gpio-reset driver's reset-delays property to
   microseconds and added an optional initially-in-reset property,
 - and reworked the gpio-reset probe function to better handle
   requested GPIOs returning -EPROBE_DEFER.

regards
Philipp

---
 .../devicetree/bindings/reset/fsl,imx-src.txt      |   49 ++++
 .../devicetree/bindings/reset/gpio-reset.txt       |   37 +++
 Documentation/devicetree/bindings/reset/reset.txt  |   75 +++++
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    3 +
 arch/arm/boot/dts/imx51.dtsi                       |    7 +
 arch/arm/boot/dts/imx53.dtsi                       |    7 +
 arch/arm/boot/dts/imx6q.dtsi                       |    1 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |    4 +-
 arch/arm/mach-imx/Kconfig                          |    3 +
 arch/arm/mach-imx/mm-imx5.c                        |    2 +
 arch/arm/mach-imx/src.c                            |   69 ++++-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    3 +
 drivers/reset/Kconfig                              |   26 ++
 drivers/reset/Makefile                             |    2 +
 drivers/reset/core.c                               |  298 ++++++++++++++++++++
 drivers/reset/gpio-reset.c                         |  208 ++++++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-common.c        |   12 +-
 include/linux/reset-controller.h                   |   51 ++++
 include/linux/reset.h                              |   17 ++
 20 files changed, 871 insertions(+), 5 deletions(-)

