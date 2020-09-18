Return-Path: <SRS0=VqYW=C3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B35C43463
	for <linux-pm@archiver.kernel.org>; Fri, 18 Sep 2020 02:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B1D23770
	for <linux-pm@archiver.kernel.org>; Fri, 18 Sep 2020 02:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600396691;
	bh=Kvg4TYtCRyYFiO+X6QdpTQiPvFHaswMRec8XtHXSmN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dP43E/7cBHwYSMt08HnTEFXgHkBhaevb9nzoBxlacSfttpdxibGmH+mmrbXEsbxjC
	 rPsulHwg1ZCs+CuttXVW4QsiGyRs3gJertkkWxKDlDssjc5edp8ZPiTxNALiGXL0do
	 HY8XJEj8YvSWUOqlGPxv5r8jZpg7UHSSqMP2GGkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgIRCiA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbgIRCMa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Sep 2020 22:12:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51022395C;
        Fri, 18 Sep 2020 02:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395149;
        bh=Kvg4TYtCRyYFiO+X6QdpTQiPvFHaswMRec8XtHXSmN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFbE9k+i2w563HolCNKfu72VmXle8l0O+rtlkxEEnY4ifvDUSA/pwLACXrOdyoVCM
         +gR0g1JOpQtKoO0aSCHqcIXAetZ2IBuwU6SwkbquTUaLfmkZfi/pZ0/rc868rR1fyt
         6XuGxEorVZcF6uT30OSWf9Eghh/XGRVd60bA5mrI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 008/127] PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
Date:   Thu, 17 Sep 2020 22:10:21 -0400
Message-Id: <20200918021220.2066485-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021220.2066485-1-sashal@kernel.org>
References: <20200918021220.2066485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 53b4b2aeee26f42cde5ff2a16dd0d8590c51a55a ]

There is another kHz-conversion bug in the code, resulting in integer
overflow. Although, this time the resulting value is 4294966296 and it's
close to ULONG_MAX, which is okay in this case.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/tegra-devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 6627a7dce95c4..f6a2dd6b188fa 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -79,6 +79,8 @@
 
 #define KHZ							1000
 
+#define KHZ_MAX						(ULONG_MAX / KHZ)
+
 /* Assume that the bus is saturated if the utilization is 25% */
 #define BUS_SATURATION_RATIO					25
 
@@ -179,7 +181,7 @@ struct tegra_actmon_emc_ratio {
 };
 
 static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
-	{ 1400000, ULONG_MAX },
+	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
 	{ 1000000,    500000 },
-- 
2.25.1

