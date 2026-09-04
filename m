Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1843303F
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556831; cv=none; b=pO/RcP9lwV/hQxxZKc5jNvtrK8lCPsS1FQN6LRE13ca87Rcl6xVSV4JRWYhR1PhhkdZq1961B868fGXkZl+BqREo+heRJzk7SVRp/kIQauBIbzfT6pZ9ejCVShvkbq0cHuiEc0fe2Boko4j+WrmFQe8qvTOT38byQkP5vF9BsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556831; c=relaxed/simple;
	bh=wHt8CgT1P0RNc7F6QrmjRIV/zR3o86+dVdAliaBmpiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5SvYMh8qXI6XvOMVzPyNSb/tNYH5UudQCMdtXKj/gkeZUAHuzYvL1nfbhx/IxmiAwye7W4HBggn3hKQk08ntdl3hp+CO8o/8S7R+YafpSdWIHVPoEhuN0n4RmkKpw2b6ynMadaCGnN2zj+JiXlBF8vwqrn3ZBpY8f6V+iKzJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xouz/ruK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xouz/ruK"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1193041a91.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788556828; x=1789161628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hiuf8CN7cTb9FarsrDvFqalXR9R3H1JNJ1T35r1Vjm0=;
        b=Xouz/ruK0/tbHMloxLNU0+w1MPjolYFHh0sFto40sWRvhtOUJW7Dg9aEYeszLm444G
         zp9CYHkCMtjJ+O6ckMaKcyqlnxAzSiBeVt7zQ7vG3Vk+1ir2OvCA/mjGwepufwnFtzi2
         DXhY58MnTg/FpSR3g/JBaJV6XTLqujEQkBSoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556828; x=1789161628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hiuf8CN7cTb9FarsrDvFqalXR9R3H1JNJ1T35r1Vjm0=;
        b=HCAEsjTCY7YVLdwwuvY1F3LErKk2U1jhZ/LEKFFmfrVu2DBHm3HcijoNxKTsQTjHUc
         l/rsxk5PpkGopQ1oodh+EyJh3wqs3W+yA17O0UNMQ7y2rCx0OhWdHUPCs/zGbFMneV5O
         ZlWaQ8ew0pvRhLQ/7vPSZZMeyytxNBf7PepL8sy8k1gXoAb7P8X1ERdFVXelPDD6CSYv
         j5RsC3rww5BhwsIx3j9PC8oxejEZmYC1ayPO1lBB84h+A85AmVostKnk+r7pVvgeprgV
         amS/5Ek3yrSM3k5IO7jZx/XQv/Z7xDIpXHzNCE4fQPqtFZJ66TIwyeV8dgtw92z/v0vQ
         CoHw==
X-Forwarded-Encrypted: i=1; AKwUvBxEE4Ah1vKa0sg/2eRj+FWbRE4CpswQIviLTeUlxy3H1c99Qslxrmi7hlDGzXqz+vfSvZQYPlzW1Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kquQ6KjS581wEzYdazRA83IvhDytM26rerQki/KVC+2ahNu2WI
	4j/4ZvZWSgHkTCebDVK8Hi+w+Ek/l+C6ZZhVYopSnyX8nwwCpoefl5XvlU61BoEXCg==
X-Gm-Gg: AYBFou2v3okSJ1Di1Oiipk5/TboflQAPIFBnrvBk1spim7//Kz+KoOTUnNBFqRxVpzY
	3AfVJmiaoiY9Em4dXnEy5oq8S94J7YwBpeCE02e1JCtGrzP4YcvJ5tDu9mhTeSb5Ofsrxi1bsp2
	DWL+VnowBjzPiYB4gmnk3+jNvnQAKbKiXQ9lUI5mW5Q9cYF4gWwvLw/HlMxgGQTnpITPSWUy6Hz
	giaN+WPfpHh/U3+qMNiUwgFPzlyf37ipp1da0lDUeu3RS3UkwBz7mRQmUPWqJHNJhLW/wI14Jbi
	D7xhoqgcMut+cvsnqvriajeTkjN0aFk1aYdEgigbFJs4XZwqHlKJb2QwG4ZI46lCuI4WaL8raB0
	aFFLjkX+eda3t3BiqLfp7Ih4k6nx44yMuhowc6eB1kgvxGCdUSKR5335eH8BWiEX3tzDjL6TtcM
	dqpV0OQiffz6x+zid7l/yrXXipTH4qTNgvUEa+bsdhFx3qUVgqLuW3yS7LsmQL/B4DqzGdtRD16
	BCfLa+kViDJ4YJo/6qBM4/m03bZyCd1BAvds+YQYWVElGQMgg==
X-Received: by 2002:a17:90b:39a7:b0:398:9bd1:3211 with SMTP id 98e67ed59e1d1-39b262ab182mr12456467a91.18.1788556828297;
        Fri, 04 Sep 2026 14:20:28 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5597:62ab:c321:4a7f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-143243bfbe3sm8877459c88.11.2026.09.04.14.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:20:27 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 04/11] PM: runtime: Pull API docs from kerneldoc
Date: Fri,  4 Sep 2026 14:12:09 -0700
Message-ID: <20260904141215.4.I2cb2c43192ef46bd9dfad6699080d8a1d56756d5@changeid>
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

This avoids staleness and duplication, as the same APIs were previously
documented twice.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 Documentation/power/runtime_pm.rst | 280 +----------------------------
 1 file changed, 6 insertions(+), 274 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index a53ab09c37d5..380dad7590a9 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -307,219 +307,10 @@ All of the above fields are members of the 'power' member of 'struct device'.
 The following runtime PM helper functions are defined in
 drivers/base/power/runtime.c and include/linux/pm_runtime.h:
 
-  `void pm_runtime_init(struct device *dev);`
-    - initialize the device runtime PM fields in 'struct dev_pm_info'
-
-  `void pm_runtime_remove(struct device *dev);`
-    - make sure that the runtime PM of the device will be disabled after
-      removing the device from device hierarchy
-
-  `int pm_runtime_idle(struct device *dev);`
-    - execute the subsystem-level idle callback for the device; returns an
-      error code on failure, where -EINPROGRESS means that ->runtime_idle() is
-      already being executed; if there is no callback or the callback returns 0
-      then run pm_runtime_autosuspend(dev) and return its result
-
-  `int pm_runtime_suspend(struct device *dev);`
-    - execute the subsystem-level suspend callback for the device; returns 0 on
-      success, 1 if the device's runtime PM status was already 'suspended', or
-      error code on failure, where -EAGAIN or -EBUSY means it is safe to attempt
-      to suspend the device again in future and -EACCES means that
-      'power.disable_depth' is different from 0
-
-  `int pm_runtime_autosuspend(struct device *dev);`
-    - same as pm_runtime_suspend() except that a call to
-      pm_runtime_mark_last_busy() is made and an autosuspend is scheduled for
-      the appropriate time and 0 is returned
-
-  `int pm_runtime_resume(struct device *dev);`
-    - execute the subsystem-level resume callback for the device; returns 0 on
-      success, 1 if the device's runtime PM status is already 'active' (also if
-      'power.disable_depth' is nonzero, but the status was 'active' when it was
-      changing from 0 to 1) or error code on failure, where -EAGAIN means it may
-      be safe to attempt to resume the device again in future, but
-      'power.runtime_error' should be checked additionally, and -EACCES means
-      that the callback could not be run, because 'power.disable_depth' was
-      different from 0
-
-  `int pm_runtime_resume_and_get(struct device *dev);`
-    - run pm_runtime_resume(dev) and if successful, increment the device's
-      usage counter; returns 0 on success (whether or not the device's
-      runtime PM status was already 'active') or the error code from
-      pm_runtime_resume() on failure.
-
-  `int pm_request_idle(struct device *dev);`
-    - submit a request to execute the subsystem-level idle callback for the
-      device (the request is represented by a work item in pm_wq); returns 0 on
-      success or error code if the request has not been queued up
-
-  `int pm_request_autosuspend(struct device *dev);`
-    - Call pm_runtime_mark_last_busy() and schedule the execution of the
-      subsystem-level suspend callback for the device when the autosuspend delay
-      expires
-
-  `int pm_schedule_suspend(struct device *dev, unsigned int delay);`
-    - schedule the execution of the subsystem-level suspend callback for the
-      device in future, where 'delay' is the time to wait before queuing up a
-      suspend work item in pm_wq, in milliseconds (if 'delay' is zero, the work
-      item is queued up immediately); returns 0 on success, 1 if the device's PM
-      runtime status was already 'suspended', or error code if the request
-      hasn't been scheduled (or queued up if 'delay' is 0); if the execution of
-      ->runtime_suspend() is already scheduled and not yet expired, the new
-      value of 'delay' will be used as the time to wait
-
-  `int pm_request_resume(struct device *dev);`
-    - submit a request to execute the subsystem-level resume callback for the
-      device (the request is represented by a work item in pm_wq); returns 0 on
-      success, 1 if the device's runtime PM status was already 'active', or
-      error code if the request hasn't been queued up
-
-  `void pm_runtime_get_noresume(struct device *dev);`
-    - increment the device's usage counter
-
-  `int pm_runtime_get(struct device *dev);`
-    - increment the device's usage counter, run pm_request_resume(dev) and
-      return its result
-
-  `int pm_runtime_get_sync(struct device *dev);`
-    - increment the device's usage counter, run pm_runtime_resume(dev) and
-      return its result;
-      note that it does not drop the device's usage counter on errors, so
-      consider using pm_runtime_resume_and_get() instead of it, especially
-      if its return value is checked by the caller, as this is likely to
-      result in cleaner code.
-
-  `int pm_runtime_get_if_in_use(struct device *dev);`
-    - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
-      runtime PM status is RPM_ACTIVE and the runtime PM usage counter is
-      nonzero, increment the counter and return 1; otherwise return 0 without
-      changing the counter
-
-  `int pm_runtime_get_if_active(struct device *dev);`
-    - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
-      runtime PM status is RPM_ACTIVE, increment the counter and
-      return 1; otherwise return 0 without changing the counter
-
-  `void pm_runtime_put_noidle(struct device *dev);`
-    - decrement the device's usage counter
-
-  `int pm_runtime_put(struct device *dev);`
-    - decrement the device's usage counter; if the result is 0 then run
-      pm_request_idle(dev) and return its result
-
-  `int pm_runtime_put_autosuspend(struct device *dev);`
-    - set the power.last_busy field to the current time and decrement the
-      device's usage counter; if the result is 0 then run
-      pm_request_autosuspend(dev) and return its result
-
-  `int __pm_runtime_put_autosuspend(struct device *dev);`
-    - decrement the device's usage counter; if the result is 0 then run
-      pm_request_autosuspend(dev) and return its result
-
-  `int pm_runtime_put_sync(struct device *dev);`
-    - decrement the device's usage counter; if the result is 0 then run
-      pm_runtime_idle(dev) and return its result
-
-  `int pm_runtime_put_sync_suspend(struct device *dev);`
-    - decrement the device's usage counter; if the result is 0 then run
-      pm_runtime_suspend(dev) and return its result
-
-  `int pm_runtime_put_sync_autosuspend(struct device *dev);`
-    - set the power.last_busy field to the current time and decrement the
-      device's usage counter; if the result is 0 then run
-      pm_runtime_autosuspend(dev) and return its result
-
-  `void pm_runtime_enable(struct device *dev);`
-    - decrement the device's 'power.disable_depth' field; if that field is equal
-      to zero, the runtime PM helper functions can execute subsystem-level
-      callbacks described in Section 2 for the device
-
-  `int pm_runtime_disable(struct device *dev);`
-    - increment the device's 'power.disable_depth' field (if the value of that
-      field was previously zero, this prevents subsystem-level runtime PM
-      callbacks from being run for the device), make sure that all of the
-      pending runtime PM operations on the device are either completed or
-      canceled; returns 1 if there was a resume request pending and it was
-      necessary to execute the subsystem-level resume callback for the device
-      to satisfy that request, otherwise 0 is returned
-
-  `void pm_runtime_barrier(struct device *dev);`
-    - check if there's a resume request pending for the device and resume it
-      (synchronously) in that case, cancel any other pending runtime PM requests
-      regarding it and wait for all runtime PM operations on it in progress to
-      complete
-
-  `void pm_suspend_ignore_children(struct device *dev, bool enable);`
-    - set/unset the power.ignore_children flag of the device
-
-  `int pm_runtime_set_active(struct device *dev);`
-    - clear the device's 'power.runtime_error' flag, set the device's runtime
-      PM status to 'active' and update its parent's counter of 'active'
-      children as appropriate (it is only valid to use this function if
-      'power.runtime_error' is set or 'power.disable_depth' is greater than
-      zero); it will fail and return error code if the device has a parent
-      which is not active and the 'power.ignore_children' flag of which is unset
-
-  `void pm_runtime_set_suspended(struct device *dev);`
-    - clear the device's 'power.runtime_error' flag, set the device's runtime
-      PM status to 'suspended' and update its parent's counter of 'active'
-      children as appropriate (it is only valid to use this function if
-      'power.runtime_error' is set or 'power.disable_depth' is greater than
-      zero)
-
-  `bool pm_runtime_active(struct device *dev);`
-    - return true if the device's runtime PM status is 'active' or its
-      'power.disable_depth' field is not equal to zero, or false otherwise
-
-  `bool pm_runtime_suspended(struct device *dev);`
-    - return true if the device's runtime PM status is 'suspended' and its
-      'power.disable_depth' field is equal to zero, or false otherwise
-
-  `bool pm_runtime_status_suspended(struct device *dev);`
-    - return true if the device's runtime PM status is 'suspended'
-
-  `void pm_runtime_no_callbacks(struct device *dev);`
-    - set the power.no_callbacks flag for the device and remove the runtime
-      PM attributes from /sys/devices/.../power (or prevent them from being
-      added when the device is registered)
-
-  `void pm_runtime_irq_safe(struct device *dev);`
-    - set the power.irq_safe flag for the device, causing the runtime-PM
-      callbacks to be invoked with interrupts off
-
-  `bool pm_runtime_is_irq_safe(struct device *dev);`
-    - return true if power.irq_safe flag was set for the device, causing
-      the runtime-PM callbacks to be invoked with interrupts off
-
-  `void pm_runtime_mark_last_busy(struct device *dev);`
-    - set the power.last_busy field to the current time
-
-  `void pm_runtime_use_autosuspend(struct device *dev);`
-    - set the power.use_autosuspend flag, enabling autosuspend delays; call
-      pm_runtime_get_sync if the flag was previously cleared and
-      power.autosuspend_delay is negative
-
-  `void pm_runtime_dont_use_autosuspend(struct device *dev);`
-    - clear the power.use_autosuspend flag, disabling autosuspend delays;
-      decrement the device's usage counter if the flag was previously set and
-      power.autosuspend_delay is negative; call pm_runtime_idle
-
-  `void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);`
-    - set the power.autosuspend_delay value to 'delay' (expressed in
-      milliseconds); if 'delay' is negative then runtime suspends are
-      prevented; if power.use_autosuspend is set, pm_runtime_get_sync may be
-      called or the device's usage counter may be decremented and
-      pm_runtime_idle called depending on if power.autosuspend_delay is
-      changed to or from a negative value; if power.use_autosuspend is clear,
-      pm_runtime_idle is called
-
-  `unsigned long pm_runtime_autosuspend_expiration(struct device *dev);`
-    - calculate the time when the current autosuspend delay period will expire,
-      based on power.last_busy and power.autosuspend_delay; if the delay time
-      is 1000 ms or larger then the expiration time is rounded up to the
-      nearest second; returns 0 if the delay period has already expired or
-      power.use_autosuspend isn't set, otherwise returns the expiration time
-      in jiffies
+.. kernel-doc:: drivers/base/power/runtime.c
+   :export:
+
+.. kernel-doc:: include/linux/pm_runtime.h
 
 It is safe to execute the following helper functions from interrupt context:
 
@@ -728,67 +519,8 @@ Subsystems may wish to conserve code space by using the set of generic power
 management callbacks provided by the PM core, defined in
 driver/base/power/generic_ops.c:
 
-  `int pm_generic_runtime_suspend(struct device *dev);`
-    - invoke the ->runtime_suspend() callback provided by the driver of this
-      device and return its result, or return 0 if not defined
-
-  `int pm_generic_runtime_resume(struct device *dev);`
-    - invoke the ->runtime_resume() callback provided by the driver of this
-      device and return its result, or return 0 if not defined
-
-  `int pm_generic_suspend(struct device *dev);`
-    - if the device has not been suspended at run time, invoke the ->suspend()
-      callback provided by its driver and return its result, or return 0 if not
-      defined
-
-  `int pm_generic_suspend_noirq(struct device *dev);`
-    - if pm_runtime_suspended(dev) returns "false", invoke the ->suspend_noirq()
-      callback provided by the device's driver and return its result, or return
-      0 if not defined
-
-  `int pm_generic_resume(struct device *dev);`
-    - invoke the ->resume() callback provided by the driver of this device and,
-      if successful, change the device's runtime PM status to 'active'
-
-  `int pm_generic_resume_noirq(struct device *dev);`
-    - invoke the ->resume_noirq() callback provided by the driver of this device
-
-  `int pm_generic_freeze(struct device *dev);`
-    - if the device has not been suspended at run time, invoke the ->freeze()
-      callback provided by its driver and return its result, or return 0 if not
-      defined
-
-  `int pm_generic_freeze_noirq(struct device *dev);`
-    - if pm_runtime_suspended(dev) returns "false", invoke the ->freeze_noirq()
-      callback provided by the device's driver and return its result, or return
-      0 if not defined
-
-  `int pm_generic_thaw(struct device *dev);`
-    - if the device has not been suspended at run time, invoke the ->thaw()
-      callback provided by its driver and return its result, or return 0 if not
-      defined
-
-  `int pm_generic_thaw_noirq(struct device *dev);`
-    - if pm_runtime_suspended(dev) returns "false", invoke the ->thaw_noirq()
-      callback provided by the device's driver and return its result, or return
-      0 if not defined
-
-  `int pm_generic_poweroff(struct device *dev);`
-    - if the device has not been suspended at run time, invoke the ->poweroff()
-      callback provided by its driver and return its result, or return 0 if not
-      defined
-
-  `int pm_generic_poweroff_noirq(struct device *dev);`
-    - if pm_runtime_suspended(dev) returns "false", run the ->poweroff_noirq()
-      callback provided by the device's driver and return its result, or return
-      0 if not defined
-
-  `int pm_generic_restore(struct device *dev);`
-    - invoke the ->restore() callback provided by the driver of this device and,
-      if successful, change the device's runtime PM status to 'active'
-
-  `int pm_generic_restore_noirq(struct device *dev);`
-    - invoke the ->restore_noirq() callback provided by the device's driver
+.. kernel-doc:: drivers/base/power/generic_ops.c
+   :export:
 
 These functions are the defaults used by the PM core if a subsystem doesn't
 provide its own callbacks for ->runtime_idle(), ->runtime_suspend(),
-- 
2.55.0.979.g7e5102b832-goog

