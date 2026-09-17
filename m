Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252B4E533D
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675263; cv=none; b=o/yXSV49fzT2HGVdyISFA79pUx7+5KlmxQ2Wpe5cACkWQoD86wDb6KAMV2vastOq+n3NtB8xH+0cD4Q3VmHSb5Of7FxkLEPae3AHvloTa+JbLgiSZdoVxa+0S6sgvpAs0VzwMH3mt8Uarz1yHm1eXo3D4YNweZZBqeL7JPH+bLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675263; c=relaxed/simple;
	bh=qxcmgvHOEjnIuw5qmLXvVlzWQ/o/BZK1q3oFOTHg2to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaZZfetaS2cYrjS9+BaXM8RJPgXuF1O7b5eUczC8gUiZE5tAomA2J3sTUdV5ap2KkS4HuGlJNP5TE4L1NO5Q7QRJZ7p+BQHD2nT4rYHeQq8nl1YH0X4WIU7qjNfTKbACNbTu3k/dBaI2LpY0r8uFwKn9Id+39Olf3zRVUw3nxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BanTezuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BanTezuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAAA1F00893
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789675261;
	bh=KalH+4JYqq60RIUeriN/AZiwYomckR9FBAi+z5xvFFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BanTezuOPR1+3L6VBn1t5BRhFWjMv8R6e3iou97lFdBTcl/jnm4I9XcLl7G51rVfo
	 kdYZaaHsHNGTXEbaC8aJZl6c+/hPA3R+KzKkgWYS+hGiQIzmh1WzbnOHL7CNkJujxB
	 68CUhp2h/q2VG/k0wIrfcU03+AI59EFsG44/a5WHjV6eshY/BVsQfCqZWv+CSovz3h
	 IhsHJrC/9USwmz0+lG8ZvqeXr1E0b2iIYAYZOOh5y1Hm9AZC8Mi4FaNbNONeE5ezPT
	 7sGb5PWgt2XTiJwSOw7i4MDR5qr4sOwg5vFxITcb7WExg+W88an56ic9MY/v2lBoMB
	 8noA1wRix2OfQ==
Received: by mail-lr2-f25.google.com with SMTP id 38308e7fff4ca-3a2ff17443dso399521fa.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 13:01:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBydx22MPGoDjWOMno7EeztyqAtyPfYjlPikoUv68f2cuh0peyryymH1A+PCcOQfSexT/O7/YZKKiA==@vger.kernel.org
X-Gm-Message-State: AFuF++n1sWdbaIk7Xy9/uJM7Nw38sQ8PlDdoYggkw09RjLyDmq7xb1MW
	Vvdi5WY4W0FhUgw5TdiYAXasyoVzuI3xrUWDwVlQtjcwzLimNIwsOWX7kujk0TzDtPhIypR2vP7
	YLsRL2Qm53jfoS3UFY7ooC2dYqlKMqJ8=
X-Received: by 2002:a2e:bcc9:0:b0:3a1:980f:5907 with SMTP id
 38308e7fff4ca-3a5fbec22e7mr18031fa.8.1789675259785; Thu, 17 Sep 2026 13:00:59
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904212000.4167880-1-briannorris@chromium.org> <20260904141215.6.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
In-Reply-To: <20260904141215.6.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 17 Sep 2026 21:59:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ivQ25s_+fvhSaBJX+F80fjvBsrKtibMf=xEsi6n0FOAw@mail.gmail.com>
X-Gm-Features: AcwNN1VV-GU_KckE4dxsn5pto6RaE1DAGcRvsGkgaClI-Jx9jLSfal-wfvHGi0c
Message-ID: <CAJZ5v0ivQ25s_+fvhSaBJX+F80fjvBsrKtibMf=xEsi6n0FOAw@mail.gmail.com>
Subject: Re: [PATCH 06/11] PM: runtime: Expand introduction with core concepts
 and structure
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 11:20=E2=80=AFPM Brian Norris <briannorris@chromium.=
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
>  Documentation/power/runtime_pm.rst | 87 +++++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index 39fdeeda7a1e..620b6988deca 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -11,31 +11,80 @@ Runtime Power Management Framework for I/O Devices
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
> +
> +Core Concepts
> +-------------
> +
> +Understanding runtime PM requires distinguishing between several pairs o=
f
> +complementary states that operate orthogonally: **active** / **suspended=
**,
> +**enabled** / **disabled**, and **allowed** / **forbidden**.
> +
> +* **Active**: The PM core tracks a device's runtime status as either **a=
ctive**
> +  (the device is operational, having completed its resume callback) or
> +  **suspended** (the device is idle or in a low-power state, having
> +  completed its suspend callback), along with transitional **suspending*=
*
> +  and **resuming** phases. State transitions are primarily driven by
> +  reference counting: drivers call pm_runtime_get() (or related variants=
)
> +  when the hardware is needed (ensuring the device is active) and
> +  pm_runtime_put() when work completes, allowing the PM core to initiate
> +  suspension (immediately or after an autosuspend delay) once the usage
> +  counter and any active child dependencies reach zero.

While the above is fine IMV, the enabled/disabled concept is more
fundamental because "active" and "suspended" are not really relevant
when runtime PM is disabled.  Yes, they need to be set properly before
enabling it and there is some complexity related to the integration
with system-wide PM, but generally speaking, if runtime PM is disabled
for a given device, its active/suspended status is irrelevant.

> +
> +* **Enabled**: Orthogonal to whether a device is currently active or sus=
pended
> +  is whether runtime PM is **enabled** or **disabled**.

So it is not orthogonal.

> This is governed by an
> +  internal disable counter (``disable_depth``). All devices are initiali=
zed
> +  with runtime PM disabled (``disable_depth =3D=3D 1``)

This is only partially true because the PCI bus type, for instance,
enables runtime PM for all PCI devices and so it is enabled when
drivers get to them.

> and can also be disabled
> +  during system sleep transitions or explicitly via pm_runtime_disable()=
. In
> +  the disabled state, the PM core ignores idle and suspend requests and =
will
> +  not execute runtime PM callbacks (->runtime_suspend(), ->runtime_resum=
e(),
> +  ->runtime_idle()).

Moreover, parent-child and supplied-consumer dependencies are
generally not tracked for devices with disabled runtime PM.

> A driver activates runtime PM processing during
> +  initialization or probe by calling pm_runtime_enable(), decrementing
> +  ``disable_depth`` to zero.

Yes, and it needs to set the active/suspended status to reflect the
current physical state of the device before calling
pm_runtime_enable().

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
> +described in more detail in Section 9.

Yup, and the changes below look good.

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
> +  include/linux/pm.h). See Section 2.
> +
> +* A number of runtime PM fields in the 'power' member of 'struct device'=
 that
> +  can be used for synchronizing runtime PM operations with one another. =
These
> +  are covered in Section 3.
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
> +  Section 4.
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
>  2. Device Runtime PM Callbacks
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> --
> 2.55.0.979.g7e5102b832-goog

Do the subsequent patches in the series depend on this one?
