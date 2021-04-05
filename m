Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB41C001B9
	for <linux-pm@archiver.kernel.org>; Mon,  5 Apr 2021 16:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDBF3613CE
	for <linux-pm@archiver.kernel.org>; Mon,  5 Apr 2021 16:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbhDEQEZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 5 Apr 2021 12:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241916AbhDEQEO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Apr 2021 12:04:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4275D613B8;
        Mon,  5 Apr 2021 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617638647;
        bh=bqcHL98/5DIfVZ4OpfrnQ/Lr5T/8yN1YD9VjwhQTA2g=;
        h=From:To:Cc:Subject:Date:From;
        b=By8QQuI0ybx3rNKeDgWczVAOrK21KLR+KCOa/Fu9MHmwKeb7jx63hLUg/E/Ab61ks
         LJZkz/Btb+gq4FK/PEb0HcmQIAw4HA+CWttS3H1sO2YriGAc87iMSqBdZWL7DZr+Dh
         jry62JrWW6fe+X/0gfmyebtUCCzbmtE4saqGzCbFwzUPu5CZfs5HOyY9vdS1bx/UT5
         AqJRQ2sG5Hd8OTs6hI/4fv21byBHFRw5SAq4R1zIvvZqel0/GSuAdlcnfAZrWDzADC
         3hlqAmlHUt+eKuiqSVjOAqvNytb/25C+gIAbyGgljNP8Q1DUOvXhQsSXrC1hJz5Mij
         N7QQKbl+HzwpQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 01/22] interconnect: core: fix error return code of icc_link_destroy()
Date:   Mon,  5 Apr 2021 12:03:44 -0400
Message-Id: <20210405160406.268132-1-sashal@kernel.org>
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
index 5ad519c9f239..8a1e70e00876 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -942,6 +942,8 @@ int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
 		       GFP_KERNEL);
 	if (new)
 		src->links = new;
+	else
+		ret = -ENOMEM;
 
 out:
 	mutex_unlock(&icc_lock);
-- 
2.30.2

