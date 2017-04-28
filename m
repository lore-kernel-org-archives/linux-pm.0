From: Jon Mason <jon.mason@broadcom.com>
Subject: [PATCH v3 0/3] thermal: broadcom: Add NSP Thermal Support
Date: Fri, 28 Apr 2017 16:11:28 -0400
Message-ID: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:32963 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035538AbdD1ULj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Apr 2017 16:11:39 -0400
Received: by mail-io0-f174.google.com with SMTP id k87so76834991ioi.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Apr 2017 13:11:38 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Changes in v3:
* Enable THERMAL on NSP, not all iProc Chips (per Scott Branden)
* Correct the Kconfig syntax in patch 2 (per Eduardo Valentin)

Changes in v2:
* Split SoC enablement into a separate patch (per Eduardo Valentin)
* Added Eduardo Valentin's Acked-by to the DTS patch


This adds support for NSP to the existing Northstar thermal driver.
This code is based on patches currently in the Linux SoC Thermal git
tree.  Specfically,
https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?h=linus&id=a94cb7eeecc4104a6874339f90c5d0647359c102

Jon Mason (3):
  ARM: BCM: Enable thermal support for NSP SoCs
  thermal: broadcom: ns-thermal: default on iProc SoCs
  ARM: dts: NSP: Add Thermal Support

 arch/arm/boot/dts/bcm-nsp.dtsi   | 26 ++++++++++++++++++++++++++
 arch/arm/mach-bcm/Kconfig        |  2 ++
 drivers/thermal/broadcom/Kconfig |  9 +++++----
 3 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.7.4
