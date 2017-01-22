From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v4 1/8] devicetree: property-units: add mWh and mAh units
Date: Sat, 21 Jan 2017 23:13:57 -0800
Message-ID: <20170122071404.9654-2-matt@ranostay.consulting>
References: <20170122071404.9654-1-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32973 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbdAVHOG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 02:14:06 -0500
Received: by mail-pf0-f178.google.com with SMTP id y143so32937155pfb.0
        for <linux-pm@vger.kernel.org>; Sat, 21 Jan 2017 23:14:06 -0800 (PST)
In-Reply-To: <20170122071404.9654-1-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: sre@kernel.org, tony@atomide.com, Matt Ranostay <matt@ranostay.consulting>

Add entries for microwatt-hours and microamp-hours to property
units.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 Documentation/devicetree/bindings/property-units.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
index 12278d79f6c0..5e8d220cc2b6 100644
--- a/Documentation/devicetree/bindings/property-units.txt
+++ b/Documentation/devicetree/bindings/property-units.txt
@@ -25,8 +25,10 @@ Distance
 Electricity
 ----------------------------------------
 -microamp	: micro amps
+-microamp-hours : micro amp hours
 -ohms		: Ohms
 -micro-ohms	: micro Ohms
+-microwatt-hours: micro Watt hours
 -microvolt	: micro volts
 
 Temperature
-- 
2.10.2

