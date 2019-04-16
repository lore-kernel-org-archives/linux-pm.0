Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0046FC10F0E
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 02:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF94A2070D
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 02:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qC7I6nQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfDPCks (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:40:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35550 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfDPCks (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2019 22:40:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so9547234plp.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2019 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B9nI6AnXwzfaGRey3tfJqr1B6b1hsmrDCgcO7B1U0aM=;
        b=qC7I6nQX+1eAjCCYMnBXm9FR3crfzYHaYkoXr1XEw7wHRUnaNwgMbLAg7/20ieozPy
         05+vtq/60AXDYeJT+tu/mu+w8epaq4q6OhtgWiw1e12hNJWzBw62ECjnz8PCrDNbmOF4
         PKpLtfv56kof3YX75QI7OaOEQOKm40zqTLdWqdj99UWPrBLz8WTfxN9vJssZgG3NX8ey
         KzugtgM3WEsj503OJSsCWodXZL04nTEh72T4wH+PuiVXSSMtNTM5lE4fS7dn8kyif4kS
         drRK153vU8CZGD0kPUvMQzLqvQ69803UPNiuVe74+pYm0kwKh3queRjiFnX1bs8R2CHr
         eCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B9nI6AnXwzfaGRey3tfJqr1B6b1hsmrDCgcO7B1U0aM=;
        b=RSeo6PfXSyde24PUXJQXFxWB2C78uJNd4LF6n772yvMXySGEEEuDF+mT2w2Vylxc0/
         hpL4Y12XILW6dcIyt3b5ul40Rd5TvnZuPRfNUCJDGEgcKYHbfOMi9qIfo+H7+IrtDiPB
         k2mIawOSzfBcj45hwpAofvpx03KkkE9T0jnYsWnVgug6BHncguPo/NTtnHuyHxm4eaR/
         qB/RMa45439n/Mu3ltzVlDRyJDl+ky668Q8S4DK8wbQnyLkNbI55MPswycUQcuSy244c
         Z9VUA6cly1tNR/reO3qFXV5dDazIJt1tC2q2m395yVMYobRa7ltrj4+CXxUBNEW13zQ4
         KjPQ==
X-Gm-Message-State: APjAAAXt/RyJAltTiuHbXuu8h/gAo1WLWFbgYOtLMAqxJA0V9uHi9EbD
        saq2qVkSSkHjAOYTe6SY3dE=
X-Google-Smtp-Source: APXvYqw91VDCtRKLE0CwSwa6ZzSYf5TWUN/wihTSrnLF0cikayhnJqfI+RSam3TPSGXsCSm+McL3Tg==
X-Received: by 2002:a17:902:ab87:: with SMTP id f7mr78965766plr.85.1555382447459;
        Mon, 15 Apr 2019 19:40:47 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id i135sm67111724pgd.41.2019.04.15.19.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 19:40:46 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] cpufreq: Remove needless bios_limit check in show_bios_limit()
Date:   Tue, 16 Apr 2019 10:40:27 +0800
Message-Id: <20190416024027.6516-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Initially, bios_limit attribute will be created if driver->bios_limit
is set in cpufreq_add_dev_interface(). So remove the redundant check
for latter show operation.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/cpufreq/cpufreq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d9123de..047662b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -857,11 +857,9 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
 {
 	unsigned int limit;
 	int ret;
-	if (cpufreq_driver->bios_limit) {
-		ret = cpufreq_driver->bios_limit(policy->cpu, &limit);
-		if (!ret)
-			return sprintf(buf, "%u\n", limit);
-	}
+	ret = cpufreq_driver->bios_limit(policy->cpu, &limit);
+	if (!ret)
+		return sprintf(buf, "%u\n", limit);
 	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
 }
 
-- 
1.9.1

