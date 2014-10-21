From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 07/47] qnap-poweroff: Drop reference to pm_power_off from devicetree bindings
Date: Mon, 20 Oct 2014 21:12:23 -0700
Message-ID: <1413864783-3271-8-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33553 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbaJUEN3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 00:13:29 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XgQp7-002ccQ-7K
	for linux-pm@vger.kernel.org; Tue, 21 Oct 2014 04:13:29 +0000
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

Replace reference to pm_power_off (which is an implementation detail)
and replace it with a more generic description of the driver's functionality.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Drop implementation details

 Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
index af25e77..c363d71 100644
--- a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
+++ b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
@@ -3,8 +3,7 @@
 QNAP NAS devices have a microcontroller controlling the main power
 supply. This microcontroller is connected to UART1 of the Kirkwood and
 Orion5x SoCs. Sending the character 'A', at 19200 baud, tells the
-microcontroller to turn the power off. This driver adds a handler to
-pm_power_off which is called to turn the power off.
+microcontroller to turn the power off.
 
 Synology NAS devices use a similar scheme, but a different baud rate,
 9600, and a different character, '1'.
-- 
1.9.1

