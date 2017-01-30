From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 3/3] dt-bindings: power: reset: qnap-poweroff: Drop reference to pm_power_off
Date: Mon, 30 Jan 2017 11:51:22 +0100
Message-ID: <20170130105122.6475-3-thierry.reding@gmail.com>
References: <20170130105122.6475-1-thierry.reding@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33318 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbdA3Kvf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 05:51:35 -0500
In-Reply-To: <20170130105122.6475-1-thierry.reding@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>

From: Guenter Roeck <linux@roeck-us.net>

Replace reference to pm_power_off (which is an implementation detail)
and replace it with a more generic description of the driver's
functionality.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/power/reset/qnap-poweroff.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qnap-poweroff.txt b/Documentation/devicetree/bindings/power/reset/qnap-poweroff.txt
index af25e77c0e0c..c363d7173129 100644
--- a/Documentation/devicetree/bindings/power/reset/qnap-poweroff.txt
+++ b/Documentation/devicetree/bindings/power/reset/qnap-poweroff.txt
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
2.11.0

