From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 01/10] cpufreq: Add support for per-policy driver data
Date: Thu, 28 Aug 2014 11:22:23 +0530
Message-ID: <d42f24a1f00b830b17bc6d21360b6f8faf692c79.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62419 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaH1Fwv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 01:52:51 -0400
Received: by mail-pa0-f54.google.com with SMTP id fb1so1102928pad.41
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 22:52:51 -0700 (PDT)
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com, Viresh Kumar <viresh.kumar@linaro.org>

Drivers supporting multiple clusters or multiple 'struct cpufreq_policy'
instances may need to keep per-policy data. If the core doesn't provide support
for that, they might do it in the most unoptimized way: 'per-cpu' data.

This patch adds another field in struct cpufreq_policy: 'driver_data'. It isn't
accessed by core and is for driver's internal use only.

Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7d1955a..138336b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -112,6 +112,9 @@ struct cpufreq_policy {
 	spinlock_t		transition_lock;
 	wait_queue_head_t	transition_wait;
 	struct task_struct	*transition_task; /* Task which is doing the transition */
+
+	/* For cpufreq driver's internal use */
+	void			*driver_data;
 };
 
 /* Only for ACPI */
-- 
2.0.3.693.g996b0fd

