From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/3] dt-bindings: mfd: as3722: Drop reference to pm_power_off
Date: Mon, 30 Jan 2017 11:51:20 +0100
Message-ID: <20170130105122.6475-1-thierry.reding@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36748 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbdA3Kv0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 05:51:26 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>

From: Guenter Roeck <linux@roeck-us.net>

Devicetree bindings are supposed to be operating system independent and
should thus not describe how a specific functionality is implemented in
Linux.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/mfd/as3722.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/as3722.txt b/Documentation/devicetree/bindings/mfd/as3722.txt
index 4f64b2a73169..0b2a6099aa20 100644
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
2.11.0

