Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307426;
	b=ncSzGjp2AwYacNEVP5sBhBhS0wl1Zuvsexhz4vh3dW91EfVSs8zxcUxx184RR6LvbgbA
	 VTE4gvIBl2YTBzR4sKRcKBTapCUSuBm0KlQAeLHu1ON3STYOp6f/63gUGJZOO7Q47fQSD
	 L5xZpFiq7UGiD4Y3/VNF9PjFGbtlpObNJRB8qrCyvVUMBRKuZ3xsIYjiqVHrj3a4r9nkR
	 v8MYLOkqVm5LarBkZPDWzuDhakdLvlqnbKnxsp3u5Oj/VmwJi3Vg2nnmN9r29f6tRHYFb
	 9SaCmVb5keOXZS3QeRqYJDkLpS/F45HyII0zwZYYj13xJNdFHQDN9z1HfXBRPPJiE2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307426;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WSkKRUW0yoinbV4AO1Y7PFuksn7ciQsu/vcNKDRio9g=;
	b=08xKs2PlpRITTjkUnKwsOUwUe7CRw5nqhF/3CxJ7Px0ESIXpS8imsujvFlzWZtliBGeB
	 AioBDIja0g7NczVY3urjhT4Jj4LqtHcbGMnfzfCsBed9nTgSpgXiUn+Y2frNifhncKOtW
	 zeoyt8Wgwvaj5zSlAoem+NfbjIB1WOEUM2JHrmjYwSwuJQixGPMw/HCy5VuxvvGdv5H8T
	 1htn0beZfbPJwKOPWLxUidIzIfD1lw6Kg5jkOslxkRzc46vFUYYnFZhdYbxCCRgO+okMF
	 FOZVPAc8L2CpNXFtAvvKCf8ltSjnp1uXHUzYxRL2XE5bqZp2gillY1n04BWICXRokuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqhyRVBs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEC606A332;
	Tue, 10 Nov 2026 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqhyRVBs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364AF1F008A1;
	Tue, 10 Nov 2026 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307425;
	bh=WSkKRUW0yoinbV4AO1Y7PFuksn7ciQsu/vcNKDRio9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VqhyRVBs7ZOOgPr8fNdylGQVL1qdPtfV7RaE4KzKPG82wjYc5Ef6X2OQwyU1uljYX
	 xd51IA3EJ+ZjFODSew9SLxD5ibMY+F46W0wh0/9jJbdgZIjUsxqEs4+/1880f1hgoE
	 j6f3wcSL+sFyMiZFRz7GsjEgyLG9Hl3JDT3G4WUr8CsavKhgM3FK73OsC/C/k9gkVx
	 yKDoMbHeutxDJPClFIqVZHa+roNfeynI6gv1ejD3R7Xa8u+5jsOTwR80Y3tVygBxy/
	 6l03dP666xzFrXuta34TPu1r5TmfOTu2FtIN9LLsGlC8Cbq1txY9q1ORUSALed46FQ
	 org+C93/KnHyA==
From: Joshua Crofts <crofts@kernel.org>
Date: Tue, 10 Nov 2026 11:43:20 +0100
Subject: [PATCH 1/3] PM: runtime: add additional suspend/resume metrics
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
Message-Id: <20261110-pm-runtime-summary-v1-1-12ebf283db78@kernel.org>
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
In-Reply-To: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794307420; l=5757;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=XvTIIviBWBkCSoCgUsp6FbfaeSuYa1kYm0g8fJwViMk=;
 b=sDysfN/Y7bhGCvKpgEIy+3BDt4N24DdayXYM4VN8NrVguYLV11CYbaYM4hPHBH8S2Z2fBhsI+
 4JQ59k9d8sJCQ4/zaT0R6JjLGCDMsWRyKO/aVU8TmK0D5Iwk0qmFZ7c
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=

The current implementation only logs the total accumulated time a device
spends in suspended or active states.

Add tracking for:
- resume_count : number of successful transitions to active
- suspend_count: number of successful transitions to suspended
- last_suspended_time: duration of the most recent sleep cycle (ns)
- min_suspended_time / max_suspended_sleep: shortest and longest sleep
  cycle durations to help detect power thrashing (ns)

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/base/power/runtime.c | 70 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/pm.h           | 12 ++++++++
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 304a2b12342082ffacce32aa9c2e863466b0d4ae..5087a52f1784f7b4493896bce147ebcb0424d17c 100644
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
@@ -103,11 +105,62 @@ static void update_pm_runtime_accounting(struct device *dev)
 		dev->power.active_time += delta;
 }
 
+static void rpm_account_suspend(struct device *dev)
+{
+	dev->power.suspend_time = ktime_get_mono_fast_ns();
+	dev->power.suspend_count++;
+}
+
+static void rpm_account_sleep_end(struct device *dev)
+{
+	u64 now, duration;
+
+	if (!dev->power.suspend_time)
+		return;
+
+	now = ktime_get_mono_fast_ns();
+	if (now <= dev->power.suspend_time)
+		return;
+
+	duration = now - dev->power.suspend_time;
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
+
 static void __update_runtime_status(struct device *dev, enum rpm_status status)
 {
+	enum rpm_status old_status = dev->power.runtime_status;
+
 	update_pm_runtime_accounting(dev);
 	trace_rpm_status(dev, status);
 	dev->power.runtime_status = status;
+
+	if (dev->power.disable_depth > 0)
+		return;
+
+	if ((old_status == RPM_SUSPENDING || old_status == RPM_ACTIVE) &&
+	    status == RPM_SUSPENDED)
+		rpm_account_suspend(dev);
+	else if (old_status == RPM_RESUMING && status == RPM_SUSPENDED)
+		dev->power.suspend_time = ktime_get_mono_fast_ns();
+	else if (old_status == RPM_SUSPENDED && status != RPM_SUSPENDED)
+		rpm_account_sleep_end(dev);
+
+	if ((old_status == RPM_RESUMING || old_status == RPM_SUSPENDED) &&
+	    status == RPM_ACTIVE)
+		rpm_account_resume_complete(dev);
 }
 
 static u64 rpm_get_accounted_time(struct device *dev, bool suspended)
@@ -1589,10 +1642,12 @@ void pm_runtime_enable(struct device *dev)
 	dev->power.last_status = RPM_INVALID;
 	dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
 
-	if (dev->power.runtime_status == RPM_SUSPENDED &&
-	    !dev->power.ignore_children &&
-	    atomic_read(&dev->power.child_count) > 0)
-		dev_warn(dev, "Enabling runtime PM for inactive device with active children\n");
+	if (dev->power.runtime_status == RPM_SUSPENDED) {
+		dev->power.suspend_time = dev->power.accounting_timestamp;
+		if (!dev->power.ignore_children &&
+		    atomic_read(&dev->power.child_count) > 0)
+			dev_warn(dev, "Enabling runtime PM for inactive device with active children\n");
+	}
 
 out:
 	spin_unlock_irqrestore(&dev->power.lock, flags);
@@ -1861,6 +1916,13 @@ void pm_runtime_init(struct device *dev)
 	pm_suspend_ignore_children(dev, false);
 	dev->power.runtime_auto = true;
 
+	dev->power.resume_count = 0;
+	dev->power.suspend_count = 0;
+	dev->power.suspend_time = 0;
+	dev->power.last_suspended_time = 0;
+	dev->power.min_suspended_time = 0;
+	dev->power.max_suspended_time = 0;
+
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index ef3f1310e749c34d4aff75a2fd7e95b9f2ef3a10..7cd1350ea327be4e800175c2fc0e3b3e35c3ea57 100644
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
@@ -816,6 +822,12 @@ struct dev_pm_info {
 	u64			active_time;
 	u64			suspended_time;
 	u64			accounting_timestamp;
+	u64			resume_count;
+	u64			suspend_count;
+	u64			suspend_time;
+	u64			last_suspended_time;
+	u64			min_suspended_time;
+	u64			max_suspended_time;
 #endif
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);

-- 
2.47.3

