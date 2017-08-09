From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v3 3/4] ARM: multi_v7_defconfig: add CONFIG_BRCMSTB_THERMAL
Date: Wed,  9 Aug 2017 14:56:31 -0700
Message-ID: <20170809215632.4124-4-code@mmayer.net>
References: <20170809215632.4124-1-code@mmayer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170809215632.4124-1-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Doug Berger <opendmb@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Turn on CONFIG_BRCMSTB_THERMAL as module.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4d19c1b..230f7fa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -455,6 +455,7 @@ CONFIG_SENSORS_NTC_THERMISTOR=m
 CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_CPU_THERMAL=y
+CONFIG_BRCMSTB_THERMAL=m
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
-- 
2.7.4
