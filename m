From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] dt-bindings: power: reset: gpio-poweroff: Drop reference to pm_power_off
Date: Mon, 30 Jan 2017 11:51:21 +0100
Message-ID: <20170130105122.6475-2-thierry.reding@gmail.com>
References: <20170130105122.6475-1-thierry.reding@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170130105122.6475-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

pm_power_off is an implementation detail. Replace it with a more generic
description of the driver's functionality.

Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Acked-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Acked-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/power/reset/gpio-poweroff.txt          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
index d4eab9227ea4..e62d53d844cc 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
+++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
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
+When the power-off handler is called, the gpio is configured as an
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
