From: Jon Mason <jon.mason@broadcom.com>
Subject: [PATCH 0/2] thermal: broadcom: Add NSP Thermal Support
Date: Tue, 25 Apr 2017 16:49:09 -0400
Message-ID: <1493153351-12698-1-git-send-email-jon.mason@broadcom.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34365 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954477AbdDYUtd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 16:49:33 -0400
Received: by mail-pg0-f47.google.com with SMTP id v1so22104848pgv.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2017 13:49:33 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

This adds support for NSP to the existing Northstar thermal driver.
This code is based on patches currently in the Linux SoC Thermal git
tree.  Specfically,
https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?h=linus&id=a94cb7eeecc4104a6874339f90c5d0647359c102


Jon Mason (2):
  thermal: broadcom: Allow for NSP to use ns-thermal driver
  ARM: dts: NSP: Add Thermal Support

 arch/arm/boot/dts/bcm-nsp.dtsi   | 26 ++++++++++++++++++++++++++
 arch/arm/mach-bcm/Kconfig        |  2 ++
 drivers/thermal/broadcom/Kconfig |  9 +++++----
 3 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.7.4
