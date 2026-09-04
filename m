Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF13EDAA3
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556828; cv=none; b=BdFpyXT380MczkHupFxW1GNpsG4o5J5YNbeE/36SgODig00a+Aklr73Uu6VK5HtfVPtbSHwA1qaWwgnJ97N/2GhjYWHEHtDzF16C5RD72/L1cjq5DNl1MI87wrIRBFNOAebdnaIfDILTo4UvIQR2tHaF/H80TdfPAGFTgSZj5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556828; c=relaxed/simple;
	bh=DuSGfp51Xf6/n7M7ml+kwYVXFwSh35utIU++rb689EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZoSXCRjpBWwPlRwFw36MqwFwgEr95Yz0CJYpuD5mASB8xWMBGfBo6SguNxLlV02gzNKZOZ3eTMw8K5KxroQgMQSJ0MoFQy+pR1ZvZW02RJw1IVUq+uDtou0kP5Ow7yGg8rF8poaWr4dgnCnsM+OaOQt/o4y4piThmn0516iK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ERWHbeVf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ERWHbeVf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce98cb8165so16932025ad.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788556826; x=1789161626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T6q1VnyWEoTKWyOgQ9OahNNcGYr+xXm1NffFlxt/MKM=;
        b=ERWHbeVfePqQI3GQtqx9i0XuDwJKHyVJxWChmst4Fhajzsq+IqmOpS7+neIKdE5qNs
         E+tDICCdI+V3xcVCsCUpwOMUC4tcncbP4b5llhUhlFD5nyJ7TagNH/WJrLOtTS3xZDrv
         fEmBwA76fE4YqCYrdR9kjEJoQMoTACbvIHLjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556826; x=1789161626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T6q1VnyWEoTKWyOgQ9OahNNcGYr+xXm1NffFlxt/MKM=;
        b=rTpaODZFAIBzB762OqGXvqrAXGzB4R/cvwMH+GZV7P+QBCun1aPt4dPd1mGKxJu81m
         LOptAZ43SRFeUTTEWl7rQ/32JISpxGrQMb6G7vh/m7ZT40n4jmleF4GGvPLNSTJpnVph
         rkTJS0yjylor0xMasjKV0Opd0lVfGEk5niRGYNUuXyZXiyFly2BaeqLeKFxdNjhGvvHI
         owV1PI2Y7iBiO+D+7OFYGW6dA2l7Isp01WHd1zIl68APyzhwNhCfCRYPUxfSK9SrRWDt
         Yfhgoh8Cz9cDmji4RtX9pksY/gEgODtbOfnsrCz3VNDrhsD2Pekrl1XQ9EfwmY7gBOu5
         Wpmw==
X-Forwarded-Encrypted: i=1; AKwUvBxduwhKbZx+YxNweLCFyFxWaBF9ZwY0Cgy5ujkfew+WXEPMVM3dHgXcMzsNDcPfVcbqwGw4hJmr5g==@vger.kernel.org
X-Gm-Message-State: AFuF++kp9kKME0596Y6esgcWD1TGsfMF4Ch7uoXPSQvg+gydFBQfFLDY
	sWgjDfmZPLCtBFyYcsOX0Rry2AKWIDodtAfYgRwftIckjYX37ImHIG2ZYHmVoROvLA==
X-Gm-Gg: AYBFou1IC/Uz8xNZhRTQHbQPDV6BVkNtxc8/Y8stATmICF9OeHP3Lc60PUBnS+GES5x
	lQSoa7MdCk0qYnmqeVcwujDrNRYBW67/Q1Dps0bmb/dfkCadxyRb8ZOKbGRFgMUtBVg0c3LTnqD
	hml72279LO0wcaGjf67djwJbc0lSmuzw15Nqc6gGcAIVw/iKqKgpHv+dHsJgaNndXG1HK53OsIN
	XlGula6A2Hafo/4cNXQNKMOyhWpjBaPglrFroQnsljvQg9LbaTy6kQFhy1bZh9OX2OGlnRVf6N/
	vqLTE9u9Eyf5vWRNVVEqwg/z3T8L8FtPS+j0NzQvi1EMVfjEr9CEze9bVzOl+tXkcvi7/MsW+ee
	OVSyiGCotkjoHJJIFLSmVPEkffPJPinRvc/o1uUcCRmxUZNoRH2JgVLVlkGyHjQVJ/02b2wv3tN
	h4vjJzb2PciTRU6ZJ2MjJSXAXYQGYuglBxKCB1QaJkFoBX+hpV5l1ZNHqRXrca2MtzslbFjkZuo
	AqNA8tCQPrWxTCrIrIiahVwlHdpZO2bBns52Gf0pyKW6DhoeQ==
X-Received: by 2002:a17:903:2ac6:b0:2d7:1858:1d96 with SMTP id d9443c01a7336-2dafaf5f50dmr146868315ad.7.1788556825495;
        Fri, 04 Sep 2026 14:20:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5597:62ab:c321:4a7f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3339885d29esm9868188eec.2.2026.09.04.14.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:20:24 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 03/11] PM: runtime: kerneldoc wording improvements
Date: Fri,  4 Sep 2026 14:12:08 -0700
Message-ID: <20260904141215.3.I3bdec7dcda46e1bee6d4f91530518fbe9c9096fd@changeid>
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

In preparation for removing duplicate documentation from
Documentation/power/runtime_pm.rst, borrow some of the useful wording
from runtime_pm.rst, and update other language for clarity, ease of
reading, and completeness.

Other guiding principles in this change:

 * Try to highlight "core", as in, "functions that are not for driver
   use but are exported because the real entrypoints are inline
   functions"

 * Rework pm_runtime_barrier() docs significantly. More below.

 * Include some clarifying cross-references and recommendations for
   pm_runtime_put_sync{,_suspend,_autosuspend}()

 * Attempt to deemphasize some of the implementation details (e.g.,
   "asynchronous" instead of "queue")

 * Try for more clear user-facing language. For example, "set up
   autosuspend" isn't quite clear whether we're configuring autosuspend,
   or if we're initiating an attempt to autosuspend (i.e., setting a
   timer).

pm_runtime_barrier(): currently, we speak a lot about implementation
details and sequences of events, but obscure the key point that it
treats "pending resume" and "pending suspend" very differently -- I try
to improve that.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime.c | 65 +++++++++++++-----------
 include/linux/pm_runtime.h   | 95 +++++++++++++++++++-----------------
 2 files changed, 87 insertions(+), 73 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index ce7e08e628a2..f24b84757606 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1101,14 +1101,13 @@ static int rpm_drop_usage_count(struct device *dev)
 }
 
 /**
- * __pm_runtime_idle - Entry point for runtime idle operations.
+ * __pm_runtime_idle - Core entry point for runtime idle operations.
  * @dev: Device to send idle notification for.
  * @rpmflags: Flag bits.
  *
- * If the RPM_GET_PUT flag is set, decrement the device's usage count and
- * return immediately if it is larger than zero (if it becomes negative, log a
- * warning, increment it, and return an error).  Then carry out an idle
- * notification, either synchronous or asynchronous.
+ * Carry out an idle check for @dev, either synchronous or asynchronous.
+ * If %RPM_GET_PUT is set in @rpmflags, decrement the device's usage count
+ * first, proceeding with idle notification only if the counter drops to zero.
  *
  * This routine may be called in atomic context if the %RPM_ASYNC flag is set,
  * or if pm_runtime_irq_safe() has been called.
@@ -1139,14 +1138,13 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
 EXPORT_SYMBOL_GPL(__pm_runtime_idle);
 
 /**
- * __pm_runtime_suspend - Entry point for runtime put/suspend operations.
+ * __pm_runtime_suspend - Core entry point for runtime put/suspend operations.
  * @dev: Device to suspend.
  * @rpmflags: Flag bits.
  *
- * If the RPM_GET_PUT flag is set, decrement the device's usage count and
- * return immediately if it is larger than zero (if it becomes negative, log a
- * warning, increment it, and return an error).  Then carry out a suspend,
- * either synchronous or asynchronous.
+ * Carry out a suspend operation for @dev, either synchronous or asynchronous.
+ * If %RPM_GET_PUT is set in @rpmflags, decrement the device's usage count
+ * first, proceeding with suspend only if the counter drops to zero.
  *
  * This routine may be called in atomic context if the %RPM_ASYNC flag is set,
  * or if pm_runtime_irq_safe() has been called.
@@ -1177,12 +1175,13 @@ int __pm_runtime_suspend(struct device *dev, int rpmflags)
 EXPORT_SYMBOL_GPL(__pm_runtime_suspend);
 
 /**
- * __pm_runtime_resume - Entry point for runtime resume operations.
+ * __pm_runtime_resume - Core entry point for runtime resume operations.
  * @dev: Device to resume.
  * @rpmflags: Flag bits.
  *
- * If the RPM_GET_PUT flag is set, increment the device's usage count.  Then
- * carry out a resume, either synchronous or asynchronous.
+ * Carry out a runtime resume operation for @dev, either synchronous or
+ * asynchronous. If %RPM_GET_PUT is set in @rpmflags, increment the device's
+ * usage count first, then bring the device to %RPM_ACTIVE state.
  *
  * This routine may be called in atomic context if the %RPM_ASYNC flag is set,
  * or if pm_runtime_irq_safe() has been called.
@@ -1276,17 +1275,15 @@ EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
  * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
  * @dev: Target device.
  *
- * Increment the runtime PM usage counter of @dev if its runtime PM status is
- * %RPM_ACTIVE and its runtime PM usage counter is greater than 0 or it is not
- * ignoring children and its active child count is nonzero.  1 is returned in
- * this case.
- *
- * If @dev is in a different state or it is not in use (that is, its usage
- * counter is 0, or it is ignoring children, or its active child count is 0),
- * 0 is returned.
+ * Increment the runtime PM usage counter of @dev if it is "in use." A device
+ * is considered in use if its runtime PM status is %RPM_ACTIVE and its runtime
+ * PM usage counter is greater than 0, or if it is not ignoring children and
+ * its active child count is nonzero.
  *
- * -EINVAL is returned if runtime PM is disabled for the device, in which case
- * also the usage counter of @dev is not updated.
+ * Return:
+ * * %-EINVAL: Runtime PM is disabled for @dev. The usage counter is not incremented.
+ * * %1: Success; usage counter is incremented.
+ * * %0: @dev was not in use; usage counter is not incremented.
  */
 int pm_runtime_get_if_in_use(struct device *dev)
 {
@@ -1470,11 +1467,13 @@ static void __pm_runtime_barrier(struct device *dev)
  * pm_runtime_barrier - Flush pending requests and wait for completions.
  * @dev: Device to handle.
  *
- * Prevent the device from being suspended by incrementing its usage counter and
- * if there's a pending resume request for the device, wake the device up.
- * Next, make sure that all pending requests for the device have been flushed
- * from pm_wq and wait for all runtime PM operations involving the device in
- * progress to complete.
+ * If the device has a pending resume request, resume it synchronously. For all
+ * other request types, cancel any queued request, and wait for running
+ * operations to complete.
+ *
+ * Note that this is intentionally asymmetric, as it guarantees any queued
+ * asynchronous resume request will complete, but it may cancel asynchronous
+ * suspend requests.
  */
 void pm_runtime_barrier(struct device *dev)
 {
@@ -1558,8 +1557,16 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
 EXPORT_SYMBOL_GPL(__pm_runtime_disable);
 
 /**
- * pm_runtime_enable - Enable runtime PM of a device.
+ * pm_runtime_enable - Enable runtime PM for a device.
  * @dev: Device to handle.
+ *
+ * Enable runtime PM transitions for @dev by decrementing its disable counter.
+ * Once the counter reaches zero, the PM core is permitted to execute runtime
+ * PM callbacks for @dev as power conditions change.
+ *
+ * Callers should ensure that the device's runtime PM status accurately reflects
+ * its physical hardware state (via pm_runtime_set_active() or
+ * pm_runtime_set_suspended()) before enabling runtime PM.
  */
 void pm_runtime_enable(struct device *dev)
 {
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 1ffd9d5c3010..322e3b17f987 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -352,11 +352,11 @@ static inline int pm_runtime_force_resume(struct device *dev) { return -ENXIO; }
 #endif /* CONFIG_PM_SLEEP */
 
 /**
- * pm_runtime_idle - Conditionally set up autosuspend of a device or suspend it.
+ * pm_runtime_idle - Conditionally initiate autosuspend of a device or suspend it.
  * @dev: Target device.
  *
  * Invoke the "idle check" callback of @dev and, depending on its return value,
- * set up autosuspend of @dev or suspend it (depending on whether or not
+ * initiate autosuspend of @dev or suspend it (depending on whether or not
  * autosuspend has been enabled for it).
  *
  * Return:
@@ -400,13 +400,13 @@ static inline int pm_runtime_suspend(struct device *dev)
 }
 
 /**
- * pm_runtime_autosuspend - Update the last access time and set up autosuspend
+ * pm_runtime_autosuspend - Update the last access time and initiate autosuspend
  * of a device.
  * @dev: Target device.
  *
- * First update the last access time, then set up autosuspend of @dev or suspend
- * it (depending on whether or not autosuspend is enabled for it) without
- * engaging its "idle check" callback.
+ * First update the last access time, then initiate autosuspend of @dev or
+ * suspend it (depending on whether or not autosuspend is enabled for it)
+ * without engaging its "idle check" callback.
  *
  * Return:
  * * %1: Success; device was already suspended.
@@ -442,11 +442,11 @@ static inline int pm_runtime_resume(struct device *dev)
 }
 
 /**
- * pm_request_idle - Queue up "idle check" execution for a device.
+ * pm_request_idle - Request an asynchronous idle check for a device.
  * @dev: Target device.
  *
- * Queue up a work item to run an equivalent of pm_runtime_idle() for @dev
- * asynchronously.
+ * Asynchronously request the PM core to evaluate whether @dev can be idled
+ * or suspended, invoking its ->runtime_idle() callback if provided.
  *
  * Return:
  * * %0: Success.
@@ -465,9 +465,12 @@ static inline int pm_request_idle(struct device *dev)
 }
 
 /**
- * pm_request_resume - Queue up runtime-resume of a device.
+ * pm_request_resume - Request an asynchronous runtime resume for a device.
  * @dev: Target device.
  *
+ * Asynchronously request the PM core to resume @dev to %RPM_ACTIVE state
+ * without modifying its usage counter.
+ *
  * Return:
  * * %1: Success; @dev is already %RPM_ACTIVE.
  * * %0: Success.
@@ -479,12 +482,11 @@ static inline int pm_request_resume(struct device *dev)
 }
 
 /**
- * pm_request_autosuspend - Update the last access time and queue up autosuspend
- * of a device.
+ * pm_request_autosuspend - Update access time and request delayed suspension.
  * @dev: Target device.
  *
- * Update the last access time of a device and queue up a work item to run an
- * equivalent pm_runtime_autosuspend() for @dev asynchronously.
+ * Update the last access time of @dev and asynchronously request the PM core
+ * to suspend it after the autosuspend delay has elapsed.
  *
  * Return:
  * * %1: Success; device was already suspended.
@@ -505,11 +507,11 @@ static inline int pm_request_autosuspend(struct device *dev)
 }
 
 /**
- * pm_runtime_get - Bump up usage counter and queue up resume of a device.
+ * pm_runtime_get - Increment usage counter and request asynchronous resume.
  * @dev: Target device.
  *
- * Bump up the runtime PM usage counter of @dev and queue up a work item to
- * carry out runtime-resume of it.
+ * Increment the runtime PM usage counter of @dev and, if the device is
+ * currently suspended, asynchronously request the PM core to resume it.
  *
  * Return:
  * * %1: Success; @dev is already %RPM_ACTIVE.
@@ -528,12 +530,10 @@ static inline int pm_runtime_get(struct device *dev)
  * Bump up the runtime PM usage counter of @dev and carry out runtime-resume of
  * it synchronously.
  *
- * The possible return values of this function are the same as for
- * pm_runtime_resume() and the runtime PM usage counter of @dev remains
- * incremented in all cases, even if it returns an error code.
- * Consider using pm_runtime_resume_and_get() instead of it, especially
- * if its return value is checked by the caller, as this is likely to result
- * in cleaner code.
+ * Note that the runtime PM usage counter of @dev remains incremented in all
+ * cases, even if it returns an error code. Consider using
+ * pm_runtime_resume_and_get() instead, especially if the return value is
+ * checked by the caller, as this is likely to result in cleaner code.
  *
  * Return:
  * * %1: Success; @dev is already %RPM_ACTIVE.
@@ -575,11 +575,12 @@ static inline int pm_runtime_resume_and_get(struct device *dev)
 }
 
 /**
- * pm_runtime_put - Drop device usage counter and queue up "idle check" if 0.
+ * pm_runtime_put - Drop device usage counter and request asynchronous idle check.
  * @dev: Target device.
  *
- * Decrement the runtime PM usage counter of @dev and if it turns out to be
- * equal to 0, queue up a work item for @dev like in pm_request_idle().
+ * Decrement the runtime PM usage counter of @dev. If the counter reaches zero
+ * and the device has no active child dependencies, asynchronously request the
+ * PM core to idle or suspend the device.
  */
 static inline void pm_runtime_put(struct device *dev)
 {
@@ -611,13 +612,13 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
 }
 
 /**
- * pm_runtime_put_autosuspend - Update the last access time of a device, drop
- * its usage counter and queue autosuspend if the usage counter becomes 0.
+ * pm_runtime_put_autosuspend - Update the last access time, drop usage counter
+ * and request autosuspend.
  * @dev: Target device.
  *
- * Update the last access time of @dev, decrement runtime PM usage counter of
- * @dev and if it turns out to be equal to 0, queue up a work item for @dev like
- * in pm_request_autosuspend().
+ * Update the last access time of @dev and decrement its runtime PM usage
+ * counter. If the counter drops to zero, asynchronously request the PM core to
+ * suspend the device once its autosuspend delay has elapsed.
  *
  * Return:
  * * %1: Success. Usage counter dropped to zero, but device was already suspended.
@@ -688,10 +689,12 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.
  *
- * Decrement the runtime PM usage counter of @dev and if it turns out to be
- * equal to 0, invoke the "idle check" callback of @dev and, depending on its
- * return value, set up autosuspend of @dev or suspend it (depending on whether
- * or not autosuspend has been enabled for it).
+ * Decrement the runtime PM usage counter of @dev. If the counter drops to zero,
+ * synchronously evaluate and trigger idle/suspend handling.
+ *
+ * Note that this does not update the last access time, but it does respect
+ * existing autosuspend timers. If @dev uses autosuspend, consider using
+ * pm_runtime_put_sync_autosuspend() or pm_runtime_put_sync_suspend() instead.
  *
  * The runtime PM usage counter of @dev remains decremented in all cases, even
  * if it returns an error code.
@@ -718,8 +721,12 @@ static inline int pm_runtime_put_sync(struct device *dev)
  * pm_runtime_put_sync_suspend - Drop device usage counter and suspend if 0.
  * @dev: Target device.
  *
- * Decrement the runtime PM usage counter of @dev and if it turns out to be
- * equal to 0, carry out runtime-suspend of @dev synchronously.
+ * Decrement the runtime PM usage counter of @dev. If the counter drops to zero,
+ * suspend the device synchronously.
+ *
+ * This API differs from pm_runtime_put_sync() and
+ * pm_runtime_put_sync_autosuspend() in that it ignores any outstanding
+ * autosuspend delays.
  *
  * The runtime PM usage counter of @dev remains decremented in all cases, even
  * if it returns an error code.
@@ -747,10 +754,11 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
  * drop device usage counter and autosuspend if 0.
  * @dev: Target device.
  *
- * Update the last access time of @dev, decrement the runtime PM usage counter
- * of @dev and if it turns out to be equal to 0, set up autosuspend of @dev or
- * suspend it synchronously (depending on whether or not autosuspend has been
- * enabled for it).
+ * Update the last access time of @dev and decrement its runtime PM usage
+ * counter. If the counter drops to zero, synchronously suspend the device (or
+ * schedule autosuspend if the delay has not elapsed).
+ *
+ * Prefer this API over pm_runtime_put_sync() for devices that use autosuspend.
  *
  * The runtime PM usage counter of @dev remains decremented in all cases, even
  * if it returns an error code.
@@ -827,9 +835,8 @@ static inline int pm_runtime_set_suspended(struct device *dev)
  *
  * If the counter is zero when this function runs and there is a pending runtime
  * resume request for @dev, it will be resumed.  If the counter is still zero at
- * that point, all of the pending runtime PM requests for @dev will be canceled
- * and all runtime PM operations in progress involving it will be waited for to
- * complete.
+ * that point, this function cancels all pending runtime PM requests for @dev
+ * and waits for its runtime PM operations to complete (if any).
  *
  * For each invocation of this function for @dev, there must be a matching
  * pm_runtime_enable() call, so that runtime PM is eventually enabled for it
-- 
2.55.0.979.g7e5102b832-goog

