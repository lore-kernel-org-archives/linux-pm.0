Return-Path: <SRS0=B0WI=DH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAC0C4742C
	for <linux-pm@archiver.kernel.org>; Wed, 30 Sep 2020 10:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E9E20BED
	for <linux-pm@archiver.kernel.org>; Wed, 30 Sep 2020 10:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0zpqotB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgI3KCb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 30 Sep 2020 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbgI3KCb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 06:02:31 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFDAC0613D2
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 03:02:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 77so1428143lfj.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 03:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyrNRlrzgocwFtm4m1D+vgyjZWlJZcz7p/Dz+/oWD3I=;
        b=m0zpqotBVnmz/7C8jVSYyhqZBMEXJh33+flGjkdUOMwY+pgk0H+RmC2MBTAIFR3JRo
         CHWqmgecP0Qv0I/S7mtJLJxoNK91cr33eDtF7KO75/f1K0vuwtuZ5SwyGmGa7GsMqYgY
         hjaNrynyfZ42TSGgRaiM+UkCOAUcKWJVa+Pud+OZjbay3TBKBmTpp2/JkUXaCGykRORG
         VwSIcFz25PnTj8FkpIhrWtXpwV0djWXXs/MNnS85wSy7h8gyFyTlVqno1b7/XqcukJea
         uJOG7J2FiJZK+qd4mwUM71jT9a6Ezn99yPMBzge7LSFhrD+pLrSUq4MiKAwpNAOzQQuM
         zZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyrNRlrzgocwFtm4m1D+vgyjZWlJZcz7p/Dz+/oWD3I=;
        b=c7UDVVduc3RVYS/Gzad4dlLXH26tBo/AwmCD6oKXrqcJJsF7kFCr98RYVIaDK03TiK
         XWZIHU3Izvw3iGaKHalTqIFjs7iWR9hpZy8ldNYj3fbMMY4ZEUPskwTRAUBYa6P15+kE
         IaC1myaoUnyZfdfrxegauo/XIz9/6WPiRQ77YPlYTfxTAYOx+KsziewZviTwz1JHPc2B
         rehUvSHtEO4WDcLqjJ/8Nk1au8sd3uqbrQDjqGln1b4RaY6RLmT32tnMeN1Q/IOloIoq
         u4uPe6r/H3pDNIN308SlmjQTjGSxwLyNrVxwcqMXL78C1slZrtvxMY4THHLv+Bw1jhVS
         0MCg==
X-Gm-Message-State: AOAM533fwtCFz1AOZmzo7UTrVZg+Ljyx313uVRLNRYDeETe7yK+jHkAJ
        JLTHPTlCxj2OvL81p6Vr3dyDGA==
X-Google-Smtp-Source: ABdhPJwddXc4gkJLT7lTD9hdiCEYhG7SQmgB2Cj8256KwRtnod2YQUHDzOCUT1H2Gg/oNINWXTFqGQ==
X-Received: by 2002:a19:8c03:: with SMTP id o3mr550531lfd.349.1601460147807;
        Wed, 30 Sep 2020 03:02:27 -0700 (PDT)
Received: from eriador.lan ([188.162.64.138])
        by smtp.gmail.com with ESMTPSA id w4sm132479lff.231.2020.09.30.03.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 03:02:27 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 04/10] iio: adc: qcom-vadc-common: use fixp_linear_interpolate
Date:   Wed, 30 Sep 2020 13:01:57 +0300
Message-Id: <20200930100203.1988374-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
References: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use new function fixp_linear_interpolate() instead of hand-coding the
linear interpolation.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-vadc-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index d11f3343ad52..40d77b3af1bb 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -2,6 +2,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/fixp-arith.h>
 #include <linux/math64.h>
 #include <linux/log2.h>
 #include <linux/err.h>
@@ -368,10 +369,9 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
 	} else {
 		/* result is between search_index and search_index-1 */
 		/* interpolate linearly */
-		*output = (((s32)((pts[i].y - pts[i - 1].y) *
-			(input - pts[i - 1].x)) /
-			(pts[i].x - pts[i - 1].x)) +
-			pts[i - 1].y);
+		*output = fixp_linear_interpolate(pts[i - 1].x, pts[i - 1].y,
+						  pts[i].x, pts[i].y,
+						  input);
 	}
 
 	return 0;
-- 
2.28.0

