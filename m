Return-Path: <SRS0=Boio=CM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77649C433E9
	for <linux-pm@archiver.kernel.org>; Thu,  3 Sep 2020 14:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC71206EF
	for <linux-pm@archiver.kernel.org>; Thu,  3 Sep 2020 14:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOSGEgf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgICOle (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgICOix (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 10:38:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA18C0619F0
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 06:31:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so3221241wrn.10
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0z+nN4Q2Lop7WGeqT2R4X33dK+rJ9oWoUAFXO5nbng=;
        b=vOSGEgf6njBXHejEOPLRHy4TZAUQbPHyzsizQv5UbjVey2hgli2PPE3iNmgeVMMFs0
         meXBmX3GehNJYf3Ml6pbsP2w+4GF+P6VawqJTS1rRAj2/4oGepg1b1xG2XaSI+e7RWit
         8HUcIb5RhAPVg5TvwMbJZEM/MIjDq/fbCrqfS6Y053rTcS1XYTsuVRGfBIvafn9rNkmi
         JEwAseO17PL7oWFMSA4A66UwSwyoHr2SapFY34R7ouYM7Gj0Ukfc4mWUoe51kB+Gc+MZ
         cN+Ql6/5tuaw74VyLSTTKCj6J2l3AVXNMioaOfqFNUGt1QtHYWuOnVdgucewh50lSBBR
         KCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0z+nN4Q2Lop7WGeqT2R4X33dK+rJ9oWoUAFXO5nbng=;
        b=gvDJKgCHhRSFj39PnO2JEM+Hl9W2uApD5aC7haHBcDuViMK5KiuNZI8Op64/krF+Gp
         1QKvyqViq7Mxg98Aqiw1pdIbf+T8ekd7jw7RPO1whAPOlk037Xt4CksNbK1wa0qd7x+K
         idU+v9X5kzotPugLhy4nttPSQJyGWCgudYoceewT2Zbf3Fo0dQ5GoaPV1mwL+ZfXoi2w
         z05/u39ImxIGwR2PQUqfiUNcm4Bsn5RzUi9P1S44pkss1cu0vT/ZniC8Y14gItT0g7ox
         LaEq8Zsfe06/1QTzqA7SlFfBiYOpBWs47udVl8X33F8kB6UO2bKhfsENm+9+6mlgSTwn
         VGlg==
X-Gm-Message-State: AOAM533sWPzxw86+Tn75xy0Js3+TD/nozGtOhUF7kQKBIh+VXA/n1BLi
        0KXLcW4Q7A3E/otFk+I90in99u9RcAcTlg==
X-Google-Smtp-Source: ABdhPJxTxGCfwDBn+/7V1YSvROvPT1ttvkiv0uIYlja7weTTbnepk4txpD42uCKrL8YHil8kIzqmkQ==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr2451454wrs.367.1599139902154;
        Thu, 03 Sep 2020 06:31:42 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b2sm4310768wmh.47.2020.09.03.06.31.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:31:41 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] interconnect: qcom: sdm845: Replace xlate with xlate_extended
Date:   Thu,  3 Sep 2020 16:31:31 +0300
Message-Id: <20200903133134.17201-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200903133134.17201-1-georgi.djakov@linaro.org>
References: <20200903133134.17201-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the qcom_icc_xlate_extended() in order to parse tags, that are
specified as an additional arguments to the path endpoints in DT.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index f6c7b969520d..3b81dbb71b0b 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -469,7 +469,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	provider->set = qcom_icc_set;
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
+	provider->xlate_extended = qcom_icc_xlate_extended;
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
 
