Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CF8C43217
	for <linux-pm@archiver.kernel.org>; Sun, 16 Oct 2022 09:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJPJBb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 16 Oct 2022 05:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJPJB1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Oct 2022 05:01:27 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B082236BDC;
        Sun, 16 Oct 2022 02:01:23 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 01C92CE595;
        Sun, 16 Oct 2022 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1665910882; bh=+LC0nQ/rmVa9aJgBr3/Wzl+B6dflfpHLFO4lmvsYrYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TZTD7JjgyVbh2p5vn4+OjdSChltTlFRs7ti0z8LbtVQlHILoUXCmCJ76qvuoJ9ZLA
         ITFhmkXBcRBZo/ZV4YGgvMy87a5cJ8lfG5g3qrj3bAxSUzF2NppRxXFj+3SaP48iEf
         anjJerOqt/Z6Mfz9jc9XKf2pLHKpH0w1c0cZQM/E=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] dt-bindings: thermal: tsens: Add sm8450 compatible
Date:   Sun, 16 Oct 2022 11:00:34 +0200
Message-Id: <20221016090035.565350-5-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221016090035.565350-1-luca@z3ntu.xyz>
References: <20221016090035.565350-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the tsens-v2 compatible for sm8450 SoC.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 038d81338fcf..7db905c1d555 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -57,6 +57,7 @@ properties:
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens
+              - qcom,sm8450-tsens
           - const: qcom,tsens-v2
 
   reg:
-- 
2.38.0

