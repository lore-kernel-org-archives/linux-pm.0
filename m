Return-Path: <SRS0=x0P7=S4=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E5C43218
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 06:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E30206E0
	for <linux-pm@archiver.kernel.org>; Fri, 26 Apr 2019 06:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfJ3X+fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfDZGGR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:06:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43790 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZGGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Apr 2019 02:06:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so1057495pgu.10
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2019 23:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IK6LtV2VE0envL1uHFmlb5xFNDxowLlUijBcUPLnXrc=;
        b=OfJ3X+fh4hdjkopuJZHC11BQJ5oUdoei5xijjz+Y0/gpr2rmAFUZLeYU/lG9eAXzEt
         jNdFkUWFDOWxqrmJyIe/I268jd+0WvKIyLSoKI0ew72yqO0/wvyV+J4Tl5JKGYK9qgog
         9Fqt1ptnOgxYMxTjACFK+aqNovx/UioGXxrs6o7T1AqO64whFKZesdsWudoM/C/O4I2a
         eJlSDUUVQTkX9qIxXgmAu8D2ViY6XaMn2WPf66oZGnv4h0HFcE6cb5mdQj541+E3G2OT
         mRDfcRTgBvsGgYLr3177LzWQ9utYioysUC6XaH+vC/9md8MhUxphU5d6jCGTfqdo1wWy
         9i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IK6LtV2VE0envL1uHFmlb5xFNDxowLlUijBcUPLnXrc=;
        b=unAPiy5agMRtaQlOuxH/jw46N1E7RJq3R8Q+As4RCN9XXC4B6qWntHPQjtWJIA8sY5
         PPtVwLR5rms+v+vELfe9XN8f2pKm/K9gSx9FJMLG9U/avXl4DrXbnOEZ9YBagwhV7lu3
         wLKyvlC3YHQKuq9SyP9imRTR/t007t9JoaXcw+YmNE4JIbXhGui1bTlv7ttzDOz4yRPX
         t9at+7Xq1C+xhk7Qmiy0KbmjKzsi2jFotumUqRsodmrqQi8CZHnryl86FIKgYY0ixovG
         TVUgP2MnwL3/WvqagbHI4xsPj2+p2y1eIkzHipWWpLUQ+u0m7X/iZR6jTrzMhS1b71mO
         EVCQ==
X-Gm-Message-State: APjAAAWIYy5RXi7vdDXRMz2ELnF4JwULu+MYaiay7fV3fjJKbqgYmG7e
        bqtVz7bjeTArGgZD6lwgzE4=
X-Google-Smtp-Source: APXvYqzLsLhcYAjuHZCe7A4XlzToiaO4oeHWvNslf9bAy65TZqKFytZc8qaV1baaNcZAM5Ya+EOpWQ==
X-Received: by 2002:a63:6e01:: with SMTP id j1mr41990921pgc.442.1556258775857;
        Thu, 25 Apr 2019 23:06:15 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id p2sm61491924pfi.73.2019.04.25.23.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 23:06:15 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] cpufreq: Don't find governor for setpolicy drivers in cpufreq_init_policy()
Date:   Fri, 26 Apr 2019 14:05:51 +0800
Message-Id: <20190426060551.5932-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

In cpufreq_init_policy() we will check if there's last_governor for target
and setpolicy type. However last_governor is set only if has_target() is
true in cpufreq_offline(). That means find last_governor for setpolicy
type is pointless. Also new_policy.governor will not be used if ->setplicy
callback is set in cpufreq_set_policy().

Moreover, there's duplicate ->setpolicy check in using default policy path.
Let's add a new helper function to avoid it. Also fix a little comment.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/cpufreq/cpufreq.c | 66 ++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0322cce..b822a3e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -578,6 +578,20 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
 	return NULL;
 }
 
+static int cpufreq_parse_static_governor(char *str_governor,
+					struct cpufreq_policy *policy)
+{
+	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
+		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
+		return 0;
+	}
+	if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
+		policy->policy = CPUFREQ_POLICY_POWERSAVE;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 /**
  * cpufreq_parse_governor - parse a governor string
  */
@@ -585,15 +599,7 @@ static int cpufreq_parse_governor(char *str_governor,
 				  struct cpufreq_policy *policy)
 {
 	if (cpufreq_driver->setpolicy) {
-		if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
-			policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-			return 0;
-		}
-
-		if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
-			policy->policy = CPUFREQ_POLICY_POWERSAVE;
-			return 0;
-		}
+		return cpufreq_parse_static_governor(str_governor, policy);
 	} else {
 		struct cpufreq_governor *t;
 
@@ -1020,32 +1026,40 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
 
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
-	struct cpufreq_governor *gov = NULL;
+	struct cpufreq_governor *gov = NULL, *def_gov = NULL;
 	struct cpufreq_policy new_policy;
 
 	memcpy(&new_policy, policy, sizeof(*policy));
 
-	/* Update governor of new_policy to the governor used before hotplug */
-	gov = find_governor(policy->last_governor);
-	if (gov) {
-		pr_debug("Restoring governor %s for cpu %d\n",
+	def_gov = cpufreq_default_governor();
+
+	if (has_target()) {
+		/*
+		 * Update governor of new_policy to the governor used before
+		 * hotplug
+		 */
+		gov = find_governor(policy->last_governor);
+		if (gov)
+			pr_debug("Restoring governor %s for cpu %d\n",
 				policy->governor->name, policy->cpu);
+		else {
+			if (!def_gov)
+				return -ENODATA;
+			gov = def_gov;
+		}
+		new_policy.governor = gov;
 	} else {
-		gov = cpufreq_default_governor();
-		if (!gov)
-			return -ENODATA;
-	}
-
-	new_policy.governor = gov;
-
-	/* Use the default policy if there is no last_policy. */
-	if (cpufreq_driver->setpolicy) {
+		/* Use the default policy if there is no last_policy. */
 		if (policy->last_policy)
 			new_policy.policy = policy->last_policy;
-		else
-			cpufreq_parse_governor(gov->name, &new_policy);
+		else {
+			if (!def_gov)
+				return -ENODATA;
+			cpufreq_parse_static_governor(def_gov->name,
+						      &new_policy);
+		}
 	}
-	/* set default policy */
+	/* Set new policy */
 	return cpufreq_set_policy(policy, &new_policy);
 }
 
-- 
1.9.1

