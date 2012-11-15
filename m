From: "hongbo.zhang" <hongbo.zhang@linaro.org>
Subject: [PATCH V6 0/2] Upstream ST-Ericsson thermal driver
Date: Thu, 15 Nov 2012 18:56:41 +0800
Message-ID: <1352977003-25095-1-git-send-email-hongbo.zhang@linaro.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:39386 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993226Ab2KOK5M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Nov 2012 05:57:12 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so621894dak.19
        for <linux-pm@vger.kernel.org>; Thu, 15 Nov 2012 02:57:11 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rui.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, amit.kachhap@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, "hongbo.zhang" <hongbo.zhang@linaro.com>

From: "hongbo.zhang" <hongbo.zhang@linaro.com>

V5->V6 Changes:

In patch "Thermal: Add ST-Ericsson DB8500 thermal driver":
 - Add depends on ARCH_U8500 in Kconfig

In patch "Thermal: Add ST-Ericsson DB8500 thermal properties and platform
 - Add Acked-by: Linus Walleij <linus.walleij@linaro.org>


hongbo.zhang (2):
  Thermal: Add ST-Ericsson DB8500 thermal driver.
  Thermal: Add ST-Ericsson DB8500 thermal properties and platform data.

 .../devicetree/bindings/thermal/db8500-thermal.txt |  44 ++
 arch/arm/boot/dts/dbx5x0.dtsi                      |  14 +
 arch/arm/boot/dts/snowball.dts                     |  31 ++
 arch/arm/configs/u8500_defconfig                   |   2 +
 arch/arm/mach-ux500/board-mop500.c                 |  64 +++
 drivers/thermal/Kconfig                            |  20 +
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/db8500_cpufreq_cooling.c           | 108 +++++
 drivers/thermal/db8500_thermal.c                   | 531 +++++++++++++++++++++
 include/linux/platform_data/db8500_thermal.h       |  38 ++
 10 files changed, 854 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/db8500-thermal.txt
 create mode 100644 drivers/thermal/db8500_cpufreq_cooling.c
 create mode 100644 drivers/thermal/db8500_thermal.c
 create mode 100644 include/linux/platform_data/db8500_thermal.h

-- 
1.8.0

