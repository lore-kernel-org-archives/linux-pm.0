From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 19/24] dt: bindings: ux500: Add documentation for power domains
Date: Tue, 10 Jun 2014 12:51:32 +0200
Message-ID: <1402397497-26737-20-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:42332 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaFJKww (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:52:52 -0400
Received: by mail-lb0-f172.google.com with SMTP id l4so3829211lbv.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 03:52:51 -0700 (PDT)
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../devicetree/bindings/arm/ux500/power_domain.txt |   35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ux500/power_domain.txt

diff --git a/Documentation/devicetree/bindings/arm/ux500/power_domain.txt b/Documentation/devicetree/bindings/arm/ux500/power_domain.txt
new file mode 100644
index 0000000..1c98f01
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ux500/power_domain.txt
@@ -0,0 +1,35 @@
+* ST-Ericsson UX500 Power Domains
+
+UX500 supports multiple power domains which are used to gate power to one or
+more peripherals on the SOC.
+
+The implementation of power domains for UX500 are based upon the generic power
+domain and use the corresponding DT bindings.
+
+==Power domain providers==
+
+Required properties:
+ - compatible: Must be "stericsson,ux500-pm-domains".
+ - #power-domain-cells : Number of cells in a power domain specifier, must be 1.
+
+Example:
+	pm_domains: pm_domains0 {
+		compatible = "stericsson,ux500-pm-domains";
+		#power-domain-cells = <1>;
+	};
+
+==Power domain consumers==
+
+Required properties:
+ - power-domains: A phandle and power domain specifier. Below are the list of
+		valid specifiers:
+
+		Index	Specifier
+		-----	---------
+		0	DOMAIN_VAPE
+
+Example:
+	sdi0_per1@80126000 {
+		compatible = "arm,pl18x", "arm,primecell";
+		power-domains = <&pm_domains DOMAIN_VAPE>
+	};
-- 
1.7.9.5

