Return-Path: <SRS0=jn4m=UE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE2DC28CC5
	for <linux-pm@archiver.kernel.org>; Wed,  5 Jun 2019 16:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E43D2075C
	for <linux-pm@archiver.kernel.org>; Wed,  5 Jun 2019 16:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfFEQMq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:12:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41097 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbfFEQMq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:12:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id 83so5827508pgg.8
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2019 09:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=79Sfm8YIr23xFkRcXWa+gOIRmNAKkSIQltISbwaioUI=;
        b=Y4ShZqK26GCV232REGWYwErBw6zQmKJdJXheBta6oekYgy6+lMReQX2Fk5oKzzc5fR
         rBpJYqmfAtKfooZzlx23m5SFSlpRB+5mFqRXF5oFM3/yrdOSfGE8RiOLgA0KaYUVsXPS
         BU4YXxaUUQ2miAj5UpNpmyxmP1xYuxR2suat4nuj+fcfrkhRqL1FissAs78SPTpmeu5d
         fSDIGUNHGrOFfwQOsfAU4pcP02JdT7/WRjH8Q1apJi9ugB94lYMJu/Nwi9SyOIW6TO1U
         oHsrQIaPra7nwozgRBIvPV2i3nu1o7FBGmq4WnfocnsQYPdJGXI6A6YhaAWjOj2RkQJK
         BeFA==
X-Gm-Message-State: APjAAAVSFYGgcIvngI11WXxUuHOLkJYmnSwtSEIGDRZ5InD6bVYlC1Fb
        LY3uOOAmd5PwQeWM6KoR4UHZBGa9TmI=
X-Google-Smtp-Source: APXvYqxjkznisIoTau+XvZf/GLhvZndexplcbkYF6j2Xo/Y1lA4UJmkMw1XvHk4hQknJTvE34IGz3A==
X-Received: by 2002:a65:490f:: with SMTP id p15mr5485988pgs.275.1559751165796;
        Wed, 05 Jun 2019 09:12:45 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 25sm22746617pfp.76.2019.06.05.09.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:12:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] PM: Show how long dpm_suspend_start() and dpm_suspend_end() take
Date:   Wed,  5 Jun 2019 09:12:37 -0700
Message-Id: <20190605161237.176983-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When debugging device driver power management code it is convenient to
know how much time is spent in the "suspend start" and "suspend end"
phases. Hence log the time spent in these phases.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/base/power/main.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index dcfc0a36c8f7..1e84b8aa220f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1631,17 +1631,20 @@ int dpm_suspend_late(pm_message_t state)
  */
 int dpm_suspend_end(pm_message_t state)
 {
-	int error = dpm_suspend_late(state);
+	ktime_t starttime = ktime_get();
+	int error;
+
+	error = dpm_suspend_late(state);
 	if (error)
-		return error;
+		goto out;
 
 	error = dpm_suspend_noirq(state);
-	if (error) {
+	if (error)
 		dpm_resume_early(resume_event(state));
-		return error;
-	}
 
-	return 0;
+out:
+	dpm_show_time(starttime, state, error, "end");
+	return error;
 }
 EXPORT_SYMBOL_GPL(dpm_suspend_end);
 
@@ -2034,6 +2037,7 @@ int dpm_prepare(pm_message_t state)
  */
 int dpm_suspend_start(pm_message_t state)
 {
+	ktime_t starttime = ktime_get();
 	int error;
 
 	error = dpm_prepare(state);
@@ -2042,6 +2046,7 @@ int dpm_suspend_start(pm_message_t state)
 		dpm_save_failed_step(SUSPEND_PREPARE);
 	} else
 		error = dpm_suspend(state);
+	dpm_show_time(starttime, state, error, "start");
 	return error;
 }
 EXPORT_SYMBOL_GPL(dpm_suspend_start);
-- 
2.22.0.rc3

