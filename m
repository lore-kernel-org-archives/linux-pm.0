Return-Path: <SRS0=uzaG=CP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3714C433E2
	for <linux-pm@archiver.kernel.org>; Sun,  6 Sep 2020 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C4F20838
	for <linux-pm@archiver.kernel.org>; Sun,  6 Sep 2020 14:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgIFOsJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 6 Sep 2020 10:48:09 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53565 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgIFOsI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 10:48:08 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1121C40002;
        Sun,  6 Sep 2020 14:48:04 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 2/2] dt-bindings: power: ingenic,battery: add new compatibles
Date:   Sun,  6 Sep 2020 16:47:26 +0200
Message-Id: <20200906144726.8852-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906144726.8852-1-contact@artur-rojek.eu>
References: <20200906144726.8852-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This binding can support Ingenic JZ4725B and JZ4770 SoCs, as they are
compatible with Ingenic JZ4740 battery.

Introduce the following compatible property combinations:
 compatible = "ingenic,jz4725b-battery", "ingenic,jz4740-battery",
 compatible = "ingenic,jz4770-battery", "ingenic,jz4740-battery"

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

Changes:
    v2: new patch

 .../devicetree/bindings/power/supply/ingenic,battery.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
index b4e0275ac63a..b9e5458499bf 100644
--- a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
@@ -12,7 +12,13 @@ maintainers:
 
 properties:
   compatible:
-    const: ingenic,jz4740-battery
+    oneOf:
+      - const: ingenic,jz4740-battery
+      - items:
+        - enum:
+          - ingenic,jz4725b-battery
+          - ingenic,jz4770-battery
+        - const: ingenic,jz4740-battery
 
   io-channels:
     items:
-- 
2.28.0

