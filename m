From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 13/13] power: reset: ltc2952: document optional trigger behavior
Date: Wed, 22 Oct 2014 16:31:10 +0200
Message-ID: <1413988270-28092-14-git-send-email-frans.klaver@xsens.com>
References: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:49889 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbaJVObw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Oct 2014 10:31:52 -0400
In-Reply-To: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Document the fact that the trigger signal is now optional, and describe
the behavior when this is used.

While at it, fix a typo, and paraphrase a sentence to be less platform
specific.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 .../devicetree/bindings/power/reset/ltc2952-poweroff.txt    | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt
index 0c94c63..cd2d7f5 100644
--- a/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt
+++ b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt
@@ -1,20 +1,23 @@
 Binding for the LTC2952 PowerPath controller
 
 This chip is used to externally trigger a system shut down. Once the trigger has
-been sent, the chips' watchdog has to be reset to gracefully shut down.
-If the Linux systems decides to shut down it powers off the platform via the
-kill signal.
+been sent, the chip's watchdog has to be reset to gracefully shut down.
+A full powerdown can be triggered via the kill signal.
 
 Required properties:
 
 - compatible:		Must contain: "lltc,ltc2952"
-- trigger-gpios:	phandle + gpio-specifier for the GPIO connected to the
-			chip's trigger line
 - watchdog-gpios:	phandle + gpio-specifier for the GPIO connected to the
 			chip's watchdog line
 - kill-gpios:		phandle + gpio-specifier for the GPIO connected to the
 			chip's kill line
 
+Optional properties:
+- trigger-gpios:	phandle + gpio-specifier for the GPIO connected to the
+			chip's trigger line. If this property is not set, the
+			trigger function is ignored and the chip is kept alive
+			until an explicit kill signal is received
+
 Example:
 
 ltc2952 {
-- 
2.1.0

