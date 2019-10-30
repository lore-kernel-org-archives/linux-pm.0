Return-Path: <SRS0=w0+C=YX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241C6CA9EAF
	for <linux-pm@archiver.kernel.org>; Wed, 30 Oct 2019 09:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA70E2083E
	for <linux-pm@archiver.kernel.org>; Wed, 30 Oct 2019 09:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jcy8Fggj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfJ3JLe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:11:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38228 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfJ3JLa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 05:11:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so1377222wrq.5
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 02:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0cMzmwOQ45CvCpy5BV9I0axI+oTcT02C42maobILAtA=;
        b=Jcy8FggjKwJb4bd9H4Q6f/qntfaIsKoRcwzdf8bVSIBZsq/wZACAWyQxjs8qrpoM48
         0ojV8Qx7fKxGvn1Ln8S3TyUUB2yHjlEIbRFbrWIPy6gqUg+cq1BwbLCUPD3//EwoprbA
         AgGv2ykIUrdJ0p3sJsRBFDWKLmEm2e1yZMwHwVPUUzdzXR2f/e46jXEky77tjWm7SmOm
         +pCMyc8RIFnudmO8HCTTXlsoQpgvD5OSf6MlAZxumT0m8PyR0xwCe5aXgbKqRzprLcKq
         ZsblpQ+IM82gyL4ansMguDQ6BFePNWjNBI5BYGWQwFY56600Vfb/MQRl+GTWWYPd7eK+
         YETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0cMzmwOQ45CvCpy5BV9I0axI+oTcT02C42maobILAtA=;
        b=Svxk7JwtF3G9AVfyYBj0oJwvO1BEZSJeo2DCtooKCrRa/X92sR87Fr9ssiYBbNoHRa
         xgGfu47O314nKabN6o1b6wxqxkTLscrV/WynyFr7tjzXww8kG/okNhqISIb+kKD72+XQ
         FJ2D0tLevMOqHc1JibqS/lQT3esh6miebFFz/Rkd4jyuyXTRs49qrWnfja2cRwdQwEDS
         MaCiNeS0SfzGPwRXdYq8RWTSX4mqI0gHRLObtKzzbTbWPwnoQMybCIGG7ymUpchN1ouc
         S2lZ11wYBebycmWBUtZOo16ArtiUdte7aeKfYYibmf3IdUgcmxHU5ZdJrc/Fl5RDeef3
         xU2w==
X-Gm-Message-State: APjAAAXBx03JqHl1TRb1dw/6mHSbF55am2WzCYJFPoWByv4aztfWzSvo
        GzVWgSdqdU4JWLkHrow26MY6iRkrqRo=
X-Google-Smtp-Source: APXvYqz2E4NMQlmOnxogLoFoSCKmtXixmPvQMaVqKsn2Qt80aUGkIwMVP0MmgrZZNDpIGpFr/1oowA==
X-Received: by 2002:a5d:66c6:: with SMTP id k6mr23308468wrw.152.1572426688132;
        Wed, 30 Oct 2019 02:11:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:2c7f:2fc:5551:ee55])
        by smtp.gmail.com with ESMTPSA id t24sm2608394wra.55.2019.10.30.02.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 02:11:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] thermal: cpu_cooling: Reorder the header file
Date:   Wed, 30 Oct 2019 10:10:37 +0100
Message-Id: <20191030091038.678-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030091038.678-1-daniel.lezcano@linaro.org>
References: <20191030091038.678-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As the conditions are simplified and unified, it is useless to have
different blocks of definitions under the same compiler condition,
let's merge the blocks.

There is no functional change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/cpu_cooling.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 72d1c9c5e538..b74732535e4b 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -33,6 +33,13 @@ cpufreq_cooling_register(struct cpufreq_policy *policy);
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 
+/**
+ * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
+ * @policy: cpufreq policy.
+ */
+struct thermal_cooling_device *
+of_cpufreq_cooling_register(struct cpufreq_policy *policy);
+
 #else /* !CONFIG_CPU_THERMAL */
 static inline struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy)
@@ -45,16 +52,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	return;
 }
-#endif	/* CONFIG_CPU_THERMAL */
 
-#ifdef CONFIG_CPU_THERMAL
-/**
- * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
- * @policy: cpufreq policy.
- */
-struct thermal_cooling_device *
-of_cpufreq_cooling_register(struct cpufreq_policy *policy);
-#else
 static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
-- 
2.17.1

