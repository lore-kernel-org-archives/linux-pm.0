Return-Path: <SRS0=E4ep=C7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08ABC2D0E2
	for <linux-pm@archiver.kernel.org>; Tue, 22 Sep 2020 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C562086A
	for <linux-pm@archiver.kernel.org>; Tue, 22 Sep 2020 09:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNxw5fQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIVJQA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Sep 2020 05:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgIVJQA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 05:16:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C18C061755
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 02:16:00 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u8so17230617lff.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWzVGk4JwxAprXdefL8n0YBnT6uhEhTXmeWIi4FWIck=;
        b=cNxw5fQ0uZBDyY/R+kJ2M+FcXhEbwNU29/OqthyaEOWySCWH6RBjlnywY6bEqih57R
         7kQg1/r4YO+V1y4bstBNWWDJ+Xj7qGDXNIg4Gib4hV2Wy8iM7EqEmot8wk6I7Jq9usnQ
         nXDalPtY4jWWXU6W6w4gklsD+ZNowmQFOaW07wS794eY0tkOWVh5DdUn+7+VHxDcmA7X
         1r60oDoeA1+R47/SLVHuP+x6OSOV9SZ6Eu1sTuvzEeK4xLwp4RcR7MWWTI1uvDEoVrhP
         3CoOhvt1GBfB4oAbFPviF2HRVvI2gQTL+zRQ4ZDKr84aj6C94VQZBHqg4T7kkQ6f1K0l
         uLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWzVGk4JwxAprXdefL8n0YBnT6uhEhTXmeWIi4FWIck=;
        b=nTfbDbjb4v4we0mdz40HhtRlQzGBkRgdczVRhzG4JGxDnePR9hUT6+awa1zGPCg9mm
         5dwvYo3pxEVP9rp2v5U8TBc4q6qzMhVlFsWnGhQ9SXojuveHfIvoOGZGX1FcQDDNkCaL
         tw+A07D9OqpwUQ5Vw1gw0pgAxemEl931nbjriTJ0MPML3Cjc4bX8pd9FcrQB9oQbsVuf
         /XnfaMkAEhfDZ9tXi8G9X4XRApk4ebss8NsV22nbqDo34UuIF75hnzvAtQZ0cI3KMDd+
         bPP+uVInAVETmcIIZi5ZNFlX9D+74gWnLkQXeS66+sBgIuzLMDDd7lG1hMN64Wx+zlOS
         GZYg==
X-Gm-Message-State: AOAM530gKld54ZpCVnkdW1W+9VBh/sy1h26sNdh5gkovzLVKGRiL9Nix
        kbFeTp0XYGb3Nz/PPU8OYLxMQONSRQRA8yMa
X-Google-Smtp-Source: ABdhPJyyAf5H9EGRPv//u95wgcn0lOO+Bs/RWiEEBxCxgowihC4TkgFFBiV+xkjYmXxAbrBxm13aXw==
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr1437725lfb.73.1600766158463;
        Tue, 22 Sep 2020 02:15:58 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-169.NA.cust.bahnhof.se. [155.4.133.169])
        by smtp.gmail.com with ESMTPSA id 10sm3321516lfo.197.2020.09.22.02.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 02:15:57 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] cpuidle: Drop misleading comments about RCU usage
Date:   Tue, 22 Sep 2020 11:15:50 +0200
Message-Id: <20200922091550.90191-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle deeper into the
idle path"), moved the calls rcu_idle_enter|exit() into the cpuidle core.

However, it forgot to remove a couple of comments in enter_s2idle_proper()
about why RCU_NONIDLE earlier was needed. So, let's drop them as they have
become a bit misleading.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 6c7e5621cf9a..29e84687f3c3 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -142,11 +142,6 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 
 	time_start = ns_to_ktime(local_clock());
 
-	/*
-	 * trace_suspend_resume() called by tick_freeze() for the last CPU
-	 * executing it contains RCU usage regarded as invalid in the idle
-	 * context, so tell RCU about that.
-	 */
 	tick_freeze();
 	/*
 	 * The state used here cannot be a "coupled" one, because the "coupled"
@@ -159,11 +154,6 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	target_state->enter_s2idle(dev, drv, index);
 	if (WARN_ON_ONCE(!irqs_disabled()))
 		local_irq_disable();
-	/*
-	 * timekeeping_resume() that will be called by tick_unfreeze() for the
-	 * first CPU executing it calls functions containing RCU read-side
-	 * critical sections, so tell RCU about that.
-	 */
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
 		rcu_idle_exit();
 	tick_unfreeze();
-- 
2.25.1

