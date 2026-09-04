Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2153F660F
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556823; cv=none; b=MYLQL6mFFrrZT5gnUFBwHEmYONt5Zz5ea+ND0XYztvagIfvuzkZRQDyHpj9UbHLnNVC9152JTJKlrukev6GqdC6AOH3hfnCoqB3/WAtR948O8FF9dlVnDRNPXnaV+MSWuP92uyDgwYHiiSGbUy5LT81VWWdQ8ejRkIt5YPvf3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556823; c=relaxed/simple;
	bh=D2sTRkXI+U1SD3+QdSTnvj0X0Jbvf2TQ6H0iBo0j+84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkrtnwNm45Bpt0eRiTci2Q/Jzfc3Z8RwPXIrHNS3xGQtaZX9Zt5zTH/rTGwlIE4bU1sBcH2Rc7fE0YTLeyst09uRtz+CXMqWCRKyJuSP1/M9961uMBmh6iP6AuzOS6Qv5g6f2k2KmiDwSMrXVxEncL6fAsdPIMMgpbPQsZ7usYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dprkws3O; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dprkws3O"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2db18e5cb56so11067625ad.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788556821; x=1789161621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MrnYpRzoj88ITEj49c8hPybU6W+S4YMZn8H5haI/CBI=;
        b=Dprkws3O6i5+KoP1ChARXUAMapbP4m142So2ZGiHCMGvAscgWmDlglsIvaDNqs5N0s
         H84f0b4gclQNTPyj7OH+kcvl5fj3v1ZLbrYsHgDFl881/PUe0/37pNErMHCGco+V1Qju
         6hQjkwXhS/4xEEeR+6JCmTjzXloI6QmW7Bzuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556821; x=1789161621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MrnYpRzoj88ITEj49c8hPybU6W+S4YMZn8H5haI/CBI=;
        b=AQexMMQUeW+0ueNXdzKDD1EIta2+sv0uYz/hZu2V2BdHcm+LnZxW4aJwiEVxwXl/c1
         TT2DMIZWPsqASVVzHgY0neOIVuc62L4KRJsQhCJrm1Qw9sVZWVZDxLQjYgAqE/ui2zJe
         IEkRgH0D9xOggej0lf1tB+x+JPjIG2SXw6niar0ul//Gm2f+1/nufAXW/KXorOP0N4SQ
         JeZiy7Fv7lx8q1FaEmyLc/G+OpxXTducUtut93CapvbM26jsWxF1EUvVtjBDgvg9II55
         Cvhb1XUv7ydf+cEs5xWgKSjbDUbSfQdykti9335ACXHYStnQ2ipvzS0IzttfgkkDPJNV
         0l5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxzeGp8FmGItYXMuop3MhJIXwVgUIMY0sB1qI++Ps+5WcaZp9Ozq9yQ6p/VsERRfHgg3SgY0FOs1w==@vger.kernel.org
X-Gm-Message-State: AFuF++mmFFSuiBwELTSQf3enhDbhkomFnnvGHjZKYSTJ3ZlEQet6uXcN
	enc5waIf69eBqPmdHNBvS9M7MNt+xgIeIRuU9J0FRzOiPa0Y9q/PU5tThi2y/kIr8g==
X-Gm-Gg: AYBFou1Euuzrmk8sQJXCILZq0zK1vhDbe/v0/NSuoIZlkP4Mf7rMXj0a9SWnYeD1YAM
	ETi7nw7Fqiie5fEgf8G5ZrbXmMyTRGpA1RJg+8OODd7qT1OPyeL/77HkaVVXvsJswptTZabHwwy
	rFSP3Frx8xwtl3sFNjSkc0COtuqNgQvrjOhzXw92xytChTtK51wokD0u/P6smEuedqlFcZ7CPcN
	sJSxnjpjrZEdlRczzL4Dm41xxgHd5Txi/JgKrLI8qmJHGKRT5Zn8quIWR5w+94vGq6tc8w/kKbe
	n3dbdUuUvks+O5lLdZYll21wqmhkJDzCFnH8wq43dfnQRfQR6tBQuefAqNKdYDCK7X59YVMnu3q
	ynVpk1mEn6dYH52PYq/l6bFa9mhNc7D2rsKikVZU2EfDIjOVaMsyrmnZzInYsDyzq4NiyVui8z+
	Kq8K4Xe5pGZkAsQ5AAKsmtbaP0CKkOLyXq46WsXwe7KXx8/oX2PU0r88QY6s/rxVZn6MuQuFOUx
	MuO9sXnamy9C+wqayACgvpUe5o=
X-Received: by 2002:a17:90b:4c41:b0:398:9bd5:490e with SMTP id 98e67ed59e1d1-39b2623ac0fmr11596376a91.21.1788556820428;
        Fri, 04 Sep 2026 14:20:20 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5597:62ab:c321:4a7f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3339885d29esm9867791eec.2.2026.09.04.14.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:20:19 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 01/11] PM: runtime: kerneldoc fixes
Date: Fri,  4 Sep 2026 14:12:06 -0700
Message-ID: <20260904141215.1.Ib31d6be7e93f6c02321d03c78ea410e02d7380fc@changeid>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904212000.4167880-1-briannorris@chromium.org>
References: <20260904212000.4167880-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When included into a Documentation/.../*.rst file, `make htmldocs`
complains:

./include/linux/pm_runtime.h:359: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]
[... more ...]

We should fix up the list format here to look nicer in HTML form, and
avoid warnings. Adjust to a few other kerneldoc-isms (formatting,
"Return:") while we're at it too.

The result now passes 'make htmldocs' without warning, once these files
are included in Documentation/.../*.rst.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime.c |  24 ++-
 include/linux/pm_runtime.h   | 291 ++++++++++++++++++++---------------
 2 files changed, 183 insertions(+), 132 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index fab38bc98113..0c0931763d07 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -162,7 +162,7 @@ static void pm_runtime_cancel_pending(struct device *dev)
 	dev->power.request = RPM_REQ_NONE;
 }
 
-/*
+/**
  * pm_runtime_autosuspend_expiration - Get a device's autosuspend-delay expiration time.
  * @dev: Device to handle.
  *
@@ -200,7 +200,7 @@ static int dev_memalloc_noio(struct device *dev, void *data)
 	return dev->power.memalloc_noio;
 }
 
-/*
+/**
  * pm_runtime_set_memalloc_noio - Set a device's memalloc_noio flag.
  * @dev: Device to handle.
  * @enable: True for setting the flag and False for clearing the flag.
@@ -1043,6 +1043,11 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
  * pm_schedule_suspend - Set up a timer to submit a suspend request in future.
  * @dev: Device to suspend.
  * @delay: Time to wait before submitting a suspend request, in milliseconds.
+ *
+ * Return:
+ * * %1: Success; @dev is already %RPM_SUSPENDED.
+ * * %0: Success.
+ * * Error code on failure.
  */
 int pm_schedule_suspend(struct device *dev, unsigned int delay)
 {
@@ -1105,7 +1110,7 @@ static int rpm_drop_usage_count(struct device *dev)
  * warning, increment it, and return an error).  Then carry out an idle
  * notification, either synchronous or asynchronous.
  *
- * This routine may be called in atomic context if the RPM_ASYNC flag is set,
+ * This routine may be called in atomic context if the %RPM_ASYNC flag is set,
  * or if pm_runtime_irq_safe() has been called.
  */
 int __pm_runtime_idle(struct device *dev, int rpmflags)
@@ -1143,7 +1148,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_idle);
  * warning, increment it, and return an error).  Then carry out a suspend,
  * either synchronous or asynchronous.
  *
- * This routine may be called in atomic context if the RPM_ASYNC flag is set,
+ * This routine may be called in atomic context if the %RPM_ASYNC flag is set,
  * or if pm_runtime_irq_safe() has been called.
  */
 int __pm_runtime_suspend(struct device *dev, int rpmflags)
@@ -1179,7 +1184,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_suspend);
  * If the RPM_GET_PUT flag is set, increment the device's usage count.  Then
  * carry out a resume, either synchronous or asynchronous.
  *
- * This routine may be called in atomic context if the RPM_ASYNC flag is set,
+ * This routine may be called in atomic context if the %RPM_ASYNC flag is set,
  * or if pm_runtime_irq_safe() has been called.
  */
 int __pm_runtime_resume(struct device *dev, int rpmflags)
@@ -1254,9 +1259,12 @@ static int pm_runtime_get_conditional(struct device *dev, bool ign_usage_count)
  * @dev: Target device.
  *
  * Increment the runtime PM usage counter of @dev if its runtime PM status is
- * %RPM_ACTIVE, in which case it returns 1. If the device is in a different
- * state, 0 is returned. -EINVAL is returned if runtime PM is disabled for the
- * device, in which case also the usage_count will remain unmodified.
+ * already %RPM_ACTIVE
+ *
+ * Return:
+ * * %-EINVAL: Runtime PM is disabled for @dev. The usage counter is not incremented.
+ * * %1: Success; usage counter is incremented.
+ * * %0: @dev was not active.
  */
 int pm_runtime_get_if_active(struct device *dev)
 {
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 64921b10ac74..ab6a19a85880 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -137,13 +137,14 @@ static inline void pm_runtime_put_noidle(struct device *dev)
  * pm_runtime_suspended - Check whether or not a device is runtime-suspended.
  * @dev: Target device.
  *
- * Return %true if runtime PM is enabled for @dev and its runtime PM status is
- * %RPM_SUSPENDED, or %false otherwise.
- *
  * Note that the return value of this function can only be trusted if it is
  * called under the runtime PM lock of @dev or under conditions in which
  * runtime PM cannot be either disabled or enabled for @dev and its runtime PM
  * status cannot change.
+ *
+ * Return:
+ * * %true: @dev has runtime PM enabled and its status is %RPM_SUSPENDED.
+ * * %false: Otherwise.
  */
 static inline bool pm_runtime_suspended(struct device *dev)
 {
@@ -155,13 +156,14 @@ static inline bool pm_runtime_suspended(struct device *dev)
  * pm_runtime_active - Check whether or not a device is runtime-active.
  * @dev: Target device.
  *
- * Return %true if runtime PM is disabled for @dev or its runtime PM status is
- * %RPM_ACTIVE, or %false otherwise.
- *
  * Note that the return value of this function can only be trusted if it is
  * called under the runtime PM lock of @dev or under conditions in which
  * runtime PM cannot be either disabled or enabled for @dev and its runtime PM
  * status cannot change.
+ *
+ * Return:
+ * * %true: Runtime PM is disabled for @dev or its status is %RPM_ACTIVE.
+ * * %false: Otherwise.
  */
 static inline bool pm_runtime_active(struct device *dev)
 {
@@ -173,12 +175,13 @@ static inline bool pm_runtime_active(struct device *dev)
  * pm_runtime_status_suspended - Check if runtime PM status is "suspended".
  * @dev: Target device.
  *
- * Return %true if the runtime PM status of @dev is %RPM_SUSPENDED, or %false
- * otherwise, regardless of whether or not runtime PM has been enabled for @dev.
- *
  * Note that the return value of this function can only be trusted if it is
  * called under the runtime PM lock of @dev or under conditions in which the
  * runtime PM status of @dev cannot change.
+ *
+ * Return:
+ * * %true: Runtime PM status of @dev is %RPM_SUSPENDED.
+ * * %false: Otherwise.
  */
 static inline bool pm_runtime_status_suspended(struct device *dev)
 {
@@ -189,11 +192,13 @@ static inline bool pm_runtime_status_suspended(struct device *dev)
  * pm_runtime_enabled - Check if runtime PM is enabled.
  * @dev: Target device.
  *
- * Return %true if runtime PM is enabled for @dev or %false otherwise.
- *
  * Note that the return value of this function can only be trusted if it is
  * called under the runtime PM lock of @dev or under conditions in which
  * runtime PM cannot be either disabled or enabled for @dev.
+ *
+ * Return:
+ * * %true: Runtime PM is enabled for @dev.
+ * * %false: Otherwise.
  */
 static inline bool pm_runtime_enabled(struct device *dev)
 {
@@ -205,6 +210,10 @@ static inline bool pm_runtime_enabled(struct device *dev)
  * @dev: Target device.
  *
  * Do not call this function outside system suspend/resume code paths.
+ *
+ * Return:
+ * * %true: Runtime PM enabling is blocked for @dev.
+ * * %false: Otherwise.
  */
 static inline bool pm_runtime_blocked(struct device *dev)
 {
@@ -215,8 +224,9 @@ static inline bool pm_runtime_blocked(struct device *dev)
  * pm_runtime_has_no_callbacks - Check if runtime PM callbacks may be present.
  * @dev: Target device.
  *
- * Return %true if @dev is a special device without runtime PM callbacks or
- * %false otherwise.
+ * Return:
+ * * %true: @dev is marked as having no runtime PM callbacks.
+ * * %false: Otherwise.
  */
 static inline bool pm_runtime_has_no_callbacks(struct device *dev)
 {
@@ -239,9 +249,11 @@ static inline void pm_runtime_mark_last_busy(struct device *dev)
  * pm_runtime_is_irq_safe - Check if runtime PM can work in interrupt context.
  * @dev: Target device.
  *
- * Return %true if @dev has been marked as an "IRQ-safe" device (with respect
- * to runtime PM), in which case its runtime PM callabcks can be expected to
- * work correctly when invoked from interrupt handlers.
+ * Return:
+ * * %true: @dev has been marked as an "IRQ-safe" device, in which case its
+ *   runtime PM callbacks can be expected to work correctly from interrupt
+ *   handlers.
+ * * %false: Otherwise.
  */
 static inline bool pm_runtime_is_irq_safe(struct device *dev)
 {
@@ -348,17 +360,17 @@ static inline int pm_runtime_force_resume(struct device *dev) { return -ENXIO; }
  * autosuspend has been enabled for it).
  *
  * Return:
- * * 0: Success.
- * * -EINVAL: Runtime PM error.
- * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage counter non-zero, Runtime PM status change
- *            ongoing or device not in %RPM_ACTIVE state.
- * * -EBUSY: Runtime PM child_count non-zero.
- * * -EPERM: Device PM QoS resume latency 0.
- * * -EINPROGRESS: Suspend already in progress.
- * * -ENOSYS: CONFIG_PM not enabled.
- * Other values and conditions for the above values are possible as returned by
- * Runtime PM idle and suspend callbacks.
+ * * %0: Success.
+ * * %-EINVAL: Runtime PM error.
+ * * %-EACCES: Runtime PM disabled.
+ * * %-EAGAIN: Runtime PM usage counter non-zero, Runtime PM status change
+ *   ongoing or device not in %RPM_ACTIVE state.
+ * * %-EBUSY: Runtime PM child_count non-zero.
+ * * %-EPERM: Device PM QoS resume latency 0.
+ * * %-EINPROGRESS: Suspend already in progress.
+ * * %-ENOSYS: %CONFIG_PM not enabled.
+ * * Other values and conditions for the above values are possible as returned
+ *   by Runtime PM idle and suspend callbacks.
  */
 static inline int pm_runtime_idle(struct device *dev)
 {
@@ -370,17 +382,17 @@ static inline int pm_runtime_idle(struct device *dev)
  * @dev: Target device.
  *
  * Return:
- * * 1: Success; device was already suspended.
- * * 0: Success.
- * * -EINVAL: Runtime PM error.
- * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage counter non-zero or Runtime PM status change
- *            ongoing.
- * * -EBUSY: Runtime PM child_count non-zero.
- * * -EPERM: Device PM QoS resume latency 0.
- * * -ENOSYS: CONFIG_PM not enabled.
- * Other values and conditions for the above values are possible as returned by
- * Runtime PM suspend callbacks.
+ * * %1: Success; device was already suspended.
+ * * %0: Success.
+ * * %-EINVAL: Runtime PM error.
+ * * %-EACCES: Runtime PM disabled.
+ * * %-EAGAIN: Runtime PM usage counter non-zero or Runtime PM status change
+ *   ongoing.
+ * * %-EBUSY: Runtime PM child_count non-zero.
+ * * %-EPERM: Device PM QoS resume latency 0.
+ * * %-ENOSYS: %CONFIG_PM not enabled.
+ * * Other values and conditions for the above values are possible as returned
+ *   by Runtime PM suspend callbacks.
  */
 static inline int pm_runtime_suspend(struct device *dev)
 {
@@ -397,17 +409,17 @@ static inline int pm_runtime_suspend(struct device *dev)
  * engaging its "idle check" callback.
  *
  * Return:
- * * 1: Success; device was already suspended.
- * * 0: Success.
- * * -EINVAL: Runtime PM error.
- * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage counter non-zero or Runtime PM status change
- *            ongoing.
- * * -EBUSY: Runtime PM child_count non-zero.
- * * -EPERM: Device PM QoS resume latency 0.
- * * -ENOSYS: CONFIG_PM not enabled.
- * Other values and conditions for the above values are possible as returned by
- * Runtime PM suspend callbacks.
+ * * %1: Success; device was already suspended.
+ * * %0: Success.
+ * * %-EINVAL: Runtime PM error.
+ * * %-EACCES: Runtime PM disabled.
+ * * %-EAGAIN: Runtime PM usage counter non-zero or Runtime PM status change
+ *   ongoing.
+ * * %-EBUSY: Runtime PM child_count non-zero.
+ * * %-EPERM: Device PM QoS resume latency 0.
+ * * %-ENOSYS: %CONFIG_PM not enabled.
+ * * Other values and conditions for the above values are possible as returned
+ *   by Runtime PM suspend callbacks.
  */
 static inline int pm_runtime_autosuspend(struct device *dev)
 {
@@ -418,6 +430,11 @@ static inline int pm_runtime_autosuspend(struct device *dev)
 /**
  * pm_runtime_resume - Resume a device synchronously.
  * @dev: Target device.
+ *
+ * Return:
+ * * %1: Success; @dev is already %RPM_ACTIVE.
+ * * %0: Success.
+ * * Error code on failure.
  */
 static inline int pm_runtime_resume(struct device *dev)
 {
@@ -432,15 +449,15 @@ static inline int pm_runtime_resume(struct device *dev)
  * asynchronously.
  *
  * Return:
- * * 0: Success.
- * * -EINVAL: Runtime PM error.
- * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage counter non-zero, Runtime PM status change
- *            ongoing or device not in %RPM_ACTIVE state.
- * * -EBUSY: Runtime PM child_count non-zero.
- * * -EPERM: Device PM QoS resume latency 0.
- * * -EINPROGRESS: Suspend already in progress.
- * * -ENOSYS: CONFIG_PM not enabled.
+ * * %0: Success.
+ * * %-EINVAL: Runtime PM error.
+ * * %-EACCES: Runtime PM disabled.
+ * * %-EAGAIN: Runtime PM usage counter non-zero, Runtime PM status change
+ *   ongoing or device not in %RPM_ACTIVE state.
+ * * %-EBUSY: Runtime PM child_count non-zero.
+ * * %-EPERM: Device PM QoS resume latency 0.
+ * * %-EINPROGRESS: Suspend already in progress.
+ * * %-ENOSYS: %CONFIG_PM not enabled.
  */
 static inline int pm_request_idle(struct device *dev)
 {
@@ -450,6 +467,11 @@ static inline int pm_request_idle(struct device *dev)
 /**
  * pm_request_resume - Queue up runtime-resume of a device.
  * @dev: Target device.
+ *
+ * Return:
+ * * %1: Success; @dev is already %RPM_ACTIVE.
+ * * %0: Success.
+ * * Error code on failure.
  */
 static inline int pm_request_resume(struct device *dev)
 {
@@ -465,16 +487,16 @@ static inline int pm_request_resume(struct device *dev)
  * equivalent pm_runtime_autosuspend() for @dev asynchronously.
  *
  * Return:
- * * 1: Success; device was already suspended.
- * * 0: Success.
- * * -EINVAL: Runtime PM error.
- * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage counter non-zero or Runtime PM status change
- *            ongoing.
- * * -EBUSY: Runtime PM child_count non-zero.
- * * -EPERM: Device PM QoS resume latency 0.
- * * -EINPROGRESS: Suspend already in progress.
- * * -ENOSYS: CONFIG_PM not enabled.
+ * * %1: Success; device was already suspended.
+ * * %0: Success.
+ * * %-EINVAL: Runtime PM error.
+ * * %-EACCES: Runtime PM disabled.
+ * * %-EAGAIN: Runtime PM usage counter non-zero or Runtime PM status change
+ *   ongoing.
+ * * %-EBUSY: Runtime PM child_count non-zero.
+ * * %-EPERM: Device PM QoS resume latency 0.
+ * * %-EINPROGRESS: Suspend already in progress.
+ * * %-ENOSYS: %CONFIG_PM not enabled.
  */
 static inline int pm_request_autosuspend(struct device *dev)
 {
@@ -488,6 +510,11 @@ static inline int pm_request_autosuspend(struct device *dev)
  *
  * Bump up the runtime PM usage counter of @dev and queue up a work item to
  * carry out runtime-resume of it.
+ *
+ * Return:
+ * * %1: Success; @dev is already %RPM_ACTIVE.
+ * * %0: Success; runtime-resume was queued.
+ * * Error code on failure.
  */
 static inline int pm_runtime_get(struct device *dev)
 {
@@ -507,6 +534,11 @@ static inline int pm_runtime_get(struct device *dev)
  * Consider using pm_runtime_resume_and_get() instead of it, especially
  * if its return value is checked by the caller, as this is likely to result
  * in cleaner code.
+ *
+ * Return:
+ * * %1: Success; @dev is already %RPM_ACTIVE.
+ * * %0: Success.
+ * * Error code on failure.
  */
 static inline int pm_runtime_get_sync(struct device *dev)
 {
@@ -531,8 +563,11 @@ static inline int pm_runtime_get_active(struct device *dev, int rpmflags)
  * @dev: Target device.
  *
  * Resume @dev synchronously and if that is successful, increment its runtime
- * PM usage counter. Return 0 if the runtime PM usage counter of @dev has been
- * incremented or a negative error code otherwise.
+ * PM usage counter.
+ *
+ * Return:
+ * * %0: Success; @dev is active and its usage counter has been incremented.
+ * * Negative error code on failure; usage counter is unchanged.
  */
 static inline int pm_runtime_resume_and_get(struct device *dev)
 {
@@ -559,16 +594,16 @@ static inline void pm_runtime_put(struct device *dev)
  * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
  *
  * Return:
- * * 1: Success. Usage counter dropped to zero, but device was already suspended.
- * * 0: Success.
- * * -EINVAL: Runtime PM error.
- * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
- *            change ongoing.
- * * -EBUSY: Runtime PM child_count non-zero.
- * * -EPERM: Device PM QoS resume latency 0.
- * * -EINPROGRESS: Suspend already in progress.
- * * -ENOSYS: CONFIG_PM not enabled.
+ * * %1: Success. Usage counter dropped to zero, but device was already suspended.
+ * * %0: Success.
+ * * %-EINVAL: Runtime PM error.
+ * * %-EACCES: Runtime PM disabled.
+ * * %-EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
+ *   change ongoing.
+ * * %-EBUSY: Runtime PM child_count non-zero.
+ * * %-EPERM: Device PM QoS resume latency 0.
+ * * %-EINPROGRESS: Suspend already in progress.
+ * * %-ENOSYS: %CONFIG_PM not enabled.
  */
 static inline int __pm_runtime_put_autosuspend(struct device *dev)
 {
@@ -585,16 +620,16 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
  * in pm_request_autosuspend().
  *
  * Return:
- * * 1: Success. Usage counter dropped to zero, but device was already suspended.
- * * 0: Success.
- * * -EINVAL: Runtime PM error.
- * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
- *            change ongoing.
- * * -EBUSY: Runtime PM child_count non-zero.
- * * -EPERM: Device PM QoS resume latency 0.
- * * -EINPROGRESS: Suspend already in progress.
- * * -ENOSYS: CONFIG_PM not enabled.
+ * * %1: Success. Usage counter dropped to zero, but device was already suspended.
+ * * %0: Success.
+ * * %-EINVAL: Runtime PM error.
+ * * %-EACCES: Runtime PM disabled.
+ * * %-EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
+ *   change ongoing.
+ * * %-EBUSY: Runtime PM child_count non-zero.
+ * * %-EPERM: Device PM QoS resume latency 0.
+ * * %-EINPROGRESS: Suspend already in progress.
+ * * %-ENOSYS: %CONFIG_PM not enabled.
  */
 static inline int pm_runtime_put_autosuspend(struct device *dev)
 {
@@ -662,17 +697,17 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
  * if it returns an error code.
  *
  * Return:
- * * 1: Success. Usage counter dropped to zero, but device was already suspended.
- * * 0: Success.
- * * -EINVAL: Runtime PM error.
- * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
- *            change ongoing.
- * * -EBUSY: Runtime PM child_count non-zero.
- * * -EPERM: Device PM QoS resume latency 0.
- * * -ENOSYS: CONFIG_PM not enabled.
- * Other values and conditions for the above values are possible as returned by
- * Runtime PM suspend callbacks.
+ * * %1: Success. Usage counter dropped to zero, but device was already suspended.
+ * * %0: Success.
+ * * %-EINVAL: Runtime PM error.
+ * * %-EACCES: Runtime PM disabled.
+ * * %-EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
+ *   change ongoing.
+ * * %-EBUSY: Runtime PM child_count non-zero.
+ * * %-EPERM: Device PM QoS resume latency 0.
+ * * %-ENOSYS: %CONFIG_PM not enabled.
+ * * Other values and conditions for the above values are possible as returned
+ *   by Runtime PM suspend callbacks.
  */
 static inline int pm_runtime_put_sync(struct device *dev)
 {
@@ -690,17 +725,17 @@ static inline int pm_runtime_put_sync(struct device *dev)
  * if it returns an error code.
  *
  * Return:
- * * 1: Success. Usage counter dropped to zero, but device was already suspended.
- * * 0: Success.
- * * -EINVAL: Runtime PM error.
- * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
- *            change ongoing.
- * * -EBUSY: Runtime PM child_count non-zero.
- * * -EPERM: Device PM QoS resume latency 0.
- * * -ENOSYS: CONFIG_PM not enabled.
- * Other values and conditions for the above values are possible as returned by
- * Runtime PM suspend callbacks.
+ * * %1: Success. Usage counter dropped to zero, but device was already suspended.
+ * * %0: Success.
+ * * %-EINVAL: Runtime PM error.
+ * * %-EACCES: Runtime PM disabled.
+ * * %-EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
+ *   change ongoing.
+ * * %-EBUSY: Runtime PM child_count non-zero.
+ * * %-EPERM: Device PM QoS resume latency 0.
+ * * %-ENOSYS: %CONFIG_PM not enabled.
+ * * Other values and conditions for the above values are possible as returned
+ *   by Runtime PM suspend callbacks.
  */
 static inline int pm_runtime_put_sync_suspend(struct device *dev)
 {
@@ -721,18 +756,18 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
  * if it returns an error code.
  *
  * Return:
- * * 1: Success. Usage counter dropped to zero, but device was already suspended.
- * * 0: Success.
- * * -EINVAL: Runtime PM error.
- * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
- *            change ongoing.
- * * -EBUSY: Runtime PM child_count non-zero.
- * * -EPERM: Device PM QoS resume latency 0.
- * * -EINPROGRESS: Suspend already in progress.
- * * -ENOSYS: CONFIG_PM not enabled.
- * Other values and conditions for the above values are possible as returned by
- * Runtime PM suspend callbacks.
+ * * %1: Success. Usage counter dropped to zero, but device was already suspended.
+ * * %0: Success.
+ * * %-EINVAL: Runtime PM error.
+ * * %-EACCES: Runtime PM disabled.
+ * * %-EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
+ *   change ongoing.
+ * * %-EBUSY: Runtime PM child_count non-zero.
+ * * %-EPERM: Device PM QoS resume latency 0.
+ * * %-EINPROGRESS: Suspend already in progress.
+ * * %-ENOSYS: %CONFIG_PM not enabled.
+ * * Other values and conditions for the above values are possible as returned
+ *   by Runtime PM suspend callbacks.
  */
 static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
 {
@@ -748,6 +783,10 @@ static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
  * of it will be taken into account.
  *
  * It is not valid to call this function for devices with runtime PM enabled.
+ *
+ * Return:
+ * * %0: Success.
+ * * Error code on failure.
  */
 static inline int pm_runtime_set_active(struct device *dev)
 {
@@ -762,6 +801,10 @@ static inline int pm_runtime_set_active(struct device *dev)
  * dependencies of it will be taken into account.
  *
  * It is not valid to call this function for devices with runtime PM enabled.
+ *
+ * Return:
+ * * %0: Success.
+ * * Error code on failure.
  */
 static inline int pm_runtime_set_suspended(struct device *dev)
 {
-- 
2.55.0.979.g7e5102b832-goog

