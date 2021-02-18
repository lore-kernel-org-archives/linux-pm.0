Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D6CC433E9
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 10:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3CD64EB3
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 10:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhBRKow (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Feb 2021 05:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhBRJjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 04:39:32 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D4C061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:38:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t2so1102512pjq.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Ha0o4hPhJuSU2ivR0S1ZG5Hz8Y//ZRFwnTdQ2hpr6M=;
        b=OQ4CZI2tcg53UCpXji8ZHBa45Bb1no5pZ/E3DKlVGYnywo+ritkR6Pq9Y0fcDZX4qh
         GxHDEEOoC+7FylZ8rmaB/T8PVgxNs0xz7JdaUjUWe/FGQ6rah7P1bHxyVcqzQ/XdNXYC
         3UHXx3H1oecv0CUvmlCfjnv4cdfTqIzbVTFMHLo6ubRQtk7BdrPA1OKpJFRP6KAl4DMR
         G7RsaDEXFritem0cNZDbtBaBr/HLuA2ojjyxoRf4aCJ2X0G+WqBHXyZ26m5AzhicYhFw
         EQ9KCY77rCcdv+y9pnpheAsFSrn7bMfgZhNmMzOT8Q36IJGT6cstolWSTzyhD3Z+5Ws2
         DvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Ha0o4hPhJuSU2ivR0S1ZG5Hz8Y//ZRFwnTdQ2hpr6M=;
        b=I3qw9PBxldmf4rG2i3oX4DMDM8EgHfLQqNPX0NAs3c2ioNoboWEh82YpVsrvGvJWl/
         /uFiV8lzp+W0Wvdnbl8XhVInaCF8mXMGqRI/DOjyJABS2/uRiYTOYuWvh3diTPWzpl1j
         ttYV1czqp93eN5mqFE6CMD73P3pUMvy2sIqa1TTbVCcaHw7FZBIgE0rzsHx1ZXUbDQcC
         m6RTNCDX54LBeBpDdEszdmGuIzSjTXB1eRN41VYUbVL2UrJaqrJajKIRpQCCLKHGOKhO
         1GAKEGS6HWrDkNcH9bpjNzfUiNTOrWDzDULzWLfhuUfej/kKKQ4p0J9+k0nAAjPhkDGi
         VQpA==
X-Gm-Message-State: AOAM531kmBxu2872mqsYo74EgQKYybukEj2OBMmvUsP3UeEl4VCslNh3
        iAffaYqnWeH2jsj6JtQPKAA=
X-Google-Smtp-Source: ABdhPJwNQ3BEbvZ56LILCmAZdFgmdNaVS5R9qknmIQ02w0GERC+WLyCGP8z5AyNn+eVNzli2i+g+BQ==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr3257125pjb.199.1613641107421;
        Thu, 18 Feb 2021 01:38:27 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id z12sm4714159pjz.16.2021.02.18.01.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 01:38:26 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] cpufreq: schedutil: Remove comment to update_lock of struct sugov_policy
Date:   Thu, 18 Feb 2021 17:37:53 +0800
Message-Id: <20210218093753.1700-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, update_lock is also used in sugov_update_single_freq(). The
comment is not helpful anymore.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index add8081..fd43d59 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -26,7 +26,7 @@ struct sugov_policy {
 	struct sugov_tunables	*tunables;
 	struct list_head	tunables_hook;
 
-	raw_spinlock_t		update_lock;	/* For shared policies */
+	raw_spinlock_t		update_lock;
 	u64			last_freq_update_time;
 	s64			freq_update_delay_ns;
 	unsigned int		next_freq;
-- 
1.9.1

