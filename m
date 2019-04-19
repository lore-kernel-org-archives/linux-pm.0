Return-Path: <SRS0=DtRT=SV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2BFC282DF
	for <linux-pm@archiver.kernel.org>; Fri, 19 Apr 2019 20:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FA320821
	for <linux-pm@archiver.kernel.org>; Fri, 19 Apr 2019 20:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVsYCO4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfDSUQO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:16:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42696 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSUQO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Apr 2019 16:16:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so3079465pgh.9
        for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2019 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xaKLcXqgvpIhUZ5Sb3zwLh5apBX7LqGVKrAiPbClQMU=;
        b=oVsYCO4TDxPaipnGKirMWJZJF2RW/czl6sRMjYEULhnFairkAaX3Xqm5xKgTtqQKaR
         eztb0/E6cF7tj1g4LtVUcES04XaFCnYuXLY0sOOBk5pa6+gQlW5L+Y2vtx7597TWBvuT
         cVXMdwGNnw1Vl+wQlvEQPgAdd2o0wzWvS4uk7WD96nxmwIh68ElXjz7o1bftTSbugekz
         OsRO/KAu78Z0KO86SKJA+5QG7f1YcrvIqXDnJo2j62b6Y9kie/OfgLmwruaFdTks0Jm6
         TQK3jMXxTkXxsWp0FuaEGCp0erEpgTFwIgFvrk0oyYUKMSRRK7J7ezOSqkOgm0QOOR4h
         w0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xaKLcXqgvpIhUZ5Sb3zwLh5apBX7LqGVKrAiPbClQMU=;
        b=i/1wMR0gxnhrwxIpLavNZucHVIsNr8Uvk6wfYgkQ78axOL0MnSZSDqtErE3bjEMvJ3
         swpia6O3I4/U1DImTsayr8pqFd5/N9jWQCpO6752pvZKHhBYKGAuJcCZF4514OlKAbyg
         WcfT3VEYlD0eVTSabdg0w43H3aye2WyvMdWVlr6CfxGsaSD/8bY16mg+E+PNlBTvPAqT
         ecOO51d0PnMVf8G0+uISqeG1jQADqx81Mr+FfXqW5W/opYkmcXoNY/t5jAMbBUHmnWbU
         x6jVlw+iJpMVJMPFN8mKuPPcTqDNvBysIkDvld2nCrb0xRrXc11COea7zALZ8hBV1Zlk
         17lg==
X-Gm-Message-State: APjAAAV8Hf+yvat4Qsq85d19FVEUECUm5+fqba4ZpApXPi9B5hXLFRMP
        Bm9fYIUW0dZpARNo8KeU/RLXz67V
X-Google-Smtp-Source: APXvYqy476h8ycc32uFZ/pofuXPnDMb/w377+gAPmiacj6knLhaormPawOgHZuz8TGEoiViClT9LEQ==
X-Received: by 2002:a63:1918:: with SMTP id z24mr2194261pgl.406.1555655291882;
        Thu, 18 Apr 2019 23:28:11 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id k6sm7880865pfj.173.2019.04.18.23.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 23:28:11 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] cpufreq: Move ->get callback check outside of __cpufreq_get()
Date:   Fri, 19 Apr 2019 14:27:58 +0800
Message-Id: <20190419062759.8524-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currenly, __cpufreq_get() called by show_cpuinfo_cur_freq() will check
->get callback. That is needless since cpuinfo_cur_freq attribute will
not be created if ->get is not set. So let's drop it in __cpufreq_get().
Also keep this check in cpufreq_get().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/cpufreq/cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 047662b..c6187f1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1548,7 +1548,7 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 {
 	unsigned int ret_freq = 0;
 
-	if (unlikely(policy_is_inactive(policy)) || !cpufreq_driver->get)
+	if (unlikely(policy_is_inactive(policy)))
 		return ret_freq;
 
 	ret_freq = cpufreq_driver->get(policy->cpu);
@@ -1586,7 +1586,8 @@ unsigned int cpufreq_get(unsigned int cpu)
 
 	if (policy) {
 		down_read(&policy->rwsem);
-		ret_freq = __cpufreq_get(policy);
+		if (cpufreq_driver->get)
+			ret_freq = __cpufreq_get(policy);
 		up_read(&policy->rwsem);
 
 		cpufreq_cpu_put(policy);
-- 
1.9.1

