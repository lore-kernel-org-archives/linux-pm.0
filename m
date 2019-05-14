Return-Path: <SRS0=snuF=TO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4646FC04AB7
	for <linux-pm@archiver.kernel.org>; Tue, 14 May 2019 08:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E44A208C3
	for <linux-pm@archiver.kernel.org>; Tue, 14 May 2019 08:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfENI6o (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 May 2019 04:58:44 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:48180 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfENI6o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2019 04:58:44 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id C8yf200053XaVaC068yf2j; Tue, 14 May 2019 10:58:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hQTGg-0000FQ-VA; Tue, 14 May 2019 10:58:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hQTGg-0004mK-Sp; Tue, 14 May 2019 10:58:38 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2] ARM: dts: r8a7791: Move enable-method to CPU nodes
Date:   Tue, 14 May 2019 10:58:37 +0200
Message-Id: <20190514085837.18325-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190514085837.IBMSEFof5eN4108PIJu_VY67nupchHUIrimOen-mE7s@z>

According to Documentation/devicetree/bindings/arm/cpus.yaml, the
"enable-method" property should be a property of the individual CPU
nodes, and not of the parent "cpus" container node.
However, on R-Car M2-W, the property is tied to the "cpus" node instead.

Secondary CPU bringup and CPU hot (un)plug work regardless, as
arm_dt_init_cpu_maps() falls back to looking in the "cpus" node.

The cpuidle code does not have such a fallback, so it does not detect
the enable-method.  Note that cpuidle does not support the
"renesas,apmu" enable-method yet, so for now this does not make any
difference.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Arm64 and powerpc do not have such a fallback, but SH has, like arm32.

This is marked RFC, as the alternative is to update the DT bindings to
keep the status quo.

v2:
  - Update reference after commit 672951cbd1b70a9e ("dt-bindings: arm:
    Convert cpu binding to json-schema").
---
 arch/arm/boot/dts/r8a7791.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 6f875502453cf40a..a8266e76d7e50739 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -68,7 +68,6 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		enable-method = "renesas,apmu";
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
@@ -77,6 +76,7 @@
 			clock-frequency = <1500000000>;
 			clocks = <&cpg CPG_CORE R8A7791_CLK_Z>;
 			power-domains = <&sysc R8A7791_PD_CA15_CPU0>;
+			enable-method = "renesas,apmu";
 			next-level-cache = <&L2_CA15>;
 			voltage-tolerance = <1>; /* 1% */
 			clock-latency = <300000>; /* 300 us */
@@ -97,6 +97,7 @@
 			clock-frequency = <1500000000>;
 			clocks = <&cpg CPG_CORE R8A7791_CLK_Z>;
 			power-domains = <&sysc R8A7791_PD_CA15_CPU1>;
+			enable-method = "renesas,apmu";
 			next-level-cache = <&L2_CA15>;
 			voltage-tolerance = <1>; /* 1% */
 			clock-latency = <300000>; /* 300 us */
-- 
2.17.1

