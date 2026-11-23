Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424866;
	b=dxCocHCYpReaCD4CC07Zb4I7ro6xGj7U05NkXOxRde8UHlsVqi6HMxBFKM11qoyXrkgt
	 ej0mLqwtKrYiwME+04DsxUKrxJnzX7V3bLgljbCge7wqrogIZ38ZU50Xdz6JU4C+jM2RG
	 gFR8mZiSI627/wTIofK96ClsGDH875q65BEHDs6RrKbev3xQHou5vNwD2nk33Eg5kROs4
	 /WTsWPu8oipvP23Co/+OBPZqSVqxLktbiVaWJgZmMT+ZU/JkPzwFNOo+XCXXwXiwWRsws
	 5s22KndQ+LxdSWq95NJsPbhOUsoB5g6MIFhXbBhRjbfjZ2QZr27bnT3hFegyVF3BZzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424866;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=oNXJQGvVV/3UPi9v0oDuHfYKtoUPiyJRV7OzaEpjHoA=;
	b=Vmr2txh8+7CfQBr0dhf9W0awFiYBOYCqobxXu9PswLA1rp+A1fG4H1Ey9OQikExCqrPA
	 hY/yul4CNHMvG1kBrMRCxvfEfUQhRvztmi0xYbShp7s9Mix/emgGsAXyN7DNqSvdegjuq
	 tH9g/JW4M/CB2EPiLdwdqb04tT0Oex+k3WjsP9IveXtYTxNOSkRFrQcvBeVGsAb3cFutO
	 K69E3XTLC1aQq5hHGrZGXr2QG6d/lVNhpTc71+Q497AEBUflXnMgN5z5N525vuG9Fm5cK
	 ZCp1+ObPO4MdEELu1rQWQueGWP/cQkfYC5+kaAwk8I4HvtoxXKe/6wgIR7RffqPLRUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i/ChAMHa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C73606A321;
	Mon, 23 Nov 2026 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i/ChAMHa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FED01F000EE;
	Mon, 23 Nov 2026 09:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795424865;
	bh=oNXJQGvVV/3UPi9v0oDuHfYKtoUPiyJRV7OzaEpjHoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i/ChAMHaAVAEX1mCk7y1cARyEnHREMLA0F1tcKlLOXHrjLYbNCF9AD4pNoaMhuHTZ
	 r968Oh4VRzQnx7X6Tom0qISMgpfRf2JKLGjk5ODKfEKJIh9mflq4ox5lOTNbXpmXtD
	 +pqwt6vpKaH+l5TiOJK+6vrIjfyiR2sZJlasXU7oNPiPL3lkL4wH64rso30C7ViC2c
	 MEIjdBeqQGfDAGFZbYI9D47tykZy8bMKlFEP14C6/g8qGQIyceHCq+4HHa9kcWGeq4
	 AbSS8IgxgAM9jbz9Zx+Irp/jGtyAoTSinX/aR36eQbshdMtEDUsqZ9gc5d0Mo/NIMp
	 Al5dAfCNvpcJg==
From: Joshua Crofts <crofts@kernel.org>
Date: Mon, 23 Nov 2026 10:06:55 +0100
Subject: [PATCH v3 2/2] PM: runtime: add debugfs entry for
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
Message-Id: <20261123-pm-runtime-summary-v3-2-81a966953a81@kernel.org>
References: <20261123-pm-runtime-summary-v3-0-81a966953a81@kernel.org>
In-Reply-To: <20261123-pm-runtime-summary-v3-0-81a966953a81@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Samuel Wu <wusamuel@google.com>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795424856; l=3387;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=S7OuVKaOgmvGLK4rr9ywmeDW06K1LMn3jHlpz+GhhIY=;
 b=NdpQ3pMxnQa48BeasZARLuJQq9gpY5DlITypl6vGsWSBsEc3IziEJ2GonqIWL3plrcKRPIbi1
 Us861fg2X0EDNhDMOHt4K02n8RkhR3UZXPChX3Awj+rzS7xvZbSokEP
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=

Add a debugfs entry for showing the runtime statistics for devices with
PM runtime enabled.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/base/power/runtime.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 17aee68366cf..cf657251633e 100644
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
@@ -2223,3 +2225,87 @@ bool pm_runtime_need_not_resume(struct device *dev)
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

