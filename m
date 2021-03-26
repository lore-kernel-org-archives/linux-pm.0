Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25731C433C1
	for <linux-pm@archiver.kernel.org>; Fri, 26 Mar 2021 12:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0704619C2
	for <linux-pm@archiver.kernel.org>; Fri, 26 Mar 2021 12:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCZMHu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 Mar 2021 08:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhCZMH2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 08:07:28 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93439C0613AA
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 05:07:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:5cae:bca6:def7:9f08])
        by xavier.telenet-ops.be with bizsmtp
        id l07P2400953vE1T0107PxQ; Fri, 26 Mar 2021 13:07:23 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lPlFK-00AXPH-QT; Fri, 26 Mar 2021 13:07:22 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lPlFK-006cVo-Az; Fri, 26 Mar 2021 13:07:22 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     Myungjoo Ham <myungjoo.ham@samsung.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] cpufreq: Fix scaling_{available,boost}_frequencies_show() comments
Date:   Fri, 26 Mar 2021 13:07:21 +0100
Message-Id: <20210326120721.1577965-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function names in the comment blocks for the functions
scaling_available_frequencies_show() and
scaling_boost_frequencies_show() do not match the actual names.

Fixes: 6f19efc0a1ca08bc ("cpufreq: Add boost frequency support in core")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/cpufreq/freq_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index d3f756f7b5a0594c..67e56cf638efb86a 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -267,7 +267,7 @@ struct freq_attr cpufreq_freq_attr_##_name##_freqs =     \
 __ATTR_RO(_name##_frequencies)
 
 /*
- * show_scaling_available_frequencies - show available normal frequencies for
+ * scaling_available_frequencies_show - show available normal frequencies for
  * the specified CPU
  */
 static ssize_t scaling_available_frequencies_show(struct cpufreq_policy *policy,
@@ -279,7 +279,7 @@ cpufreq_attr_available_freq(scaling_available);
 EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_available_freqs);
 
 /*
- * show_available_boost_freqs - show available boost frequencies for
+ * scaling_boost_frequencies_show - show available boost frequencies for
  * the specified CPU
  */
 static ssize_t scaling_boost_frequencies_show(struct cpufreq_policy *policy,
-- 
2.25.1

