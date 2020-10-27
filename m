Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946F8C4363A
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 00:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8892222C
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603757417;
	bh=4rPUf9RHRm4dF7dLuDFTIcOKcD9hrYc/amceOdeWJWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MWVudlkVhZshlJEPAjk5royhcEm+DpyzeQVedJRnf8JGmh98lT8KKC8w/pg8lGffX
	 O1EAX/z3CU6IuQIJUgJO6uMP/IMSqTivQzFCr91S0DY8/uxwMynUN2zHfQd6Kwzmic
	 KbYNBfIYfNAL3lSdbJgYHkLX/zk8YKt4llXFFVk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439175AbgJ0AKP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439166AbgJ0AKN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Oct 2020 20:10:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C552151B;
        Tue, 27 Oct 2020 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603757413;
        bh=4rPUf9RHRm4dF7dLuDFTIcOKcD9hrYc/amceOdeWJWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlaEf93YpEN3x+umJrqzT2jBrtP2BUw4sP9fqdQJx4fs/I6DdOG6rICe2DaU26PK8
         3FLx36tRd6pxvHvdqxTfs6cuS06IszxLvrD2EAzWyv4whETKRgSoffI+e/6hXxPy8E
         yxBbfArnklSLgeRPB790uYfH4Ah3QJZOl53sia7s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alain Volmat <avolmat@me.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 22/46] cpufreq: sti-cpufreq: add stih418 support
Date:   Mon, 26 Oct 2020 20:09:21 -0400
Message-Id: <20201027000946.1026923-22-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027000946.1026923-1-sashal@kernel.org>
References: <20201027000946.1026923-1-sashal@kernel.org>
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
index 47105735df126..6b5d241c30b70 100644
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
@@ -261,7 +262,8 @@ static int sti_cpufreq_init(void)
 	int ret;
 
 	if ((!of_machine_is_compatible("st,stih407")) &&
-		(!of_machine_is_compatible("st,stih410")))
+		(!of_machine_is_compatible("st,stih410")) &&
+		(!of_machine_is_compatible("st,stih418")))
 		return -ENODEV;
 
 	ddata.cpu = get_cpu_device(0);
-- 
2.25.1

