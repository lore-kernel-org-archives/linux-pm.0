Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956CEC7EE22
	for <linux-pm@archiver.kernel.org>; Mon,  8 May 2023 13:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjEHNhW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 May 2023 09:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjEHNhV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 09:37:21 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E842CD23;
        Mon,  8 May 2023 06:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description;
        bh=seOyPTPFaU0gL9veZr6+r2Y5hMFw78whMWlcD7v4Ggo=; b=msUjHnCZqEXt3N0NeQow9x0pGx
        0bKYGwuMJVIZ3U2htzhYj6ayuU1oHVPylp8XkYQUyYoORjLFEVPLAZXuK5pQwEexzF0g/t15qHsiO
        DcJ7w0E///UGgoNWSUMvGVuuZIbqjZSHhZjvK95+6Bc0r6AA2aT0DdFZW7PhqvcpCJ6wjipCU6j2K
        COb3g22+GSo1hd22AM/EsD9eX0cnjKrPfSkSvZsTgBMwhSLIANDF9j1BTJwXMpi0uEfLhSjQ1KEmP
        x03jtFsygXbYdfhleARDlQFXd+GCqNNf+Ya2TL4xXyEO1lg3msKZDi7A9CiUgjq3hmvbE2HYaQZeD
        HSqlJ6RA==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pw0hT-009LZn-Jg; Mon, 08 May 2023 15:14:47 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Mon, 08 May 2023 15:13:42 +0200
Subject: [PATCH v4 5/6] dt-bindings: thermal: qcom-tsens: Add MSM8909
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-msm8909-tsens-v4-5-d9119622cb19@kernkonzept.com>
References: <20230508-msm8909-tsens-v4-0-d9119622cb19@kernkonzept.com>
In-Reply-To: <20230508-msm8909-tsens-v4-0-d9119622cb19@kernkonzept.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSM8909 uses the TSENS v0.1 block similar to other SoCs like MDM9607.
Document the "qcom,msm8909-tsens" compatible in the existing schema.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 59b74fdacf00..47e95fe44c16 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -29,6 +29,7 @@ properties:
         items:
           - enum:
               - qcom,mdm9607-tsens
+              - qcom,msm8909-tsens
               - qcom,msm8916-tsens
               - qcom,msm8939-tsens
               - qcom,msm8974-tsens

-- 
2.30.2

