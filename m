Return-Path: <SRS0=F5jN=W7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E6C41514
	for <linux-pm@archiver.kernel.org>; Wed,  4 Sep 2019 16:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93682053B
	for <linux-pm@archiver.kernel.org>; Wed,  4 Sep 2019 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613683;
	bh=a24iZ2MjDUQx9Im6BkpZfOWH4LS2JSDlVVS7Oz2Ur3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IJw0/9wzgCJhC2yeQLW6hxdxYw+Co+9YsGqTpYbKfeIf/FYgwhpPdl8HAOM0YPdtP
	 eMhMUK0FvngFMm40RqpQX9u40OKxfJhiNYshGmEJQvo0Lru7rpaqTyzrm5tkXuUi5F
	 43n03HfpgZFj6t8j0jX8y/u3VyWalX2kNFvBL2AE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbfIDQOf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732478AbfIDP7q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Sep 2019 11:59:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B31A222CED;
        Wed,  4 Sep 2019 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612786;
        bh=a24iZ2MjDUQx9Im6BkpZfOWH4LS2JSDlVVS7Oz2Ur3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRSELE54EftlQ1+o1aLqtVRM/1ox8ON3EOx8c6oyBpbLdIDUUfpto0PRWbVsBWO0z
         Kcpo1SAaZ13YaIsvxRRMUcTqB4My/nriEZu3rp31sCDyz2XKNPIPi6/HYuIK+eXzDp
         805oIeK63zRX9ZcsvN0f+NoC4jm0C47XbiXt2iGk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Len Brown <len.brown@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 81/94] tools/power turbostat: fix leak of file descriptor on error return path
Date:   Wed,  4 Sep 2019 11:57:26 -0400
Message-Id: <20190904155739.2816-81-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 15423b958f33132152e209e98df0dedc7a78f22c ]

Currently the error return path does not close the file fp and leaks
a file descriptor. Fix this by closing the file.

Fixes: 5ea7647b333f ("tools/power turbostat: Warn on bad ACPI LPIT data")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb9901cd..71a931813de00 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2938,6 +2938,7 @@ int snapshot_sys_lpi_us(void)
 	if (retval != 1) {
 		fprintf(stderr, "Disabling Low Power Idle System output\n");
 		BIC_NOT_PRESENT(BIC_SYS_LPI);
+		fclose(fp);
 		return -1;
 	}
 	fclose(fp);
-- 
2.20.1

