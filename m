Return-Path: <SRS0=hqGy=YK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C477FA373D
	for <linux-pm@archiver.kernel.org>; Thu, 17 Oct 2019 12:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F2F21D7D
	for <linux-pm@archiver.kernel.org>; Thu, 17 Oct 2019 12:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8ydhIBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502345AbfJQM15 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:27:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42679 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502334AbfJQM1x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 08:27:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so1562221pff.9
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=J2+dIH77bj5pUXUsovECtUNC+eDZQzRNadhd1RCEVqs=;
        b=H8ydhIBW4Hdav4jAbhdZFLfJHJ/rNTYXcPXSEpoc1DBwisHhHI2hsG9clVYOgLtj5Q
         lwx83X6r3G55GLeR9g55BvIxOwYOzNyZeHAmUKLgPyo5rPoXK0lxel4Nrp+YnCViHgNS
         GtvuCSCCb51pgg5WL64XgulygN4+2/iTQa39xCZjpAkuwLrkRehJR9O2DPH8k/F1ARfs
         IRPkGRYPhsEr5qrRWF7lytjQ7cNCDA0S2kJDoVsXnh8lSVkgwkN6YNmstydqRPPieqpw
         C3OsKtmoRM2XSUxCOT+zeAfxj7MuKI+45kSs77GROL4WWApel3iJZTmUv+RsR+Q+WMpb
         Y2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=J2+dIH77bj5pUXUsovECtUNC+eDZQzRNadhd1RCEVqs=;
        b=SeBFZ+G0smBxmONTJzx5ZJnCSm+egrLWoLVA7RMiEomUd/c1UaZlHQa/ZPmm9wxUdf
         UGBuZ93usKUgbEMwbP6ywfCOMCh8mTYbewrFjFs4rXAVdDiMG89tW3AVy3GWjhqjZFaN
         KO360IAfKzyitJKCtXiQ1aydW+73eNfk+QrLRprtyakXbnxFtXLzb3p3wJx2IDKAjzix
         UNeOS7jKAFJso38RpwwHfPIfF99/5XmzbSN9AhNmx7W+0xbi0g4COAm1YYfQHO/xviig
         Ug6E3lMdTscztHp3/jKwi289iKxhuYTScm06586KcBJ92fqrwHTT/ae5lFCgUPTuRZmJ
         +2BQ==
X-Gm-Message-State: APjAAAVsSAHEcGXpM446nBmJFrChNNH3sdP3RR22nZy6uq/lX+kIWJt4
        2k3gOGqWLl+mb8/7nnM6cRkgFg==
X-Google-Smtp-Source: APXvYqzmKwMCQLucBl0CUBU8zqp2eDcOrDP2n0WXsN6rWk8R0BxLYnGg7GBjIvPXLmEI1tpdhJpSDw==
X-Received: by 2002:a63:1f25:: with SMTP id f37mr3859122pgf.50.1571315271392;
        Thu, 17 Oct 2019 05:27:51 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id q76sm4615049pfc.86.2019.10.17.05.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 05:27:50 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v3 2/6] thermal: Initialize thermal subsystem earlier
Date:   Thu, 17 Oct 2019 17:57:34 +0530
Message-Id: <cc2aa18e2e6004ba099e69b41d0d505a4361443c.1571314830.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that the thermal framework is built-in, in order to facilitate
thermal mitigation as early as possible in the boot cycle, move the
thermal framework initialization to core_initcall.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d21b754baee2..d8251d723459 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1537,4 +1537,5 @@ static int __init thermal_init(void)
 	mutex_destroy(&poweroff_lock);
 	return result;
 }
-fs_initcall(thermal_init);
+
+core_initcall(thermal_init);
-- 
2.17.1

