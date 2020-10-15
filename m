Return-Path: <SRS0=rzrg=DW=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4641FC433DF
	for <linux-pm@archiver.kernel.org>; Thu, 15 Oct 2020 14:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF151212CC
	for <linux-pm@archiver.kernel.org>; Thu, 15 Oct 2020 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlBsPkdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388795AbgJOOon (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 15 Oct 2020 10:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388790AbgJOOom (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 10:44:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF36C0613D2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 07:44:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so3835781wre.4
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=soOA4oYAhoT9qwZTBOd2JvR9jvEOzaqFrTAOBqyp4f0=;
        b=vlBsPkdyH8oejvdNlnl86nagXsrdmsxHvUCaJM+QjEw8FPG0xv3b17ZWs2bM2xAUR4
         vYBnXKnwfopyoMFCSfhME1KQGNKrdXSOv5N2AMthdQ7vCzdbI1DzgNho+6EEqmEaDNZF
         Z6nEw/JKGtDxDSvxRTA15F3OGOKlWgyPSg7KncoKfy38zZj/PtUER8UYermCLrShyiHK
         FfzgU+NKrN8D+pgmzW4iKfWeeLOywlzqz7PnYJ4XlAe+HY0nzNP+LZvPJH8aSI1n5RHy
         y5OKgFI6R6lHjXzlnSA0tbu5fRw9Eo1dF45crxpcUNleW0CzS38ZDy+4NYPzEAkGp45S
         5+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=soOA4oYAhoT9qwZTBOd2JvR9jvEOzaqFrTAOBqyp4f0=;
        b=HJUuY3DLdAh7SBd2+Jpd67bUkUeS2363ua4Fk7aCM6l/+w8LelzqEP6L3zmr35ejjS
         JPLUV0D2434DQV1v9r6vlwF1qicpZProg3zuYzCtfnQgs++ldkL4HQurobTZzK2pp35e
         ljWK+mX74iVqcq553828STD506SlTHR1fSJOJMdvNFFmXugPz2/ByvfNm00PGBMDLqlr
         j+27UhlBRG3tnzNQAL3Cx3brEQtG+ckYeJVDmc0A05rBguGxi1B5epLFelRSzWw4V3LU
         cT7rT03ihJSA0nciDs0/MFMEVe8pCPyxdCZIdXRRG82xiyNXr8MjnNOUa/Jz/JqFzoHF
         DxeA==
X-Gm-Message-State: AOAM532nuqZaEaoDJdkL0ccPpw5cDM/ZTD4cyLLAgX2IdFFvDOKo67ju
        bMX+mSXm2ZcLe2aBBnhPUBO0vbnrYCDm5A==
X-Google-Smtp-Source: ABdhPJzBmoNj4CR7eehnW501dpYjt5vXWvCzTXToYHQs64VPdWP4Kl1AqPrwgqU27sJO9yY17hw0ww==
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr4911757wrw.426.1602773081012;
        Thu, 15 Oct 2020 07:44:41 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-134-136.adsl.proxad.net. [82.252.134.136])
        by smtp.gmail.com with ESMTPSA id 40sm5053800wrc.46.2020.10.15.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:44:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ilina@codeaurora.org
Subject: [PATCH 1/5] cpuidle: Remove pointless stub
Date:   Thu, 15 Oct 2020 16:44:27 +0200
Message-Id: <20201015144431.9979-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpuidle.h header is declaring functions with an empty stub when
cpuidle is not enabled. However these functions are only called from
the governors which depends on cpuidle. In other words, when the
function is called it is when cpuidle is enabled, there is no
situation when it is called with cpuidle disabled.

Remove the pointless stub.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/cpuidle.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 6175c77bf25e..74fdcc6106b1 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -270,13 +270,8 @@ struct cpuidle_governor {
 	void (*reflect)		(struct cpuidle_device *dev, int index);
 };
 
-#ifdef CONFIG_CPU_IDLE
 extern int cpuidle_register_governor(struct cpuidle_governor *gov);
 extern s64 cpuidle_governor_latency_req(unsigned int cpu);
-#else
-static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
-{return 0;}
-#endif
 
 #define __CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter,			\
 				idx,					\
-- 
2.17.1

