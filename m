Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CEB51123E
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556833; cv=none; b=E91RqpcGi7wz8ZkhMR2vykwt0Y+pVRc3X1yMQWNASIHidFL6MVaPpcay/c4yPeUWTXyGbk/6tyWrC94sDHKDxXz6n9AB3DEiKPqbbumhy2XxXxf9wTzTuqpa9ngzA08val5uoFvTIcE1lZ/Fg+hU7T/xFe19yi8/5N21cqmtC8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556833; c=relaxed/simple;
	bh=LZEKoVQoRx81lyPvfBjCOIdhqvTqx4i0RZu0XcYnujU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZprSch/QekFjzd+wYOW4M/4600IM8HQt9bUYOeozWxcUtQT7pLHqjheWyli4nSh8MJKTkDCrkNs2Vlp9HPMwfMJsdblmJPeM5+478ketpZO0qN6PAjAOiODbLAD6hmUEl/yy4fLsRhPy2MJpXjwRbRMwb4B+6Fwq5iOAChgqFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M5KQG5a3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M5KQG5a3"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso1130045a91.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788556831; x=1789161631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6HoEZQGU9N+yQkXXBJTBMgHTLQ2Iz13P65ihXGvgEQ=;
        b=M5KQG5a3kJ0GQhO/QbsBwPa7tsLISkEr9/S1Gu1o3Mw1IUklkbU2Ynj+MfbGePNRee
         Bz10+hBnigEyYA0TBMWj54IhJz6dxY9NgOZ9oEzcYQocC9vWLGPkjVbMzOiLv+NACFfW
         DFKwdTTmyQmmA/YnxzpxoWixOQK8o/0cNyMPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556831; x=1789161631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S6HoEZQGU9N+yQkXXBJTBMgHTLQ2Iz13P65ihXGvgEQ=;
        b=Re5aBKxKizzosFValgzIF43Wy1Lg1joPnoA0tRK5CBiiU3ggT34TQlWvP/EgMhWJqo
         XqGOaIJ8IdqOUQBZdblOknK5OStffMADowQ/BMXHRwfxE1D2kD6u1tUBT5Z/pdj5efuS
         0Bxgq1nPl6cGWPqp1vz41omqhZOnF7H22+tHegjZOBfG4kAT8T3xBLr8gf01x108hUnX
         RefmWh0lBucS6lCmjirQqCayc8Z/zWSETlgPn03I0PGhzybNq8rQDAmarcbtr5OYFO+S
         3vfhDQkRk22jO8V+jkyFegoNBXM97s5T8lE0T1FOm/nIExD3EivV5YzlNCPuqwwwvbQb
         JW0w==
X-Forwarded-Encrypted: i=1; AKwUvByKKh00/eLY3mxvLtyrJVZKLzyeaZMBfHyi710Bu0ZbVuctG1gYKfCKHJpUSiIrTomDnnjC6zUeNw==@vger.kernel.org
X-Gm-Message-State: AFuF++lSB2f5hiNSaRHh7MTlQCFBc17JPgs2KgGxpw57DR308YHTXjmr
	yYvd+m3xmajQHd2g1eu0na6vyB6yKdO15CPYEC50QVUsB+LUMh0YLPvK/tzivfsaVA==
X-Gm-Gg: AYBFou1KPR8JBZGPUk9rq4KMSe9x+Qqi5d7xEUT1LLS+K8zXOeMl0h5wuG81PbrDkz5
	PaLTTWCfybtDGoMP4MD2vK07siRzQ4A/aBI1ZRefuf6+VFF4UA/KO243p4YmxJpWp7TfAMA3Uss
	dSVNZNnnb3LqowSPgmFyvGj+9H2fK8eWGUEjbTiyChVDuvWAAjIKSfEDu0FDNXJFA+VV4XTwJlg
	J1Mx6XMioSFO1VR/9a5sRGm9zzlDtqSiWJNa4tGFi+Kq6AYlQa7gtJTE18vMcButtW+nxEzXbiu
	dr2asM4Yc/MFQ9NhPAocc2fP/dXE5SwVqS7yGb0GX8uocVizzuJEkofQIUUk677GjvTd/wt6jSn
	CXJzeyjPE2rzzaUYbwS68l/2HdS8wzaUBA9nrfptq+stt+l0i4Nqt/Rp7ih+81a4wkKSgdqhKW0
	57/qfL7DdQBRBNW4XMeeM/cxD1drktEqr5cOiKiWPB8M26jc9GMbnVjjmQnogZNLtj2pboLS8nV
	ULCm1TCQs6rKaHU6OGCLg+rgeo=
X-Received: by 2002:a17:90b:5705:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-39b2617ed3bmr15450076a91.8.1788556831176;
        Fri, 04 Sep 2026 14:20:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5597:62ab:c321:4a7f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-143243767e1sm7834797c88.6.2026.09.04.14.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:20:30 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 05/11] PM: core: Document struct dev_pm_info with kerneldoc
Date: Fri,  4 Sep 2026 14:12:10 -0700
Message-ID: <20260904141215.5.Ib0272869f8b1178426106d911441c449ac299048@changeid>
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

Documentation/power/runtime_pm.rst includes several descriptions of
dev_pm_info fields, but many of them are wrong these days, as the types
or behaviors have changed. This is a prime reason for keeping docs
closer to the code where possible.

Adapt and rewrite some of these descriptions, and add them to
include/linux/pm.h directly. Then pull these docs into the generated
HTML.

Tested with `make htmldocs`.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 Documentation/power/runtime_pm.rst | 101 ++---------------------------
 include/linux/pm.h                 |  93 ++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 96 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 380dad7590a9..39fdeeda7a1e 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -203,103 +203,12 @@ rules:
 3. Runtime PM Device Fields
 ===========================
 
-The following device runtime PM fields are present in 'struct dev_pm_info', as
-defined in include/linux/pm.h:
+Device PM fields are found in 'struct dev_pm_info', as defined in
+include/linux/pm.h. Many of those fields track runtime PM configuration and
+state.
 
-  `struct timer_list suspend_timer;`
-    - timer used for scheduling (delayed) suspend and autosuspend requests
-
-  `unsigned long timer_expires;`
-    - timer expiration time, in jiffies (if this is different from zero, the
-      timer is running and will expire at that time, otherwise the timer is not
-      running)
-
-  `struct work_struct work;`
-    - work structure used for queuing up requests (i.e. work items in pm_wq)
-
-  `wait_queue_head_t wait_queue;`
-    - wait queue used if any of the helper functions needs to wait for another
-      one to complete
-
-  `spinlock_t lock;`
-    - lock used for synchronization
-
-  `atomic_t usage_count;`
-    - the usage counter of the device
-
-  `atomic_t child_count;`
-    - the count of 'active' children of the device
-
-  `unsigned int ignore_children;`
-    - if set, the value of child_count is ignored (but still updated)
-
-  `unsigned int disable_depth;`
-    - used for disabling the helper functions (they work normally if this is
-      equal to zero); the initial value of it is 1 (i.e. runtime PM is
-      initially disabled for all devices)
-
-  `int runtime_error;`
-    - if set, there was a fatal error (one of the callbacks returned error code
-      as described in Section 2), so the helper functions will not work until
-      this flag is cleared; this is the error code returned by the failing
-      callback
-
-  `unsigned int idle_notification;`
-    - if set, ->runtime_idle() is being executed
-
-  `unsigned int request_pending;`
-    - if set, there's a pending request (i.e. a work item queued up into pm_wq)
-
-  `enum rpm_request request;`
-    - type of request that's pending (valid if request_pending is set)
-
-  `unsigned int deferred_resume;`
-    - set if ->runtime_resume() is about to be run while ->runtime_suspend() is
-      being executed for that device and it is not practical to wait for the
-      suspend to complete; means "start a resume as soon as you've suspended"
-
-  `enum rpm_status runtime_status;`
-    - the runtime PM status of the device; this field's initial value is
-      RPM_SUSPENDED, which means that each device is initially regarded by the
-      PM core as 'suspended', regardless of its real hardware status
-
-  `enum rpm_status last_status;`
-    - the last runtime PM status of the device captured before disabling runtime
-      PM for it (invalid initially and when disable_depth is 0)
-
-  `unsigned int runtime_auto;`
-    - if set, indicates that the user space has allowed the device driver to
-      power manage the device at run time via the /sys/devices/.../power/control
-      `interface;` it may only be modified with the help of the
-      pm_runtime_allow() and pm_runtime_forbid() helper functions
-
-  `unsigned int no_callbacks;`
-    - indicates that the device does not use the runtime PM callbacks (see
-      Section 8); it may be modified only by the pm_runtime_no_callbacks()
-      helper function
-
-  `unsigned int irq_safe;`
-    - indicates that the ->runtime_suspend() and ->runtime_resume() callbacks
-      will be invoked with the spinlock held and interrupts disabled
-
-  `unsigned int use_autosuspend;`
-    - indicates that the device's driver supports delayed autosuspend (see
-      Section 9); it may be modified only by the
-      pm_runtime{_dont}_use_autosuspend() helper functions
-
-  `unsigned int timer_autosuspends;`
-    - indicates that the PM core should attempt to carry out an autosuspend
-      when the timer expires rather than a normal suspend
-
-  `int autosuspend_delay;`
-    - the delay time (in milliseconds) to be used for autosuspend
-
-  `unsigned long last_busy;`
-    - the time (in jiffies) when the pm_runtime_mark_last_busy() helper
-      function was last called for this device; used in calculating inactivity
-      periods for autosuspend
-
-All of the above fields are members of the 'power' member of 'struct device'.
+.. kernel-doc:: include/linux/pm.h
+   :identifiers: dev_pm_info
 
 4. Runtime PM Device Helper Functions
 =====================================
diff --git a/include/linux/pm.h b/include/linux/pm.h
index afcaaa37a812..ef3f1310e749 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -663,6 +663,99 @@ struct pm_subsys_data {
 #define DPM_FLAG_SMART_SUSPEND		BIT(2)
 #define DPM_FLAG_MAY_SKIP_RESUME	BIT(3)
 
+/**
+ * struct dev_pm_info - Device power management information.
+ *
+ * @power_state: Legacy power state (mostly unused in modern kernels).
+ * @can_wakeup: Device is capable of generating wakeup signals.
+ * @async_suspend: Device can be suspended and resumed asynchronously.
+ * @in_dpm_list: Device is on the dpm_list.
+ * @is_prepared: Device's ->prepare() callback has run successfully.
+ * @is_suspended: Device is suspended during a system sleep transition.
+ * @is_noirq_suspended: Device's noirq suspend callback has run successfully.
+ * @is_late_suspended: Device's late suspend callback has run successfully.
+ * @no_pm: Device does not participate in power management transitions.
+ * @early_init: Device was initialized before standard PM initialization.
+ * @direct_complete: Device can skip suspend/resume callbacks and remain
+ *   runtime-suspended during system sleep.
+ * @driver_flags: Driver flags (e.g. %DPM_FLAG_SMART_SUSPEND) set at probe time.
+ * @lock: Spinlock used for synchronizing PM state transitions and runtime PM
+ *   operations.
+ * @entry: List head for device power management lists.
+ * @completion: Completion for synchronization during asynchronous system
+ *   suspend/resume.
+ * @wakeup: Wakeup source object associated with the device.
+ * @work_in_progress: Asynchronous PM operation in progress.
+ * @wakeup_path: Device is in the wakeup path or can wake the system up.
+ * @syscore: Device participates in syscore power management operations.
+ * @no_pm_callbacks: Device has no PM callbacks; handled by parent or subsystem.
+ * @smart_suspend: Driver requested smart-suspend behavior.
+ * @must_resume: Device must be resumed during system resume.
+ * @may_skip_resume: Set by subsystems to indicate driver resume callbacks may
+ *   be skipped.
+ * @out_band_wakeup: Out-of-band wakeup is supported.
+ * @strict_midlayer: Middle layer code does not want callbacks invoked via
+ *   pm_runtime_force_suspend() / pm_runtime_force_resume().
+ * @should_wakeup: Wakeup flag when system sleep is not enabled.
+ * @suspend_timer: High-resolution timer used for scheduling delayed runtime
+ *   suspend and autosuspend requests.
+ * @timer_expires: Timer expiration time in nanoseconds monotonic time
+ *   (runtime PM).
+ * @work: Work structure used for queuing up requests into pm_wq (runtime PM).
+ * @wait_queue: Wait queue used if any helper functions need to wait for another
+ *   state change to complete (runtime PM).
+ * @wakeirq: Dedicated wakeup interrupt for the device.
+ * @usage_count: Device runtime PM usage counter.
+ * @child_count: Count of active children of the device (runtime PM).
+ * @disable_depth: Disable counter for runtime PM (runtime PM is enabled when
+ *   this is 0; initial value is 1).
+ * @idle_notification: Set if ->runtime_idle() is being executed.
+ * @request_pending: Set if a work item is queued into pm_wq (runtime PM).
+ * @deferred_resume: Set if ->runtime_resume() should run as soon as
+ *   ->runtime_suspend() completes.
+ * @needs_force_resume: Indicates the device was forced into suspend by
+ *   pm_runtime_force_suspend() and must be resumed by
+ *   pm_runtime_force_resume().
+ * @runtime_auto: User space has allowed the driver to power manage the device
+ *   at runtime via sysfs control attribute; also can be set by
+ *   pm_runtime_allow() or pm_runtime_forbid().
+ * @ignore_children: If set, the value of child_count is ignored for runtime
+ *   suspend and idle decisions.
+ * @no_callbacks: Indicates the device does not use runtime PM callbacks.
+ * @irq_safe: Indicates runtime PM callbacks will be invoked with the spinlock
+ *   held and interrupts disabled.
+ * @use_autosuspend: Indicates the device driver supports delayed runtime
+ *   autosuspend.
+ * @timer_autosuspends: Indicates the runtime PM core should attempt an
+ *   autosuspend rather than a normal suspend when the timer expires.
+ * @memalloc_noio: Indicates memory allocation during runtime PM transitions
+ *   must avoid I/O (GFP_NOIO).
+ * @links_count: Number of device links that require runtime PM coordination.
+ * @request: Type of pending runtime PM request (valid if request_pending is
+ *   set).
+ * @runtime_status: Runtime PM status of the device.
+ * @last_status: Last status captured before disabling runtime PM, or
+ *   %RPM_BLOCKED / %RPM_INVALID.
+ * @runtime_error: Fatal error code returned by a failing callback, blocking
+ *   helpers until cleared.
+ * @autosuspend_delay: Delay time in milliseconds to be used for runtime
+ *   autosuspend.
+ * @last_busy: Timestamp in nanoseconds when pm_runtime_mark_last_busy() was
+ *   last called. Used in calculating inactivity periods for autosuspend.
+ * @active_time: Accumulated time in nanoseconds spent in %RPM_ACTIVE state.
+ * @suspended_time: Accumulated time in nanoseconds spent in %RPM_SUSPENDED
+ *   state.
+ * @accounting_timestamp: Timestamp in nanoseconds of the last runtime PM state
+ *   accounting update.
+ * @subsys_data: Subsystem-specific power management data.
+ * @set_latency_tolerance: Callback for setting latency tolerance.
+ * @qos: Per-device PM Quality of Service (QoS) constraints.
+ * @detach_power_off: Indicates device should be detached from PM domain on
+ *   power off.
+ *
+ * Device power management information stored in the "power" member of struct
+ * device.
+ */
 struct dev_pm_info {
 	pm_message_t		power_state;
 	bool			can_wakeup:1;
-- 
2.55.0.979.g7e5102b832-goog

