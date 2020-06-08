Return-Path: <SRS0=539E=7W=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA71EC433E0
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jun 2020 00:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E2920760
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jun 2020 00:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664101;
	bh=Sl/PYpXNg++EVQUk+AQqR0ej8vbmve0/ub7u9lPRBMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VT3qVxV/6WxhjGswy+gSRQpVNXcLChTrQ+PQONSvkzzNmC0NduDFGyKvYcN3vnaD6
	 HFKAOXRqIV6VgFyRimknJhNjvUn7UTwS89ph7rk4Com/Ws21Yhti8mhHKhsrtA4pxd
	 RNrWtrH5+pwQ4ZDizaDI7NmTzu18anDMhJ0UC4Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgFIAym (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgFHXJb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jun 2020 19:09:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F352E208C3;
        Mon,  8 Jun 2020 23:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657771;
        bh=Sl/PYpXNg++EVQUk+AQqR0ej8vbmve0/ub7u9lPRBMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NeELp2pjl36MzAMRdPZaZKHlcTTbpu2DLTvfPnWfEZrRxfB53jd7a75gmj0kXPSwV
         JzVwRlM6M90BJLtUvEnloFpG9Ehv9Ey4ejcQsWEZVzRi+UAvNSss5H5QXLU+WsKHI1
         BHMP6d4s2OTrddoC/lLpGx+YLPRDtbi3x/SMAFTI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 155/274] cpufreq: qcom: fix wrong compatible binding
Date:   Mon,  8 Jun 2020 19:04:08 -0400
Message-Id: <20200608230607.3361041-155-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ansuel Smith <ansuelsmth@gmail.com>

[ Upstream commit 2dea651680cea1f3a29925de51002f33d1f55711 ]

Binding in Documentation is still "operating-points-v2-kryo-cpu".
Restore the old binding to fix the compatibility problem.

Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a1b8238872a2..d06b37822c3d 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -277,7 +277,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENOENT;
 
-	ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");
+	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
 	if (!ret) {
 		of_node_put(np);
 		return -ENOENT;
-- 
2.25.1

