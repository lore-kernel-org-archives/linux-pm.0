From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 4/4] ARM: configs: Update mvebu defconfig for thermal
Date: Tue, 26 Mar 2013 07:16:28 -0300
Message-ID: <1364292988-8358-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:51471 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757217Ab3CZKQu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Mar 2013 06:16:50 -0400
In-Reply-To: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The thermal management driver for Armada XP/370 has been added
so we update the defconfig to reflect this.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 2ec8119..fc7e8be 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -49,6 +49,8 @@ CONFIG_MTD_M25P80=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_THERMAL=y
+CONFIG_ARMADA_THERMAL=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.7.8.6

