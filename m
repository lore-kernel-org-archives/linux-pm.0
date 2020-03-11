Return-Path: <SRS0=+pCq=44=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67285C18E5B
	for <linux-pm@archiver.kernel.org>; Wed, 11 Mar 2020 05:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B62B208C4
	for <linux-pm@archiver.kernel.org>; Wed, 11 Mar 2020 05:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCKFOC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:14:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:35814 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgCKFOC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 01:14:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C3522008B6;
        Wed, 11 Mar 2020 06:14:00 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F5D62008BB;
        Wed, 11 Mar 2020 06:13:57 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 83AE4402A5;
        Wed, 11 Mar 2020 13:13:52 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] thermal: qoriq: Sort includes alphabetically
Date:   Wed, 11 Mar 2020 13:07:32 +0800
Message-Id: <1583903252-2058-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
References: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sort includes alphabetically for consistency, and take this chance
to remove unused include of of_address.h.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 67a8d84..028a6bb 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -3,12 +3,11 @@
 // Copyright 2016 Freescale Semiconductor, Inc.
 
 #include <linux/clk.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/sizes.h>
 #include <linux/thermal.h>
-- 
2.7.4

