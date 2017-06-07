From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v14 01/11] devicetree: property-units: Add uWh and uAh units
Date: Wed,  7 Jun 2017 11:37:49 -0700
Message-ID: <20170607183759.20261-2-liam@networkimprov.net>
References: <20170607183759.20261-1-liam@networkimprov.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607183759.20261-1-liam@networkimprov.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>
List-Id: linux-pm@vger.kernel.org

From: Matt Ranostay <matt@ranostay.consulting>

Add entries for microwatt-hours and microamp-hours.

Cc: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/property-units.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
index 12278d79..0849618a 100644
--- a/Documentation/devicetree/bindings/property-units.txt
+++ b/Documentation/devicetree/bindings/property-units.txt
@@ -25,8 +25,10 @@ Distance
 Electricity
 ----------------------------------------
 -microamp	: micro amps
+-microamp-hours : micro amp-hours
 -ohms		: Ohms
 -micro-ohms	: micro Ohms
+-microwatt-hours: micro Watt-hours
 -microvolt	: micro volts
 
 Temperature
-- 
2.13.0
