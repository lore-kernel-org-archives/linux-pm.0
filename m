From: kernel@martin.sperl.org
Subject: [PATCH-V2 4/5] ARM: bcm2835: add thermal driver to default_config
Date: Fri, 13 May 2016 13:13:05 +0000
Message-ID: <1463145186-12906-5-git-send-email-kernel@martin.sperl.org>
References: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 212-186-180-163.dynamic.surfer.at ([212.186.180.163]:54635 "EHLO
	cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbcEMNNU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 09:13:20 -0400
In-Reply-To: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>

From: Martin Sperl <kernel@martin.sperl.org>

Add the thermal driver to list of compiled modules
in the default config for bcm2835.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/configs/bcm2835_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 1ef69fc..f254d6b 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -71,6 +71,8 @@ CONFIG_SPI_BCM2835=y
 CONFIG_SPI_BCM2835AUX=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_BCM2835_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
 CONFIG_FB=y
-- 
2.1.4

