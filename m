Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1C547064
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674154; cv=none; b=ff0FwM7XRqGeoZV6k+4zbzVBUyuRPrZo7ZwxnedLZmQVfrf/W2ykk7Epg1+2b4ozF1UaRHeiZRcCS8seIxblIdcQPprUQ7+u7BEDYfbtSsn/6dDB5gVwwNfU+8jJ8GQsd7bSJBTRLSe77r+QCa9nabhg8Cf8ashjIEobHAZ2i1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674154; c=relaxed/simple;
	bh=foYHm2o2+MQYrdR+mpSr7B5iCKdVj48EFsHR+MXZsH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwoJOD/FJyo2WwnTBSTFXjDMFfPV915JYLlUHl6EFicNFJ2UN4EJ0v+VCt0UIMOGxwxb2bWa++MNmTOX1Jh36Y+KmuWFJwR2w3SaRGa99VR0HV+8EIScnv3eYC1LglBllmK55l1TbHg+i9sJGKlnRQIXf5+ABfuve9WQfFgx12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVdfF1p3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVdfF1p3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358E81F00899
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789674152;
	bh=2BCWfhhEYgzD7DaQHesnxgyG/gcGvwv95EZYwth9a3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UVdfF1p34mesS2N1qg/fL8ehSvSlAW6xkIbzgseznGO1lLVxamIM+z7SwM11kLNSG
	 vO4khuUnVDuwav7wzRfjyXPGojkun6RPBE0paOhFl1o/ZLVOcbcI7ROrjLP16Un/A/
	 pxz+CHvOTHIYQWvxCp0xvSscHvaS3H8PdmCDITLgjTrX1xZv8W4n6eTp3GyikS8C4O
	 LVUwwmdKoJ1vDgCLt7DPv/ZDwXEjmV4SoHB2Qqig8Pk7r2s6/SQmRObiWOBEbupE6n
	 zbJ65ZILkcPACJ556/WAugn5r2AGNN4VCB7Da9wjYhOj/Z+AO9sJmHGuyIrNJUntuz
	 Tzq6qIUOhjogg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1b846so1594110e87.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 12:42:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzjCnOAsHflu7y+69d029PpXAzo76PZtFjgWjTMLTRDCduNClLn4RsOborxJ7d1DqrmLYsk3NM/OQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kwr4CUiguBrT58/NjQ5DPCCF0f5wstxzoaYC+fC5J9vV5OzE7e
	BBcF2h48Rgwy/zAwhiBy04mkW2asiElLe9yRpgKEHhBivKhSl0ji2pDWCH/Me7lhmmaIWycBuUx
	WM0Q9fxSnZFWz9GK5XU3Yi1FfEOn9lVk=
X-Received: by 2002:a05:6512:1194:b0:5ae:ba7a:1789 with SMTP id
 2adb3069b0e04-5b8b6600b10mr2624216e87.13.1789674150487; Thu, 17 Sep 2026
 12:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904212000.4167880-1-briannorris@chromium.org> <20260904141215.5.Ib0272869f8b1178426106d911441c449ac299048@changeid>
In-Reply-To: <20260904141215.5.Ib0272869f8b1178426106d911441c449ac299048@changeid>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 17 Sep 2026 21:41:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hsceFpdp7mW+cLDn+KTuyNSNzZO6ZtDLMcFG7311qOdg@mail.gmail.com>
X-Gm-Features: AcwNN1WCL5grxwwX4Lp0R-9BaaiZJw5zDg8kY2f408iKFbGK6nYFbJ3kzC6Mzgs
Message-ID: <CAJZ5v0hsceFpdp7mW+cLDn+KTuyNSNzZO6ZtDLMcFG7311qOdg@mail.gmail.com>
Subject: Re: [PATCH 05/11] PM: core: Document struct dev_pm_info with kerneldoc
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 11:20=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> Documentation/power/runtime_pm.rst includes several descriptions of
> dev_pm_info fields, but many of them are wrong these days, as the types
> or behaviors have changed. This is a prime reason for keeping docs
> closer to the code where possible.
>
> Adapt and rewrite some of these descriptions, and add them to
> include/linux/pm.h directly. Then pull these docs into the generated
> HTML.
>
> Tested with `make htmldocs`.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

All of the previous patches and this one look fine to me and I'm going
to pick them up right away.

And thank you for doing this work!  It's been on my todo list for quite a w=
hile.

> ---
>
>  Documentation/power/runtime_pm.rst | 101 ++---------------------------
>  include/linux/pm.h                 |  93 ++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+), 96 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index 380dad7590a9..39fdeeda7a1e 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -203,103 +203,12 @@ rules:
>  3. Runtime PM Device Fields
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> -The following device runtime PM fields are present in 'struct dev_pm_inf=
o', as
> -defined in include/linux/pm.h:
> +Device PM fields are found in 'struct dev_pm_info', as defined in
> +include/linux/pm.h. Many of those fields track runtime PM configuration =
and
> +state.
>
> -  `struct timer_list suspend_timer;`
> -    - timer used for scheduling (delayed) suspend and autosuspend reques=
ts
> -
> -  `unsigned long timer_expires;`
> -    - timer expiration time, in jiffies (if this is different from zero,=
 the
> -      timer is running and will expire at that time, otherwise the timer=
 is not
> -      running)
> -
> -  `struct work_struct work;`
> -    - work structure used for queuing up requests (i.e. work items in pm=
_wq)
> -
> -  `wait_queue_head_t wait_queue;`
> -    - wait queue used if any of the helper functions needs to wait for a=
nother
> -      one to complete
> -
> -  `spinlock_t lock;`
> -    - lock used for synchronization
> -
> -  `atomic_t usage_count;`
> -    - the usage counter of the device
> -
> -  `atomic_t child_count;`
> -    - the count of 'active' children of the device
> -
> -  `unsigned int ignore_children;`
> -    - if set, the value of child_count is ignored (but still updated)
> -
> -  `unsigned int disable_depth;`
> -    - used for disabling the helper functions (they work normally if thi=
s is
> -      equal to zero); the initial value of it is 1 (i.e. runtime PM is
> -      initially disabled for all devices)
> -
> -  `int runtime_error;`
> -    - if set, there was a fatal error (one of the callbacks returned err=
or code
> -      as described in Section 2), so the helper functions will not work =
until
> -      this flag is cleared; this is the error code returned by the faili=
ng
> -      callback
> -
> -  `unsigned int idle_notification;`
> -    - if set, ->runtime_idle() is being executed
> -
> -  `unsigned int request_pending;`
> -    - if set, there's a pending request (i.e. a work item queued up into=
 pm_wq)
> -
> -  `enum rpm_request request;`
> -    - type of request that's pending (valid if request_pending is set)
> -
> -  `unsigned int deferred_resume;`
> -    - set if ->runtime_resume() is about to be run while ->runtime_suspe=
nd() is
> -      being executed for that device and it is not practical to wait for=
 the
> -      suspend to complete; means "start a resume as soon as you've suspe=
nded"
> -
> -  `enum rpm_status runtime_status;`
> -    - the runtime PM status of the device; this field's initial value is
> -      RPM_SUSPENDED, which means that each device is initially regarded =
by the
> -      PM core as 'suspended', regardless of its real hardware status
> -
> -  `enum rpm_status last_status;`
> -    - the last runtime PM status of the device captured before disabling=
 runtime
> -      PM for it (invalid initially and when disable_depth is 0)
> -
> -  `unsigned int runtime_auto;`
> -    - if set, indicates that the user space has allowed the device drive=
r to
> -      power manage the device at run time via the /sys/devices/.../power=
/control
> -      `interface;` it may only be modified with the help of the
> -      pm_runtime_allow() and pm_runtime_forbid() helper functions
> -
> -  `unsigned int no_callbacks;`
> -    - indicates that the device does not use the runtime PM callbacks (s=
ee
> -      Section 8); it may be modified only by the pm_runtime_no_callbacks=
()
> -      helper function
> -
> -  `unsigned int irq_safe;`
> -    - indicates that the ->runtime_suspend() and ->runtime_resume() call=
backs
> -      will be invoked with the spinlock held and interrupts disabled
> -
> -  `unsigned int use_autosuspend;`
> -    - indicates that the device's driver supports delayed autosuspend (s=
ee
> -      Section 9); it may be modified only by the
> -      pm_runtime{_dont}_use_autosuspend() helper functions
> -
> -  `unsigned int timer_autosuspends;`
> -    - indicates that the PM core should attempt to carry out an autosusp=
end
> -      when the timer expires rather than a normal suspend
> -
> -  `int autosuspend_delay;`
> -    - the delay time (in milliseconds) to be used for autosuspend
> -
> -  `unsigned long last_busy;`
> -    - the time (in jiffies) when the pm_runtime_mark_last_busy() helper
> -      function was last called for this device; used in calculating inac=
tivity
> -      periods for autosuspend
> -
> -All of the above fields are members of the 'power' member of 'struct dev=
ice'.
> +.. kernel-doc:: include/linux/pm.h
> +   :identifiers: dev_pm_info
>
>  4. Runtime PM Device Helper Functions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index afcaaa37a812..ef3f1310e749 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -663,6 +663,99 @@ struct pm_subsys_data {
>  #define DPM_FLAG_SMART_SUSPEND         BIT(2)
>  #define DPM_FLAG_MAY_SKIP_RESUME       BIT(3)
>
> +/**
> + * struct dev_pm_info - Device power management information.
> + *
> + * @power_state: Legacy power state (mostly unused in modern kernels).
> + * @can_wakeup: Device is capable of generating wakeup signals.
> + * @async_suspend: Device can be suspended and resumed asynchronously.
> + * @in_dpm_list: Device is on the dpm_list.
> + * @is_prepared: Device's ->prepare() callback has run successfully.
> + * @is_suspended: Device is suspended during a system sleep transition.
> + * @is_noirq_suspended: Device's noirq suspend callback has run successf=
ully.
> + * @is_late_suspended: Device's late suspend callback has run successful=
ly.
> + * @no_pm: Device does not participate in power management transitions.
> + * @early_init: Device was initialized before standard PM initialization=
.
> + * @direct_complete: Device can skip suspend/resume callbacks and remain
> + *   runtime-suspended during system sleep.
> + * @driver_flags: Driver flags (e.g. %DPM_FLAG_SMART_SUSPEND) set at pro=
be time.
> + * @lock: Spinlock used for synchronizing PM state transitions and runti=
me PM
> + *   operations.
> + * @entry: List head for device power management lists.
> + * @completion: Completion for synchronization during asynchronous syste=
m
> + *   suspend/resume.
> + * @wakeup: Wakeup source object associated with the device.
> + * @work_in_progress: Asynchronous PM operation in progress.
> + * @wakeup_path: Device is in the wakeup path or can wake the system up.
> + * @syscore: Device participates in syscore power management operations.
> + * @no_pm_callbacks: Device has no PM callbacks; handled by parent or su=
bsystem.
> + * @smart_suspend: Driver requested smart-suspend behavior.
> + * @must_resume: Device must be resumed during system resume.
> + * @may_skip_resume: Set by subsystems to indicate driver resume callbac=
ks may
> + *   be skipped.
> + * @out_band_wakeup: Out-of-band wakeup is supported.
> + * @strict_midlayer: Middle layer code does not want callbacks invoked v=
ia
> + *   pm_runtime_force_suspend() / pm_runtime_force_resume().
> + * @should_wakeup: Wakeup flag when system sleep is not enabled.
> + * @suspend_timer: High-resolution timer used for scheduling delayed run=
time
> + *   suspend and autosuspend requests.
> + * @timer_expires: Timer expiration time in nanoseconds monotonic time
> + *   (runtime PM).
> + * @work: Work structure used for queuing up requests into pm_wq (runtim=
e PM).
> + * @wait_queue: Wait queue used if any helper functions need to wait for=
 another
> + *   state change to complete (runtime PM).
> + * @wakeirq: Dedicated wakeup interrupt for the device.
> + * @usage_count: Device runtime PM usage counter.
> + * @child_count: Count of active children of the device (runtime PM).
> + * @disable_depth: Disable counter for runtime PM (runtime PM is enabled=
 when
> + *   this is 0; initial value is 1).
> + * @idle_notification: Set if ->runtime_idle() is being executed.
> + * @request_pending: Set if a work item is queued into pm_wq (runtime PM=
).
> + * @deferred_resume: Set if ->runtime_resume() should run as soon as
> + *   ->runtime_suspend() completes.
> + * @needs_force_resume: Indicates the device was forced into suspend by
> + *   pm_runtime_force_suspend() and must be resumed by
> + *   pm_runtime_force_resume().
> + * @runtime_auto: User space has allowed the driver to power manage the =
device
> + *   at runtime via sysfs control attribute; also can be set by
> + *   pm_runtime_allow() or pm_runtime_forbid().
> + * @ignore_children: If set, the value of child_count is ignored for run=
time
> + *   suspend and idle decisions.
> + * @no_callbacks: Indicates the device does not use runtime PM callbacks=
.
> + * @irq_safe: Indicates runtime PM callbacks will be invoked with the sp=
inlock
> + *   held and interrupts disabled.
> + * @use_autosuspend: Indicates the device driver supports delayed runtim=
e
> + *   autosuspend.
> + * @timer_autosuspends: Indicates the runtime PM core should attempt an
> + *   autosuspend rather than a normal suspend when the timer expires.
> + * @memalloc_noio: Indicates memory allocation during runtime PM transit=
ions
> + *   must avoid I/O (GFP_NOIO).
> + * @links_count: Number of device links that require runtime PM coordina=
tion.
> + * @request: Type of pending runtime PM request (valid if request_pendin=
g is
> + *   set).
> + * @runtime_status: Runtime PM status of the device.
> + * @last_status: Last status captured before disabling runtime PM, or
> + *   %RPM_BLOCKED / %RPM_INVALID.
> + * @runtime_error: Fatal error code returned by a failing callback, bloc=
king
> + *   helpers until cleared.
> + * @autosuspend_delay: Delay time in milliseconds to be used for runtime
> + *   autosuspend.
> + * @last_busy: Timestamp in nanoseconds when pm_runtime_mark_last_busy()=
 was
> + *   last called. Used in calculating inactivity periods for autosuspend=
.
> + * @active_time: Accumulated time in nanoseconds spent in %RPM_ACTIVE st=
ate.
> + * @suspended_time: Accumulated time in nanoseconds spent in %RPM_SUSPEN=
DED
> + *   state.
> + * @accounting_timestamp: Timestamp in nanoseconds of the last runtime P=
M state
> + *   accounting update.
> + * @subsys_data: Subsystem-specific power management data.
> + * @set_latency_tolerance: Callback for setting latency tolerance.
> + * @qos: Per-device PM Quality of Service (QoS) constraints.
> + * @detach_power_off: Indicates device should be detached from PM domain=
 on
> + *   power off.
> + *
> + * Device power management information stored in the "power" member of s=
truct
> + * device.
> + */
>  struct dev_pm_info {
>         pm_message_t            power_state;
>         bool                    can_wakeup:1;
> --
> 2.55.0.979.g7e5102b832-goog
>
