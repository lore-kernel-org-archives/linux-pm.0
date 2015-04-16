From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH v2 3/5] devicetree: bindings: Add new cpuidle enable method for Renesas R-car SoCs
Date: Thu, 16 Apr 2015 19:35:38 +0900
Message-ID: <1429180540-5692-4-git-send-email-keita.kobayashi.ym@renesas.com>
References: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:47746 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757173AbbDPKgK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2015 06:36:10 -0400
In-Reply-To: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>

This patch add the ARM CPUs Device Tree binding to document a new
enable method of Renesas cpuidle.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 8b9e0a9..663ee11 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -196,6 +196,7 @@ nodes to be present and contain the properties described below.
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
+			    "renesas,rcar-idle"
 			    "rockchip,rk3066-smp"
 
 	- cpu-release-addr
-- 
1.9.1

