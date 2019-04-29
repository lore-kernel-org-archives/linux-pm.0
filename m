Return-Path: <SRS0=2Oin=S7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667B5C43219
	for <linux-pm@archiver.kernel.org>; Mon, 29 Apr 2019 08:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DB0205ED
	for <linux-pm@archiver.kernel.org>; Mon, 29 Apr 2019 08:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tn+XgiyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfD2IlA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:41:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35039 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfD2IlA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 04:41:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so6229915wrs.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RkuphNEeqnp3OCEr+63Sfar4bxKyDZqKVHUmZHrORFY=;
        b=Tn+XgiyHsSFyzqj6mkPF6TWU/4PyPnJREoDA1sBsDlBHvI31Bsltv/9TaD6qLH7plq
         UuYqnjCfnvsMNujerwut2P8bQ0faee6kXncevbLSpxt2Y7+SqclZDwbLlW4XCaFRU9JA
         ta0D4RAK1aeP7xBQozPEesR1FkG56N/bKj/mRORuDY0wtn/X1lmAr8IOp7Rqmdumd6Jq
         daC8WXTQVn+up+RJlTXIwgex0wrJ1CicFQjVc9c4eR2pcDHQHeu5PuwG4BulNhUPZoux
         GdcLvhmA+scPpv81SXivS7zAvWTgqQnTguQE3i9kmf/Hm9htglHwaZF/QC60k89XyVwk
         kEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RkuphNEeqnp3OCEr+63Sfar4bxKyDZqKVHUmZHrORFY=;
        b=G8bHa9C2+LcgN78lq5SutRUpo22OuhHfUPjtSX1EO2lNlN41hxBwEx9+KK63Sj9mAY
         pnYNwPLVmXvhk4PNGWKGWO4y/AE3WL6tKW+6zLTnrepto96LzADHLL+Dk0AVft6G1bNC
         GMvgSDm08vZnlMszPrAt2Vm1HEPf7Bpm/JPkJrX4j+kevUx/lkrREPqLgxzTcwRNcCIR
         4Yu7v96O8dWl7mnbaZB3iCmw3TTDz6fYqvYcqgKPNVdVR1WjD4oC0OzmG7M9CoVU9Wkv
         inNtVr2gWfWnWxrJ8ojQbcleOi7mPq4S4Ky6vJqzLzRGOuKCF4ejpt9mZC6YsceEbBJI
         YnfA==
X-Gm-Message-State: APjAAAWo+qgp6bZ/T0i70Gsyuw4/XrlAYxNyzA546PU6dSRoaoHKzUb7
        rc+gqWZIouXubQn1X+MEEKjKag==
X-Google-Smtp-Source: APXvYqxGzGkretE4afo2nM4aoNaWHr/uFvy91W/ZDPl9IB3/bIPrF2LMkCXOtnEDQghdyePdoVt7pA==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr17637388wrs.269.1556527258884;
        Mon, 29 Apr 2019 01:40:58 -0700 (PDT)
Received: from clegane.local (129.201.95.92.rev.sfr.net. [92.95.201.129])
        by smtp.gmail.com with ESMTPSA id n6sm39795964wmn.48.2019.04.29.01.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 01:40:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Subject: [PATCH - resend] thermal/drivers/cpu_cooling: Fixup the header and copyright
Date:   Mon, 29 Apr 2019 10:40:12 +0200
Message-Id: <20190429084012.23244-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
References: <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429084012.WyfHTRr-i3gE_nehkG275jmUSIyQHPdIOEUMOqd5whc@z>

The copyright format does not conform to the format requested by
Linaro: https://wiki.linaro.org/Copyright

Fix it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ee8419a6390c..42aeb9087cab 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -2,9 +2,11 @@
  *  linux/drivers/thermal/cpu_cooling.c
  *
  *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
- *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
  *
- *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
+ *  Copyright (C) 2012-2018 Linaro Limited.
+ *
+ *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
+ *		Viresh Kumar <viresh.kumar@linaro.org>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *  This program is free software; you can redistribute it and/or modify
-- 
2.17.1

