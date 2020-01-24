Return-Path: <SRS0=VFB/=3N=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9F9C35241
	for <linux-pm@archiver.kernel.org>; Fri, 24 Jan 2020 01:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DA824125
	for <linux-pm@archiver.kernel.org>; Fri, 24 Jan 2020 01:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828748;
	bh=8I4N5SI5pfjtzoqByMlS3MkZ2k66b7rxqF1BnrKZr/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tKvsfhFWXZZryYxZ1sLzI3dyY1QHvi9w7AJIJH7FFf0VAedyCi/v3o9HB2Pl4BTyb
	 5/bNODWq6iZRFbUgUqQ9eQ7zIiUir4FJt99i1n1adVSbQ2vp2n2gQHKGimcpRmAdWJ
	 7Pff6exnJZjnDg5Mw4QuO6rtCQibd86Fuqd000FE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgAXBTA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbgAXBRz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Jan 2020 20:17:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4533722464;
        Fri, 24 Jan 2020 01:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828674;
        bh=8I4N5SI5pfjtzoqByMlS3MkZ2k66b7rxqF1BnrKZr/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yv0RcOofRqgGLvg1lpWlq53g9eeZm6V3wAKVoWiaPMMeNqkKRAAq7GGlqiQZj1+oK
         RXMVkGkBJPpMQX2/GJlYJhFbD631PRC3Qbwdu7KQKCewmfsd7iamfQN5SBwppJkwW0
         C2febhM4CN6obLWQbV+MlmRrMpIWPBmlxRqouDRM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/11] ARM: OMAP2+: SmartReflex: add omap_sr_pdata definition
Date:   Thu, 23 Jan 2020 20:17:42 -0500
Message-Id: <20200124011747.18575-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124011747.18575-1-sashal@kernel.org>
References: <20200124011747.18575-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

[ Upstream commit 2079fe6ea8cbd2fb2fbadba911f1eca6c362eb9b ]

The omap_sr_pdata is not declared but is exported, so add a
define for it to fix the following warning:

arch/arm/mach-omap2/pdata-quirks.c:609:36: warning: symbol 'omap_sr_pdata' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/power/smartreflex.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
index 7b81dad712de8..37d9b70ed8f0a 100644
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -296,6 +296,9 @@ struct omap_sr_data {
 	struct voltagedomain		*voltdm;
 };
 
+
+extern struct omap_sr_data omap_sr_pdata[OMAP_SR_NR];
+
 #ifdef CONFIG_POWER_AVS_OMAP
 
 /* Smartreflex module enable/disable interface */
-- 
2.20.1

