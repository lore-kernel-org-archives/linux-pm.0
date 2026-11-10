Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307432;
	b=HJvDF6EEnQC3hipnMLXw1b5X38qGT9AGbcZ3rF4Y0EEGNdHPLCKw2Sw+3J2XoP8hoZzH
	 ARVh+KUD3iGS23Zi9LUFzl2dh3Avzt1e/aSfrBhfIPXih253yNEs8km88rhGoJxS8+VYN
	 k48nENOTJw8eubWNqcsmaQ0/l/mZOavHb7Z+gnvslDUBFTiF7KYFfuXd9/hfABBTGo7zT
	 97EO8zcv+Q+EkanE0HRE4PpkEhJmfwB62ebqX+E9inf0svuhonambDcBbimGDCV8j9GDG
	 FDwm8SGl+vF58b6qNWL3x3uUyh5DB+4K/PulkHc91Rp0f6DthYMC14Zb9w5l2wiAW+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307432;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Hf6AsW+SSV1TWSy6GE47UPvce7GxZ72+c8kesuE2YI4=;
	b=1PmaUPTYgFZwKRlImpBp+5e7No0KVnpXGaEbFltO7aWCsKgh3IEfnfD50t6W6eea7Qbm
	 pJlX/ZFxQzvZw0xXt0hqUAhedos6LVew+MAAw1prFHwtAnm3w5FTzqnka5u2aJ1rK6/Wr
	 AexILUYgnP5I3Vn2u7vxxfNcYmt2c2Hj0jLU9wMJr8lUm32bN1kHt1tbH/Ue7Qww2LXmu
	 MwLC6OkXmk0x6uGTi9wAQ78nEGPHrdqsJKgh6bY9uo0y1RVPfYWD/MGFaukS8TFOVmZzw
	 Zz1RivPkQeZipn75vdB5Qf6l61UXfCmuqoKIdUjWG9mORWxpgIrknRfDzU2VexAkoCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otha8aMJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED202606A333;
	Tue, 10 Nov 2026 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otha8aMJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C581F008A1;
	Tue, 10 Nov 2026 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307431;
	bh=Hf6AsW+SSV1TWSy6GE47UPvce7GxZ72+c8kesuE2YI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=otha8aMJ1b0Mq+/LpcIcAybXSKUVAzjtgyelSvFIyNHJXWBrtAd1xMLkZJ4kJEgQy
	 Tg3EZDvo1Ykei0/sTJapc9mdaoh5iahKJpTLazwl9UZZjImck4SPlbtleTJjfZwgVl
	 Q0Ymq7fxRirvW+sBL1K2RNJR6/9QnCmkAmfVSbVFomnhotrnFew16+Mdb5Ta6cHajn
	 XcQECqtcVHkdq0KyHu5iA2eOcSvEU63QD5W94upLk8gc1+iIsdOsMu2j6TpFaJFaO3
	 Klslrqh+Qv9td9ibKx6giYW4VhCfAUkq59ClgicZUv4ZuWq6j8yuiCXFYRv+QA178f
	 yeWbwG+6xJs7A==
From: Joshua Crofts <crofts@kernel.org>
Date: Tue, 10 Nov 2026 11:43:22 +0100
Subject: [PATCH 3/3] PM: runtime: add debugfs entry for pm_runtime_summary
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-pm-runtime-summary-v1-3-12ebf283db78@kernel.org>
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
In-Reply-To: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794307420; l=3443;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=hPNHg+sTsUBVYzN5VrY9xEFxP16H6UCtaFGzZnBY4U8=;
 b=KW02XaxfwKKGJZfR+y6MXPLDaBxcf6x5yXum5PaNOVg2jpdlhEWIN6+Y768lv0f3p/x9jx7Nx
 NVGS0EaTrDXD2OHBaxrU0XNfkghImnGOkSAKA+VjKOb+GlWAZ6EVPDA
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=

Add a debugfs entry for showing the runtime statistics for devices with
PM runtime enabled.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/base/power/runtime.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5087a52f1784f7b4493896bce147ebcb0424d17c..f5ea6ba6d20fc4a9a3088e1fcb20b70cd5ebe476 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -14,6 +14,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/rculist.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 #include <trace/events/rpm.h>
 
 #include "../base.h"
@@ -2193,3 +2195,87 @@ bool pm_runtime_need_not_resume(struct device *dev)
 }
 
 #endif /* CONFIG_PM_SLEEP */
+
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_PM_SLEEP)
+static void rpm_summary_show_dev(struct device *dev, void *data)
+{
+	struct seq_file *s = data;
+	unsigned long flags;
+	u64 active_time, suspended_time;
+	u64 last_sleep, min_sleep, max_sleep;
+	u64 resumes, suspends;
+	const char *status_str;
+	bool enabled;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+
+	enabled = pm_runtime_enabled(dev);
+	if (!enabled && !dev->power.resume_count && !dev->power.suspend_count) {
+		spin_unlock_irqrestore(&dev->power.lock, flags);
+		return;
+	}
+
+	update_pm_runtime_accounting(dev);
+
+	switch (dev->power.runtime_status) {
+	case RPM_ACTIVE:
+		status_str = "active";
+		break;
+	case RPM_SUSPENDED:
+		status_str = "suspended";
+		break;
+	case RPM_SUSPENDING:
+		status_str = "suspending";
+		break;
+	case RPM_RESUMING:
+		status_str = "resuming";
+		break;
+	default:
+		status_str = "unknown";
+		break;
+	}
+
+	active_time = dev->power.active_time;
+	suspended_time = dev->power.suspended_time;
+	resumes = dev->power.resume_count;
+	suspends = dev->power.suspend_count;
+	last_sleep = dev->power.last_suspended_time;
+	min_sleep = dev->power.min_suspended_time;
+	max_sleep = dev->power.max_suspended_time;
+
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	do_div(active_time, NSEC_PER_MSEC);
+	do_div(suspended_time, NSEC_PER_MSEC);
+	do_div(last_sleep, NSEC_PER_MSEC);
+	do_div(min_sleep, NSEC_PER_MSEC);
+	do_div(max_sleep, NSEC_PER_MSEC);
+
+	seq_printf(s, "%-32s %-12s %8llu %8llu %12llu %12llu %10llu %10llu %10llu\n",
+		   dev_name(dev), enabled ? status_str : "disabled",
+		   resumes, suspends, active_time, suspended_time,
+		   last_sleep, min_sleep, max_sleep);
+}
+
+static int pm_runtime_summary_show(struct seq_file *s, void *unused)
+{
+	seq_printf(s, "%-32s %-12s %8s %8s %12s %12s %10s %10s %10s\n",
+		   "Device", "Status", "Resumes", "Suspends",
+		   "Active(ms)", "Suspend(ms)", "Last(ms)", "Min(ms)", "Max(ms)");
+	seq_puts(s, "--------------------------------------------------------------------------------------------------------------------------\n");
+
+	dpm_for_each_dev(s, rpm_summary_show_dev);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pm_runtime_summary);
+
+static int __init pm_runtime_debugfs_init(void)
+{
+	debugfs_create_file("pm_runtime_summary", 0444, NULL, NULL,
+			    &pm_runtime_summary_fops);
+
+	return 0;
+}
+late_initcall(pm_runtime_debugfs_init);
+#endif /* defined(CONFIG_DEBUG_FS) && defined(CONFIG_PM_SLEEP) */

-- 
2.47.3

