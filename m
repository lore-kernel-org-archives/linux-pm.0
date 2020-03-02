Return-Path: <SRS0=VxX7=4T=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE73C3F2D1
	for <linux-pm@archiver.kernel.org>; Mon,  2 Mar 2020 15:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDADD21D56
	for <linux-pm@archiver.kernel.org>; Mon,  2 Mar 2020 15:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgCBPy1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:54:27 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:36655 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgCBPy1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 10:54:27 -0500
Received: from droid13.amlogic.com (45.146.122.89) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Mon, 2 Mar 2020
 23:54:45 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
List-Id: <soc.lore.kernel.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>, SoC Team <soc@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] dt-bindings: power: Fix dt_binding_check error
Date:   Mon, 2 Mar 2020 23:54:08 +0800
Message-ID: <1583164448-83438-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [45.146.122.89]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Missing ';' in the end of secure-monitor example node.

Fixes: 165b5fb294e8 ("dt-bindings: power: add Amlogic secure power domains bindings")
Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
index af32209..bc4e037 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
@@ -36,5 +36,5 @@ examples:
             compatible = "amlogic,meson-a1-pwrc";
             #power-domain-cells = <1>;
         };
-    }
+    };
 
-- 
2.7.4

