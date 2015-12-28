From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH v2] PM/OPP: Set cpu_dev->id in cpumask first
Date: Mon, 28 Dec 2015 21:06:17 +0800
Message-ID: <1451307977-7427-1-git-send-email-pi-cheng.chen@linaro.org>
References: <20151228031123.GB3598@ubuntu>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36169 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbbL1NG0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2015 08:06:26 -0500
Received: by mail-pa0-f51.google.com with SMTP id yy13so17693778pab.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Dec 2015 05:06:26 -0800 (PST)
In-Reply-To: <20151228031123.GB3598@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Set cpu_dev->id in cpumask first when setting up cpumask for CPUs that
share the same OPP table. This might be helpful when handling cpumask
without the original CPU bitfield set.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
v1->v2:
- Set cpu_dev->id in cpumask at the top instead of skip it in the loop
---
 drivers/base/power/opp/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 7b445e8..9f0c155 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -214,7 +214,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
 /*
  * Works only for OPP v2 bindings.
  *
- * cpumask should be already set to mask of cpu_dev->id.
  * Returns -ENOENT if operating-points-v2 bindings aren't supported.
  */
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
@@ -230,6 +229,8 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask
 		return -ENOENT;
 	}
 
+	cpumask_set_cpu(cpu_dev->id, cpumask);
+
 	/* OPPs are shared ? */
 	if (!of_property_read_bool(np, "opp-shared"))
 		goto put_cpu_node;
-- 
1.9.1

