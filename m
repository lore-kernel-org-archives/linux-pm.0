Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25EAC10F11
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849C9206B6
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GP0phiTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfDJIUt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:20:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43969 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbfDJIUs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2019 04:20:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so1242660lja.10
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2019 01:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/i1P7RcZS0nPamy0F7apI0HkwNW2ZATDEDVSzcyhElI=;
        b=GP0phiTitWCowgFdyE98UpDaYbbRdaeoGJJFtlBgkRp4GH8FdondGvkhArSSgqgChh
         coAcL81UNQii/VcyR3SfUb4lM0b3u3BuhrGsuvTFZne8dNwGN6LiXqgB0OD484bWreYy
         Gu11Lq1vUN0ZujEmNiVdEyBl1qk8maPGU4Mp65929lOH7Flr5GeeUr0/d33cOwaGc/4V
         c3patnbK1lCK0fpYA1eoj9TQ9bK6rehv5+e735PCgBU4ccnfQmKVvt623oM9i/DZsVsO
         HRAlJkOYiL1NaTWgbO9B2incA5QF6Gi1mmODDI7eYO6lFoZ32YtKNH8zF5MY77KkKKjq
         RtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/i1P7RcZS0nPamy0F7apI0HkwNW2ZATDEDVSzcyhElI=;
        b=Unizpl+MM5iFxIN4YH/mJ9LceFOcDHBEkf8n+kr+Fc/+YY2E+91a3vGqXxQe+67EAq
         uV9G0y6/JIH2NCtPD1zc9Ti0uqxS2vTIx3utGT1pC8kUCfeRq6Dk8n7vhLpI6NZVanOB
         0eXWk3GDDVB2pAf1XkYKrNgQlQKYYyEBQFnqjXO3AM8aIGxoi5O9jOfkQSEJcku5o3hb
         zr+Q73wlUMdEjOtT9RnnThJKmu3Lr4QoHSLLFtCGIzEwun2p6sCPtooIViVaVdeZsHPw
         sdvgyY45Nua1yZ6xIAsaUXGeIq05TKr7SrSAiG0XJkHw0WV0djZ79wXnLnVugUYpvrvY
         G0GA==
X-Gm-Message-State: APjAAAUerjrAWdWnuHdI23PjLlo7SzVVlrl+zLWA4qrPmF4Rc/GH9i0W
        0zSxuEznzVmUbr5qCDKnfZ+E/Q==
X-Google-Smtp-Source: APXvYqzXLcsVniYyBVz9bDCydjsovygxv2CXViJzk5qN80M/7XTQHjtC59HgFjstiGB7qIDg0FH3Vw==
X-Received: by 2002:a2e:7114:: with SMTP id m20mr22220697ljc.120.1554884446727;
        Wed, 10 Apr 2019 01:20:46 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q6sm3385189lfj.36.2019.04.10.01.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 01:20:46 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v2 4/5] drivers: firmware: psci: Simplify error path of psci_dt_init()
Date:   Wed, 10 Apr 2019 10:20:24 +0200
Message-Id: <20190410082025.5989-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410082025.5989-1-ulf.hansson@linaro.org>
References: <20190410082025.5989-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410082024.pCStb_8cpiGeFGVzD_NP7_610dihLyqMKBW_kLlO7bc@z>

Instead of having each psci init function taking care of the of_node_put(),
let's deal with that from psci_dt_init(), as this enables a bit simpler
error path for each psci init function.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/firmware/psci/psci.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 9788bfc1cf8b..e480e0af632c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -609,9 +609,9 @@ static int __init psci_0_2_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
+
 	/*
 	 * Starting with v0.2, the PSCI specification introduced a call
 	 * (PSCI_VERSION) that allows probing the firmware version, so
@@ -619,11 +619,7 @@ static int __init psci_0_2_init(struct device_node *np)
 	 * can be carried out according to the specific version reported
 	 * by firmware
 	 */
-	err = psci_probe();
-
-out_put_node:
-	of_node_put(np);
-	return err;
+	return psci_probe();
 }
 
 /*
@@ -635,9 +631,8 @@ static int __init psci_0_1_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
 
 	pr_info("Using PSCI v0.1 Function IDs from DT\n");
 
@@ -661,9 +656,7 @@ static int __init psci_0_1_init(struct device_node *np)
 		psci_ops.migrate = psci_migrate;
 	}
 
-out_put_node:
-	of_node_put(np);
-	return err;
+	return 0;
 }
 
 static const struct of_device_id psci_of_match[] __initconst = {
@@ -678,6 +671,7 @@ int __init psci_dt_init(void)
 	struct device_node *np;
 	const struct of_device_id *matched_np;
 	psci_initcall_t init_fn;
+	int ret;
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
@@ -685,7 +679,10 @@ int __init psci_dt_init(void)
 		return -ENODEV;
 
 	init_fn = (psci_initcall_t)matched_np->data;
-	return init_fn(np);
+	ret = init_fn(np);
+
+	of_node_put(np);
+	return ret;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.17.1

