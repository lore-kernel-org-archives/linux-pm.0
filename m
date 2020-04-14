Return-Path: <SRS0=6fVe=56=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86ABC2BA19
	for <linux-pm@archiver.kernel.org>; Tue, 14 Apr 2020 12:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0176206A2
	for <linux-pm@archiver.kernel.org>; Tue, 14 Apr 2020 12:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgDNMxl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:53:41 -0400
Received: from mail.manjaro.org ([176.9.38.148]:51616 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502290AbgDNMxi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Apr 2020 08:53:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id F3052374279E;
        Tue, 14 Apr 2020 14:53:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0c0lpGzq1UF4; Tue, 14 Apr 2020 14:53:33 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND v6 1/3] dt-bindings: Document cellwise vendor-prefix
Date:   Tue, 14 Apr 2020 14:52:06 +0200
Message-Id: <20200414125208.1091989-2-t.schramm@manjaro.org>
In-Reply-To: <20200414125208.1091989-1-t.schramm@manjaro.org>
References: <20200414125208.1091989-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..58cf4e8b8d56 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -179,6 +179,8 @@ patternProperties:
     description: Cadence Design Systems Inc.
   "^cdtech,.*":
     description: CDTech(H.K.) Electronics Limited
+  "^cellwise,.*":
+    description: CellWise Microelectronics Co., Ltd
   "^ceva,.*":
     description: Ceva, Inc.
   "^chipidea,.*":
-- 
2.26.0

