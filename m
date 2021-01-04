Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A3DC433DB
	for <linux-pm@archiver.kernel.org>; Mon,  4 Jan 2021 12:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B8E221F9
	for <linux-pm@archiver.kernel.org>; Mon,  4 Jan 2021 12:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbhADMLi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 4 Jan 2021 07:11:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44726 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhADMLh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 07:11:37 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kwOhK-0004Ts-63; Mon, 04 Jan 2021 12:10:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] powercap/drivers/dtpm: Fix size of object being allocated
Date:   Mon,  4 Jan 2021 12:10:53 +0000
Message-Id: <20210104121053.33210-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The kzalloc allocation for dtpm_cpu is currently allocating the size
of the pointer and not the size of the structure. Fix this by using
the correct sizeof argument.

Addresses-Coverity: ("Wrong sizeof argument")
Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/powercap/dtpm_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 6933c783c6b4..51c366938acd 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -200,7 +200,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	if (!dtpm)
 		return -EINVAL;
 
-	dtpm_cpu = kzalloc(sizeof(dtpm_cpu), GFP_KERNEL);
+	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
 	if (!dtpm_cpu)
 		goto out_kfree_dtpm;
 
-- 
2.29.2

