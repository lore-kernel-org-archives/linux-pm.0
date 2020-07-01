Return-Path: <SRS0=2dfJ=AM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A61C433DF
	for <linux-pm@archiver.kernel.org>; Wed,  1 Jul 2020 02:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C28F2074D
	for <linux-pm@archiver.kernel.org>; Wed,  1 Jul 2020 02:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGACx3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:53:29 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:42734 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbgGACx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 22:53:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0U1ERHkX_1593572006;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0U1ERHkX_1593572006)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Jul 2020 10:53:27 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH]  cpufreq: CPPC: fix some unreasonable codes in cppc_cpufreq_perf_to_khz()
Date:   Wed,  1 Jul 2020 10:52:19 +0800
Message-Id: <20200701025219.10122-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 257d726a4456..444ee76a6bae 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -161,7 +161,7 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
 		if (!max_khz)
 			max_khz = cppc_get_dmi_max_khz();
 		mul = max_khz;
-		div = cpu->perf_caps.highest_perf;
+		div = caps->highest_perf;
 	}
 	return (u64)perf * mul / div;
 }
--
2.24.1
