From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v2 1/5] cpu_pm: add syscore_suspend error handling
Date: Thu, 25 Jan 2018 23:38:31 -0800
Message-ID: <20180126073835.16575-2-dbasehore@chromium.org>
References: <20180126073835.16575-1-dbasehore@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33051 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeAZHil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jan 2018 02:38:41 -0500
Received: by mail-pf0-f195.google.com with SMTP id t5so7754429pfi.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2018 23:38:41 -0800 (PST)
In-Reply-To: <20180126073835.16575-1-dbasehore@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>

If cpu_cluster_pm_enter() fails, cpu_pm_exit() should be called. This
will put the CPU in the correct state to resume from the failure.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 kernel/cpu_pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 67b02e138a47..03bcc0751a51 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -186,6 +186,9 @@ static int cpu_pm_suspend(void)
 		return ret;
 
 	ret = cpu_cluster_pm_enter();
+	if (ret)
+		cpu_pm_exit();
+
 	return ret;
 }
 
-- 
2.16.0.rc1.238.g530d649a79-goog
