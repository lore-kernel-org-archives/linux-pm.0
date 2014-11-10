From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 06/48] gpio-poweroff: Drop reference to pm_power_off from devicetree bindings
Date: Sun,  9 Nov 2014 17:42:23 -0800
Message-ID: <1415583785-6980-7-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

pm_power_off is an implementation detail. Replace it with a more generic
description of the driver's functionality.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- No change.
v5:
- Rebase to v3.18-rc3
v4:
- No change
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
v2:
- No change

 Documentation/devicetree/bindings/gpio/gpio-poweroff.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
index d4eab92..78262de 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
@@ -2,12 +2,12 @@ Driver a GPIO line that can be used to turn the power off.
 
 The driver supports both level triggered and edge triggered power off.
 At driver load time, the driver will request the given gpio line and
-install a pm_power_off handler. If the optional properties 'input' is
-not found, the GPIO line will be driven in the inactive
+install a handler to power off the system. If the optional properties
+'input' is not found, the GPIO line will be driven in the inactive
 state. Otherwise its configured as an input.
 
-When the pm_power_off is called, the gpio is configured as an output,
-and drive active, so triggering a level triggered power off
+When the the power-off handler is called, the gpio is configured as an
+output, and drive active, so triggering a level triggered power off
 condition. This will also cause an inactive->active edge condition, so
 triggering positive edge triggered power off. After a delay of 100ms,
 the GPIO is set to inactive, thus causing an active->inactive edge,
@@ -24,7 +24,7 @@ Required properties:
 
 Optional properties:
 - input : Initially configure the GPIO line as an input. Only reconfigure
-  it to an output when the pm_power_off function is called. If this optional
+  it to an output when the power-off handler is called. If this optional
   property is not specified, the GPIO is initialized as an output in its
   inactive state.
 
-- 
1.9.1
