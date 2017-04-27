From: Jon Mason <jon.mason@broadcom.com>
Subject: [PATCH v2 0/3] thermal: broadcom: Add NSP Thermal Support
Date: Thu, 27 Apr 2017 17:23:11 -0400
Message-ID: <1493328194-1766-1-git-send-email-jon.mason@broadcom.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36076 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034875AbdD0VXZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2017 17:23:25 -0400
Received: by mail-wm0-f47.google.com with SMTP id u65so27537829wmu.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2017 14:23:24 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Changes in v2:
* Split SoC enablement into a separate patch (per Eduardo Valentin)
* Added Eduardo Valentin's Acked-by to the DTS patch


This adds support for NSP to the existing Northstar thermal driver.
This code is based on patches currently in the Linux SoC Thermal git
tree.  Specfically,
https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?h=linus&id=a94cb7eeecc4104a6874339f90c5d0647359c102

Jon Mason (3):
  ARM: BCM: Enable thermal support for iProc SoCs
  thermal: broadcom: ns-thermal: default on iProc SoCs
  ARM: dts: NSP: Add Thermal Support

 arch/arm/boot/dts/bcm-nsp.dtsi   | 26 ++++++++++++++++++++++++++
 arch/arm/mach-bcm/Kconfig        |  2 ++
 drivers/thermal/broadcom/Kconfig |  9 +++++----
 3 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.7.4
