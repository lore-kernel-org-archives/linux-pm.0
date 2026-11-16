Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821784;
	b=qIT+r1grCdrsICD1YCrcR7PnUjhhkNAzRooU7EesWT1NJ9RKA3AUBXO4xJwC3QvvdhGh
	 a2GDoU9VmyMXRXuEei9aTjmbW47bSj0Ge6yNm+VzLtHOrNvjFqjdaeEqM0FeNhkZJ03ER
	 tZ6VhNzHnZY+nfdjAohJ9xbRSBZ4rJ/9QsMzRvoKfUU8cNWhEqgPhFOJCwqsxqwxrCa0l
	 aJiCMlAcmuCIZpyGNB/U44ieRkzujwihSit2t+BG033Wb1qMNHPYi9697p93/VkEg4XJk
	 guTSggZ+9XxNudOwWEnmgcyZ0bzOHwS3gLbZQxHY3TY0zSqdJKuX4gKgGEpidoXPFVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821784;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0XXjFRsPQjw1veYWZlTtE7bEFgiQwU4Uv9sDqEWorag=;
	b=3k07zD28HDq8du1QR0wm8DioHAbPvkGkABToWkuyxfsEnR1Cc69Ms7VC2d2bhNMeFz1J
	 Ji8nKRxm4gV4H1n13R6iwhh6tmDIsJaiAoZuS4COcQzzNyi56VJt00BWGmynHXl/0XB7M
	 qF3SfmNovwT/smB6B682Jm26zTrOehXLSL1AAwntbBsnGfdmGRt4BIY/SQROwSJ9Jlcju
	 tOdMMYPJ5czjDQ/FZK6LBNp7TdHmJFkcIbIWzK3P7f+OOdkipRwhL5TBBBEmdLN7wKNBf
	 Q3Y4QUM+DzfG1JmZrUVwieO7lBxH0za4J3b3eXl8oQwJbl8tUCHEN6e623Dd6JeXpGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hi0jcKWb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25F606A331;
	Mon, 16 Nov 2026 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hi0jcKWb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4197A1F000C5;
	Mon, 16 Nov 2026 09:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794821784;
	bh=0XXjFRsPQjw1veYWZlTtE7bEFgiQwU4Uv9sDqEWorag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hi0jcKWbmoU1si1eoejLnoOj/kj/w2u5BgZXIPMNplHhja94R4BFVESt0NGGpvOjK
	 GtxHHgUQjAPVysz/W6xkuxXBNY4Q1MO+Y//VhCr/0uwVVXkQXFXkPwkVKocm/vrR9A
	 RWCSbMCIhKsdtERwfCF8HNbjSloqBVyeKtJ+s0/Vn2tbab6VUTyKzsvIjlDrfaGUnh
	 VhuZZRSISN0sp/8VjgqRFk7B6sh83BX642cZqlTgQZxQXVRSj0CwJc6Y6R81pejXv1
	 QkH4CdaDSAEeKur/weaeMX6f3j4ZHn49kiMeNsTWJ0hLqTM6ZsWXCdBehMOWXfu79v
	 /ijDPMWViNqKA==
From: Joshua Crofts <crofts@kernel.org>
Date: Mon, 16 Nov 2026 10:36:09 +0100
Subject: [PATCH v2 1/2] PM: runtime: add additional suspend/resume metrics
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
Message-Id: <20261116-pm-runtime-summary-v2-1-a3d8654baf8f@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794821782; l=6211;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=ksdzRkG5Pd7dfOGTL6XNU+OFyqfuRCF81MZhJoi+zsA=;
 b=vZc+j7S0HhM4NMW+TuiL01I18ZjvwbA5DgSO1HDipriy9GRcXr/UseBOaO2Mm3Kb3BPjQwGWx
 2OYP0nZNwdRDQeuoxuFQ+2tu/kqePsbMuoBvVB9VcBIiIMUBOrWbr30
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
 drivers/base/power/runtime.c | 76 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/pm.h           | 12 +++++++
 2 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 304a2b12342082ffacce32aa9c2e863466b0d4ae..3085318e9c32fce892def5a901aae300f473ea2d 100644
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
@@ -103,11 +105,58 @@ static void update_pm_runtime_accounting(struct device *dev)
 		dev->power.active_time += delta;
 }
 
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
+
 static void __update_runtime_status(struct device *dev, enum rpm_status status)
 {
+	enum rpm_status old_status = dev->power.runtime_status;
+
 	update_pm_runtime_accounting(dev);
 	trace_rpm_status(dev, status);
 	dev->power.runtime_status = status;
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
 }
 
 static u64 rpm_get_accounted_time(struct device *dev, bool suspended)
@@ -1571,6 +1620,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_disable);
 void pm_runtime_enable(struct device *dev)
 {
 	unsigned long flags;
+	u64 now;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
@@ -1587,12 +1637,21 @@ void pm_runtime_enable(struct device *dev)
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
+		if (dev->power.suspend_time && dev->power.accounting_timestamp
+		    && now > dev->power.accounting_timestamp)
+			dev->power.suspend_time += now - dev->power.accounting_timestamp;
+		else
+			dev->power.suspend_time = now;
+
+		if (!dev->power.ignore_children &&
+		    atomic_read(&dev->power.child_count) > 0)
+			dev_warn(dev, "Enabling runtime PM for inactive device with active children\n");
+	}
+
+	dev->power.accounting_timestamp = now;
 
 out:
 	spin_unlock_irqrestore(&dev->power.lock, flags);
@@ -1861,6 +1920,13 @@ void pm_runtime_init(struct device *dev)
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

