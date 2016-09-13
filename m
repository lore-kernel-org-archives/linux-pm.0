From: kernel@martin.sperl.org
Subject: [PATCH V5 6/6] ARM64: bcm2835: add thermal driver to default_config
Date: Tue, 13 Sep 2016 09:34:22 +0000
Message-ID: <1473759262-27031-7-git-send-email-kernel@martin.sperl.org>
References: <1473759262-27031-1-git-send-email-kernel@martin.sperl.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:57312
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757860AbcIMJei (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 05:34:38 -0400
In-Reply-To: <1473759262-27031-1-git-send-email-kernel@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Stefan Wahren <stefan.wahren@i2se.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>

From: Martin Sperl <kernel@martin.sperl.org>

Add the thermal driver for bcm2837 to list of compiled modules
in the default config.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

Note: untested as I have no 64 bit test system.

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eadf485..372f981 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -252,6 +252,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
+CONFIG_BCM2835_THERMAL=y
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_RENESAS_WDT=y
--
2.1.4
