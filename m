Return-Path: <SRS0=+X/1=5E=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D1CC4332B
	for <linux-pm@archiver.kernel.org>; Thu, 19 Mar 2020 20:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4392072C
	for <linux-pm@archiver.kernel.org>; Thu, 19 Mar 2020 20:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WuLvPS7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCSUfH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:35:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50742 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgCSUfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 16:35:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id z13so4221708wml.0;
        Thu, 19 Mar 2020 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RRhROApEcb204AeuCPMJcD4+LhyGPoAGUFvTjnDbJk=;
        b=WuLvPS7MO3JjnrTdyLixJJozVeO+g7q1Bn4vs++KlrdqcqvFbmcfIvQBAOmORNBXEN
         wTsrY+3Rltjd0CtCSmKo/JSpM8G/UiHa2FqYByMaBiNH27pT0aQDVlA/F38jZWBCLA6K
         cPh0AtXXzzN1uOb1RgNafI/aAn0mNdaFWPLu7CPMl1f4ergvhXPzcc0gUtUESz7xsV44
         mF44eDc9PFdb3XgU0fjvQUIP85tl00qiJ3sd8kGOYXnyzy72PiOrOE4qQSnhWFkp9aCh
         IvgNK8o2T12ufzW65jJ+3HzRLdXDrEc4D84ZGPqMMvpLy+o7AzkWskaGWokGAw9tgDlP
         Yvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RRhROApEcb204AeuCPMJcD4+LhyGPoAGUFvTjnDbJk=;
        b=tZKVVMhlOvZC9ngrxzcy0rs0HPkmil9b6LDv/uXByK0Un7EcHVvjlvhrvmBaVvfH2i
         /5q7utwUy5u4jnjBG5o/AFLf9RePft04gOzrotO5cXTIOcCEqtHwH/QYqLF6mr9szxT2
         uTnCSYaWHQLZ7GwiKltjJHDbLkrgesDdqWuvUyN4ZjrWPUP3YJ+RtTdjWkoeWOa33WsJ
         +m20t76O3mDvGRhNiLUQzdMdtZ8HLqUAdmbRLYkGR73lvWqmGOHvyqvOO+245kthnRDR
         ggztkTzkSb0KGviO6Y35amll5swNoNObm4ITphU6BaKp91pwz9a2JLx7jafmSD+dqtnz
         PiKg==
X-Gm-Message-State: ANhLgQ1Pf4DSB8jDTEv+pXkqIkgfHCH8xYI28h8m+FlnB71iWdQWPlcq
        EiRfeMSS6LfXo/jvhR9Ant4=
X-Google-Smtp-Source: ADFU+vvN87aV9h5DQk373Le1newa2fcLju+bTKeM04zZKybI27soSbkw0cX8T8TODsUPXqH4hqsCZA==
X-Received: by 2002:a1c:c907:: with SMTP id f7mr68703wmb.121.1584650101005;
        Thu, 19 Mar 2020 13:35:01 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r9sm4744968wma.47.2020.03.19.13.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 13:35:00 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     yuq825@gmail.com, dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        tomeu.vizoso@collabora.com, robh@kernel.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, wens@csie.org,
        linux-pm@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 1/2] dt-bindings: gpu: mali-utgard: Add the #cooling-cells property
Date:   Thu, 19 Mar 2020 21:34:26 +0100
Message-Id: <20200319203427.2259891-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319203427.2259891-1-martin.blumenstingl@googlemail.com>
References: <20200319203427.2259891-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The GPU can be one of the big heat sources on a SoC. Allow the
"#cooling-cells" property to be specified for ARM Mali Utgard GPUs so
the GPU clock speeds (and voltages) can be reduced to prevent a SoC from
overheating.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index afde81be3c29..33548ca2a759 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -107,6 +107,9 @@ properties:
 
   operating-points-v2: true
 
+  "#cooling-cells":
+    const: 2
+
 required:
   - compatible
   - reg
@@ -162,6 +165,7 @@ examples:
       clocks = <&ccu 1>, <&ccu 2>;
       clock-names = "bus", "core";
       resets = <&ccu 1>;
+      #cooling-cells = <2>;
     };
 
 ...
-- 
2.25.2

