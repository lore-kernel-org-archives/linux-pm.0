Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C7AC7113B
	for <linux-pm@archiver.kernel.org>; Thu, 24 Aug 2023 13:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbjHXNOR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 24 Aug 2023 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbjHXNNw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 09:13:52 -0400
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623D1198B;
        Thu, 24 Aug 2023 06:13:50 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 367988CC659; Thu, 24 Aug 2023 15:13:49 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Alexandre Courbot <acourbot@nvidia.com>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: power: supply: bq24190: Add ti,bq24193
Date:   Thu, 24 Aug 2023 15:13:29 +0200
Message-ID: <20230824131342.206784-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824131342.206784-1-linkmauve@linkmauve.fr>
References: <20230824112741.201353-1-linkmauve@linkmauve.fr>
 <20230824131342.206784-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This power supply device is used in the Nintendo Switch.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 Documentation/devicetree/bindings/power/supply/bq24190.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index d3ebc9de8c0b..2ad107589a16 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -19,6 +19,7 @@ properties:
       - ti,bq24190
       - ti,bq24192
       - ti,bq24192i
+      - ti,bq24193
       - ti,bq24196
 
   reg:
-- 
2.42.0

