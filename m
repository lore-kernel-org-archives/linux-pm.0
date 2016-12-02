From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 2/5] regulator: Document the regulator-allow-changes-at-runtime DT property
Date: Fri,  2 Dec 2016 14:57:13 +0100
Message-ID: <1480687036-5037-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60730 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760504AbcLBN5U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2016 08:57:20 -0500
In-Reply-To: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>

regulator-allow-changes-at-runtime is an extra property that can be
set in a regulator suspend state to tell whether the suspend state can
be entered at runtime or not.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 6ab5aef619d9..7b724650500a 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -37,6 +37,11 @@ Optional properties:
 	  The set of possible operating modes depends on the capabilities of
 	  every hardware so the valid modes are documented on each regulator
 	  device tree binding document.
+	- regulator-allow-changes-at-runtime: runtime changes are allowed when
+	  the regulator does not support programming a suspend state that will
+	  be applied later on when the system is suspended.
+	  Applying changes at runtime can be dangerous, and you should only
+	  add this property if you know what you're doing.
 - regulator-initial-mode: initial operating mode. The set of possible operating
   modes depends on the capabilities of every hardware so each device binding
   documentation explains which values the regulator supports.
-- 
2.7.4

