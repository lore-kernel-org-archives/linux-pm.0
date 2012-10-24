From: "hongbo.zhang" <hongbo.zhang@linaro.org>
Subject: [PATCH V2 0/6] Fix thermal bugs and Upstream ST-Ericsson thermal driver
Date: Wed, 24 Oct 2012 19:58:14 +0800
Message-ID: <1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
References: <1350387889-15324-1-git-send-email-hongbo.zhang@linaro.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:58687 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab2JXL6z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Oct 2012 07:58:55 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so220401dak.19
        for <linux-pm@vger.kernel.org>; Wed, 24 Oct 2012 04:58:54 -0700 (PDT)
In-Reply-To: <1350387889-15324-1-git-send-email-hongbo.zhang@linaro.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, "hongbo.zhang" <hongbo.zhang@linaro.com>

From: "hongbo.zhang" <hongbo.zhang@linaro.com>

V1->V2 Changes:

DB8500 thermal dirver: Accept comments from Francesco Lavra and Viresh Kumar,
and split platform and driver parts into separate patches.

Thermal layer: Cancel the patch for deferring bind due to new patch for generic
cpu cooling layer to fix this issue.

CPU cooling layer: New patch "Remove the cooling_cpufreq_list" added, thus old
patch to fix empty list checking is also removed.

hongbo.zhang (6):
  Thermal: add indent for code alignment.
  Thermal: make sure cpufreq cooling register after cpufreq driver
  Thermal: fix bug of counting cpu frequencies.
  Thermal: Remove the cooling_cpufreq_list.
  Thermal: Add ST-Ericsson DB8500 thermal dirver.
  Thermal: Add ST-Ericsson DB8500 thermal properties and platform data.

 .../devicetree/bindings/thermal/db8500-thermal.txt |  40 ++
 arch/arm/boot/dts/dbx5x0.dtsi                      |  14 +
 arch/arm/boot/dts/snowball.dts                     |  31 ++
 arch/arm/configs/u8500_defconfig                   |   4 +
 arch/arm/mach-ux500/board-mop500.c                 |  64 +++
 drivers/thermal/Kconfig                            |  20 +
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/cpu_cooling.c                      |  95 +---
 drivers/thermal/db8500_cpufreq_cooling.c           | 123 +++++
 drivers/thermal/db8500_thermal.c                   | 557 +++++++++++++++++++++
 include/linux/platform_data/db8500_thermal.h       |  39 ++
 11 files changed, 920 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/db8500-thermal.txt
 create mode 100644 drivers/thermal/db8500_cpufreq_cooling.c
 create mode 100644 drivers/thermal/db8500_thermal.c
 create mode 100644 include/linux/platform_data/db8500_thermal.h

-- 
1.7.11.3

