Return-Path: <SRS0=HLSa=2N=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07A8C2D0D0
	for <linux-pm@archiver.kernel.org>; Mon, 23 Dec 2019 14:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941A721569
	for <linux-pm@archiver.kernel.org>; Mon, 23 Dec 2019 14:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="UDGlQvn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLWOVD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:21:03 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:33586 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLWOVC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 09:21:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id AD19C3FBB5;
        Mon, 23 Dec 2019 15:21:00 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=UDGlQvn9;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bm2r93y-Ua7l; Mon, 23 Dec 2019 15:21:00 +0100 (CET)
Received: from flawful.org (ua-84-217-220-205.bbcust.telenor.se [84.217.220.205])
        (Authenticated sender: mb274189)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 0E0433F9B3;
        Mon, 23 Dec 2019 15:21:00 +0100 (CET)
Received: by flawful.org (Postfix, from userid 1001)
        id AE3A31451; Mon, 23 Dec 2019 15:20:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1577110859; bh=EyKdGWY3GSzMDVIT/5i98X8pT95aI1RKjyAzIbDN3gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDGlQvn9CBU5Z/6Ysfjy4ERF+MeM06p2g5AkbPnEXuo/zkiDjCOyKPxwobefmMXee
         CNJswv4xJ2cIuAgJC4EeanYI3MjULskFCN+V4q+WmzWTkFWKIiu7t6VDk4DpXSQE24
         g2qQpQKRoGgLC0FKnodQuO/H4gaAcxfS+ZOSbDSU=
From:   Niklas Cassel <nks@flawful.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: [PATCH 4/5] power: avs: qcom-cpr: remove set but unused variable
Date:   Mon, 23 Dec 2019 15:19:33 +0100
Message-Id: <20191223141934.19837-5-nks@flawful.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191223141934.19837-1-nks@flawful.org>
References: <20191223141934.19837-1-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

drivers/power/avs/qcom-cpr.c:896:35:
warning: variable ‘prev’ set but not used

Detected when running make with W=1.

Signed-off-by: Niklas Cassel <nks@flawful.org>
---
 drivers/power/avs/qcom-cpr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index 232836a1ef27..484dd498f8b9 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -893,7 +893,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 	int i;
 	unsigned int step_volt;
 	struct fuse_corner_data *fdata;
-	struct fuse_corner *fuse, *end, *prev;
+	struct fuse_corner *fuse, *end;
 	int uV;
 	const struct reg_sequence *accs;
 	int ret;
@@ -909,7 +909,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 	end = &fuse[desc->num_fuse_corners - 1];
 	fdata = desc->cpr_fuses.fuse_corner_data;
 
-	for (i = 0, prev = NULL; fuse <= end; fuse++, fuses++, i++, fdata++) {
+	for (i = 0; fuse <= end; fuse++, fuses++, i++, fdata++) {
 		/*
 		 * Update SoC voltages: platforms might choose a different
 		 * regulators than the one used to characterize the algorithms
-- 
2.24.1

