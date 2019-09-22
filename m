Return-Path: <SRS0=0A/B=XR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EEAC3A5A6
	for <linux-pm@archiver.kernel.org>; Sun, 22 Sep 2019 19:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ABB20644
	for <linux-pm@archiver.kernel.org>; Sun, 22 Sep 2019 19:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569181172;
	bh=Lc59sncasa5gS38TB/SVhDDqzccv+JjvHgvKuSv4u+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YauRGgF3eri79aVfQQXTXS3RDMJlVGRI6SXyEL7R58bQ3xCnV0/leeneKoQSdzuoj
	 dTV4DANSNAf/2HJIK59g/yBPDfR5ibsSEIFIX5oQWtnMPXkxpMsbnKgqNHAfixQo3k
	 5+Y2NeunKbNULHP5QcryjW6ft88lwSoWwftedei4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbfIVSn5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388156AbfIVSnz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 22 Sep 2019 14:43:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 466D5208C2;
        Sun, 22 Sep 2019 18:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569177834;
        bh=Lc59sncasa5gS38TB/SVhDDqzccv+JjvHgvKuSv4u+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbZjLj/GI2VvpA44g+nfEV7NBqYfn9+rI8eVbtCpj2Qd9MS2WW26VmwkIIvzBor2r
         IuksnVhQN2t8x8o7BcLWRe5kOtornKKjoMxZXMtIyPfxVJiEzBAQeo6F3djih7iM02
         Kfjggtwrw/Xb4yJKwPqfWCi7IqrrupZ/Rj3RDZrk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 003/203] cpufreq: ap806: Add NULL check after kcalloc
Date:   Sun, 22 Sep 2019 14:40:29 -0400
Message-Id: <20190922184350.30563-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Hariprasad Kelam <hariprasad.kelam@gmail.com>

[ Upstream commit 3355c91b79394593ebbb197c8e930a91826f4ff3 ]

Add NULL check  after kcalloc.

Fix below issue reported by coccicheck
./drivers/cpufreq/armada-8k-cpufreq.c:138:1-12: alloc with no test,
possible model on line 151

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/armada-8k-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index 988ebc326bdbb..39e34f5066d3d 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -136,6 +136,8 @@ static int __init armada_8k_cpufreq_init(void)
 
 	nb_cpus = num_possible_cpus();
 	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);
+	if (!freq_tables)
+		return -ENOMEM;
 	cpumask_copy(&cpus, cpu_possible_mask);
 
 	/*
-- 
2.20.1

