Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424862;
	b=2Q9D9yR/K3J24e4f7yODiipXwVcrdKztINDDfhobS3HuXyNzMMovrycLR3SDRpStWL8m
	 6Pw3EPXhLkuf+x/T8LvlWRtsI0m85FnOwWXJ9/tQmObzRmm8LdtuaQVn3ouRyreavYuor
	 b8cw1JvXgUv7ZG/wyCClNGKXFU3vHQ8OLiZaTe88zeF8o8Fd90420uMYtUUrqanGRafm1
	 eFsITou2MXb2wPfuQ33lR0bhaMv1lFNOb1fZpkfjLTykr7tdG0SQ6UUlQp+ZRI8y++Md8
	 iXU6QiUdmdfg0euBXmjiNOZEymo/uLpv3EkdgIQlGyeBjZizCx2MykFufUYOcTNj6DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424862;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hhcfcmfWUrP64e68aNF2tYl1YHqKvdB/WQnHd93JTHo=;
	b=og/8qEInsjtQI41I5yn/7/8owp/B+GsosWL0bAjf5ZWm4DORtelHnZ0cRNOci9Tub8oH
	 HHd/HMkUUkXbJ4NyJORCwyZXjbxbRW8VjSa78nlePXzVGtGxkrPGFhxEiNLQtzV6hS5Au
	 akuqwkNFP4O373AgH0IMv5D5XJDBnEJh9oWugJqqNtxIhD+jd3uv942k4kGVVwL0pGGEX
	 OKDViu7kd5H8W5Ab0Pf4I0CREFpuyAIhCXj9MFmykadD1ImXqP+QKEc5c5lPN8vahTYmx
	 waL3l+dbHupXJrUbCGByeXsOxb2VlHYf/Gmdm8RQYXQvC89Goomdxy9A4olbG/2RUGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2ksOOII;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A10606A32A;
	Mon, 23 Nov 2026 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2ksOOII
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D821E1F000F0;
	Mon, 23 Nov 2026 09:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795424862;
	bh=hhcfcmfWUrP64e68aNF2tYl1YHqKvdB/WQnHd93JTHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y2ksOOIIjNvYr56yDqznVexIrBKx/m850/0QRQMATB4YcIuYeXfb49Q4hehhYVmTT
	 HmHHbODc4vOUrAvvh2WsOd5KZoTevryrzyZ6wa1LxQ/G10JId/q5ip4JIrVpjzCMAv
	 M6o0G7J0xxPv5xp2KlOrywg4iBNLz5hhXykWehS1BqA7jTrgUIu47zfOQxIckF+/do
	 iDWwfoGmCeBhy7ReWQydqCEXfK7FIzVkwM5D4mykUOQHuZMD8VuyUvKaUFru11lanI
	 YuEF6ze7p83Pu90EhNc3mZG8rB6jKRvHbCVkY4He4UFS0S/PmhVagnpBjkkGPi0jWp
	 2egzBOie7bzLA==
From: Joshua Crofts <crofts@kernel.org>
Date: Mon, 23 Nov 2026 10:06:54 +0100
Subject: [PATCH v3 1/2] PM: runtime: add additional suspend/resume metrics
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
Message-Id: <20261123-pm-runtime-summary-v3-1-81a966953a81@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795424856; l=6630;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=N7d2tkbkFKeb3qey4gHjzbYdTxMdfZr5FklwivjOsIs=;
 b=NHuhihgkWF6QQug31Q658fGJJmsAn1vrh/OBaBAf1djzYQeITBWNYbeYpPY8lUoLL5IH67Aip
 YaebB+FhWT/Cq735C3TPZgappGM1XwcAJN7BHVPgNhTiYnROtXNqHMk
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=

The current implementation only logs the total accumulated time a device
spends in suspended or active states.

Add tracking for:
- resume_count : number of successful transitions to active
- suspend_count: number of successful transitions to suspended
- last_suspended_time: duration of the most recent sleep cycle (ns)
- min_suspended_time / max_suspended_time: shortest and longest sleep
  cycle durations to help detect power thrashing (ns)

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/base/power/runtime.c | 93 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/pm.h           | 16 +++++++-
 2 files changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4e9c23059a40..17aee68366cf 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  * Copyright (C) 2010 Alan Stern <stern@rowland.harvard.edu>
  */
+#include <linux/pm.h>
+#include <linux/timekeeping.h>
 #include <linux/sched/mm.h>
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
@@ -103,11 +105,70 @@ static void update_pm_runtime_accounting(struct device *dev)
 		dev->power.active_time += delta;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static void rpm_account_suspend(struct device *dev)
+{
+	dev->power.suspend_time = dev->power.accounting_timestamp;
+	dev->power.suspend_count++;
+}
+
+static void rpm_account_sleep_end(struct device *dev)
+{
+	u64 duration;
+
+	if (!dev->power.suspend_time)
+		return;
+
+	if (dev->power.accounting_timestamp <= dev->power.suspend_time)
+		return;
+
+	duration = dev->power.accounting_timestamp - dev->power.suspend_time;
+	dev->power.last_suspended_time = duration;
+
+	/* Update min/max extrema at the exact same moment as last_suspended_time */
+	if (!dev->power.min_suspended_time || duration < dev->power.min_suspended_time)
+		dev->power.min_suspended_time = duration;
+
+	if (duration > dev->power.max_suspended_time)
+		dev->power.max_suspended_time = duration;
+}
+
+static void rpm_account_resume_complete(struct device *dev)
+{
+	dev->power.resume_count++;
+	dev->power.suspend_time = 0;
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static void __update_runtime_status(struct device *dev, enum rpm_status status)
 {
+#ifdef CONFIG_DEBUG_FS
+	enum rpm_status old_status = dev->power.runtime_status;
+#endif /* CONFIG_DEBUG_FS */
+
 	update_pm_runtime_accounting(dev);
 	trace_rpm_status(dev, status);
 	dev->power.runtime_status = status;
+
+#ifdef CONFIG_DEBUG_FS
+	if (dev->power.disable_depth > 0) {
+		if (status == RPM_ACTIVE)
+			dev->power.suspend_time = 0;
+		return;
+	}
+
+	if ((old_status == RPM_SUSPENDING || old_status == RPM_ACTIVE) &&
+	    status == RPM_SUSPENDED)
+		rpm_account_suspend(dev);
+	else if (old_status == RPM_RESUMING && status == RPM_SUSPENDED)
+		dev->power.suspend_time = dev->power.accounting_timestamp;
+	else if (old_status == RPM_SUSPENDED && status != RPM_SUSPENDED)
+		rpm_account_sleep_end(dev);
+
+	if ((old_status == RPM_RESUMING || old_status == RPM_SUSPENDED) &&
+	    status == RPM_ACTIVE)
+		rpm_account_resume_complete(dev);
+#endif /* CONFIG_DEBUG_FS */
 }
 
 static u64 rpm_get_accounted_time(struct device *dev, bool suspended)
@@ -1580,6 +1641,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_disable);
 void pm_runtime_enable(struct device *dev)
 {
 	unsigned long flags;
+	u64 now;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
@@ -1596,12 +1658,24 @@ void pm_runtime_enable(struct device *dev)
 		dump_stack();
 	}
 	dev->power.last_status = RPM_INVALID;
-	dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
+	now = ktime_get_mono_fast_ns();
 
-	if (dev->power.runtime_status == RPM_SUSPENDED &&
-	    !dev->power.ignore_children &&
-	    atomic_read(&dev->power.child_count) > 0)
-		dev_warn(dev, "Enabling runtime PM for inactive device with active children\n");
+	if (dev->power.runtime_status == RPM_SUSPENDED) {
+#ifdef CONFIG_DEBUG_FS
+		if (dev->power.suspend_time) {
+			if (dev->power.accounting_timestamp
+			    && now > dev->power.accounting_timestamp)
+				dev->power.suspend_time += now - dev->power.accounting_timestamp;
+		} else {
+			dev->power.suspend_time = now;
+		}
+#endif /* CONFIG_DEBUG_FS */
+		if (!dev->power.ignore_children &&
+		    atomic_read(&dev->power.child_count) > 0)
+			dev_warn(dev, "Enabling runtime PM for inactive device with active children\n");
+	}
+
+	dev->power.accounting_timestamp = now;
 
 out:
 	spin_unlock_irqrestore(&dev->power.lock, flags);
@@ -1870,6 +1944,15 @@ void pm_runtime_init(struct device *dev)
 	pm_suspend_ignore_children(dev, false);
 	dev->power.runtime_auto = true;
 
+#ifdef CONFIG_DEBUG_FS
+	dev->power.resume_count = 0;
+	dev->power.suspend_count = 0;
+	dev->power.suspend_time = 0;
+	dev->power.last_suspended_time = 0;
+	dev->power.min_suspended_time = 0;
+	dev->power.max_suspended_time = 0;
+#endif /* CONFIG_DEBUG_FS */
+
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index ef3f1310e749..caa4ba4a65de 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -747,6 +747,12 @@ struct pm_subsys_data {
  *   state.
  * @accounting_timestamp: Timestamp in nanoseconds of the last runtime PM state
  *   accounting update.
+ * @resume_count: Number of transitions from suspended -> active
+ * @suspend_count: Number of transitions from active -> suspended
+ * @suspend_time: Timestamp when device entered RPM_SUSPENDED
+ * @last_suspended_time: Residency of the last sleep period (ns)
+ * @min_suspended_time: Shortest sleep duration
+ * @max_suspended_time: Longest sleep duration
  * @subsys_data: Subsystem-specific power management data.
  * @set_latency_tolerance: Callback for setting latency tolerance.
  * @qos: Per-device PM Quality of Service (QoS) constraints.
@@ -816,7 +822,15 @@ struct dev_pm_info {
 	u64			active_time;
 	u64			suspended_time;
 	u64			accounting_timestamp;
-#endif
+#ifdef CONFIG_DEBUG_FS
+	u64			resume_count;
+	u64			suspend_count;
+	u64			suspend_time;
+	u64			last_suspended_time;
+	u64			min_suspended_time;
+	u64			max_suspended_time;
+#endif /* CONFIG_DEBUG_FS */
+#endif /* CONFIG_PM */
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
 	struct dev_pm_qos	*qos;

-- 
2.47.3

