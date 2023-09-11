Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF8DCA0ECE
	for <linux-pm@archiver.kernel.org>; Mon, 11 Sep 2023 21:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240839AbjIKVGw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243972AbjIKSeQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2023 14:34:16 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA81AB;
        Mon, 11 Sep 2023 11:34:05 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id E89BC5FD70;
        Mon, 11 Sep 2023 18:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1694457244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wy1qjxrLlq/EwS2P0KEQlfuBQ/GQXkJ4OLsU45kg4GE=;
        b=htU9FRzBmSZBePa04KXTk6T9/pAvWU3U8knLX67+Wa5pcHbuGEEpFjHkOBKOOm4p0Hj4qi
        AlPjdvZok9SkPIkHfUpdxxXWNcfpstCLLTlIGLPihY0LK8qXfZoG/H6vCY2xraGtHTqLtX
        iS/gzJ62LvhiKrrjyTNW1R7K+PdoUdg=
Received: from frank-G5.. (fttx-pool-217.61.151.158.bambit.de [217.61.151.158])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 1513A360799;
        Mon, 11 Sep 2023 18:34:03 +0000 (UTC)
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
        Daniel Golle <daniel@makrotopia.org>
Subject: [RFC v1 1/3] dt-bindings: thermal: mediatek: add mt7988 compatible
Date:   Mon, 11 Sep 2023 20:33:52 +0200
Message-Id: <20230911183354.11487-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911183354.11487-1-linux@fw-web.de>
References: <20230911183354.11487-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f392470e-8bc2-481d-ae45-f63a02f7ae27
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add compatible string for mt7988.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../devicetree/bindings/thermal/mediatek,lvts-thermal.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index fe9ae4c425c0..49effe561963 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -18,6 +18,7 @@ description: |
 properties:
   compatible:
     enum:
+      - mediatek,mt7988-lvts
       - mediatek,mt8192-lvts-ap
       - mediatek,mt8192-lvts-mcu
       - mediatek,mt8195-lvts-ap
-- 
2.34.1

