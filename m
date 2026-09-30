Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8504F7CCD
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783032; cv=none; b=LJ+3clKtzCU/XqO5FB7u6M0czIKlgTbnuVZGuLLK8yxA426C+EZpXZq6nebMR8ioxI/ZyXpW1eMeiAW4BdzehfZpuTX2xKqMkXXf7zYi8zllOxVnPWGUCgGBm4SCIHjKgjAPTKmF2DVprl44U7T6vI2g2mcqOel3BR2CgJSG5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783032; c=relaxed/simple;
	bh=XH49CGixjjksXun7g5i7bMMAdjRXsDHjHFvYOdHvpVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miOPJPKI5CNTogyvKB3u7/uoeB9U0apxv+lD+5SSfVJEf3lefklQWV9O7hBTwYCkYcdQoLZMdJm8ORvAbfHaH4lEYoVIPoo/ci7x6fw9Me5hx91J4wqCdA39HbNABnOdsaizpv9dC9emIy8akXtHQZ/mL9RbAny0Bk8zm0DDb9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H28pCtz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H28pCtz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEB11F0089F
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 15:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790783024;
	bh=RgDyfRoaqiRPgneHgZKWaqHOPayWQXCh/v6+T6AoTk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H28pCtz/NWuzAwuSUne6iRNSKDiSGDJ1B7T1jhz6DHg9DW3wVWjuwS4SSjagOP9FT
	 BU8GLcXVVvCv2PAj/xhmfxZvLzPS6itsWej4IKVLwdYHsBEhoSWitobKyoIekD28Sx
	 n7tTYJcJOWYZ2hrU1Cwy9Azl3nxY+PD0of/ld5M6ol8kPGwbdmiTKVwwYxEOYWlZcP
	 2WQH68SaE8y2r9r/haTx/0pWHWm83lG2gh3HwJq5EVV1koxXb/PPwQ/sBCqmeY4Rg2
	 C7VZL2o29MtWSZLjV6WSfIvs9YPOlgEQg9gVcYFf+ZM8z261A4qIhW3F4NpJjIhEf0
	 M8A6h2iFGUaIA==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a773bdf720so7470531fa.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 08:43:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxSZ+afJXUQOiW8SFix7+1sUsOirmIHwK6UuUo9YHEKfVSDNM/qqZtv4qw8Z1Bwg9CV+OlDDRlCYA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJeKpzZ6zx8uKiJ0gzHyMX9QNkhksJeghBRhz6LpmFCTCIDlrvy
	rDg8pweYG1jLS5p0eAPEmFiiCJYJ1x1zXM2PtqY73CIdjgE8xFBtFflGBLdAaJBxKMmV5v6fsKs
	38Kgc55Vt4lPdzdLVwZWwOhSEtY0Uv8E=
X-Received: by 2002:a05:651c:1986:b0:3a6:636b:63c5 with SMTP id
 38308e7fff4ca-3a7791c27b5mr6513401fa.16.1790783022385; Wed, 30 Sep 2026
 08:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930025044.104824-1-briannorris@chromium.org> <20260929194956.v3.7.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
In-Reply-To: <20260929194956.v3.7.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 30 Sep 2026 17:41:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ifwGx-1H-YVM63-0HUD5cs+5W4Tk8T+2LdLZpy5sLS9w@mail.gmail.com>
X-Gm-Features: AclHuK8cCRtb72aYjdwV70zWye9WCjL7mKQ8pDTimUJJiieKZ6fYVm3sRZLghLQ
Message-ID: <CAJZ5v0ifwGx-1H-YVM63-0HUD5cs+5W4Tk8T+2LdLZpy5sLS9w@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] PM: runtime: Expand introduction with core
 concepts and structure
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Ulf Hansson <ulfh@kernel.org>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:51=E2=80=AFAM Brian Norris <briannorris@chromium.=
org> wrote:
>
> I commonly see people have difficulty learning how runtime PM works
> because of the following key points [*]:
>
>  1) there are several boolean concepts in runtime PM, with somewhat
>     similar meanings:
>
>      enabled / disabled
>      active / suspended
>      allowed / forbidden
>
>  2) if these concepts are documented at all, they're scattered across
>     the kerneldoc or Documentation/
>
>  3) the runtime_pm.rst docs don't make any attempt to ease a reader into
>     understanding the concepts, and instead jump straight into how it's
>     implemented (queues, 'struct device' fields, helpers).
>
> Let's try to remedy this a bit by discussing the core concepts and
> highlights at the top of the introduction, and introduce a few
> sub-headings, so it's easier to navigate different aspects of the
> introduction.
>
> While shuffling the intro around, I also see that the existing text
> largely mirrors the layout of the following sections (2, 3, and 4), but
> does so out of order. Reorder those, and point to section numbers.
>
> [*] In addition to API complexity. I count 61 pm_*() helpers, 7 of which
>     are variations of put() and 8 of which are variations of get().
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> Address review feedback around descriptions of "enabled" and "active". I
> know not every point of discussion was settled, but I hope this updated
> version resolves many of them and provides a better basis for further
> improvement.
>  * Avoid calling enabled and active "orthogonal"
>  * Describe more of their inter-relationship
>  * Prioritize talking about "enabled" first, since that's the first
>    concept a reader should know about
>  * Brief mentions of parent/child and supplier/consumer, and dependency
>    handling
>  * Other tweaks
>
>  Documentation/power/runtime_pm.rst | 103 +++++++++++++++++++++++------
>  1 file changed, 84 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index 68903d93a3e7..c63fbf0ff862 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -13,31 +13,96 @@ Runtime Power Management Framework for I/O Devices
>  1. Introduction
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -Support for runtime power management (runtime PM) of I/O devices is prov=
ided
> -at the power management core (PM core) level by means of:
> -
> -* The power management workqueue pm_wq in which bus types and device dri=
vers can
> -  put their PM-related work items.  It is strongly recommended that pm_w=
q be
> -  used for queuing all work items related to runtime PM, because this al=
lows
> -  them to be synchronized with system-wide power transitions (suspend to=
 RAM,
> -  hibernation and resume from system sleep states).  pm_wq is declared i=
n
> -  include/linux/pm_runtime.h and defined in kernel/power/main.c.
> -
> -* A number of runtime PM fields in the 'power' member of 'struct device'=
 (which
> -  is of the type 'struct dev_pm_info', defined in include/linux/pm.h) th=
at can
> -  be used for synchronizing runtime PM operations with one another.
> +Runtime power management (or runtime PM, sometimes shortened to RPM) all=
ows
> +individual I/O devices to transition between high and low-power states
> +dynamically while the system is running, conserving power without waitin=
g for a
> +system-wide sleep state.

I would rephrase the above as follows:

"Runtime power management (or runtime PM, sometimes also referred to
as RPM) allows individual I/O devices that are not in active use to be
put into low-power states, in which they may not be operational or
even accessible, and go back to the fully operational state as needed.
Power can be reduced this way without waiting for a transition into a
system-wide sleep state."

> +
> +Core Concepts
> +-------------
> +
> +Understanding runtime PM requires distinguishing between several pairs o=
f
> +related but distinct concepts that apply to each device: **enabled** /
> +**disabled**, **active** / **suspended**, and **allowed** / **forbidden*=
*.
> +
> +* **Enabled**: To use runtime PM to manage a device's power states, it m=
ust
> +  first be **enabled**. If RPM is never enabled for a device, it general=
ly
> +  stays inactive from an RPM perspective, and the PM core will ignore it=
.
> +  If it is enabled, the PM core can manage the device status (see **Acti=
ve**
> +  below) according to its understanding of whether the device is in use,=
 and
> +  perform state transitions via the appropriate PM callbacks
> +  (->runtime_suspend(), ->runtime_resume()).
> +
> +  Each device has an internal disable counter (``disable_depth``) which
> +  determines whether runtime PM is currently enabled. Devices are initia=
lly
> +  registered with runtime PM disabled (``disable_depth =3D=3D 1``), thou=
gh some bus
> +  types (such as PCI) may enable it before driver probe.
> +
> +  To opt into runtime PM, a driver first ensures that the device's recor=
ded
> +  status matches its actual physical state (for example, by calling
> +  pm_runtime_set_active() if the device was powered on at probe) and the=
n calls
> +  pm_runtime_enable(), decrementing ``disable_depth`` to zero (i.e.,
> +  **enabled**). Runtime PM may be disabled again explicitly via
> +  pm_runtime_disable() or temporarily during system sleep transitions.
> +
> +* **Active**: The PM core tracks a device's runtime status as either **a=
ctive**
> +  (the device is operational, having completed its resume callback or ot=
herwise
> +  marked active) or **suspended** (the device is idle or in a low-power =
state,
> +  having completed its suspend callback or otherwise marked suspended), =
along
> +  with transitional **suspending** and **resuming** phases. When runtime=
 PM is
> +  **enabled**, state transitions are primarily driven by reference count=
ing:
> +  drivers call pm_runtime_resume_and_get() (or related variants) before =
using
> +  the hardware, to ensure the device is active; and pm_runtime_put() (or
> +  related variants) once work completes. When a device's usage counter d=
rops to
> +  zero and its dependencies (children or consumers) are suspended, the P=
M core
> +  can suspend the device immediately or after an autosuspend delay.
> +
> +  Besides driving the state of the device in question, a device's runtim=
e
> +  status also affects those of its dependencies =E2=80=94 its parent (if=
 the parent's
> +  ``power.ignore_children`` is false) and its linked supplier device(s) =
(for
> +  links with the ``DL_FLAG_PM_RUNTIME`` flag). An **active** device hold=
s
> +  reference counts on its dependencies, preventing them from suspending.
> +
> +* **Allowed**: System policy and user space govern whether dynamic suspe=
nsion
> +  is permitted through the concepts of **allowed** and **forbidden**,
> +  manipulated in-kernel via pm_runtime_allow() and pm_runtime_forbid() a=
nd
> +  exposed to user space through the ``/sys/devices/.../power/control``
> +  attribute. When runtime PM is forbidden (``control`` set to ``on``), t=
he PM
> +  core increments the device's usage counter, forcing the device to rema=
in
> +  active regardless of whether the driver is idle. When runtime PM is al=
lowed
> +  (``control`` set to ``auto``), this reference is dropped, permitting t=
he PM
> +  core to automatically suspend the device whenever its driver and child
> +  devices are no longer using it.
> +
> +Notably, runtime PM also has a feature called "autosuspend." This is dif=
ferent
> +than the ``control`` notion of "auto" (i.e., "allowed"). Autosuspend is
> +described in more detail in `Section 9`_.

Regarding the above, I have reconsidered it with the conclusion that
it would be better to describe "active" and "suspended" first and
"enabled" and "disabled" subsequently, and maybe without going too
much into details yet.  Here's my version of it:

"There are some device-level concepts that need to be grasped in order
to understand runtime PM as a whole.

First of all, runtime PM tracks whether or not devices are in active
use, which generally means that they are accessible and operational,
and may be depended on by something (for example, other devices or
user space).  That is represented by the **active** meta-state of a
device from the runtime PM perspective.  The other persistent device
meta-state used by runtime PM, called **suspended**, represents a
promise that the given device will not be accessed.  This covers
devices in low-power states, but it also may include devices that are
not fully operational, or are regarded as such, for other reasons.
There are also two transient meta-states, **suspending** and
**resuming**, that represent transitions between **active** and
**suspended** often referred to as *runtime suspend* and *runtime
resume*, or just *suspend* and *resume*, respectively.  Every device
handled by runtime PM is in one of these four meta-states at any time
and the meta-state it is in is expected to reflect its actual physical
configuration (that is, for instance, if the device is not accessible,
it cannot be **active**).  The term "runtime PM state" used in what
follows refers to the meta-states described above.

Second, in order to track the runtime PM state and carry out
transitions between **active** and **suspended**, runtime PM needs to
be **enabled** for the given device.  If it is **disabled**, it
generally leaves the device alone.  This means in particular that the
runtime PM state of a device and its actual physical configuration may
get out of sync after disabling runtime PM for it.  Analogously, the
runtime PM state of a device may need to be explicitly adjusted to
reflect its current physical configuration before enabling runtime PM
for it.  Moreover, it is generally not recommended to leave devices in
the **active** meta-state after disabling runtime PM for them because
that may affect what can be done to their ancestors and suppliers
going forward.

More specifically, in addition to tracking the runtime PM state of
every device, runtime PM tracks dependencies between different
devices.  In fact, that dependency tracking mechanism is the main
reason for using runtime PM.  The idea is that in order for a device
to become **active**, all of the devices it depends on must also be
**active** and that is enforced by runtime PM.  Accordingly, an
attempt to resume a device causes all of the devices it depends on to
become **active** and remain **active** until the given device is
suspended.  In turn, an attempt to suspend a device may allow the
devices it depends on to also suspend unless they are additionally
depended on by something else.  While desirable so long as runtime PM
is **enabled**, this may become problematic when runtime PM is
**disabled** because the tracking of dependencies does not stop
automatically at that point and it may cause some devices to remain
**active** unnecessarily.

As a rule, runtime PM is **disabled** for all devices to start with,
but there are bus types that enable it for every device (for instance,
the PCI bus type does so).  Generally speaking, drivers are expected
to know which bus they belong to and so they should also know whether
or not runtime PM has been enabled for the devices handled by them
already.  In the cases in which runtime PM is not enabled by the bus
type, drivers are responsible for enabling it if they want to
participate in it.  The devices for which runtime PM has never been
enabled are black boxes from its point of view.

Finally, runtime PM may be **forbidden** even though it has been
enabled.  Doing so causes the given device to transition into the
**active** meta-state (unless it has been **active** already before)
and prevents it from being suspended.  In other words, a device with
forbidden runtime PM remains **active** at least until runtime PM is
**allowed** for it again.  This mechanism is not only available to
kernel code, but it may also be used by user space through the
``/sys/devices/.../power/control`` *sysfs* attribute of the given
device.  Namely, writing ``on`` to that attribute causes runtime PM to
be forbidden for it, and writing ``auto`` to that attribute causes
runtime PM to be allowed.  User space may use that attribute at any
time, so the ability to transition a device into the **suspended**
meta-state via runtime PM must not be relied on for correctness, among
other things."

I think that it provides all of the information needed to start with
without pulling too much stuff documented elsewhere.

If you agree with the above, I'll send my version as a separate patch.

> +
> +Implementation Structure
> +------------------------
> +
> +Support for runtime power management is provided at the power management=
 core
> +(PM core) level by means of:
>
>  * Three device runtime PM callbacks in 'struct dev_pm_ops' (defined in
> -  include/linux/pm.h).
> +  include/linux/pm.h). See `Section 2`_.
> +
> +* A number of runtime PM fields in the 'power' member of 'struct device'=
 that
> +  can be used for synchronizing runtime PM operations with one another. =
These
> +  are covered in `Section 3`_.
>
>  * A set of helper functions defined in drivers/base/power/runtime.c that=
 can be
>    used for carrying out runtime PM operations in such a way that the
> -  synchronization between them is taken care of by the PM core.  Bus typ=
es and
> -  device drivers are encouraged to use these functions.
> +  synchronization between them is taken care of by the PM core. Bus type=
s and
> +  device drivers are encouraged to use these functions. They are covered=
 in
> +  `Section 4`_.
>
> -The runtime PM callbacks present in 'struct dev_pm_ops', the device runt=
ime PM
> -fields of 'struct dev_pm_info' and the core helper functions provided fo=
r
> -runtime PM are described below.
> +* The power management workqueue pm_wq in which bus types and device dri=
vers can
> +  put their PM-related work items. It is strongly recommended that pm_wq=
 be
> +  used for queuing all work items related to runtime PM, because this al=
lows
> +  them to be synchronized with system-wide power transitions (suspend to=
 RAM,
> +  hibernation and resume from system sleep states). pm_wq is declared in
> +  include/linux/pm_runtime.h and defined in kernel/power/main.c.
>
>  .. _Section 2:
>
> --

The last part above looks fine to me.

Thanks!
