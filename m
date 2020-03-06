Return-Path: <SRS0=Ttsr=4X=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43757C10F26
	for <linux-pm@archiver.kernel.org>; Fri,  6 Mar 2020 10:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E01208C3
	for <linux-pm@archiver.kernel.org>; Fri,  6 Mar 2020 10:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgCFKzJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:55:09 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:49680 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFKzJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 05:55:09 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id Ayv72200F5USYZQ01yv7nh; Fri, 06 Mar 2020 11:55:07 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jAAdH-000476-C6; Fri, 06 Mar 2020 11:55:07 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jAAdH-0006KD-Ab; Fri, 06 Mar 2020 11:55:07 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] dt-bindings: thermal: rcar-gen3-thermal: Add r8a77961 support
Date:   Fri,  6 Mar 2020 11:55:02 +0100
Message-Id: <20200306105503.24267-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200306105503.24267-1-geert+renesas@glider.be>
References: <20200306105503.24267-1-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document R-Car M3-W+ (R8A77961) SoC bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
index 12c740b975f78690..2993fa720195308f 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
@@ -11,6 +11,7 @@ Required properties:
 			    - "renesas,r8a774b1-thermal" (RZ/G2N)
 			    - "renesas,r8a7795-thermal" (R-Car H3)
 			    - "renesas,r8a7796-thermal" (R-Car M3-W)
+			    - "renesas,r8a77961-thermal" (R-Car M3-W+)
 			    - "renesas,r8a77965-thermal" (R-Car M3-N)
 			    - "renesas,r8a77980-thermal" (R-Car V3H)
 - reg			: Address ranges of the thermal registers. Each sensor
-- 
2.17.1

