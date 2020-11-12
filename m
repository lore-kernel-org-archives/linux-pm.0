Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E01C55ABD
	for <linux-pm@archiver.kernel.org>; Thu, 12 Nov 2020 10:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA55C22227
	for <linux-pm@archiver.kernel.org>; Thu, 12 Nov 2020 10:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKWkLkHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgKLKkK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 12 Nov 2020 05:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgKLKkJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 05:40:09 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61449C0613D1;
        Thu, 12 Nov 2020 02:40:09 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f27so3847039pgl.1;
        Thu, 12 Nov 2020 02:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBXfFm02ABja54Il3Ns8zFaadLu9ijtBeVpM6C5JJKM=;
        b=cKWkLkHEvo4/XIEEtU48nprSPCaj5mF7oXPQdNOmV3PM73+xUiRZJo7DBKkzJpdurI
         HfDr4hDHPlyoi71cyyp2xVvnspB5prgjfr903hgLX6dNlyrpkliWfNNyoKjUMW2jHOLN
         fgjb2XE48wb8V7mdxQbDI3K4cS+dVHDb+B7VrxMhwg4j15kJXSNJ6x3yTOrexwmjpamN
         ZBZ28IOjh+WiOA63HtIejDXPvd0hAD+ake/32gCgl1uokMaI5wL6/MP40SEQRBWnA8Oi
         JLB12qhB3NMN9X1KP518sgWjiYzNvHwEYJjTqfkbg9VzPDn8/KiHlvyXyTRsPvDSx5aH
         n1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBXfFm02ABja54Il3Ns8zFaadLu9ijtBeVpM6C5JJKM=;
        b=gNLfXwrQWzODmV5lC6YGV1vPC3nubx2yx5rkVQx6Ozz8xH89sCoLR3ZvrRtrYv4eKL
         B8UqqvyD+f7HISaVLMlbbVPBBqRasphg+OD/TmLXZWI2HprTgzkFsdACjddYxT0vJ6gc
         Ua61XdhdaWDnoi0dt1H7MkfDDxtTzpEOMqhn8iOEXAUkX7tuM1ZIj+wPQ5Ka31+VgQ4o
         ouQEbuRRHSHLRz88/l+k88IN4UQ2Qw9SS/X1evTQ4r5kyWnWcdJa8tvNS/tXXWaM/iM8
         DSj8Ifaf3iuNSKnmHX7g1IIl23/4MUJuh2iJMOoPnTkc70Rp66WlkCbIbEftHxph8Ijv
         Xg5w==
X-Gm-Message-State: AOAM530aQSdO1SB3M0lMCiHZtiGNKgAaZmJQ4h37T3PQuXrk8kuCj4bt
        iXBjGpqzutb2FJMPXZeBKuQ/rXfVVS8=
X-Google-Smtp-Source: ABdhPJxgVRlYPN5p4Aq+alIuGs7pZUdTkG1v3xdLLSq3H1rfkWqkWgPVFeDIN2XXK6ZZ/E8H3pNpBg==
X-Received: by 2002:a17:90a:e391:: with SMTP id b17mr8905685pjz.209.1605177609052;
        Thu, 12 Nov 2020 02:40:09 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:47a:a27:cf8e:7817:51df:a883])
        by smtp.gmail.com with ESMTPSA id mp16sm6414094pjb.13.2020.11.12.02.40.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 02:40:08 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v7 01/11] mfd: mt6360: Rearrange include file
Date:   Thu, 12 Nov 2020 18:39:48 +0800
Message-Id: <1605177598-23501-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rearrange include file without sorting by alphabet.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index e9cacc2..c7a955f 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -5,15 +5,14 @@
  * Author: Gene Chen <gene_chen@richtek.com>
  */
 
+#include <linux/crc8.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/version.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
 
 #include <linux/mfd/mt6360.h>
 
-- 
2.7.4

