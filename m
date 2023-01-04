Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CB1C61DB3
	for <linux-pm@archiver.kernel.org>; Wed,  4 Jan 2023 13:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbjADNcG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Jan 2023 08:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjADNbY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2023 08:31:24 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36E2620
        for <linux-pm@vger.kernel.org>; Wed,  4 Jan 2023 05:29:21 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id s22so35401114ljp.5
        for <linux-pm@vger.kernel.org>; Wed, 04 Jan 2023 05:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BN1HuBOcO1xYyZSvoay0D2AQ+5agsRugOrVDoErpX48=;
        b=uMe1/V2U49qWV8NEZPXnBhv604lrMCVmp6V05gDvgxyyTl20RkdTh00exLaCUIaY4Q
         IvLpwr+q71gbuCtjpDyihO6jOPT2cJ24BsFGEmiMp6HLVS0CYA0JomJmC8qRaADhCwNT
         fX+C6Zx7R9vdr5inLwnj1LgcLe1NP0KgnOBMUjsPCAeN14UIaJZFvvReWGnr3DyxAvVd
         mmSPx+ridlbM0fgTSxazMOshc/VqIHt4c3eM+hXC4hx7lr5T5YKIx+WjsPsLNfhd1l5u
         LLqVdkMj18OK9Ti0eu7HoQfNYK+UBqszfOR2Zi5iaa04EeLZkszuuxntIZyRg+fI9d3J
         rcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BN1HuBOcO1xYyZSvoay0D2AQ+5agsRugOrVDoErpX48=;
        b=RU6Mz/ZlTYDFUpq0kMK+nDWpbWXubeVmVbvq0yuOVlEB1bEsFepMWZeIdURk/HJ11q
         LPD7qtk3UaoKsRvLfqHAxnJj5t0SgdLe7u/IYL+DjA0EtyFz+VtwUYJhgoxonxoLQWTh
         G2VjJJhq+nqS8p+XZyjNh/0i58dNcQmnJftlF0PfshMQy4Cd6CD97IomOgqUK6Y7/1kU
         8ZWWvXR2/vqRF9SsuLjJJ4uwgfpqnJcoY0MjJx5dJc4ychnYtOAIrVQqZaWEcWctGqRC
         KgGz0FDOrmNq1PaYG4iCAZeLyCk/c8W8fMuMzaUZcBHoYs9pCedHdk2yoz54Lk9ZHw58
         rXzg==
X-Gm-Message-State: AFqh2kpFhSvHsn8Y1SqWl7CUgt9sc+QY38dmC9KpUCwUZirw4vvrAIAV
        SlYRfqmgAhc5KawEcSOfHQDkmg==
X-Google-Smtp-Source: AMrXdXsXU/nsbyBQ9CPaj3vZFjbU28wyzDRKxpG4BSqgr17viXzaeC0sFPTLEdg2UJcwsic716/a0w==
X-Received: by 2002:a2e:a988:0:b0:27f:e6e6:9bdf with SMTP id x8-20020a2ea988000000b0027fe6e69bdfmr4940249ljq.36.1672838959487;
        Wed, 04 Jan 2023 05:29:19 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id k23-20020a2e92d7000000b0027fd02c99d4sm1947071ljh.75.2023.01.04.05.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:29:18 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: interconnect: OSM L3: Add SM6350 OSM L3 compatible
Date:   Wed,  4 Jan 2023 14:29:13 +0100
Message-Id: <20230104132915.667946-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SM6350, similarly to SDM845, uses OSM hardware for L3 scaling.
Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 00afbbca9038..9d0a98d77ae9 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -22,6 +22,7 @@ properties:
               - qcom,sc7180-osm-l3
               - qcom,sc8180x-osm-l3
               - qcom,sdm845-osm-l3
+              - qcom,sm6350-osm-l3
               - qcom,sm8150-osm-l3
           - const: qcom,osm-l3
       - items:
-- 
2.39.0

