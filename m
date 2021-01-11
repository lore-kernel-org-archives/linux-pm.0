Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF62C433DB
	for <linux-pm@archiver.kernel.org>; Mon, 11 Jan 2021 08:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579E422A85
	for <linux-pm@archiver.kernel.org>; Mon, 11 Jan 2021 08:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbhAKIYG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:24:06 -0500
Received: from comms.puri.sm ([159.203.221.185]:60624 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbhAKIYG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 03:24:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 3FAEEDF71A;
        Mon, 11 Jan 2021 00:22:56 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8oV4D7t-4z8e; Mon, 11 Jan 2021 00:22:55 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 3/5] dt-bindings: mxsfb: Add interconnect bindings for LCDIF path
Date:   Mon, 11 Jan 2021 09:22:40 +0100
Message-Id: <20210111082240.27691-1-martin.kepplinger@puri.sm>
In-Reply-To: <20210111045103.GH28365@dragon>
References: <20210111045103.GH28365@dragon>
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

