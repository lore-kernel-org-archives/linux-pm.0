From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 5/8] dt/bindings: Update binding for PM domain idle states
Date: Fri,  7 Oct 2016 15:36:58 -0700
Message-ID: <1475879821-8035-6-git-send-email-lina.iyer@linaro.org>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34069 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754560AbcJGWhU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 18:37:20 -0400
Received: by mail-pf0-f177.google.com with SMTP id e6so29281026pfk.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Oct 2016 15:37:20 -0700 (PDT)
In-Reply-To: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>

Update DT bindings to describe idle states of PM domains.

This patch is based on the original patch by Marc Titinger.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/power/power_domain.txt     | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 025b5e7..7f8f27e 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -29,6 +29,10 @@ Optional properties:
    specified by this binding. More details about power domain specifier are
    available in the next section.
 
+- domain-idle-states : A phandle of an idle-state that shall be soaked into a
+                generic domain power state. The idle state definitions are
+                compatible with arm,idle-state specified in [1].
+
 Example:
 
 	power: power-controller@12340000 {
@@ -59,6 +63,38 @@ The nodes above define two power controllers: 'parent' and 'child'.
 Domains created by the 'child' power controller are subdomains of '0' power
 domain provided by the 'parent' power controller.
 
+Example 3:
+	parent: power-controller@12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12340000 0x1000>;
+		#power-domain-cells = <0>;
+		domain-idle-states = <&DOMAIN_RET>, <&DOMAIN_PWR_DN>;
+	};
+
+	child: power-controller@12341000 {
+		compatible = "foo,power-controller";
+		reg = <0x12341000 0x1000>;
+		power-domains = <&parent 0>;
+		#power-domain-cells = <0>;
+		domain-idle-states = <&DOMAIN_PWR_DN>;
+	};
+
+	DOMAIN_RET: state@0 {
+		compatible = "arm,idle-state";
+		reg = <0x0>;
+		entry-latency-us = <1000>;
+		exit-latency-us = <2000>;
+		min-residency-us = <10000>;
+	};
+
+	DOMAIN_PWR_DN: state@1 {
+		compatible = "arm,idle-state";
+		reg = <0x1>;
+		entry-latency-us = <5000>;
+		exit-latency-us = <8000>;
+		min-residency-us = <7000>;
+	};
+
 ==PM domain consumers==
 
 Required properties:
@@ -76,3 +112,5 @@ Example:
 The node above defines a typical PM domain consumer device, which is located
 inside a PM domain with index 0 of a power controller represented by a node
 with the label "power".
+
+[1]. Documentation/devicetree/bindings/arm/idle-states.txt
-- 
2.7.4

