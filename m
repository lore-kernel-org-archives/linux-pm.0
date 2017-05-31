From: Jon Mason <jon.mason@broadcom.com>
Subject: [PATCH] thermal: broadcom: ns-thermal: depends/default only for NS/NSP
Date: Wed, 31 May 2017 15:55:44 -0400
Message-ID: <1496260544-4200-1-git-send-email-jon.mason@broadcom.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36377 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdEaTzx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 15:55:53 -0400
Received: by mail-qt0-f170.google.com with SMTP id f55so20924639qta.3
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2017 12:55:53 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: rafal@milecki.pl, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

ARCH_BCM_IPROC includes support for many SoCs, not all of which have the
same thermal hardware interface as the Northstar/Northstar Plus SoCs.
This is not a major issue, as this driver will only be probed if the
relevant device tree entry is present.  However, it will result in a
slightly larger than necessary kernel.  By limiting the driver to only
work on the NS/NSP SoCs, we can avoid the issue.

Suggested-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 drivers/thermal/broadcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
index 42c098e86f84..c729dad2348c 100644
--- a/drivers/thermal/broadcom/Kconfig
+++ b/drivers/thermal/broadcom/Kconfig
@@ -8,8 +8,8 @@ config BCM2835_THERMAL
 
 config BCM_NS_THERMAL
 	tristate "Northstar thermal driver"
-	depends on ARCH_BCM_IPROC || COMPILE_TEST
-	default y if ARCH_BCM_IPROC
+	depends on ARCH_BCM_NSP || ARCH_BCM_5301X || COMPILE_TEST
+	default y if ARCH_BCM_NSP || ARCH_BCM_5301X
 	help
 	  Support for the Northstar and Northstar Plus family of SoCs (e.g.
 	  BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device
-- 
2.7.4
