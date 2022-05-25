Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5626C433FE
	for <linux-pm@archiver.kernel.org>; Wed, 25 May 2022 15:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244982AbiEYPNK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 25 May 2022 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245158AbiEYPMa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 11:12:30 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85358B36E1
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=L+KAYre4ng4FJ9S1+Bregm7R20q
        ElPptj+7ZwPDaqXA=; b=fsMVZnzGM2LUMKesCF5QkVVWdX71ygJT1TDy6E05IsV
        5UOPO9ghldwS89rHcwYfgl0xYTQt0xGphh89GYo25NDtLNETSgOJNQ/O9l0ClIjq
        EeIyf1ks2PsIC4M+bAc2ikgVnhDQbX6H1r5OOXMBqtmq9aIg4XmQ5HQZ28L4JR0I
        =
Received: (qmail 1644697 invoked from network); 25 May 2022 17:12:21 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 May 2022 17:12:21 +0200
X-UD-Smtp-Session: l3s3148p1@QnLpf9ff0BRZD++C
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal: rcar_gen3_thermal: Add r8a779f0 support
Date:   Wed, 25 May 2022 17:12:15 +0200
Message-Id: <20220525151216.24133-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for R-Car S4.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 43eb25b167bc..ccdf8a24ddc7 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -399,6 +399,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 		.compatible = "renesas,r8a779a0-thermal",
 		.data = &rcar_gen3_ths_tj_1,
 	},
+	{
+		.compatible = "renesas,r8a779f0-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
-- 
2.35.1

