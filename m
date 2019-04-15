Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B90DC10F0E
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CEC20656
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 09:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7rgIDyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfDOJWJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:22:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44703 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDOJWJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2019 05:22:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id h18so12472761lfj.11
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2019 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G3+n8iJp0bBZ34v6YWNsnwV9cFN9jlJYazuANl8laUI=;
        b=f7rgIDyPSnC+hvlxLz5GgYbzpV6Vq34stm7K9Jbx42rGpfhsvqEPHHl4p0o+xPlKHT
         BcFtoxT+wAC0Y25rTgmzOxtsh/yIVtOq/abxh06kYh4lKWXekEjNvq+E24tdm3MA+4rV
         4ugOMdZqX7K/kBlGxzytNgUz05PwUEx885gmTLwsZSoNE6X3cc+hdbLTI5zSXBE4B8Mt
         reHKvdctj72v4DfnM3Nfeld92gpZLLINIXwYNQySxuZo6pO+2EkmYjHpjGjGOeEwo/oE
         iVp192xN+xWQPq1WH3776yE+fSiJYsJwZOGRRoDwX5m0pLadSiNHdZoWKFl8Ve8eBuEq
         Lj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G3+n8iJp0bBZ34v6YWNsnwV9cFN9jlJYazuANl8laUI=;
        b=Z3EAJ78xwdOg5RzRwRYY+dxCLk8nrblu8uqdetXCw9jaJJBfZobyi1/Qrlav39w97c
         etXS5GRkpuJ2SUDwiEFkRGZB/wjBYQ7tJ48vFN/68ra/MwxXLZMZatQY4bP683mfwIFI
         Gx8IVPi5B0dFDfxGC5L7xkeKzIuBjvgjmxtputGTVlZy4X/OE5fe6mZbXRekerA5a1VM
         0dWnfa0KK5zhYoYflT4r/0E0GgdGYeF5zWrzQGC+XrPSJgDwggirPf4zJ3EcxTeiDgtH
         Z2baDC4lLL6C17OoEViSuh4Q+o3lgfZCH9m+cGVfGByzOUgRxELQ/6V+LpQdoSYRm6RH
         kJgQ==
X-Gm-Message-State: APjAAAU4nOpXEkZBIeQSg/4GOETtpzWFLBDQnKmDYiRcCQwdlliY/lMc
        G5t5tsI6y6DNd4VQiAik9ns=
X-Google-Smtp-Source: APXvYqyguVOgekHR5fSBnIDVCZkihSqPhV3Lskw6plPWhwfPS07SzhMiPUdBgxCL9S6rZvZnxPXSdw==
X-Received: by 2002:a05:6512:20d:: with SMTP id a13mr561460lfo.42.1555320127573;
        Mon, 15 Apr 2019 02:22:07 -0700 (PDT)
Received: from localhost.localdomain (46-243-146.internethome.cytanet.com.cy. [46.199.243.146])
        by smtp.gmail.com with ESMTPSA id g79sm9952800lje.25.2019.04.15.02.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 02:22:06 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     rjw@rjwysocki.net
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Subject: [PATCH] drivers/cpufreq/acpi-cpufreq.c: This fixes the remove the unnecessary line break.
Date:   Mon, 15 Apr 2019 12:21:56 +0300
Message-Id: <1555320116-6071-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555243658-11196-1-git-send-email-mohankumar718@gmail.com>
References: <1555243658-11196-1-git-send-email-mohankumar718@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove the unnecessary line break.

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 8030dcd..73bb2aa 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -458,8 +458,7 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	if (acpi_pstate_strict) {
 		if (!check_freqs(policy, mask,
 				 policy->freq_table[index].frequency)) {
-			pr_debug("%s (%d)\n",
-				__func__, policy->cpu);
+			pr_debug("%s (%d)\n", __func__, policy->cpu);
 			result = -EAGAIN;
 		}
 	}
-- 
2.7.4

