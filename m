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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B579FC282DF
	for <linux-pm@archiver.kernel.org>; Fri, 19 Apr 2019 19:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E93920656
	for <linux-pm@archiver.kernel.org>; Fri, 19 Apr 2019 19:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrdoKaAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfDST7T (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:59:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43607 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDST7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Apr 2019 15:59:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so2958581pfd.10
        for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2019 12:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TucnPGUSikND03oLf42t7W5Hdl2RgTDHl761l+fESbM=;
        b=JrdoKaAQBc2gyh4xvpQ5gms40/rECfPiUKUTwoeOsWQEnQhPbHwHkksXjKsTHiYLnS
         jw9+TQWYUbcvhwTiJhPk/BOKbl2kVHYqDfdhv31GXwfMLYIEsTYQJJnKfD1cVA6tT2wo
         GC/dDbagUOXrr/Dv67jWQqzxi2JiX2NDUxnt7GqB6/mN4bmD21SWw+u4KQtDeJG9FHxK
         MkOOFZZTGuChHOGIlEvyhvnpOd2WrOU+bYZvLi1ttuHkQWiMMSMC8MxbMYt11QiDQJVU
         Z6m5EfZ1sBZrwSsFcMq4ckhxVxrR23hwNNA49VsnNEuISqk5sz3V66FhPIRsjsgSHhgh
         Dsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TucnPGUSikND03oLf42t7W5Hdl2RgTDHl761l+fESbM=;
        b=EmUQvPSq56ASmoqN8+66/LwlbMXS80JrV4FnrQBVrMPxB5uMe2i0vlzZ3+Jc3pkHVH
         Y+GKB6BRIEuBkYMO5U3BYc4gdbTF6iWdMHo3Ge6L1Uhji5vCtw59xxW7qN0IJcbXLz3a
         VLnuuiJkO5m+w16NMGWFQ+NeOg6M30tPyh6k5IqI293sT4SQYQjOTC3+6m1drQnDGhEp
         05ifWOc5Kis2iOoQLqnXgBLiBE0SZ1mn09is1Lz1HmB+wSZ6pOdZHMGzV9r1by4y498D
         fiZTETa5NMp2jT+wybeZVY8NbxUKdPcIQT/fSwwrlq1Va+MroByP2R8HtDQrW5MEn6hL
         FX3Q==
X-Gm-Message-State: APjAAAUjze62q3zRl+5K1JeA1Q3dU1q+fvz3ulNisUi0y9bj0zERz6Aq
        EjfF6LPYhX2dWVa+9SGzS3kzuKF0
X-Google-Smtp-Source: APXvYqygmMz27BsATAv7TuwQ835/lntnhwSx/Qe/v4zNX6MSeZWq1lXAAwnOy9/qqb/ND+ysU44esg==
X-Received: by 2002:a63:2b41:: with SMTP id r62mr2197352pgr.403.1555655296717;
        Thu, 18 Apr 2019 23:28:16 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id k6sm7880865pfj.173.2019.04.18.23.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 23:28:16 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] cpufreq: Expose real_cpus out to userspace
Date:   Fri, 19 Apr 2019 14:27:59 +0800
Message-Id: <20190419062759.8524-2-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
In-Reply-To: <20190419062759.8524-1-zbestahu@gmail.com>
References: <20190419062759.8524-1-zbestahu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, there are 3 CPU masks, let's expose real_cpus just like the
others if user want to know related CPUs that are actually present.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/cpufreq/cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c6187f1..0322cce 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -824,6 +824,11 @@ static ssize_t show_affected_cpus(struct cpufreq_policy *policy, char *buf)
 	return cpufreq_show_cpus(policy->cpus, buf);
 }
 
+static ssize_t show_real_cpus(struct cpufreq_policy *policy, char *buf)
+{
+	return cpufreq_show_cpus(policy->real_cpus, buf);
+}
+
 static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
 					const char *buf, size_t count)
 {
@@ -873,6 +878,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
 cpufreq_freq_attr_ro(bios_limit);
 cpufreq_freq_attr_ro(related_cpus);
 cpufreq_freq_attr_ro(affected_cpus);
+cpufreq_freq_attr_ro(real_cpus);
 cpufreq_freq_attr_rw(scaling_min_freq);
 cpufreq_freq_attr_rw(scaling_max_freq);
 cpufreq_freq_attr_rw(scaling_governor);
@@ -886,6 +892,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
 	&scaling_max_freq.attr,
 	&affected_cpus.attr,
 	&related_cpus.attr,
+	&real_cpus.attr,
 	&scaling_governor.attr,
 	&scaling_driver.attr,
 	&scaling_available_governors.attr,
-- 
1.9.1

