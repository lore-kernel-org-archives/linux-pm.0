Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A190C83014
	for <linux-pm@archiver.kernel.org>; Tue,  1 Dec 2020 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C766820757
	for <linux-pm@archiver.kernel.org>; Tue,  1 Dec 2020 12:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgLAMl0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:41:26 -0500
Received: from comms.puri.sm ([159.203.221.185]:35388 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730989AbgLAMlZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Dec 2020 07:41:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 29915E0436;
        Tue,  1 Dec 2020 04:40:27 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YCVJacwuii6y; Tue,  1 Dec 2020 04:40:25 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 5/7] interconnect: imx8mq: Use icc_sync_state
Date:   Tue,  1 Dec 2020 13:39:30 +0100
Message-Id: <20201201123932.12312-6-martin.kepplinger@puri.sm>
In-Reply-To: <20201201123932.12312-1-martin.kepplinger@puri.sm>
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the icc_sync_state callback to notify the framework when consumers
are probed and the bandwidth doesn't have to be kept at maximum anymore.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Suggested-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/imx/imx8mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
index ba43a15aefec..d7768d3c6d8a 100644
--- a/drivers/interconnect/imx/imx8mq.c
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interconnect-provider.h>
 #include <dt-bindings/interconnect/imx8mq.h>
 
 #include "imx.h"
@@ -94,6 +95,7 @@ static struct platform_driver imx8mq_icc_driver = {
 	.remove = imx8mq_icc_remove,
 	.driver = {
 		.name = "imx8mq-interconnect",
+		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.20.1

