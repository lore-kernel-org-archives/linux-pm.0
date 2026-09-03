Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C291D63F3;
	Thu,  3 Sep 2026 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401764; cv=none; b=ioSwo9PArAJ6qcS2p+tio8UewAZ/xCevEDuQb7KSTvboTqgHbyhGrPqKl9tOtkghpF8jMyXfGRFIpxz3qpGYw0J4WcRkQCBLxGe7YZeJxUpQyAAtnlikcaraqquyir5CP2QtrMvHEdeo+X7nxeMnRfHs5E3nf5IIvYH3qTZnHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401764; c=relaxed/simple;
	bh=xjvhQV7JgSAHkuf8f39ZXls4swNavrnogBN4k1AH/I0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ry3QhMkDpH0p5DyuXWz26plix7xdCNjnMW8Fv88vDYSuPzzOPkf+DwxXPBwt4T0JhgQ8ZpQnwVIe0aEjHDg4QVTQxzWAkawbk0/AuJn18+hBzv91B8OX/bYMySSiE6UyK+MT1z1e+g0XkldBd78N/MKnA/aOA5Z+E+Jtxy0cDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fWRnLZ6e; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fWRnLZ6e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788401730;
	bh=a9hMr+L6f3/B1Vj5w6E1NGhMLLBJcOGtJdWdCHblVoA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=fWRnLZ6eO2OqDZAAPsOkyinsw/Z4w6TokO+B1z+EMFPfy/MddAvMgOIiXGZN0xhZg
	 ntRUGMl9m2LwgUKQfbsyt4wEqU8OObwtQ4SOXRqTCDmaJmEheH2J04U/fsWBkmMdjc
	 1rY8wsU6UiPhxhrI+pNIW3oM39UDrlBumPLKHGXs=
X-QQ-mid: esmtpgz16t1788401720t8f68330f
X-QQ-Originating-IP: k5mkv1xJVZdiidrCRPCo3sxvOTrtGtZNdWaCF/38Uw0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 10:15:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12543063456713375474
EX-QQ-RecipientCnt: 15
From: Haowen Tu <tuhaowen@uniontech.com>
To: rafael@kernel.org,
	laurent.pinchart@ideasonboard.com
Cc: tuhaowen@uniontech.com,
	gregkh@linuxfoundation.org,
	hansg@kernel.org,
	huangbibo@uniontech.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	oneukum@suse.com,
	pavel@kernel.org,
	stern@rowland.harvard.edu
Subject: [PATCH v5 3/4] PM: hibernate: allow devices to skip post-snapshot THAW
Date: Thu,  3 Sep 2026 10:14:58 +0800
Message-Id: <5cbc30863de487f42bcd395ec2d7d738d05189bb.1788399733.git.tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1788399733.git.tuhaowen@uniontech.com>
References: <20260730153817.GA1555869@killaraus.ideasonboard.com> <cover.1788399733.git.tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OTZ0n2XxY8CFa4FT7armm0Xr9RzV+/3aote/cFzTtEEVPv7FUQEeilY6
	8x9404e97RpQ6if14zBgwSvM/csa64iI6NHNkm3rNYTLKSy4IM3V4J5v5twGxiwKvn7FPY8
	S+Cw0PW4Xa88e3JIaw8Ani9ypwcdtFRy9sWBreZITR1tks9IFWj1LuVpEoSEXAmtWjIeEz5
	p2pb9y9r0TkqrPiUm2E/n+tk/2H8o4gT6N0h8YAQo16VGTSKibr3L0ykAsZITSV6rO+AyUI
	REeam5+ahqA9hgTvB9W1VIxdoKtjX5Z1DAYJbzJN1UKEk4CD5kg58D1jgcIcP/b7C0Ut5Do
	GSybWczhAQpCWt01tQbtQcSHfnTRhV4Hxw6H63CeXlrq4F/ArK+TWoE/sl90EBxdur6REZF
	48hBXuH631iHQKV/3CQ063E3CXnVLuHtEm+CbvuqFaCsk/Nqb3U9LV8Z1muFWZwyblPiAYD
	dKPLpdUkI7y3GKF8atHZKVpYohajj8szMMxhzgL3GohDXPjAC/KD5kLUy+lnt+BseNLJ1SF
	vhP7pF+/yYeK+o/W6xAMj7xJ8IaVz6sEkDO6dSSlKYBNxdL5n48ZE6/z1XLW4yavrJG1hI4
	2IN6EpZWjHIhK5Vwxa8IHZDQoZ0Ppis7FwSOtsO5OvJwefUu32ffA4f/F4meEhVQCglxQqo
	WtkeTtQeNy7t6s4LZA0YBvlUwVhYIlztLdtZ6xlTORZT44PlI+KHLtMjZ4SzB/F3Z10oWLF
	BrsafPkvmvta08nIaH3j4GB3H3j5QF+TV+nvlwHibD1vF0Kh87pW2qHTUBD+o0TanLFG/qO
	hLG735sWWegHehtpjbLlDJFJZQxGNQA0G84jrPrcCCpFUFrVjdkkcqznND/XPkwewUy+BRi
	ZIO3ZrGbM+HCbA6LV1fbYWgJjSASGrkQDvRR/ATRCbJvexysGixpWnFg6ADPf9Fs5tWsyy5
	TgmpfTL1auB8PoH5wnv5O7MLC9qhyPTl43vEgoT8WJx+Vm68VGs+2Qz+gR2s1CM7RZmKbL0
	rTdopAAWGxOH6cOByaWgssgCNKJZcpKmAwMbYfubFTzvHhZEzfUIMNoUvftD9YNq51s8cSM
	N64Zgic3LnM7krYVZqTDV6xLBDT7vSw0iFdtFYjTzQGX+PIuY8l9Ag=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

After a hibernation snapshot has been created, the PM core resumes
devices with PMSG_THAW so that the image can be written out.  Some
devices are not involved in image writeout and do not need to be resumed
during that transient phase.

Add DPM_FLAG_SKIP_HIBERNATION_THAW to let drivers opt a device out of the
post-snapshot THAW resume.  Skipped devices remain suspended while the
image is written.  If the original kernel continues running instead of
powering down, resume the skipped devices before userspace is thawed.

The skip is limited to the original kernel's post-snapshot THAW path by
checking pm_hibernation_snapshot_done().  Other THAW paths, including
recovery from failed image restore in the restore kernel, continue to
resume devices normally.

Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
---
 Documentation/driver-api/pm/devices.rst | 17 +++++++
 drivers/base/power/main.c               | 65 +++++++++++++++++++++++++
 include/linux/pm.h                      |  4 ++
 kernel/power/hibernate.c                | 14 +++++-
 4 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
index 36d5c9c9fd11..c2933931ca33 100644
--- a/Documentation/driver-api/pm/devices.rst
+++ b/Documentation/driver-api/pm/devices.rst
@@ -878,3 +878,20 @@ callback back-to-back with its "late" and "noirq" suspend ones.  [For instance,
 that is not a concern if the driver sets both ``DPM_FLAG_SMART_SUSPEND`` and
 ``DPM_FLAG_MAY_SKIP_RESUME`` and uses the same pair of suspend/resume callback
 functions for runtime PM and system-wide suspend/resume.]
+
+
+The ``DPM_FLAG_SKIP_HIBERNATION_THAW`` Driver Flag
+--------------------------------------------------
+
+During hibernation, the PM core resumes devices with ``PMSG_THAW`` after the
+hibernation snapshot has been created so that the image can be written out.
+Some devices do not need to be resumed during that image-write phase.
+
+Drivers for such devices can set ``DPM_FLAG_SKIP_HIBERNATION_THAW`` to allow
+the PM core to leave the device suspended during the post-snapshot ``THAW``.
+If the original kernel continues running instead of powering down, the PM core
+will resume the skipped devices before userspace is thawed.
+
+Drivers must only set this flag for devices that are not needed for writing the
+hibernation image and can remain suspended until the system either powers off or
+the original kernel continues running.
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e1b550664bab..e68b97608eb2 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -55,11 +55,13 @@ typedef int (*pm_callback_t)(struct device *);
 LIST_HEAD(dpm_list);
 static LIST_HEAD(dpm_prepared_list);
 static LIST_HEAD(dpm_suspended_list);
+static LIST_HEAD(dpm_hibernation_skipped_list);
 static LIST_HEAD(dpm_late_early_list);
 static LIST_HEAD(dpm_noirq_list);
 
 static DEFINE_MUTEX(dpm_list_mtx);
 static pm_message_t pm_transition;
+static bool dpm_in_hibernation_thaw;
 
 static DEFINE_MUTEX(async_wip_mtx);
 static int async_error;
@@ -1033,6 +1035,20 @@ EXPORT_SYMBOL_GPL(dpm_resume_start);
 
 static void async_resume(void *data, async_cookie_t cookie);
 
+static bool dpm_skip_hibernation_thaw(struct device *dev, pm_message_t state)
+{
+	if (!dpm_in_hibernation_thaw || state.event != PM_EVENT_THAW ||
+	    !pm_hibernation_snapshot_done())
+		return false;
+
+	return dev_pm_test_driver_flags(dev, DPM_FLAG_SKIP_HIBERNATION_THAW);
+}
+
+static void dpm_set_hibernation_thaw(bool enable)
+{
+	dpm_in_hibernation_thaw = enable;
+}
+
 /**
  * device_resume - Execute "resume" callbacks for given device.
  * @dev: Device to handle.
@@ -1141,7 +1157,11 @@ static void async_resume(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
 
+	if (dpm_skip_hibernation_thaw(dev, pm_transition))
+		goto out;
+
 	device_resume(dev, pm_transition, true);
+out:
 	put_device(dev);
 }
 
@@ -1170,12 +1190,22 @@ void dpm_resume(pm_message_t state)
 	 */
 	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
 		dpm_clear_async_state(dev);
+		if (dpm_skip_hibernation_thaw(dev, state))
+			continue;
+
 		if (dpm_root_device(dev))
 			dpm_async_with_cleanup(dev, async_resume);
 	}
 
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
+		if (dpm_skip_hibernation_thaw(dev, state)) {
+			list_move_tail(&dev->power.entry,
+				       &dpm_hibernation_skipped_list);
+			complete_all(&dev->power.completion);
+			continue;
+		}
+
 		list_move_tail(&dev->power.entry, &dpm_prepared_list);
 
 		if (!dpm_async_fn(dev, async_resume)) {
@@ -1201,6 +1231,41 @@ void dpm_resume(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
 }
 
+/**
+ * dpm_resume_hibernation_thaw - Execute the post-snapshot THAW callbacks.
+ *
+ * Execute THAW callbacks for devices required during hibernation image writeout.
+ * Devices with DPM_FLAG_SKIP_HIBERNATION_THAW set are left suspended.
+ */
+void dpm_resume_hibernation_thaw(void)
+{
+	dpm_set_hibernation_thaw(true);
+	dpm_resume(PMSG_THAW);
+	dpm_set_hibernation_thaw(false);
+}
+
+/**
+ * dpm_resume_skipped_hibernation_devices - Resume devices skipped in THAW.
+ *
+ * Resume devices whose post-snapshot THAW callbacks were skipped because they
+ * are not required during hibernation image writeout.
+ */
+void dpm_resume_skipped_hibernation_devices(void)
+{
+	mutex_lock(&dpm_list_mtx);
+	if (list_empty(&dpm_hibernation_skipped_list)) {
+		mutex_unlock(&dpm_list_mtx);
+		return;
+	}
+
+	list_splice_tail_init(&dpm_hibernation_skipped_list,
+			      &dpm_suspended_list);
+	mutex_unlock(&dpm_list_mtx);
+
+	dpm_resume(PMSG_THAW);
+	dpm_complete(PMSG_THAW);
+}
+
 /**
  * device_complete - Complete a PM transition for given device.
  * @dev: Device to handle.
diff --git a/include/linux/pm.h b/include/linux/pm.h
index afcaaa37a812..3d7f52c63f7e 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -655,6 +655,7 @@ struct pm_subsys_data {
  * SMART_PREPARE: Take the driver ->prepare callback return value into account.
  * SMART_SUSPEND: Avoid resuming the device from runtime suspend.
  * MAY_SKIP_RESUME: Allow driver "noirq" and "early" callbacks to be skipped.
+ * SKIP_HIBERNATION_THAW: Do not resume the device during post-snapshot THAW.
  *
  * See Documentation/driver-api/pm/devices.rst for details.
  */
@@ -662,6 +663,7 @@ struct pm_subsys_data {
 #define DPM_FLAG_SMART_PREPARE		BIT(1)
 #define DPM_FLAG_SMART_SUSPEND		BIT(2)
 #define DPM_FLAG_MAY_SKIP_RESUME	BIT(3)
+#define DPM_FLAG_SKIP_HIBERNATION_THAW	BIT(4)
 
 struct dev_pm_info {
 	pm_message_t		power_state;
@@ -819,6 +821,8 @@ extern void dpm_resume_end(pm_message_t state);
 extern void dpm_resume_noirq(pm_message_t state);
 extern void dpm_resume_early(pm_message_t state);
 extern void dpm_resume(pm_message_t state);
+void dpm_resume_hibernation_thaw(void);
+void dpm_resume_skipped_hibernation_devices(void);
 extern void dpm_complete(pm_message_t state);
 
 extern void device_pm_unlock(void);
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 045d29f55011..da3ce0382f6d 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -496,7 +496,10 @@ int hibernation_snapshot(int platform_mode)
 	}
 
 	msg = snapshot_done ? (error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE;
-	dpm_resume(msg);
+	if (msg.event == PM_EVENT_THAW)
+		dpm_resume_hibernation_thaw();
+	else
+		dpm_resume(msg);
 
 	if (error || !snapshot_done)
 		pm_restore_gfp_mask();
@@ -804,6 +807,7 @@ static int load_image_and_restore(void)
 int hibernate(void)
 {
 	bool snapshot_test = false;
+	bool resume_skipped = false;
 	unsigned int sleep_flags;
 	int error;
 
@@ -883,11 +887,14 @@ int hibernate(void)
 		error = swsusp_write(flags);
 		in_suspend = 0;
 		swsusp_free();
-		if (!error) {
+		if (error) {
+			resume_skipped = true;
+		} else {
 			if (hibernation_mode == HIBERNATION_TEST_RESUME)
 				snapshot_test = true;
 			else
 				power_down();
+			resume_skipped = true;
 		}
 		pm_restore_gfp_mask();
 	} else {
@@ -903,7 +910,10 @@ int hibernate(void)
 		error = swsusp_check(false);
 		if (!error)
 			error = load_image_and_restore();
+		resume_skipped = true;
 	}
+	if (resume_skipped)
+		dpm_resume_skipped_hibernation_devices();
 	thaw_processes();
 
 	/* Don't bother checking whether freezer_test_done is true */
-- 
2.20.1
