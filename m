From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 05/48] mfd: as3722: Drop reference to pm_power_off from devicetree bindings
Date: Sun,  9 Nov 2014 17:42:22 -0800
Message-ID: <1415583785-6980-6-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38872 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbaKJBn1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Nov 2014 20:43:27 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xne0t-000Tqy-Ku
	for linux-pm@vger.kernel.org; Mon, 10 Nov 2014 01:43:27 +0000
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

Devicetree bindings are supposed to be operating system independent
and should thus not describe how a specific functionality is implemented
in Linux.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- No change.
v5:
- Rebase to v3.18-rc3
v4:
- No change
v3:
- No change
v2:
- No change

 Documentation/devicetree/bindings/mfd/as3722.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/as3722.txt b/Documentation/devicetree/bindings/mfd/as3722.txt
index 4f64b2a..0b2a609 100644
--- a/Documentation/devicetree/bindings/mfd/as3722.txt
+++ b/Documentation/devicetree/bindings/mfd/as3722.txt
@@ -122,8 +122,7 @@ Following are properties of regulator subnode.
 
 Power-off:
 =========
-AS3722 supports the system power off by turning off all its rail. This
-is provided through pm_power_off.
+AS3722 supports the system power off by turning off all its rails.
 The device node should have the following properties to enable this
 functionality
 ams,system-power-controller: Boolean, to enable the power off functionality
-- 
1.9.1

