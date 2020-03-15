Return-Path: <SRS0=RDk4=5A=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC6C5ACC2
	for <linux-pm@archiver.kernel.org>; Sun, 15 Mar 2020 19:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D41206B1
	for <linux-pm@archiver.kernel.org>; Sun, 15 Mar 2020 19:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgCOTT3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 15 Mar 2020 15:19:29 -0400
Received: from mail.manjaro.org ([176.9.38.148]:51242 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgCOTT1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 15:19:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id AA55D378284B;
        Sun, 15 Mar 2020 20:19:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5eQgMVBicp4k; Sun, 15 Mar 2020 20:19:23 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v5 1/3] dt-bindings: Document cellwise vendor-prefix
Date:   Sun, 15 Mar 2020 20:19:12 +0100
Message-Id: <20200315191914.118565-2-t.schramm@manjaro.org>
In-Reply-To: <20200315191914.118565-1-t.schramm@manjaro.org>
References: <20200315191914.118565-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944bec9c..af3d1aed8118 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -177,6 +177,8 @@ patternProperties:
     description: Cadence Design Systems Inc.
   "^cdtech,.*":
     description: CDTech(H.K.) Electronics Limited
+  "^cellwise,.*":
+    description: CellWise Microelectronics Co., Ltd
   "^ceva,.*":
     description: Ceva, Inc.
   "^chipidea,.*":
-- 
2.24.1

