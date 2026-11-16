Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821788;
	b=gKNOt0M7uEXYsryfvPtkBxDsfi/sWCCv9qwbYTmYDH6zYAhdSbJ8mMOqidVJLnXL1uje
	 +PGF/yohN7A71PCcIFsKbTYrhhh4pJyfuLMAM4dbMdFT7hKsxOu1MTsgwTtdibJqBIvhp
	 31EymkJugb+ajxcXmDLrWD7v47R9OZ5ydN+ovA0yE4FVJHNjIcdxrJ8mGkAmdlc54XEwW
	 wT2HD81R7c/FKCMN7CzxBc6U00JWCwxQ5S4EuV6TswRHKj6rjywwW7+LyvUprg1/46bM5
	 HapYPWyYfjBCN6rHMNdpuanDh78OG5jRpm3CgLnI0+mJk93XCvsUxymiepUPMf/Fwqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821788;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=v+dOvc9dn3hYj8u7Wj++d+L6cCx689kHLz2GM22BnKY=;
	b=ak1LiVHEVM0nJEwxleL0F+xYxdp44Ll5C4MwnSl344m/qoxwUUxfqxcK4bxE829JRO9i
	 vQh9U1MLXWV6HHKieI4EVeK8hOux7YfuxmkqkBGKBcyALSvN9kGCWd16Ds1h5BdMRc3M6
	 WVMXOYosmJTS9cOY+dLWrerx/MZpOkv82fxwOejf4XBP2MyotT3gMMQMNGl3oGKI6mpgX
	 riph8uwSKnBa+Ng8nWEDlFd+3GY9g5VF0tf/023z92NwiK/BPc5WT3D2scl//R/uGPaL1
	 VMpKnRhGbUqzFL1sO5SgeeARNmV0mu3CNRq/CY9SqRFg6+RvQB0w/F/68puELvAHAXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eU3hwyMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE57606A32C;
	Mon, 16 Nov 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eU3hwyMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D331F000CC;
	Mon, 16 Nov 2026 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794821787;
	bh=v+dOvc9dn3hYj8u7Wj++d+L6cCx689kHLz2GM22BnKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eU3hwyMGw2HG5OX49oXQTJ/CFo6iXgoR6pT+ImSgiwkmU/pvLPrRVJ65+R1HYONGk
	 CsjsinyNhFg64Nq6s80iDIvBb3zZmzpw3dkYDPz0hOEMeRQCSZl9ROsSJPQrouvEsJ
	 fVUHXwp8u0exFKHjE4qkqAKDI2OEBd9EsRXi88+fa1IkAS+w2EqS3L59qUq0TfGH94
	 4FBlfj1V4Bqd9JqlBoJu5C5mhfBhHEsxu8R79bDfQc+4rTpmRJFpZag96FjbpBUAn3
	 zHWa6tPXuJDrGKbtekBYgNfIeXaHyIeaTqDkcf+sNr45zmJ2Y3nJ7sQRTFyl/rFMFV
	 qJvxQIHjty1lw==
From: Joshua Crofts <crofts@kernel.org>
Date: Mon, 16 Nov 2026 10:36:10 +0100
Subject: [PATCH v2 2/2] PM: runtime: add debugfs entry for
 pm_runtime_summary
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
Message-Id: <20261116-pm-runtime-summary-v2-2-a3d8654baf8f@kernel.org>
References: <20261116-pm-runtime-summary-v2-0-a3d8654baf8f@kernel.org>
In-Reply-To: <20261116-pm-runtime-summary-v2-0-a3d8654baf8f@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Samuel Wu <wusamuel@google.com>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794821782; l=3443;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=RvVdIGb/q240aMI54DmTbpCTBKxm5m2wFxt3Wkvg338=;
 b=lILjJryARVxIzeFS2wSSCVu/gcgNXwmFBSBVXtF+pwaSFyWR994A+5i3hG3r5bTRc1Ydj7Rah
 0tZHb+k5xlrDXXRrOk7AekzZKWtBYqmUklCZX4VMxFNa6zENfgMLfOI
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=

Add a debugfs entry for showing the runtime statistics for devices with
PM runtime enabled.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/base/power/runtime.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 3085318e9c32fce892def5a901aae300f473ea2d..2012c49882092fdfbe57b8d8d6e997328de207cf 100644
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
@@ -2197,3 +2199,87 @@ bool pm_runtime_need_not_resume(struct device *dev)
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

