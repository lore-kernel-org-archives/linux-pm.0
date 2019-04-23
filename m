Return-Path: <SRS0=9RE4=SZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A91C282DD
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AAD2177B
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mx7tfKFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfDWN2w (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:28:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41133 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfDWN2j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2019 09:28:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so979445lja.8
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2019 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBZVH8tY60kvdDXDwV8aJHdGVIEg5lBCBmcPhKf9y2Y=;
        b=mx7tfKFCrLM+my8sDW7dzzb2SBOnGloSVzmUgLj2SrdsqiYsq+Uq1lnU07zY7h6C5e
         y0YhFrKkNWfdkTfdMdlbNuKmiaMApa4h+ey7j9Jz639toJrjKFCByOrQXzoM/XHNorPX
         XJxuAJhHm0Tv57dwC1lVcrZvp1gxj1OPAsHwveMyKCONalWR2wAGlI6E1Q94EM+yggSP
         XsQNCgnxVz1nZZPTFmuMjHl8RLk2dSsx/7CxPZg8ylVSR+MMKw2rAlrD8vOBAYJhThDL
         taL/1wBYpNLKnmLsVnUxn7DEHk9MjQ3LCh0f9wXjbuB6Jk14ibwh/E24H+FkhD6mc00m
         s6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBZVH8tY60kvdDXDwV8aJHdGVIEg5lBCBmcPhKf9y2Y=;
        b=D5jrBTXoA5qKtz0YMp8on8u2xKHaDL8KqLjegC5Qc9RW3ta3VyQu1YzAoh87ICa7DZ
         0CRyld+dUcf+sAxlvkurVsy49gTA/gHlonsl3DiUbmmGcrK2OPQKPTUcn/hjOy7xXJXs
         jn2YSAaXNx/4NPa2rv3y6mnT0hOFshifF3SXHkIhjWuEgtGs7xiHYBVkQp3mWTfTbqOg
         +8n33HUXRF1IqbHU9vUpKg48PA0FtpjSswIvO11ge6BpG5MzfOWl/yEb5qKzNlziRVeE
         a/Yxdan8wu7ZI77fsUTXNS0cvZ52v16esrNivLnn27IX3xnkBlctMetWRzvmc22NLBWb
         XHTg==
X-Gm-Message-State: APjAAAWzLKBmrUB69KKLUph1J4L2uk1DaNcTfg+5gs9cp/60Wipti/uh
        PDbgTYubHDMKpuWlXH5W7Q3RGA==
X-Google-Smtp-Source: APXvYqzNAQqhTw6N2yoD4Bz5LuIxZwqCEb1c1WFtTJ4PtefGrEYIIRNvEmZZ8vqvnt1FgOHQdMxjbA==
X-Received: by 2002:a2e:1203:: with SMTP id t3mr3028829lje.180.1556026117559;
        Tue, 23 Apr 2019 06:28:37 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y206sm4617107lfc.72.2019.04.23.06.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 06:28:36 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 5/5] cpufreq: dt: Add support for interconnect bandwidth scaling
Date:   Tue, 23 Apr 2019 16:28:23 +0300
Message-Id: <20190423132823.7915-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423132823.7915-1-georgi.djakov@linaro.org>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423132823.6FRyGlYHSeSUy9eWnEb7oS3LLn1LWBXIcDL9bXVOmD0@z>

In addition to clocks and regulators, some devices can scale the bandwidth
of their on-chip interconnect - for example between CPU and DDR memory. Add
support for that, so that platforms which support it can make use of it.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bde28878725b..8a20f4d0243e 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -16,6 +16,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
@@ -98,6 +99,7 @@ static int resources_available(void)
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
+	struct icc_path *cpu_path;
 	int ret = 0;
 	const char *name;
 
@@ -124,6 +126,19 @@ static int resources_available(void)
 
 	clk_put(cpu_clk);
 
+	cpu_path = of_icc_get(cpu_dev, NULL);
+	ret = PTR_ERR_OR_ZERO(cpu_path);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(cpu_dev, "defer icc path: %d\n", ret);
+		else
+			dev_err(cpu_dev, "failed to get icc path: %d\n", ret);
+
+		return ret;
+	}
+
+	icc_put(cpu_path);
+
 	name = find_supply_name(cpu_dev);
 	/* Platform doesn't require regulator */
 	if (!name)
@@ -203,10 +218,18 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		}
 	}
 
+	opp_table = dev_pm_opp_set_paths(cpu_dev);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		dev_err(cpu_dev, "Failed to set interconnect path for cpu%d: %d\n",
+			policy->cpu, ret);
+		goto out_put_regulator;
+	}
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
-		goto out_put_regulator;
+		goto out_put_path;
 	}
 
 	priv->reg_name = name;
@@ -288,6 +311,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	kfree(priv);
+out_put_path:
+	dev_pm_opp_put_paths(opp_table);
 out_put_regulator:
 	if (name)
 		dev_pm_opp_put_regulators(opp_table);
