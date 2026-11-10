Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307429;
	b=dh0p9zrIgvqMe7sSaAYlYkuHuZXkg6Lj6jL3jT0qLCbfJ+YKUqfsLghb6PkhuotXP9ty
	 /BaN5gOzTK0uvOBJcLTYwkbHoO+m1WLphBfnOP66jP7KbCb1I0aPzxnQEkfci366jPGWX
	 WL/XFq7DFxGpcnhbf6o8HMhcLhGZj8zDPzGaZHF2zO6ICC4kUCSJ1LVLtsCBs8ZvRzsoT
	 J53Y9vPQBiSLaf7Vh5vVLsmz7qjVzNnFKPFLsIR/NKzjrv97t0ILSyMynjfda4TeQx+bW
	 ZNz+cgmkEV1bB4vLFUFgFSRxxAkJIGMhy+mpodzdVFZWDdlnN6UVnhmHzaUPxRNVBug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307429;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=96zDt25X7pEZ6lyb4alyrDNvlrcMXW3AEDqJyug2Kyo=;
	b=NpldGRELGEVjimmi87wd/1h3AxzohvlphEAFEpEy7AqvUPbYj+TR70YzTiA8sG6JJ0E7
	 /AdKN1g652EiMpUT9TVRylHerZIOLnM9KeA2pYpHF2URyNMpQc/JOELKzLr1N01Oh0MK4
	 LJkUV0AZ4FwZKeEzDkZjCQd104nwFsR0x2p1q2wqdxtKgHkrCYmlH2EeAfCgRXe9bvqIg
	 6+nT9c4oZh8JTOSavm4kbv1YjzUnK4pSIGXRjyL+CU5YmNIWPSTzGxTxq3e+FjcFOBv9t
	 73jUPuPFzXYtZTwcqjsahzqsKOm/z8pq5Ro1GASUFwIdtbTZRc8GYtH1UKwz4DCAXxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKaVTh04;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D155606A336;
	Tue, 10 Nov 2026 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKaVTh04
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3EE1F008BD;
	Tue, 10 Nov 2026 10:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307428;
	bh=96zDt25X7pEZ6lyb4alyrDNvlrcMXW3AEDqJyug2Kyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dKaVTh04M7lJ3DxV9oNAFQNW+haiZqPoAO0JPjwp8VTe+T6hG4zw7WXBSUmhnW/lx
	 TvZcoLwN2JXWX89n2PDwQkHO0b42+8aosVOcus4vbS5jhRaQwok4sg4KJTKuDhIHl1
	 V1cCQnayXK9scO5VJgRZwmEbCR48LDsHaBc4Jg7JXVb24e0dS8gZP3QnDistoNgSVt
	 /jHBbYaMuTGZc9ALa/wZQcy7QVhb+xNuWlqu0eBWPNR7arenIdECGgZX3RTGm+4Gc+
	 aKCQPD/y0q18yxl7o+1FQb31ewb4Sfwy54P10oLL0xfH1Lp8GN7Nv8YxO/4e+z6Il8
	 Akz8cVae7x9mg==
From: Joshua Crofts <crofts@kernel.org>
Date: Tue, 10 Nov 2026 11:43:21 +0100
Subject: [PATCH 2/3] PM: add sysfs attributes for additional suspend/resume
 metrics
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
Message-Id: <20261110-pm-runtime-summary-v1-2-12ebf283db78@kernel.org>
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
In-Reply-To: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>, 
 Dominik Brodowski <linux@dominikbrodowski.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794307420; l=5324;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=LPZDrc1NEnJlFXkTji3fr+6a3lAW2qpmdUc5MW/VW5M=;
 b=9tfVu7pIpIK4ULg4KyQO1B/730OBpp4rckHKb0ze414eaNIPf4PaMOXF411drRFxvGHV+++Se
 DdfROvi7fVKDQBtYTpIEErJ8anVng0wt0Q1m0RN7PJMvX8TECYz9w+Q
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=

Add sysfs entries for additional suspend/resume statistics. These are
useful for investigating the behaviour of devices with PM runtime
enabled.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 Documentation/ABI/testing/sysfs-devices-power | 36 ++++++++++++
 drivers/base/power/sysfs.c                    | 81 +++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 9bf7c8a267c58703a8a097ada1f12271271dbe98..03e5783d737120f98a1c88e5e53f56fe176484e5 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -284,6 +284,42 @@ Description:
 		Reports total time that the device has been suspended, in
 		milliseconds. Used for runtime PM statistics.
 
+What:           /sys/devices/.../power/runtime_resume_count
+Date:           Nov 2026
+Contact:        Joshua Crofts <crofts@kernel.org>
+Description:
+                Reports the total number of times the device entered a resume
+                state.
+
+What:           /sys/devices/.../power/runtime_suspend_count
+Date:           Nov 2026
+Contact:        Joshua Crofts <crofts@kernel.org>
+Description:
+                Reports the total number of times the device entered a suspended
+                state.
+
+What:           /sys/devices/.../power/runtime_last_suspended_time
+Date:           Nov 2026
+Contact:        Joshua Crofts <crofts@kernel.org>
+Description:
+                Reports the residency duration of the most recent suspended
+                state, in milliseconds.
+
+What:           /sys/devices/.../power/runtime_min_suspended_time
+Date:           Nov 2026
+Contact:        Joshua Crofts <crofts@kernel.org>
+Description:
+                Reports the shortest measured duration the device spent in
+                suspended mode, in milliseconds.
+
+What:           /sys/devices/.../power/runtime_max_suspended_time
+Date:           Nov 2026
+Contact:        Joshua Crofts <crofts@kernel.org>
+Description:
+                Reports the longest measured duration the device spent in
+                suspended mode, in milliseconds.
+
+
 What:		/sys/devices/.../power/runtime_usage
 Date:		Apr 2010
 Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 13b31a3adc77c0fe0a5c42fcf9b863dd5bc43088..7e5a186b33222d448b5caacaddbaf9913fe41a98 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -178,6 +178,82 @@ static ssize_t runtime_status_show(struct device *dev,
 
 static DEVICE_ATTR_RO(runtime_status);
 
+static ssize_t runtime_resume_count_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	u64 count;
+
+	spin_lock_irq(&dev->power.lock);
+	count = dev->power.resume_count;
+	spin_unlock_irq(&dev->power.lock);
+
+	return sysfs_emit(buf, "%llu\n", count);
+}
+static DEVICE_ATTR_RO(runtime_resume_count);
+
+static ssize_t runtime_suspend_count_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	u64 count;
+
+	spin_lock_irq(&dev->power.lock);
+	count = dev->power.suspend_count;
+	spin_unlock_irq(&dev->power.lock);
+
+	return sysfs_emit(buf, "%llu\n", count);
+}
+static DEVICE_ATTR_RO(runtime_suspend_count);
+
+static ssize_t runtime_last_suspended_time_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	u64 tmp;
+
+	spin_lock_irq(&dev->power.lock);
+	tmp = dev->power.last_suspended_time;
+	spin_unlock_irq(&dev->power.lock);
+
+	do_div(tmp, NSEC_PER_MSEC);
+
+	return sysfs_emit(buf, "%llu\n", tmp);
+}
+static DEVICE_ATTR_RO(runtime_last_suspended_time);
+
+static ssize_t runtime_min_suspended_time_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	u64 tmp;
+
+	spin_lock_irq(&dev->power.lock);
+	tmp = dev->power.min_suspended_time;
+	spin_unlock_irq(&dev->power.lock);
+
+	do_div(tmp, NSEC_PER_MSEC);
+
+	return sysfs_emit(buf, "%llu\n", tmp);
+}
+static DEVICE_ATTR_RO(runtime_min_suspended_time);
+
+static ssize_t runtime_max_suspended_time_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	u64 tmp;
+
+	spin_lock_irq(&dev->power.lock);
+	tmp = dev->power.max_suspended_time;
+	spin_unlock_irq(&dev->power.lock);
+
+	do_div(tmp, NSEC_PER_MSEC);
+
+	return sysfs_emit(buf, "%llu\n", tmp);
+}
+static DEVICE_ATTR_RO(runtime_max_suspended_time);
+
 static ssize_t autosuspend_delay_ms_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -649,6 +725,11 @@ static struct attribute *runtime_attrs[] = {
 	&dev_attr_runtime_suspended_time.attr,
 	&dev_attr_runtime_active_time.attr,
 	&dev_attr_autosuspend_delay_ms.attr,
+	&dev_attr_runtime_resume_count.attr,
+	&dev_attr_runtime_suspend_count.attr,
+	&dev_attr_runtime_last_suspended_time.attr,
+	&dev_attr_runtime_min_suspended_time.attr,
+	&dev_attr_runtime_max_suspended_time.attr,
 #ifdef CONFIG_PM_ADVANCED_DEBUG
 	&dev_attr_runtime_usage.attr,
 	&dev_attr_runtime_active_kids.attr,

-- 
2.47.3

