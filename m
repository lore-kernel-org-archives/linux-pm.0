Return-Path: <SRS0=4E8L=EB=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B61FC56202
	for <linux-pm@archiver.kernel.org>; Mon, 26 Oct 2020 23:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3775421D42
	for <linux-pm@archiver.kernel.org>; Mon, 26 Oct 2020 23:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603756237;
	bh=WNpDCz6GEJtJzyBdSTxEG6+fLp1ZJ7VVzTxNq8Y0yEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I6VlHV3501lbR2Vp1puxtR3Tu5IP9Mv9hg16tScX22qoAnbDnSGmvkWmHxbfUqq/F
	 aNqMtFY4+5kTbl+gUEQ6vKT3nsbhosh24MOiRyIQGkhDgNU1YvuDFXevR8PgbBkEbu
	 KSvWuaGRCHTxg6YSF/DSfn3ZeWH9YCZ6jQUlz9IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408963AbgJZXug (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409142AbgJZXuf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Oct 2020 19:50:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA5A20872;
        Mon, 26 Oct 2020 23:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756234;
        bh=WNpDCz6GEJtJzyBdSTxEG6+fLp1ZJ7VVzTxNq8Y0yEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXkiXokxdPBBSqgnmrR/fHN6MY1YaQAfeVvPE/7RO2PX+8NqfZvT/bPBd2++1VZpe
         W8qx0xzajKocdM7gUdo22X5CMPNhoTn8M8iAM8Tm/4vdMRnNCbpHfLs/pflKGipKiN
         GC41CkOyMCK4wcAXqVTpjf3PChuZLnwSH7ACnDT0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alain Volmat <avolmat@me.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 072/147] cpufreq: sti-cpufreq: add stih418 support
Date:   Mon, 26 Oct 2020 19:47:50 -0400
Message-Id: <20201026234905.1022767-72-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026234905.1022767-1-sashal@kernel.org>
References: <20201026234905.1022767-1-sashal@kernel.org>
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
index a5ad96d29adca..4ac6fb23792a0 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -141,7 +141,8 @@ static const struct reg_field sti_stih407_dvfs_regfields[DVFS_MAX_REGFIELDS] = {
 static const struct reg_field *sti_cpufreq_match(void)
 {
 	if (of_machine_is_compatible("st,stih407") ||
-	    of_machine_is_compatible("st,stih410"))
+	    of_machine_is_compatible("st,stih410") ||
+	    of_machine_is_compatible("st,stih418"))
 		return sti_stih407_dvfs_regfields;
 
 	return NULL;
@@ -258,7 +259,8 @@ static int sti_cpufreq_init(void)
 	int ret;
 
 	if ((!of_machine_is_compatible("st,stih407")) &&
-		(!of_machine_is_compatible("st,stih410")))
+		(!of_machine_is_compatible("st,stih410")) &&
+		(!of_machine_is_compatible("st,stih418")))
 		return -ENODEV;
 
 	ddata.cpu = get_cpu_device(0);
-- 
2.25.1

