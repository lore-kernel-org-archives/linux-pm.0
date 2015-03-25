From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/3] power: reset: BCM63xx reboot support
Date: Tue, 24 Mar 2015 17:17:09 -0700
Message-ID: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33786 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbbCYASN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2015 20:18:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, jogo@openwrt.org, cernekee@gmail.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com

Hi all,

This patch series adds support for the BCM6328-style software reset hardware
block commonly found on Broadcom BCM63xx DSL SoCs.

Thanks!

Florian Fainelli (3):
  Documentation: bindings: add BCM6328-style soft reset binding
  power: reset: add Broadcom BCM63xx software reset driver
  ARM: dts: BCM63xx: add soft-reset node

 .../devicetree/bindings/arm/bcm/bcm63138.txt       | 16 +++++
 arch/arm/boot/dts/bcm63138.dtsi                    |  5 ++
 drivers/power/reset/Kconfig                        |  7 ++
 drivers/power/reset/Makefile                       |  1 +
 drivers/power/reset/bcm63xx-reboot.c               | 80 ++++++++++++++++++++++
 5 files changed, 109 insertions(+)
 create mode 100644 drivers/power/reset/bcm63xx-reboot.c

-- 
2.1.0

