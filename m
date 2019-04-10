Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297C5C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE005206B6
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meorCV0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfDJIUr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:20:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43967 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbfDJIUr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2019 04:20:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so1242602lja.10
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2019 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fqLAcdPj/NLZOrfZZI3kgT4b9oSplDLhcdYfEWYk7f0=;
        b=meorCV0lfQredAwU2T0Tv4bAokTPM0RaKKvcv1f4Zkgzrz6wBM9F78OxGC4F4ULvZS
         TTwysSVVXNlZwlKOotm9O5PzUO1jLSU+pssMiR+xaVT2oGb2AiVXeBPghZsGWtw4MuXv
         U0wreO5tHp85amwZGZ5njG5mI7n27mJ/wzmO/r4BoimQNrPBusfrLBnH6EOF4YoV77vY
         vCeUpdya3P60zDgoGV7/xBw/OnHFgCehptWFeHLPHkUzg0xR+QfMNXy9PAxYjwZMjqPK
         pVvBEqtd/cJJTKbyJNbloU3b4tgWs12BMmgYss6UWYwxchMYSxpim+dHHV1rRUeOrlpK
         c9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fqLAcdPj/NLZOrfZZI3kgT4b9oSplDLhcdYfEWYk7f0=;
        b=NnzUzNgMvxmQ1tOpIcUUCsg7NM0DAM5uQ7LGATx1h22waLV1oolZ9r3I7Oj5jMieCM
         YZBjsJS59b5LmvIhbJ+30MrRZWtNM9Tzq9ggKkBOoF5lHyBYkIyAQ6YUZ+apzFYprEm3
         6gcLllhwIBqpP1r6ys6HCJ1glC6B/BNsXNPXYxGDmBr6HIMJsEwFRDnkJe/TS3GaP+Z/
         EwyEdgM1HELFrAJfm/1R74fIQVMUO5j3060Rixo3pQDoE5RIopF7az6eHHwxDyttmdiu
         Ca4sjnRj9TS02lZ6dX4RA0kOaLTkuo4cQi4ewRyOPR7PtObOJAeLo/6z6rWS4T6j9GbA
         rPMw==
X-Gm-Message-State: APjAAAXbDjjfA9KkCLX9N18sjNgvUf2k2xlit2TvYxc80Wb8vhKhErtG
        1mSgUkl/0E8rjdBXDl1jFFS6lg==
X-Google-Smtp-Source: APXvYqyzghyBIm1gYgowOZ/whO39XDQHXurGBpGYX892IX7polNLrEr5KpF1zI55BOJYcE+O19Fv6A==
X-Received: by 2002:a2e:380c:: with SMTP id f12mr23568517lja.116.1554884445456;
        Wed, 10 Apr 2019 01:20:45 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q6sm3385189lfj.36.2019.04.10.01.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 01:20:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v2 3/5] drivers: firmware: psci: Split psci_dt_cpu_init_idle()
Date:   Wed, 10 Apr 2019 10:20:23 +0200
Message-Id: <20190410082025.5989-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410082025.5989-1-ulf.hansson@linaro.org>
References: <20190410082025.5989-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410082023.xfeLtfQ6c6xX16_tk37eLGWEbwKaOpceOLo8PkxIxp0@z>

Let's split the psci_dt_cpu_init_idle() function into two functions. This
makes the code clearer and provides better re-usability.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/firmware/psci/psci.c | 42 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index c80ec1d03274..9788bfc1cf8b 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -270,9 +270,26 @@ static int __init psci_features(u32 psci_func_id)
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
 
+static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
+{
+	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
+
+	if (err) {
+		pr_warn("%pOF missing arm,psci-suspend-param property\n", np);
+		return err;
+	}
+
+	if (!psci_power_state_is_valid(*state)) {
+		pr_warn("Invalid PSCI power state %#x\n", *state);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 {
-	int i, ret, count = 0;
+	int i, ret = 0, count = 0;
 	u32 *psci_states;
 	struct device_node *state_node;
 
@@ -291,29 +308,16 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 		return -ENOMEM;
 
 	for (i = 0; i < count; i++) {
-		u32 state;
-
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
+		of_node_put(state_node);
 
-		ret = of_property_read_u32(state_node,
-					   "arm,psci-suspend-param",
-					   &state);
-		if (ret) {
-			pr_warn(" * %pOF missing arm,psci-suspend-param property\n",
-				state_node);
-			of_node_put(state_node);
+		if (ret)
 			goto free_mem;
-		}
 
-		of_node_put(state_node);
-		pr_debug("psci-power-state %#x index %d\n", state, i);
-		if (!psci_power_state_is_valid(state)) {
-			pr_warn("Invalid PSCI power state %#x\n", state);
-			ret = -EINVAL;
-			goto free_mem;
-		}
-		psci_states[i] = state;
+		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
 	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
-- 
2.17.1

