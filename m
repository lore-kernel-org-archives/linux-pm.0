Return-Path: <SRS0=O50Q=C4=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB300C43465
	for <linux-pm@archiver.kernel.org>; Sat, 19 Sep 2020 14:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98BAC2344C
	for <linux-pm@archiver.kernel.org>; Sat, 19 Sep 2020 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600524274;
	bh=ugAs2y4rZlA6vZBj2bhkYKT3elTk+a0JzAZleLgQ7w0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XmuXAREeRHEf8QO1LIOZaEhOOZzbWApKJj3woohxFP3B4m2solvjJYPibULYy/4tK
	 7pYmt0DBDQkzsNUiDWOuURrvCC8hMdcjbi7cI+vHdS1lM2ccGco7fvAeOioR87ywM0
	 ttwT9fxn+epOxNYaXzNgFLP7EtsXUrHIcxU/w7Ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgISOEd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 19 Sep 2020 10:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISOEd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Sep 2020 10:04:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48BC21741;
        Sat, 19 Sep 2020 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524272;
        bh=ugAs2y4rZlA6vZBj2bhkYKT3elTk+a0JzAZleLgQ7w0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=O7Xt1G1aXZoEJT23mm564dFtIebvpZ71szGK1T/F1LRl9PWZD2F3RTYT7uap/vdAf
         Lv7mm3niKqVeX4pSH8o1qUT6PoeiC39dA4g7fxeczrpGwCttWJWaNyBxnCObiiIOgK
         tV7ieoIqzJUySy4S7eLfwaGfnPWM+qCVNwZqPyBg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: power: bq27xxx: add bq34z100
Date:   Sat, 19 Sep 2020 16:04:13 +0200
Message-Id: <20200919140418.3705-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200919140418.3705-1-krzk@kernel.org>
References: <20200919140418.3705-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add compatible for bq34z100 charger.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 82f682705f44..45beefccf31a 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -51,6 +51,7 @@ properties:
       - ti,bq27621
       - ti,bq27z561
       - ti,bq28z610
+      - ti,bq34z100
 
   reg:
     maxItems: 1
-- 
2.17.1

