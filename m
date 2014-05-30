From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/6] thermal: sti: Add new Thermal driver
Date: Fri, 30 May 2014 10:38:29 +0100
Message-ID: <1401442715-6350-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:42315 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932619AbaE3JjA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 May 2014 05:39:00 -0400
Received: by mail-ie0-f170.google.com with SMTP id to1so268057ieb.1
        for <linux-pm@vger.kernel.org>; Fri, 30 May 2014 02:38:59 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, rui.zhang@intel.com, eduardo.valentin@ti.com, ajitpal.singh@st.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com

This patchset adds full support for 2 types of Thermal Controllers
produced by STMicroelectronics.  One is a more traditional memory
mapped variant, the other is controlled solely by system configuration
registers.

 Documentation/devicetree/bindings/thermal/st-thermal.txt |  42 ++++++++++++++++
 arch/arm/boot/dts/stih416.dtsi                           |  18 +++++++
 arch/arm/configs/multi_v7_defconfig                      |   2 +
 drivers/thermal/Kconfig                                  |   5 ++
 drivers/thermal/Makefile                                 |   1 +
 drivers/thermal/st/Kconfig                               |  12 +++++
 drivers/thermal/st/Makefile                              |   3 ++
 drivers/thermal/st/st_thermal.c                          | 313 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/st/st_thermal.h                          | 104 ++++++++++++++++++++++++++++++++++++++
 drivers/thermal/st/st_thermal_memmap.c                   | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/st/st_thermal_syscfg.c                   | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 888 insertions(+)

