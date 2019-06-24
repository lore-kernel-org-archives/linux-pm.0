Return-Path: <SRS0=M8Ta=UX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63680C48BE9
	for <linux-pm@archiver.kernel.org>; Mon, 24 Jun 2019 13:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCFE2133F
	for <linux-pm@archiver.kernel.org>; Mon, 24 Jun 2019 13:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQXz36bU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfFXNRa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:17:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36449 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfFXNRa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 09:17:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so12688639wrs.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=efC80koaOeT2KpDCiZsg2W4r8KMOQMdu6ewHJAqZM1c=;
        b=qQXz36bUWSjMxGO1GiOAaRejTpoS188FGJ60lh8ehW1GwnXUxUcrf3WMswMNMA17tb
         3JquDEdlsoGOtjCi0/v4qOs3ui/yQT0oPyKTBDUoiqwBJEUm9yMu/KvmtN4HK0w/yBqj
         3CEm1JupxSoMH5rqYw1OGPLRFG6g87EwCghEOwSFkWwUsd5QWDv5lOmlWsdFtjeWqPK0
         8Ywz6hqkZJNj2i5+OaCQFVA8Y+T4z3KyqiY7MSUSZbGNmxvm4Tb0b0el9ngNS50RdYu5
         3Ia4trUgcm5P92NadSlDdWPClvjXlTPr+UBrP1bTgtAx7vTV1H6kzGQ2rJruDkTKWyWB
         06ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=efC80koaOeT2KpDCiZsg2W4r8KMOQMdu6ewHJAqZM1c=;
        b=VGCQD7ai/cmWldbuFtvbZmTnbU/qFcYfTtAB4I59dz91E7tsAV0WExwDcHhytYu59l
         wA5QEgTzJV3tF+QHcfIfWEWra+Hml5IEo9a4mYLQyiaLstqyowli/UEf1Y5Mv61shsB9
         oVBJkxhTr7E9kndnQx6FFFykDxSmePwFYxLgk7FIE5Mt4M3yORV1M3au6R3kAS9wzMc8
         iQtM6wZPcOH9E+kFaDL374xzYWDQiXUgAftkABE5h9owTOKoz7MY2J0n1o317ZwMVzOG
         vv6xDlbaCp2Rh3QkbxdGPDA4ti+CQ+UclGeZcTH19jBuIkstj5w2D7T6+0LnmEpPhh70
         LX/w==
X-Gm-Message-State: APjAAAUpG7SUFsKj8oKBAqIRiiRxfUJz2tRb/BjWJNKNRey88xX+VeY0
        IWKzKdO0xNZ4zhBbhEwrFPGfrKLXxrQ=
X-Google-Smtp-Source: APXvYqxUOBzAyMNMaVPhzA1YuMbROLQawIe2VanUF0d5dBHRuP8fR81rJ02I7/UZxgaj+Wn8x6/Jsw==
X-Received: by 2002:adf:fc91:: with SMTP id g17mr20193129wrr.194.1561382249035;
        Mon, 24 Jun 2019 06:17:29 -0700 (PDT)
Received: from clegane.local (209.94.129.77.rev.sfr.net. [77.129.94.209])
        by smtp.gmail.com with ESMTPSA id x8sm24952817wre.73.2019.06.24.06.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:17:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH v2 1/2] cpufreq: Move the IS_ENABLED(CPU_THERMAL) macro in a stub
Date:   Mon, 24 Jun 2019 15:17:14 +0200
Message-Id: <20190624131715.1857-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq_online and the cpufreq_offline [un]register the driver as
a cooling device. This is done if the driver is flagged as a cooling
device in addition with a IS_ENABLED macro to compile out the branching
code.

Group this test in a stub function added in the cpufreq header instead
of having the IS_ENABLED in the code path.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++----
 include/linux/cpufreq.h   | 5 +++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 85ff958e01f1..aee024e42618 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1378,8 +1378,7 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
+	if (cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
@@ -1469,8 +1468,7 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
+	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
 		cpufreq_cooling_unregister(policy->cdev);
 		policy->cdev = NULL;
 	}
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d01a74fbc4db..53ec82d75565 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -409,6 +409,11 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 const char *cpufreq_get_current_driver(void);
 void *cpufreq_get_driver_data(void);
 
+static inline int cpufreq_thermal_control_enabled(struct cpufreq_driver *drv)
+{
+	return IS_ENABLED(CPU_THERMAL) && (drv->flags & CPUFREQ_IS_COOLING_DEV);
+}
+
 static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,
 		unsigned int min, unsigned int max)
 {
-- 
2.17.1

