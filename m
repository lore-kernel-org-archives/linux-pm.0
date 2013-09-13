From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 130/228] cpufreq: cris: use cpufreq_generic_init() routine
Date: Fri, 13 Sep 2013 18:31:16 +0530
Message-ID: <2b5bec06ece382705b51aaf97f53762ff540639f.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:50847 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933479Ab3IMNSZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:18:25 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so1222323pde.23
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:18:24 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel@axis.com

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: linux-cris-kernel@axis.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cris-artpec3-cpufreq.c | 6 +-----
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 5 +----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
index 4d88e4f..05fdc7e 100644
--- a/drivers/cpufreq/cris-artpec3-cpufreq.c
+++ b/drivers/cpufreq/cris-artpec3-cpufreq.c
@@ -71,13 +71,9 @@ static int cris_freq_target(struct cpufreq_policy *policy,
 
 static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 {
-	/* cpuinfo and default policy values */
-	policy->cpuinfo.transition_latency = 1000000; /* 1ms */
-
-	return cpufreq_table_validate_and_show(policy, cris_freq_table);
+	return cpufreq_generic_init(policy, cris_freq_table, 1000000);
 }
 
-
 static struct cpufreq_driver cris_freq_driver = {
 	.get	= cris_freq_get_cpu_frequency,
 	.verify	= cpufreq_generic_frequency_table_verify,
diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
index f7d2d49..fac2b26 100644
--- a/drivers/cpufreq/cris-etraxfs-cpufreq.c
+++ b/drivers/cpufreq/cris-etraxfs-cpufreq.c
@@ -70,10 +70,7 @@ static int cris_freq_target(struct cpufreq_policy *policy,
 
 static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 {
-	/* cpuinfo and default policy values */
-	policy->cpuinfo.transition_latency = 1000000;	/* 1ms */
-
-	return cpufreq_table_validate_and_show(policy, cris_freq_table);
+	return cpufreq_generic_init(policy, cris_freq_table, 1000000);
 }
 
 static struct cpufreq_driver cris_freq_driver = {
-- 
1.7.12.rc2.18.g61b472e

