Return-Path: <SRS0=5rfv=43=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62B9C10F27
	for <linux-pm@archiver.kernel.org>; Tue, 10 Mar 2020 10:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B7A24682
	for <linux-pm@archiver.kernel.org>; Tue, 10 Mar 2020 10:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nc6/NWC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgCJKko (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:40:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43987 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgCJKko (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 06:40:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id r7so13494236ljp.10
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 03:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6pxlLk38rJ+HhQrbDG9StMgSzEGNLqFsirKScynCScU=;
        b=nc6/NWC0ZnA3EHC5pXdWeUncJizYLSupGGwOcnk1c26mwggUrbQlWG54DY4FknvUYC
         28jVQAIJIwqs8DWroIOThx0+dpmmj9ek3g7+J7ZWSAEJAKnjaEuEu0hL1in+KrU4I2Cj
         6EoKk8Z2W08D0X5hLNTyxIPOnrkzo2mxdpjQabpM/cozVARF9SSCYuukC6rnk6NPDafV
         WXiPDg3mmSwA2N6t5wckhRmEi1FF+EFsr03KtdQ+hOPcjc/Agv4GfUakYa+50CUuMlEc
         541J2z+kFc8ewkil29Pgiqwh5Yynam9/Aigi50NWSaFUYN/1Nzj5TaoYkStWR2ciEepb
         q00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6pxlLk38rJ+HhQrbDG9StMgSzEGNLqFsirKScynCScU=;
        b=WKNe874E0XiaBHI/PQB1d5vG+lw39gfdI9LBohoY9ZTJ2hyuJt3G0FEYcvYXkMNG4f
         DVv2boCt5oJOoDFeC9kodH1mETBwWQKWtb/5suTX+UZ6s2E7/JVbX36kFgsO1rdyOuLB
         fe2FSroSHnHcf/+PPkcfhIlMnWTsgExlbQSqLGqyVqPSO0FoNlw1jtAsf/YDG1uRDSQu
         rUlAIGBfHTqhmcIwR5vy5ZTTQ+10hIwIourTZ1Exp9y6Jk31PWOhlgJy6J5DppNxe4ga
         acI0Dm/RjJxEBTGfCJF1bxgVKITHK1fppy0RY4qDtXHLj/+q9PJszrahJjSDQkO17H7H
         gjFA==
X-Gm-Message-State: ANhLgQ1+5w5TA2DQiVMoZ0rLYjqSHzWcFtM1h+b4CXDyMgXIc/cgWaqr
        35WQR6LmTQulctnp6R9xSr/jOA==
X-Google-Smtp-Source: ADFU+vtyugMzukSnO3/aD1ZXvAqRaTZfqRTHJXjr2Xlk1nBcgblQDVHM7XoSCktNZFEhOicuiCITog==
X-Received: by 2002:a2e:8802:: with SMTP id x2mr8541132ljh.291.1583836842549;
        Tue, 10 Mar 2020 03:40:42 -0700 (PDT)
Received: from uffe-XPS13.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e2sm21511582ljp.55.2020.03.10.03.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 03:40:41 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] cpuidle: psci: Split psci_dt_cpu_init_idle()
Date:   Tue, 10 Mar 2020 11:40:39 +0100
Message-Id: <20200310104039.4066-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To make the code a bit more readable, let's move the OSI specific
initialization out of the psci_dt_cpu_init_idle() and into a separate
function.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Resending with reviewed-tags added and dropped fixes tag.

---
 drivers/cpuidle/cpuidle-psci.c | 46 ++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index edd7a54ef0d3..bae9140a65a5 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -160,6 +160,29 @@ int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
+static int __init psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
+					    struct psci_cpuidle_data *data,
+					    unsigned int state_count, int cpu)
+{
+	/* Currently limit the hierarchical topology to be used in OSI mode. */
+	if (!psci_has_osi_support())
+		return 0;
+
+	data->dev = psci_dt_attach_cpu(cpu);
+	if (IS_ERR_OR_NULL(data->dev))
+		return PTR_ERR_OR_ZERO(data->dev);
+
+	/*
+	 * Using the deepest state for the CPU to trigger a potential selection
+	 * of a shared state for the domain, assumes the domain states are all
+	 * deeper states.
+	 */
+	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
+	psci_cpuidle_use_cpuhp = true;
+
+	return 0;
+}
+
 static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 					struct device_node *cpu_node,
 					unsigned int state_count, int cpu)
@@ -193,25 +216,10 @@ static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		goto free_mem;
 	}
 
-	/* Currently limit the hierarchical topology to be used in OSI mode. */
-	if (psci_has_osi_support()) {
-		data->dev = psci_dt_attach_cpu(cpu);
-		if (IS_ERR(data->dev)) {
-			ret = PTR_ERR(data->dev);
-			goto free_mem;
-		}
-
-		/*
-		 * Using the deepest state for the CPU to trigger a potential
-		 * selection of a shared state for the domain, assumes the
-		 * domain states are all deeper states.
-		 */
-		if (data->dev) {
-			drv->states[state_count - 1].enter =
-				psci_enter_domain_idle_state;
-			psci_cpuidle_use_cpuhp = true;
-		}
-	}
+	/* Initialize optional data, used for the hierarchical topology. */
+	ret = psci_dt_cpu_init_topology(drv, data, state_count, cpu);
+	if (ret < 0)
+		goto free_mem;
 
 	/* Idle states parsed correctly, store them in the per-cpu struct. */
 	data->psci_states = psci_states;
-- 
2.20.1

