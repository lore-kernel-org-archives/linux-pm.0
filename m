Return-Path: <SRS0=BJcq=TN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1471FC04AA7
	for <linux-pm@archiver.kernel.org>; Mon, 13 May 2019 19:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECEC20989
	for <linux-pm@archiver.kernel.org>; Mon, 13 May 2019 19:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nuEds6uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfEMTbH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 May 2019 15:31:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42436 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfEMTbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 15:31:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id 188so12077914ljf.9
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5L3+w8hUR6giXqb5Tz84iJ3SS/PuntIOYwjCkJwPh9s=;
        b=nuEds6uqvSvhzFgPN0xx4WrLj+8Aq5wMne2aRP4Hl30ysRHF3JwffRDwh2I/w4NkhA
         ruqtjGmeavnUC5G6t1+5vD7jYhWzIibj7v8eKj+D5BqywqtbMj4VlBzc5f+oeCC7YVZr
         gMQJv7sBlyWAqagmqVCdQx6ievkrgzxp6P6VXhi+yjAzjEClLL/IUaPqLF+XdiUzD+wB
         PoZRlnXLRxkuWULBDbbLIts79BiF1YdM5kTUelzfYB3F6IWAddBJ1onCo4N+i653uveS
         lhlUL6q4MSOpQOYlAnyDByOwere/dmOdnrZOjhSfSGK/7nMJMIUGdCEIfOTBMbYwDCev
         MmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5L3+w8hUR6giXqb5Tz84iJ3SS/PuntIOYwjCkJwPh9s=;
        b=VHzFMR8H3sFsm/XRNTxDTfqLHZ1yIMOw2gP3+pKLwfhRdxEiRXwGr6o0D+6Mxw0mC9
         JIKkuRPp+ltxvemu4vpwjHzknI8eu17f4IjoAOU382Kccw4De5gSBfkOyogiv7JGGmDi
         NM/W+Aw1+6cw6Wpe6yFPHnnc9OX8t/S70papAFRacVZOVD5qlYsY0/l4pVimSTHGWUQW
         gEm0ZiO7NuZ6396Rn1ghQyXvU5Y3d15AsyKMXOLntFrSSTtbPjZXjag/ZPMtWXe+GT2y
         Np6yRMmkiSrfyKWtGwwyiCKxFdZhu89d6cSJ0F81VH89g4pkYhp+i40l0gko3gA3ek+B
         RrOA==
X-Gm-Message-State: APjAAAWJLT1NfZQNVLVblHgbVx5JTggvOJ0jXmUpGu5QyJDsHRi9eYyc
        /mUuxYYE8Yz4F4+7Qa24rjcbLQ==
X-Google-Smtp-Source: APXvYqwhviRoSbMrrPulC15a2Em5gq4bwlntBmk6fP/23jtstN9Z1J324DMrQRo3VkPOVmz3QA57og==
X-Received: by 2002:a2e:9141:: with SMTP id q1mr14833265ljg.84.1557775411722;
        Mon, 13 May 2019 12:23:31 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:31 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 14/18] drivers: firmware: psci: Manage runtime PM in the idle path for CPUs
Date:   Mon, 13 May 2019 21:22:56 +0200
Message-Id: <20190513192300.653-15-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190513192256.kxTFVW4AnmsPf7K5ttjDxUUQzWvODRLCBMMyvmZ2ITE@z>

When the hierarchical CPU topology layout is used in DT, let's allow the
CPU to be power managed through its PM domain, via deploying runtime PM
support.

To know for which idle states runtime PM reference counting is needed,
let's store the index of deepest idle state for the CPU, in a per CPU
variable. This allows psci_cpu_suspend_enter() to compare this index with
the requested idle state index and then act accordingly.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Simplify the code by using the new per CPU struct, that stores the
	  needed struct device*.

---
 drivers/firmware/psci/psci.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 54e23d4ed0ea..2c4157d3a616 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -20,6 +20,7 @@
 #include <linux/linkage.h>
 #include <linux/of.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
@@ -298,6 +299,7 @@ static int __init psci_features(u32 psci_func_id)
 
 struct psci_cpuidle_data {
 	u32 *psci_states;
+	u32 rpm_state_id;
 	struct device *dev;
 };
 
@@ -385,6 +387,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			goto free_mem;
 
 		data->dev = dev;
+		data->rpm_state_id = drv->state_count - 1;
 	}
 
 	/* Idle states parsed correctly, store them in the per-cpu struct. */
@@ -481,8 +484,11 @@ static int psci_suspend_finisher(unsigned long index)
 int psci_cpu_suspend_enter(unsigned long index)
 {
 	int ret;
-	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
-	u32 composite_state = state[index - 1] | psci_get_domain_state();
+	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
+	u32 *states = data->psci_states;
+	struct device *dev = data->dev;
+	bool runtime_pm = (dev && data->rpm_state_id == index);
+	u32 composite_state;
 
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
@@ -491,11 +497,23 @@ int psci_cpu_suspend_enter(unsigned long index)
 	if (WARN_ON_ONCE(!index))
 		return -EINVAL;
 
+	/*
+	 * Do runtime PM if we are using the hierarchical CPU toplogy, but only
+	 * when cpuidle have selected the deepest idle state for the CPU.
+	 */
+	if (runtime_pm)
+		pm_runtime_put_sync_suspend(dev);
+
+	composite_state = states[index - 1] | psci_get_domain_state();
+
 	if (!psci_power_state_loses_context(composite_state))
 		ret = psci_ops.cpu_suspend(composite_state, 0);
 	else
 		ret = cpu_suspend(index, psci_suspend_finisher);
 
+	if (runtime_pm)
+		pm_runtime_get_sync(dev);
+
 	/* Clear the domain state to start fresh when back from idle. */
 	psci_set_domain_state(0);
 
-- 
2.17.1

