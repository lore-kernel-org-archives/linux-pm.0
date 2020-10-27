Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C6BC2D0A3
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 00:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7FF217A0
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603757464;
	bh=79/OI+YKXyUybfQKbJxDe2DNoV0D8ynksWSZqapMbPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FEAzZ4FC4Rx9LKbsHmEEtASF6TjOU1GK8R1yk5ECv8uPblzYmgEFjAGlOn+L15h2f
	 FjDl51iwBTQcMKagz/ca8TImwodC6zsWKHmKqh0MouXjPmxnppYUuyLtlZHtUju3xR
	 jpM5KmLJW/PzNBoJS8eR4d3pkRKJU8N0t3+EeSGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411672AbgJ0ALD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411665AbgJ0ALB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Oct 2020 20:11:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B5FE21D41;
        Tue, 27 Oct 2020 00:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603757461;
        bh=79/OI+YKXyUybfQKbJxDe2DNoV0D8ynksWSZqapMbPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pnf7PXKi3WsLMkwmdmQJIoXNQLuHQ/B2IMCQSZLupIFlorcrCXUJpFQPUwYU5kk3R
         abWRu4NRD9Wwo8W8rn/W5R4Ti03E1kSKj340VsiYVeVLgVdtBOJ7rB+fgQ++cViXdV
         NodBEcSvj7lH9OxZPdvg5igYJZKVEz2HsuNuZem0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alain Volmat <avolmat@me.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 14/30] cpufreq: sti-cpufreq: add stih418 support
Date:   Mon, 26 Oct 2020 20:10:28 -0400
Message-Id: <20201027001044.1027349-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027001044.1027349-1-sashal@kernel.org>
References: <20201027001044.1027349-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Alain Volmat <avolmat@me.com>

[ Upstream commit 01a163c52039e9426c7d3d3ab16ca261ad622597 ]

The STiH418 can be controlled the same way as STiH407 &
STiH410 regarding cpufreq.

Signed-off-by: Alain Volmat <avolmat@me.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/sti-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index b366e6d830ea3..2cb3346e82d35 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -144,7 +144,8 @@ static const struct reg_field sti_stih407_dvfs_regfields[DVFS_MAX_REGFIELDS] = {
 static const struct reg_field *sti_cpufreq_match(void)
 {
 	if (of_machine_is_compatible("st,stih407") ||
-	    of_machine_is_compatible("st,stih410"))
+	    of_machine_is_compatible("st,stih410") ||
+	    of_machine_is_compatible("st,stih418"))
 		return sti_stih407_dvfs_regfields;
 
 	return NULL;
@@ -260,7 +261,8 @@ static int sti_cpufreq_init(void)
 	int ret;
 
 	if ((!of_machine_is_compatible("st,stih407")) &&
-		(!of_machine_is_compatible("st,stih410")))
+		(!of_machine_is_compatible("st,stih410")) &&
+		(!of_machine_is_compatible("st,stih418")))
 		return -ENODEV;
 
 	ddata.cpu = get_cpu_device(0);
-- 
2.25.1

