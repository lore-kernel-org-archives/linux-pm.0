Return-Path: <SRS0=yWkS=5L=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B2C2D0EE
	for <linux-pm@archiver.kernel.org>; Thu, 26 Mar 2020 23:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5DC20409
	for <linux-pm@archiver.kernel.org>; Thu, 26 Mar 2020 23:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265186;
	bh=h2eGqPeixL/ya52/luORgsLdlKSXvpz5U783GSmKz9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ejRA6+3vRFGgnoAqm1mUZUZO09lFFPCrfg9aoqAo+t4/9KlPUBtPN6ZbRzC3jjpqm
	 0Tp49FU28nBVhkkBU2dwmRW4Cc1Fn3JijxRqB4X0EZzqnGGAtNf93zJM4+vLdKZtbg
	 JntWciRWaz0d1vQxY3+cQeokPIZaE7WgObqF9nLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCZXZX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgCZXZW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 19:25:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61C3220B1F;
        Thu, 26 Mar 2020 23:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265122;
        bh=h2eGqPeixL/ya52/luORgsLdlKSXvpz5U783GSmKz9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/Vhb7dbw7XvjsaUiAgzWMyAtUUj5FkTPJbipXblcl6izVCBPU+VkbRWZH6m84Xne
         mE4dWB+rs0LoHIVJrydPnf2UsVkECFCozsJd3mfsOS/52SqLF4x5kSPRHD/9Q3dugO
         I+37zsyRmmy5SdvPGYtDpBPkpoCeaqTju0NF8fSo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/10] tools/power turbostat: Fix gcc build warnings
Date:   Thu, 26 Mar 2020 19:25:10 -0400
Message-Id: <20200326232513.8212-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232513.8212-1-sashal@kernel.org>
References: <20200326232513.8212-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

[ Upstream commit d8d005ba6afa502ca37ced5782f672c4d2fc1515 ]

Warning: ‘__builtin_strncpy’ specified bound 20 equals destination size
	[-Wstringop-truncation]

reduce param to strncpy, to guarantee that a null byte is always copied
into destination buffer.

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 19e345cf8193e..0692f2efc25ef 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4650,9 +4650,9 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 	}
 
 	msrp->msr_num = msr_num;
-	strncpy(msrp->name, name, NAME_BYTES);
+	strncpy(msrp->name, name, NAME_BYTES - 1);
 	if (path)
-		strncpy(msrp->path, path, PATH_BYTES);
+		strncpy(msrp->path, path, PATH_BYTES - 1);
 	msrp->width = width;
 	msrp->type = type;
 	msrp->format = format;
-- 
2.20.1

