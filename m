Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DF45D916
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994108; cv=none; b=C6fI2BZXtyhvEJtRmA8jqqmreCLbdBYazlSoI2+dI8DOVZYQ2W/lBnoJQZJfkyEqsz7cPADTFCU5R2+hKbp7CK7O6iVWh7mgd/U7hoxkP8TQeuq5LySp0vHsY/vI2r7F9UuSdIQHKZbI523CJ3BWmjXOHTOcSWjIfk821tgQo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994108; c=relaxed/simple;
	bh=UaTP3cWHEqPR1qCZPKGgFnJo64FYOR3B0JkSwc/TFdQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V+CbBn09kRxQNciALT7Or69zzQhC2wg6Mbx2tcqYmbTvEizYtbv+9/ZalPTSD1LXK82wKASslh3go1/gskFuR27zG//YSmrAxjFYASyErB1npYrbWF2jOj+Cp2sK5MItR2tkKfdPwrKH1F1spVmpiGprlT89hB+YTCEGIOjePt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdEXCHf1; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdEXCHf1"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so5412581a91.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788994100; x=1789598900; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UdIQWh93komvxnsnnPp25GJniHOVDvlbRHRdTzF4xOo=;
        b=fdEXCHf1npz2W/zwMJCmaB6ZyNCCO4z+HnOOwWppLW+XzTjGGfsC7cj/Yc/ly0oixM
         7YIOQ3UwZrasBMl50jFXKFrJQa1izJpiiQXfHXRxpxezlBvhY3DplRcutoZqjt91pXF2
         65KpH1U39DGRwU30/hCg/cRDz/RBpJFhv3jg9SxA6G5adMwEmkTjSNekJNPH7KNwBbZj
         w0LZTVoh9Z3bArHHLcm/wfow+CKHBLQkg+LT80mYvo+muqoF9KHCvi6LsDkH6pEHifo+
         rbySSKoVgNMkJwprZGFqJlA9botgKbSkPxLUbW30Q+roOnxzGCoCH8N7iYQxpsTgIIK1
         b1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788994100; x=1789598900;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UdIQWh93komvxnsnnPp25GJniHOVDvlbRHRdTzF4xOo=;
        b=rrN4tUwhQnyCUWLG3rlBDHo817RiLa23Da4VgJQOrQKBR7PTNXKNkRe+h/4EZ2jmv7
         hG3akiPTMm0ePPozGU8O3EUMyvePVp75u0lGd/9/zfZt9NAkUNzTaUXgJFTPoKVWTmR/
         efQ8Bfq9U3ecv11iUnqIqmp7gub5mbk2RakNGta3nQ+1O78ghKIjgKGnCVnqhkagU7R0
         xXh2A3asGNldn2nqXXafiXP7e0tqKF4Fb04n13T8guL6pAwB6YCdH6klPJRbjE+fNZgf
         r9dazKZnyKKX7wnw2yVmHa3LSNMv2COqckCCqw27Q+//UJEA5Z06sSqQalGazB+rdi7i
         L3vQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkEBJiiZU8lVupMN7CpvQc7RJCcAjSxBZP/Oe4zv5U7JJ6RZiqRCSp14redU5U4xL8cz+rtnNO7g==@vger.kernel.org
X-Gm-Message-State: AFuF++nBq1p8rjnaWDZYW1ih+T0F3wW6TE6mUedG5+uoevnrC6zbD1At
	RaPgo6L/l40uBdLW3Q9Ek9mIzXZwp7KO/kAmcoRvb180cIxsYr/a/Ty+vnN7BlWiQeHMnowiKhh
	50unLxeIGUw==
X-Received: from dlbbu10.prod.google.com ([2002:a05:7022:220a:b0:142:d53e:16e1])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5344:b0:38e:4f41:83df
 with SMTP id 98e67ed59e1d1-39b261e0f14mr56399683a91.15.1788994100079; Wed, 09
 Sep 2026 15:48:20 -0700 (PDT)
Date: Wed,  9 Sep 2026 15:48:18 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909224818.2177311-1-mrungta@google.com>
Subject: [PATCH v2] PM: sleep: Add DPM watchdog to prepare/late/early/noirq/complete
 phases
From: Mayank Rungta <mrungta@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Mayank Rungta <mrungta@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend the DPM watchdog to wrap device_prepare, device_suspend_late,
device_suspend_noirq, device_resume_noirq, device_resume_early, and
device_complete callbacks. If a driver hangs during these transitions,
the watchdog will fire and dump a stack trace to help identify the
offending driver.

To prevent false-positive timeouts, the watchdog is set only after
waiting for subordinate (during suspend) and superior (during resume)
devices. With this change, DPM watchdog coverage is extended across all
phases of system sleep transitions.

Signed-off-by: Mayank Rungta <mrungta@google.com>
---
v2:
 - Extend DPM watchdog to device_prepare and device_complete callbacks.
 - Update commit subject and description to reflect coverage across all
   system sleep phases.
v1:
 - Initial version adding DPM watchdog to late/early/noirq phases.

Testing:
 - Tested on an ARM64 SoC (Pixel platform running a 6.18-based kernel with
   DPM watchdog enabled; Android 6.18 kernel has latest DPM changes
   backported).
 - Verified hang simulation in device_prepare and device_complete
   triggers DPM watchdog panic and stack trace as expected.

 drivers/base/power/main.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 184dc4b3b938..5e3e40312f71 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -802,6 +802,7 @@ static void device_resume_noirq(struct device *dev, pm_message_t state, bool asy
 	const char *info = NULL;
 	bool skip_resume;
 	int error = 0;
+	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
@@ -827,6 +828,7 @@ static void device_resume_noirq(struct device *dev, pm_message_t state, bool asy
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;
 
+	dpm_watchdog_set(&wd, dev);
 	skip_resume = dev_pm_skip_resume(dev);
 	/*
 	 * If the driver callback is skipped below or by the middle layer
@@ -871,6 +873,7 @@ static void device_resume_noirq(struct device *dev, pm_message_t state, bool asy
 	error = dpm_run_callback(callback, dev, state, info);
 
 Skip:
+	dpm_watchdog_clear(&wd);
 	dev->power.is_noirq_suspended = false;
 
 Out:
@@ -971,6 +974,7 @@ static void device_resume_early(struct device *dev, pm_message_t state, bool asy
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
 	int error = 0;
+	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
@@ -987,6 +991,7 @@ static void device_resume_early(struct device *dev, pm_message_t state, bool asy
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;
 
+	dpm_watchdog_set(&wd, dev);
 	if (dev->pm_domain) {
 		info = "early power domain ";
 		callback = pm_late_early_op(&dev->pm_domain->ops, state);
@@ -1004,7 +1009,7 @@ static void device_resume_early(struct device *dev, pm_message_t state, bool asy
 		goto Run;
 
 	if (dev_pm_skip_resume(dev))
-		goto Skip;
+		goto End;
 
 	if (dev->driver && dev->driver->pm) {
 		info = "early driver ";
@@ -1014,6 +1019,9 @@ static void device_resume_early(struct device *dev, pm_message_t state, bool asy
 Run:
 	error = dpm_run_callback(callback, dev, state, info);
 
+End:
+	dpm_watchdog_clear(&wd);
+
 Skip:
 	dev->power.is_late_suspended = false;
 	pm_runtime_enable(dev);
@@ -1281,10 +1289,12 @@ static void device_complete(struct device *dev, pm_message_t state)
 {
 	void (*callback)(struct device *) = NULL;
 	const char *info = NULL;
+	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
 	if (dev->power.syscore)
 		goto out;
 
+	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 
 	if (dev->pm_domain) {
@@ -1312,6 +1322,7 @@ static void device_complete(struct device *dev, pm_message_t state)
 	}
 
 	device_unlock(dev);
+	dpm_watchdog_clear(&wd);
 
 out:
 	/* If enabling runtime PM for the device is blocked, unblock it. */
@@ -1508,6 +1519,7 @@ static void device_suspend_noirq(struct device *dev, pm_message_t state, bool as
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
 	int error = 0;
+	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
@@ -1520,6 +1532,7 @@ static void device_suspend_noirq(struct device *dev, pm_message_t state, bool as
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
+	dpm_watchdog_set(&wd, dev);
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
 		callback = pm_noirq_op(&dev->pm_domain->ops, state);
@@ -1550,7 +1563,7 @@ static void device_suspend_noirq(struct device *dev, pm_message_t state, bool as
 		WRITE_ONCE(async_error, error);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
-		goto Complete;
+		goto End;
 	}
 
 Skip:
@@ -1569,6 +1582,9 @@ static void device_suspend_noirq(struct device *dev, pm_message_t state, bool as
 	if (dev->power.must_resume)
 		dpm_superior_set_must_resume(dev);
 
+End:
+	dpm_watchdog_clear(&wd);
+
 Complete:
 	complete_all(&dev->power.completion);
 	TRACE_SUSPEND(error);
@@ -1703,6 +1719,7 @@ static void device_suspend_late(struct device *dev, pm_message_t state, bool asy
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
 	int error = 0;
+	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
@@ -1720,6 +1737,8 @@ static void device_suspend_late(struct device *dev, pm_message_t state, bool asy
 	if (dev->power.direct_complete)
 		goto Complete;
 
+	dpm_watchdog_set(&wd, dev);
+
 	/*
 	 * After this point, any runtime PM operations targeting the device
 	 * will fail until the corresponding pm_runtime_enable() call in
@@ -1761,13 +1780,16 @@ static void device_suspend_late(struct device *dev, pm_message_t state, bool asy
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async late" : " late", error);
 		pm_runtime_enable(dev);
-		goto Complete;
+		goto End;
 	}
 	dpm_propagate_wakeup_to_parent(dev);
 
 Skip:
 	dev->power.is_late_suspended = true;
 
+End:
+	dpm_watchdog_clear(&wd);
+
 Complete:
 	TRACE_SUSPEND(error);
 	complete_all(&dev->power.completion);
@@ -2201,6 +2223,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	int (*callback)(struct device *) = NULL;
 	bool smart_suspend;
 	int ret = 0;
+	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
 	/*
 	 * If a device's parent goes into runtime suspend at the wrong time,
@@ -2220,6 +2243,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	if (dev->power.syscore)
 		return 0;
 
+	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 
 	dev->power.wakeup_path = false;
@@ -2245,6 +2269,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 
 unlock:
 	device_unlock(dev);
+	dpm_watchdog_clear(&wd);
 
 	if (ret < 0) {
 		suspend_report_result(dev, callback, ret);
-- 
2.55.0.1003.g10538fe699-goog

