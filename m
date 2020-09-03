Return-Path: <SRS0=Boio=CM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F869C433E2
	for <linux-pm@archiver.kernel.org>; Thu,  3 Sep 2020 14:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D75206EB
	for <linux-pm@archiver.kernel.org>; Thu,  3 Sep 2020 14:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNKNZMQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgICOmF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgICOif (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 10:38:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6226BC061A0B
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 06:31:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u18so2906314wmc.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKzq9Wd5pDbV7/549EiQnkURmwLmMM//csWdIgiebW8=;
        b=oNKNZMQ+vrelVEaKz3G2tJGNGftiIxHVRLIev4M2tPePieqANfyRxtVoH6DG1ffGPH
         QgoHxmL89GvxQF/eyfr61LHpT0ixxjGe1jgqNqmbhgw2lVP5A8DHa8houG2AicqIWgq6
         Ux6nx0xaWhS2ZZYDwtVlDZebBBThqipXRhbIj4LV0jK3AZf3sW5hlEndjrU+/rutAYcq
         PkmgCeVLpiKUd//KkVCZk6VJIxWO/mpKUDpMjiH9UqrqurNMw5g/3uUIy+ofrgXqpa7w
         RdMCCtyl5iIQi18Jvq3L6D5BkirG/fLLC0g7ZKfGfHe5kTA87i2+TINQbqwuO1forBad
         L2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKzq9Wd5pDbV7/549EiQnkURmwLmMM//csWdIgiebW8=;
        b=gCiEjZ2ugmICD18hDnXpexCfDfQrRK4InRyU1dQfPjffsChil7tDfaotJ+9aTLl6vz
         OUKmE6eN6Xa+yZWQ0yqKVhWNRnmTksbHFNwYwMqGbE6gN6cMjUzyVV0TknzYgRQbuIM1
         WpnNhLM+TLPmOKmGL/ARS49BuPiOMzqu6+uPQF6K634bgv+4+x6QZhFOzW0RnoDjEAYM
         WteUafxDOj+DtdufvFXfDg2tZapiE7RfT+DROweGGQnyqLnLT3rfhbo2ig/8AOYqarIg
         qbBi69xJFO1ybqDWhK6k5N+BC3bwl9xbd90VkAa2l5Vf23ulY9GFSsnA1WSDxODbGSxV
         y0mw==
X-Gm-Message-State: AOAM532czyjQJWwV27dJNvjbq1lkWINkjsXnKvLMpKJhCTWcma4Buw5J
        cN2EAgMV9+OnAlu/f2qbwp87V93gc9RNUQ==
X-Google-Smtp-Source: ABdhPJwideaMwQI0vVOO9NOjJGo+l6Etw+5ZlFofKjM7BTEhZ9Aoj2Q50gaHXWsGR97506yHtsDNMQ==
X-Received: by 2002:a1c:e0d4:: with SMTP id x203mr2725879wmg.91.1599139904767;
        Thu, 03 Sep 2020 06:31:44 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b2sm4310768wmh.47.2020.09.03.06.31.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:31:44 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] interconnect: qcom: sc7180: Replace xlate with xlate_extended
Date:   Thu,  3 Sep 2020 16:31:33 +0300
Message-Id: <20200903133134.17201-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200903133134.17201-1-georgi.djakov@linaro.org>
References: <20200903133134.17201-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

Use the qcom_icc_xlate_extended() in order to parse tags, that are
specified as an additional arguments to the path endpoints in DT.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index dcf493d07928..a6f119f363b1 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -535,7 +535,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	provider->set = qcom_icc_set;
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
+	provider->xlate_extended = qcom_icc_xlate_extended;
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
 
