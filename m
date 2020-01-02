Return-Path: <SRS0=3YAN=2X=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3BDC3276E
	for <linux-pm@archiver.kernel.org>; Thu,  2 Jan 2020 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212EF206DA
	for <linux-pm@archiver.kernel.org>; Thu,  2 Jan 2020 14:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCXuNdiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgABOy4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:54:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55632 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbgABOyz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 09:54:55 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so3338520pjz.5
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2020 06:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fBoLG1yNGX8O84D+YcSt5B+i5/exbpkdJTkAsAGAlGk=;
        b=qCXuNdiSR16NjCl2MfuL4UuKLIGqC+aI6fJyLyPkOWfXERE1srFvi+G65shbWPvUUB
         yak7t+K9YILtB2M5FMNMR0YVzag6Juq+ocVuPWl4xIQl5Eg6pHAvopOBMrsQm2p6dinN
         4vqGMMaqasKh/O+sWbMJj6uYO5QmuxYeiWAjg+56ly2wJAU/THpVF1vGf/phd7stDSx8
         oor7SODucz0k2ufCAhJSTm4r8ryWa8AEXXGZcImfJq3LhB6ZQRv4sGTStymGBlnryzLe
         5PEr+I6wFkGsD+I8Oi1wwF49AmSc9yM5qb+3h28Jt2WDCaESn9e2horyLYCaeeEVC9dF
         gYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fBoLG1yNGX8O84D+YcSt5B+i5/exbpkdJTkAsAGAlGk=;
        b=ioXYlduP5aFlBTThP8BF9mrP7tpQvpPo79+aCw1iNTEq0V9qo2ec5CSgxtFuQjz+E2
         trSVD9qwhtmvgd2yB8rXlCg+e2TUIo6lxdFn5yjCFCjg9UAryAxAHFjy7JW0D1TOajXY
         +yQ5fOtfET+Ungq3sQ1LN5APFzFckQ5bnRLV0fgTc6DZEFBG1vFeedm1/VpMYSb3CcA3
         kdumBN8Cb7n62Bgthn+x6BuJ5oeBr4WtZbtcyGi3XT9zT751Mukg6qSb71TXuv3A/RTo
         Up9BcRh+oKGY5qIkArrRtTUZku4Y1+kEu0WYRS+z5RPugwDyzu3TcbCvaHhGbCCn7usr
         qi7Q==
X-Gm-Message-State: APjAAAVE07nSLCKW6SPlZ8fFHaf70Y2xd4HS5X9K8yIt1mXAjRO/W56o
        +ldGCnKjDjOesZ3t6+jXd9Llfg==
X-Google-Smtp-Source: APXvYqzqhn/VAN3Br6Oz2bcdlCFgzIT2moGT2q0uNq4nk+Ht9Z8UyjO9WjWb12H49524M/mjfLgVNg==
X-Received: by 2002:a17:90a:26ec:: with SMTP id m99mr20400488pje.130.1577976894354;
        Thu, 02 Jan 2020 06:54:54 -0800 (PST)
Received: from localhost ([103.195.202.148])
        by smtp.gmail.com with ESMTPSA id h128sm66808306pfe.172.2020.01.02.06.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 06:54:53 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 4/9] drivers: thermal: tsens: Release device in success path
Date:   Thu,  2 Jan 2020 20:24:29 +0530
Message-Id: <0a969ecd48910dac4da81581eff45b5e579b2bfc.1577976221.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577976221.git.amit.kucheria@linaro.org>
References: <cover.1577976221.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We don't currently call put_device in case of successfully initialising
the device.

Allow control to fall through so we can use same code for success and
error paths to put_device.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 1cbc5a6e5b4f..e84e94a6f1a7 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -687,8 +687,6 @@ int __init init_common(struct tsens_priv *priv)
 	tsens_enable_irq(priv);
 	tsens_debug_init(op);
 
-	return 0;
-
 err_put_device:
 	put_device(&op->dev);
 	return ret;
-- 
2.20.1

