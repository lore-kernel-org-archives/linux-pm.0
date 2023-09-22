Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1106CE7D0CB
	for <linux-pm@archiver.kernel.org>; Fri, 22 Sep 2023 05:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjIVFuj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 22 Sep 2023 01:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjIVFui (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Sep 2023 01:50:38 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831FB195;
        Thu, 21 Sep 2023 22:50:28 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout4.routing.net (Postfix) with ESMTP id 68B421009F0;
        Fri, 22 Sep 2023 05:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1695361826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wdjXDLLf4xtrNUzt8GcD/GV6BJ5U7aPo/HDDEtqI8z8=;
        b=KHwvkIIX2yzZ2xdkLxlaYzZ0TlnyBd26c6GLYiEn3QwqDR9UqE3sUP9sn2maLbHwIHrzRt
        xc0DxRj0GZO9pODwSfYbaaA+ZaD78FjNH0BRZh9cIQTrHxV85y0jRQPDMoEfGw40bK4lp+
        EzA1+ut8uiVHXBI/urwLEC56VrU1W8w=
Received: from frank-G5.. (fttx-pool-217.61.149.125.bambit.de [217.61.149.125])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 72252403BF;
        Fri, 22 Sep 2023 05:50:25 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: thermal: mediatek: add mt7988 lvts compatible
Date:   Fri, 22 Sep 2023 07:50:17 +0200
Message-Id: <20230922055020.6436-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922055020.6436-1-linux@fw-web.de>
References: <20230922055020.6436-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 16933f30-6449-450f-a84f-4f76d6247f3b
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add compatible string for mt7988 lvts application processor.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2:
- change mt7988-lvts to mt7988-lvts-ap (Application Processor)
- not added Ack from Rob because of this change
---
 .../devicetree/bindings/thermal/mediatek,lvts-thermal.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index fe9ae4c425c0..e6665af52ee6 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -18,6 +18,7 @@ description: |
 properties:
   compatible:
     enum:
+      - mediatek,mt7988-lvts-ap
       - mediatek,mt8192-lvts-ap
       - mediatek,mt8192-lvts-mcu
       - mediatek,mt8195-lvts-ap
-- 
2.34.1

