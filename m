From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V8 1/3] OPP: Allow OPP table to be used for power-domains
Date: Mon, 18 Dec 2017 15:51:28 +0530
Message-ID: <9cd1e90c782a8569d098adb63bee7dd1387528c4.1513591822.git.viresh.kumar@linaro.org>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33500 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932610AbdLRKVj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 05:21:39 -0500
Received: by mail-pl0-f68.google.com with SMTP id 1so3083999plv.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2017 02:21:38 -0800 (PST)
In-Reply-To: <cover.1513591822.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1513591822.git.viresh.kumar@linaro.org>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, robh+dt@kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, rnayak@codeaurora.org, sudeep.holla@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Power-domains can also have their active states and this patch enhances
the OPP binding to define those. The power domains can use the OPP
bindings as is, with one additional change to Allow
"operating-points-v2" property to contain multiple phandles for power
domain providers providing multiple domains.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt            | 5 +++++
 Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 9d733af26be7..a3953a1bb1a1 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -45,6 +45,11 @@ Devices supporting OPPs must set their "operating-points-v2" property with
 phandle to a OPP table in their DT node. The OPP core will use this phandle to
 find the operating points for the device.
 
+This can contain more than one phandle for power domain providers that provide
+multiple power domains. That is, one phandle for each power domain. If only one
+phandle is available, then the same OPP table will be used for all power domains
+provided by the power domain provider.
+
 If required, this can be extended for SoC vendor specific bindings. Such bindings
 should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
 and should have a compatible description like: "operating-points-v2-<vendor>".
diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 14bd9e945ff6..61549840ab3b 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -40,6 +40,12 @@ phandle arguments (so called PM domain specifiers) of length specified by the
   domain's idle states. In the absence of this property, the domain would be
   considered as capable of being powered-on or powered-off.
 
+- operating-points-v2 : Phandles to the OPP tables of power domains provided by
+  a power domain provider. If the provider provides a single power domain only
+  or all the power domains provided by the provider have identical OPP tables,
+  then this shall contain a single phandle. Refer to ../opp/opp.txt for more
+  information.
+
 Example:
 
 	power: power-controller@12340000 {
-- 
2.15.0.194.g9af6a3dea062
