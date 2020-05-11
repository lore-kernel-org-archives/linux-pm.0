Return-Path: <SRS0=+SOU=6Z=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56833C54E8D
	for <linux-pm@archiver.kernel.org>; Mon, 11 May 2020 12:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3718A2082E
	for <linux-pm@archiver.kernel.org>; Mon, 11 May 2020 12:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7rXPswq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgEKMZ5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 11 May 2020 08:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729894AbgEKMZ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 08:25:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603C2C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f15so3874106plr.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfMcNqWTArL4Y5FjXhFztmuSx2FHQp5TnoxNceakMXk=;
        b=n7rXPswqzvaAQL8MJXEd+EHpWvH4A0CJYgK4ai+PXMpJUyvSTDHmBs58x3bD6ThfTo
         XsRDVktgXnzv1aChERUpor/0iWAH9aNvJPwU02MEDjZCXunynB9xChlEPF1D/n6jBfB9
         HjUAjXkOBiTDlQfZuuTBvbCkmltaO6YEofuLkF94Isei/16A86EKWsxsaDPFiAAbx0cP
         kZXAoOe3YHqxLhumKw/ki3oiCe19ki/2PjlS25LJcCZSSVbejXKzzbcuP8sBTDy82Pv3
         0S0ZPmbRaBPC7GHUMJlqwnIQHsyYHR6D32/CWy+nuLkQkDthLSEYyaKs03tfdzVS6zu4
         Z89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfMcNqWTArL4Y5FjXhFztmuSx2FHQp5TnoxNceakMXk=;
        b=GjaFI06g+BgHDR9UzbGgojNUvofwrgoYh4lnGPcNPUdCbd6UuoCZ6UZgdCr7OpduUS
         2M7+1fg8BohTkcxwiFHrC+44/MqVulc+p0U1ZRBcplZYAW75sp6w86SFsF46fYJ4VYp+
         1QH3YkVxY+g3QPkJLiuvnPqjEsegH9KDL4PUVkNhyAehGQHRK1iClam5JtYmm5smjIsZ
         0NK5THTkRIV3G/bsFLIqy5OiBSwWRGR74arxltUEe0ZsOyG8mMLOoT4H+7Rfc7bxEvLj
         cBDeGtApF9o95cmWWi4pB6YJjeBXYl6i4wWogSGRB5EGmNmOGmMwpMhwcrabWCqSKe80
         Jtuw==
X-Gm-Message-State: AGi0PuaGs2GW+anVTFNkGyRJQqu+cmYMoUj9Kqjx5N3Oaqb+M4xGdFj4
        f/07Alpo3hbzaM9GX/hLg8THYw==
X-Google-Smtp-Source: APiQypITHNfYkaL28do7g3be0G1XRhK/SouBrI17eY+WKs5pJJeTBqBv8FaNTHb9f9amRhYbxzFJBQ==
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr22693865pjy.136.1589199955901;
        Mon, 11 May 2020 05:25:55 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id go21sm10316726pjb.45.2020.05.11.05.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:25:55 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 06/14] thermal/drivers/thermal_hwmon: Include export.h
Date:   Mon, 11 May 2020 17:54:54 +0530
Message-Id: <f542962494a8441fdc8e550a11d0e535b92362a0.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is preferable to include export.h when you are using EXPORT_SYMBOL
family of macros.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index e43ae551592d..8b92e00ff236 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -11,6 +11,7 @@
  *  Copyright (C) 2013 Eduardo Valentin <eduardo.valentin@ti.com>
  */
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/hwmon.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
-- 
2.20.1

