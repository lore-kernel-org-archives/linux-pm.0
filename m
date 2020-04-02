Return-Path: <SRS0=3neH=5S=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC55AC2BA17
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5572080C
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tgny2VVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbgDBO2N (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:28:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37429 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388120AbgDBO2N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 10:28:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so4496348wrm.4
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0yL1w5+JWaXNihGaTzT6saNdFzgGKd/d3GiibbTk4FI=;
        b=Tgny2VVk+APSF6iZvl9xqCiKBh+PaEW7ArlCg1cSjsRXQSTQ5Yd8ToRlbKatb4fc+O
         DgnfDXJ6PZTB4djmgmI+pQ4aRtJHr2MG7Ep0lQUyNohXdOu5cDLB+HRvoZZ6EZh4+C6j
         zHx+MRDpy7Yslqc+HNi5TKkLi9djfrdg386zxVtm1ZHkrrAP8RC8c2X9FsZlVPG9OIjF
         l7CKHzmpeIyARD8mLMyDR598kq6m5+lTwMkg0g0BDNKAQ0VU7rxaH+kWuMEG7Ex57Lfn
         N2ReeB2iWjtX9QsfXz1S0iRjexW/DUMI72AxmH/xeVAb8K+NggZwgJVhnHhs3CqIrGvg
         giXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0yL1w5+JWaXNihGaTzT6saNdFzgGKd/d3GiibbTk4FI=;
        b=gNB6kTfvxvYqRtCADGMp3l7mgdHqYkZugBcWcp6RqoZVVxXlrrW4Rv4lsWgYDxbTcH
         jwZTnFdM8Qhf+FkUDr8OoEWI+mUK9ObDJsR9GyiOIlanc+BmmbLm+EgkEAaAa9VzgDpb
         wI4gF9xSfEJnbeJJv5cz4kzRfittHcSWlC4WVlTuEjjgBWUJIAXgR7EO6BeD1+xnxJzG
         vqKK6pAMy9bF5Vclw/MpOnKeaeKWkQe+M2IRgj2eyRvGDpLvAXQLI+NFT5Uu2QXfLj7H
         NPGvK/eOprtlXLwTJbMwfpr0SG6JxSCC0Chv2pzZXKaFMS8QY72ASMT4wDeNQUtCzlMv
         QODQ==
X-Gm-Message-State: AGi0PubQtW96Mt0R5281W0O1keBMtPy/t0pbULgVqB8IiXsNx/TlmbPQ
        zWkP66RkU32juxbVXHTP17PztQ==
X-Google-Smtp-Source: APiQypLhb4JxPDxJ1toEh0FNeaz9TM9nX/Zm+7qSIKRBmPBmdRaKUsoz+enVMUHIfk/h1R1UPepDkA==
X-Received: by 2002:adf:ea8f:: with SMTP id s15mr3738685wrm.393.1585837691388;
        Thu, 02 Apr 2020 07:28:11 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:4b2:e366:e86f:261a])
        by smtp.gmail.com with ESMTPSA id a7sm7045186wmm.34.2020.04.02.07.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:28:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 9/9] thermal: Remove thermal_zone_device_update() stub
Date:   Thu,  2 Apr 2020 16:27:47 +0200
Message-Id: <20200402142747.8307-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All users of the function depends on THERMAL, no stub is
needed. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/thermal.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7b3dbfe15b59..216185bb3014 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -426,9 +426,6 @@ static inline struct thermal_zone_device *thermal_zone_device_register(
 static inline void thermal_zone_device_unregister(
 	struct thermal_zone_device *tz)
 { }
-static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
-					      enum thermal_notify_event event)
-{ }
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
-- 
2.17.1

