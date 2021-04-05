Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F661C43461
	for <linux-pm@archiver.kernel.org>; Mon,  5 Apr 2021 16:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60637613D7
	for <linux-pm@archiver.kernel.org>; Mon,  5 Apr 2021 16:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbhDEQFU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 5 Apr 2021 12:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242204AbhDEQFH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Apr 2021 12:05:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25880613CC;
        Mon,  5 Apr 2021 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617638700;
        bh=97eCXTqfY9sOzbn9nTyUm35whMSCoyGUofXd3CkpugE=;
        h=From:To:Cc:Subject:Date:From;
        b=QBtPO4MIedhTD5WLouho0+wyfmZc3/S8YStoCgmsKI49JJTG1l8gxZEMsKAA4SAbB
         DQs9/1K/uemfRU2LV2Dj2/jBz2Numz/FjsTofeZ7VDBc9CFqdyvgxRgxfe7vnadao2
         qtANXWvbqaXG5IITMzWmP+XhN/p0Tsm0tg/C/NM8K8kRfwMZaD+cbmkGJRRlbYWut/
         hma9i8br/nvnfj8TyHWery3lRpSFjzrmc0yVNb63TRjY56wwzaCUGNI2SKj5t8vh8t
         0jNQQSCV0t4suVxejOi8KQmbWcTCHEOHsmb321IBpheddD6c964fNtcgtSjWQhocHn
         rNxAQjl/4e2QA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 01/13] interconnect: core: fix error return code of icc_link_destroy()
Date:   Mon,  5 Apr 2021 12:04:46 -0400
Message-Id: <20210405160459.268794-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 715ea61532e731c62392221238906704e63d75b6 ]

When krealloc() fails and new is NULL, no error return code of
icc_link_destroy() is assigned.
To fix this bug, ret is assigned with -ENOMEM hen new is NULL.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Link: https://lore.kernel.org/r/20210306132857.17020-1-baijiaju1990@gmail.com
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index c498796adc07..e579b3633a84 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -704,6 +704,8 @@ int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
 		       GFP_KERNEL);
 	if (new)
 		src->links = new;
+	else
+		ret = -ENOMEM;
 
 out:
 	mutex_unlock(&icc_lock);
-- 
2.30.2

