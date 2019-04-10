Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97562C10F14
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 04:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F29F20850
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 04:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A14MK+0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfDJEAI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:00:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34257 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJEAI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2019 00:00:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so549483plt.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2019 21:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8gKXUa8/K/uPfSEMm1FLMTWmYc3h05dbsDQqp3LUrfQ=;
        b=A14MK+0xiWWaenbh+nDiCNhWLADZbJqVWp16O5HCREhrUDbQjow1YiOz6MAoqE8oyU
         8uXteyqPWDQIwPxTxq6be09WgE2AaSJ2RStryZIEBX9pLtoXDKlExsVfYDbKiEz8nVms
         LDj9dFnxZOR3c2mBa+0Sqq73K0EFDkk11av9IfTevbMpn91jjBtRvKgQE86qD485Cwd3
         cwN4Cflw/RSTvK9nEINkKqOb++/Wg+mZWkorAUSuL+7XBbVOzNzvPc7ueCDEbScgPx0s
         BwX7za+lGwgRbX2csY7RKuseBHQPbnfn4sBKNWpVvU6zlagtj7ntD9QuiKykT80chA8v
         tYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8gKXUa8/K/uPfSEMm1FLMTWmYc3h05dbsDQqp3LUrfQ=;
        b=Gdkfwv+/Mc3BvxFy/+TfCDGNfWkW6SuV3sq1wdQjhGLKiYNVEKat+vycmIxymD/h3J
         sEOLBbto5Sl5v6M7+5fvUY3zDLLJx90cAV0t4tYjjyl5pYpIqxQm3tB3tywNgrlB2SI2
         iqB/H8RK86hLiQGcOgYrKWJAd4LmvweqmeOvA4yH11sc/bNjT+yNzxscw9Y/PGdyTXbb
         G44o8/H2f9SpisfrRIqQFg++SJE6mEVgP0djsut2WRLr+LRKtMyKSOHLYpS/LWgjxO1W
         Exo1hQzZTrexJBeGCyk5jV4ccZzi2FlwWr9Zim4BkbDGLQ3WD3MepIEcDrFYZ2uHLIHo
         Gu3A==
X-Gm-Message-State: APjAAAVzlX3KoUOVL7MQoy/lvidQ8GbB+50o5SkCQqYXZmkXnJnT7t0H
        rLs8/n9ZMJd3I5r7Osr92kA=
X-Google-Smtp-Source: APXvYqxfBe1/qXkoQMQ/YA7sZkVbrASyuzl9NjwHm8ZDi70/3vki6PRwHLH+lf4Xumna5QNu7aYriQ==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr41425996plt.149.1554868807535;
        Tue, 09 Apr 2019 21:00:07 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id 143sm69373140pge.50.2019.04.09.21.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 21:00:06 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] cpufreq / boost: Remove CONFIG_CPU_FREQ_BOOST_SW Kconfig option
Date:   Wed, 10 Apr 2019 11:59:52 +0800
Message-Id: <20190410035952.5728-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Commit 2fb4719b2560 ("cpufreq / boost: Kconfig: Support for
software-managed BOOST") added the CONFIG_CPU_FREQ_BOOST_SW config.
However EXYNOS based cpufreq drivers have been removed because of
switching to cpufreq-dt driver which will set boost-attr if required.

So, let's remove this option and update cpufreq_generic_attr[].

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/cpufreq/Kconfig      | 4 ----
 drivers/cpufreq/freq_table.c | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index b22e6bb..4d2b33a 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -26,10 +26,6 @@ config CPU_FREQ_GOV_COMMON
 	select IRQ_WORK
 	bool
 
-config CPU_FREQ_BOOST_SW
-	bool
-	depends on THERMAL
-
 config CPU_FREQ_STAT
 	bool "CPU frequency transition statistics"
 	help
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 3a8cc99..e7be0af 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -290,9 +290,6 @@ static ssize_t scaling_boost_frequencies_show(struct cpufreq_policy *policy,
 
 struct freq_attr *cpufreq_generic_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
-#ifdef CONFIG_CPU_FREQ_BOOST_SW
-	&cpufreq_freq_attr_scaling_boost_freqs,
-#endif
 	NULL,
 };
 EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
-- 
1.9.1

