Return-Path: <SRS0=GSIr=SQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D062CC10F13
	for <linux-pm@archiver.kernel.org>; Sun, 14 Apr 2019 12:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E11C2084E
	for <linux-pm@archiver.kernel.org>; Sun, 14 Apr 2019 12:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNYi0fis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfDNMHr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 14 Apr 2019 08:07:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47007 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNMHr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Apr 2019 08:07:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so1969679lfj.13
        for <linux-pm@vger.kernel.org>; Sun, 14 Apr 2019 05:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QiBcl40u0nC5UdOVE4yHMU4668NXtmUDFerEKoTHADI=;
        b=PNYi0fiswx7wKf6tmq2pbptWNG9Np24jp+KbYEwNE4cnYMycFJy43+9MMObJeEobkV
         EeQboiPU+rX+qXptoPZxlZ13jv+LBh/SkQdtKQpuYlHbqaQJdKJVtC/fFd8GdSOxhigY
         y9voy+O6RRpp8+wO92kgVXJoQ0RpMUsBK69F8/EOdfMoVz3wYRnJbDgE2Gjo89ggDms/
         U2q6j6EBGeM56R9FAuitWlVcLps7DstWV7rRyOzofOm0h5op5tXcvRc4beRCjcTsd1II
         OAS6s+2Fk4E1Z8JwNXkRONAR1c9gaBJuVgDH9NhNQ/NmkbuabU+xTDvHMOcoiLtnGMCu
         omsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QiBcl40u0nC5UdOVE4yHMU4668NXtmUDFerEKoTHADI=;
        b=JztpnnmtAWswNELgmxQGHdYfCRBI5wkBGsOHvxzAqHT8CatUB0MGRpOgRj7BsK8QyG
         bD3w3njIvcsaNNGJwLjXIDaVIugarTyqqCVkfq8fRp0XcjFam8UcPLX6IyIBI87JVYvL
         Fg/NwhoGOHgE9cS1rezHfb4fQSxtx38VB7Egr7k2csJteBHZUfzQNRvBAfKvUVjptl4b
         usi4C6A/tqgcepNN/keiJ0XVFJYA7CRon56QnmAoi9BsqTyERt2o7ldQEX7VC8FyahYa
         CB/bhb5xAZZ2f6gRLA7PekhwS1KA9lpmoawYj38oORBXDh6HXhlO6xN9W2A3y9RE+pmr
         dkEg==
X-Gm-Message-State: APjAAAXnswnqBpxUC2uasG7QA86k0MurpEh/2uvyErnHdM/lpfnAK+sb
        bL7/cdvpG4HVoAA8MBFMme4=
X-Google-Smtp-Source: APXvYqxv6WI5uV1Hl6vbKfbSAVvROC+SZGkqO4dLofD2PpV1+HnEpJmitEjAwRA5OhBNbNx/aRMD3Q==
X-Received: by 2002:ac2:51d9:: with SMTP id u25mr9269399lfm.91.1555243665540;
        Sun, 14 Apr 2019 05:07:45 -0700 (PDT)
Received: from localhost.localdomain (46-243-146.internethome.cytanet.com.cy. [46.199.243.146])
        by smtp.gmail.com with ESMTPSA id u19sm9471573lfg.74.2019.04.14.05.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Apr 2019 05:07:44 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     rjw@rjwysocki.net
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Subject: [PATCH] drivers/cpufreq/acpi-cpufreq.c: This fixes the following checkpatch warning
Date:   Sun, 14 Apr 2019 15:07:38 +0300
Message-Id: <1555243658-11196-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

WARNING: Prefer using '"%s...", __func__' to using function's name, in a
string

Switch hardcoded function name with a reference to __func__ making the
code more maintainable

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index c72258a..8030dcd 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -366,7 +366,7 @@ static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *dat
 
 	val = drv_read(data, mask);
 
-	pr_debug("get_cur_val = %u\n", val);
+	pr_debug("%s = %u\n", __func__, val);
 
 	return val;
 }
@@ -378,7 +378,7 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 	unsigned int freq;
 	unsigned int cached_freq;
 
-	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
+	pr_debug("%s (%d)\n", __func__, cpu);
 
 	policy = cpufreq_cpu_get_raw(cpu);
 	if (unlikely(!policy))
@@ -458,8 +458,8 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	if (acpi_pstate_strict) {
 		if (!check_freqs(policy, mask,
 				 policy->freq_table[index].frequency)) {
-			pr_debug("acpi_cpufreq_target failed (%d)\n",
-				policy->cpu);
+			pr_debug("%s (%d)\n",
+				__func__, policy->cpu);
 			result = -EAGAIN;
 		}
 	}
@@ -573,7 +573,7 @@ static int cpufreq_boost_down_prep(unsigned int cpu)
 static int __init acpi_cpufreq_early_init(void)
 {
 	unsigned int i;
-	pr_debug("acpi_cpufreq_early_init\n");
+	pr_debug("%s\n", __func__);
 
 	acpi_perf_data = alloc_percpu(struct acpi_processor_performance);
 	if (!acpi_perf_data) {
@@ -657,7 +657,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	static int blacklisted;
 #endif
 
-	pr_debug("acpi_cpufreq_cpu_init\n");
+	pr_debug("%s\n", __func__);
 
 #ifdef CONFIG_SMP
 	if (blacklisted)
@@ -856,7 +856,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 
-	pr_debug("acpi_cpufreq_cpu_exit\n");
+	pr_debug("%s\n", __func__);
 
 	policy->fast_switch_possible = false;
 	policy->driver_data = NULL;
@@ -881,7 +881,7 @@ static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 
-	pr_debug("acpi_cpufreq_resume\n");
+	pr_debug("%s\n", __func__);
 
 	data->resume = 1;
 
@@ -954,7 +954,7 @@ static int __init acpi_cpufreq_init(void)
 	if (cpufreq_get_current_driver())
 		return -EEXIST;
 
-	pr_debug("acpi_cpufreq_init\n");
+	pr_debug("%s\n", __func__);
 
 	ret = acpi_cpufreq_early_init();
 	if (ret)
@@ -991,7 +991,7 @@ static int __init acpi_cpufreq_init(void)
 
 static void __exit acpi_cpufreq_exit(void)
 {
-	pr_debug("acpi_cpufreq_exit\n");
+	pr_debug("%s\n", __func__);
 
 	acpi_cpufreq_boost_exit();
 
-- 
2.7.4

