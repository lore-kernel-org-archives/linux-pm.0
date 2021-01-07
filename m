Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D58C43331
	for <linux-pm@archiver.kernel.org>; Thu,  7 Jan 2021 12:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16372335A
	for <linux-pm@archiver.kernel.org>; Thu,  7 Jan 2021 12:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbhAGMTS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 7 Jan 2021 07:19:18 -0500
Received: from comms.puri.sm ([159.203.221.185]:43970 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbhAGMTR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Jan 2021 07:19:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 99DC7E20FB;
        Thu,  7 Jan 2021 04:18:37 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WpnXYetPGgyj; Thu,  7 Jan 2021 04:18:36 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com, gregkh@linuxfoundation.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 3/5] dt-bindings: mxsfb: Add interconnect bindings for LCDIF path
Date:   Thu,  7 Jan 2021 13:17:52 +0100
Message-Id: <20210107121754.3295-4-martin.kepplinger@puri.sm>
In-Reply-To: <20210107121754.3295-1-martin.kepplinger@puri.sm>
References: <20210107121754.3295-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add optional interconnect properties for the dram path requests.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/devicetree/bindings/display/mxsfb.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Documentation/devicetree/bindings/display/mxsfb.txt
index c985871c46b3..d494a2674290 100644
--- a/Documentation/devicetree/bindings/display/mxsfb.txt
+++ b/Documentation/devicetree/bindings/display/mxsfb.txt
@@ -15,6 +15,12 @@ Required properties:
     - "pix" for the LCDIF block clock
     - (MX6SX-only) "axi", "disp_axi" for the bus interface clock
 
+Optional properties:
+- interconnects : interconnect path specifier for LCDIF according to
+		Documentation/devicetree/bindings/interconnect/interconnect.txt.
+- interconnect-names: the name describing the interconnect path.
+		Should be "dram" for i.MX8MQ.
+
 Required sub-nodes:
   - port: The connection to an encoder chip.
 
-- 
2.20.1

