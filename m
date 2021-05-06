Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88922C433B4
	for <linux-pm@archiver.kernel.org>; Thu,  6 May 2021 19:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CCB61132
	for <linux-pm@archiver.kernel.org>; Thu,  6 May 2021 19:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhEFTKv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 6 May 2021 15:10:51 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:33123 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhEFTKu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 May 2021 15:10:50 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d05 with ME
        id 1X9p2500F21Fzsu03X9qJq; Thu, 06 May 2021 21:09:50 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 May 2021 21:09:50 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, nicola.mazzucato@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] cpufreq: scmi: Fix an error message
Date:   Thu,  6 May 2021 21:09:48 +0200
Message-Id: <b0c09698216af60d97bfd30b55bad89dc0f70112.1620328067.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

'ret' is known to be 0 here.
The last error code is stored in 'nr_opp', so use it in the error message.

Fixes: 71a37cd6a59d ("scmi-cpufreq: Remove deferred probe")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/cpufreq/scmi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index c8a4364ad3c2..ec9a87ca2dbb 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -174,7 +174,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
 		if (nr_opp <= 0) {
 			dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
-				__func__, ret);
+				__func__, nr_opp);
 
 			ret = -ENODEV;
 			goto out_free_opp;
-- 
2.30.2

