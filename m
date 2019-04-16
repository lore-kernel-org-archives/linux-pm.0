Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716D8C10F13
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D58C20872
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awmgR1Sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfDPRHG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:07:06 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42907 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPRHG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 13:07:06 -0400
Received: by mail-pl1-f201.google.com with SMTP id g92so13764025plb.9
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2019 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=4Xb9r78wtIVQzgmRj/VCgw4LZC1bfVVf3fvkPEzLd58=;
        b=awmgR1SqRft96tF11fLis6fySJvqzKmNhUU819y72B0Uc/AXwrgcSzgUS3d433pf7r
         Gs8y6uUypBao06/6SFdepc+TrlHh6BIrVPIhomcLccrDjZMVZJOatfdPC5U0p+uuT1nP
         HU5+QOTw02RV+amffH9xg4bQg2rKR1kDumUv7qVGK+Qib1Lxji/MAAOSvO5vQMafVc4p
         wOfUGB583jCBi2Q1487B/zOfTR/2yBQOTTO2Yt3td/NqvRMtdeB1DZxpGUwGIFaznfr0
         AxOTO9180WBZStmOrp+Ta+GVEBq1xMHOOmpOxVvxDdSu3av1u9zM/QoT9BTVTjLm3h89
         b/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=4Xb9r78wtIVQzgmRj/VCgw4LZC1bfVVf3fvkPEzLd58=;
        b=tKcw4nGsETrSe/n1fivjHlKT8nhFFypvo51K7ppYv+AOnYuC0BRG3AIX+T8RNgsc/w
         YbtWZhKRJsuaL0xIP0xhCEBe1n5vI6E+pe+2OO4KgO68aC98W/ndBB2h2mC0qRGhR8jy
         bGYtkHLO0Gr49DammMkahvs3PO/sLG5cR74Wh4/En77zzJzM250wy9WYhH90JaQsUi2s
         9/e9kQ6yJzrXKEm0+wHzfi50N1mqcuL18/nOvYbYncZr+f0TU6KqWxZXC6tjvSA2cs/h
         kqPfIORdGkuI4CUnM1jw949PKvb3XAb3CMzSOcHC37TrMIaJY0sa4FalGBYiYa8oGzH3
         jkrg==
X-Gm-Message-State: APjAAAX46rgGXt8nMUrTMvZwAJzk7aW7RLcxYxxxpsR0kEX/mcAOvIqE
        0QvrWrlMbOcvQWo5niaFwUUQCmA=
X-Google-Smtp-Source: APXvYqyp4OsxYT3O1FTi/ApB87QHW+yAfOoWi6Na2nZkx3UnUx8MDXjqNDeT3KTH3l6je8QwZV4WmYA=
X-Received: by 2002:a63:2356:: with SMTP id u22mr1748062pgm.2.1555434425401;
 Tue, 16 Apr 2019 10:07:05 -0700 (PDT)
Date:   Tue, 16 Apr 2019 10:07:01 -0700
Message-Id: <20190416170701.50333-1-wvw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] thermal: core: skip update disabled thermal zones after suspend
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190416170701.8PsdqIpYS3xwkEcp7P45B1mDxsCU_3DoUe-HaB5V6aY@z>

It is unnecessary to update disabled thermal zones post suspend and
sometimes leads error/warning in bad behaved thermal drivers.

Signed-off-by: Wei Wang <wvw@google.com>
---
 drivers/thermal/thermal_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6590bb5cb688..5baf5cfab999 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1494,6 +1494,7 @@ static int thermal_pm_notify(struct notifier_block *nb,
 			     unsigned long mode, void *_unused)
 {
 	struct thermal_zone_device *tz;
+	enum thermal_device_mode tz_mode;
 
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
@@ -1506,6 +1507,13 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_POST_SUSPEND:
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
+			tz_mode = THERMAL_DEVICE_ENABLED;
+			if (tz->ops->get_mode)
+				tz->ops->get_mode(tz, &tz_mode);
+
+			if (tz_mode == THERMAL_DEVICE_DISABLED)
+				continue;
+
 			thermal_zone_device_init(tz);
 			thermal_zone_device_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
-- 
2.21.0.392.gf8f6787159e-goog

