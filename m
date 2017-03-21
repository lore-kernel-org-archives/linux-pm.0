From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v1 1/7] devicetree: power: battery: Add properties for pre-charge and end-charge current
Date: Tue, 21 Mar 2017 15:09:15 -0700
Message-ID: <20170321220921.5834-2-liam@networkimprov.net>
References: <20170321220921.5834-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35191 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933034AbdCUWRy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 18:17:54 -0400
In-Reply-To: <20170321220921.5834-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

precharge-current-microamp and endcharge-current-microamp are used
by battery chargers at the beginning and end of a charging cycle.

Depends-on: https://patchwork.kernel.org/patch/9633605/
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 Documentation/devicetree/bindings/power/supply/battery.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 53a68c0..494374a 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -12,6 +12,8 @@ Optional Properties:
  - voltage-min-design-microvolt: drained battery voltage
  - energy-full-design-microwatt-hours: battery design energy
  - charge-full-design-microamp-hours: battery design capacity
+ - precharge-current-microamp: current for pre-charge phase
+ - endcharge-current-microamp: current for charge termination phase
 
 Battery properties are named, where possible, for the corresponding 
 elements in enum power_supply_property, defined in
@@ -28,6 +30,8 @@ Example:
 		voltage-min-design-microvolt = <3200000>;
 		energy-full-design-microwatt-hours = <5290000>;
 		charge-full-design-microamp-hours = <1430000>;
+		precharge-current-microamp = <256000>;
+		endcharge-current-microamp = <128000>;
 	};
 
 	charger: charger@11 {
-- 
2.9.3
