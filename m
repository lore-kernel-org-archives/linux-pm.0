Return-Path: <SRS0=+SOU=6Z=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF87C54E4A
	for <linux-pm@archiver.kernel.org>; Mon, 11 May 2020 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9BB208CA
	for <linux-pm@archiver.kernel.org>; Mon, 11 May 2020 12:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="msnddFvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgEKMZl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 11 May 2020 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729595AbgEKMZk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 08:25:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB3AC061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so4673221pfx.7
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdgxJAfo8UlOucy5NbULhDRr0uCqBFbRyMqqRo+7u8o=;
        b=msnddFvTNtREqRm1El3S+W4nTTsmznmrMM8BRZnGmgRRKKCpgTeN+txsF0X/hMWJX/
         UqTVTj5Pef0yCJ3QfSE1xhvLaHRTrNwVQU6N6VbVqj8shMvwdYqlNGPCCRgZc3IS8oby
         xpeF7qKWEwPHKMNpFwfPDmuL5H1ylxizE6U8NyipfpXoO8xKcCFAjyqD4iRriULgLxJV
         uOiJu/bPq34/DiTf6IR34VkDxUGnUovvj7Y8zLKdkkQPlTGJzZEWvJCfRfoGeRIGq+Im
         PBs4nWgbVC+wspgBwfuxwB6lV5oiftjrnnViI8EbunEnXvsp59JcpOlrbqcCtqGJHCRK
         6qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdgxJAfo8UlOucy5NbULhDRr0uCqBFbRyMqqRo+7u8o=;
        b=s23NIyvpaSrCRoEDHxuwuNLbsc4AS5R+JsvHpqSQ5jknqAR5ctHMC7hEd1i1Ay5naD
         QSzmwbo2KprqoZ0K/huVlkCRdRaN+ImxG1YJrT2GmYeWgzb3I+LTdMHDsWAWuxgaZ6+o
         sbjAMykbkKBJU7otaSz18bL3BJ+RjSGEktfzghgIHZwMasg2UEw2Ba/rwvKoyQqQ0wzT
         zAr7OoNdWD+blWOg4Kt8oiPvD5khqqUq8byjCwmkRniWXOhcDARiojbJY/4HB2I8/Qkx
         bfXaNNCH8dBNpBooJqNxW/8mrhBT2ctDim9VxBSKxWbiGOMqCHk3oajJe+ZTN3QhoTll
         yYvQ==
X-Gm-Message-State: AGi0PuZMjHpi2QgvbLnRPpQCoCGjgqUlJYe/UewThCIAxqOylINNeYrE
        Ar2jmb5W+vcAPksgm34rb7UOYQ==
X-Google-Smtp-Source: APiQypIK/SJv2BvkXBQiXCCg/PqqSZRvMjBVTYP8zmpY8DlH8pIJgGgLmuJJ3RVi1ndH5W+cXRRa0g==
X-Received: by 2002:a63:4c1d:: with SMTP id z29mr14019205pga.243.1589199939763;
        Mon, 11 May 2020 05:25:39 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id s136sm9344242pfc.29.2020.05.11.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:25:39 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 02/14] thermal/core: Replace module.h with export.h
Date:   Mon, 11 May 2020 17:54:50 +0530
Message-Id: <33af23406dcdb0c62dae1e6401446b997ccb449f.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thermal core cannot be modular, remove the unnecessary module.h include
and replace with export.h to handle EXPORT_SYMBOL family of macros.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 286920e06277..bed4a7bea7bb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -9,9 +9,9 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/kdev_t.h>
 #include <linux/idr.h>
-- 
2.20.1

