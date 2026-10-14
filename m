Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A741442F
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004561; cv=none; b=KwSvlQSxkJu3Xf4AlDvhcO+jbfHX9eCqnfFEWcNEplGL3sibZexKOAjjWsg6uRlX/RcyhJW+XAkjtu08szeqEd+lOxqf3hh19iKp3yN9sVZtnNrhXVqE25mQa2q23ozJQgWJwvnaRPEZaynm4ZLoNBIy3LsUIceCutwvLoiAE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004561; c=relaxed/simple;
	bh=5nQ7Gb4Lv+YzkIA8MvsSkhr+WIiCiNF1zfmsSL1l/PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwLD33ImmmVNyUa0pgza9bkAmU9L1Vag7mAVxMBm0WAL+1H16JFq/Y4mY2UcJoXte/C0Vz8Sgkr0QY4A8+m5AaxVmPer8vk6rSnV+jRFJzryxkmJ30w4mL9yTLPlMwNDbDSxcFbKAg7/WTXGWV+LN6Wiqq2qrJ5aycmrU1pY4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1quyXeU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1quyXeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3EA1F000C5
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 19:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792004560;
	bh=P4yHuE9oecKRchkhtoS+YYilxu5k7VBhUCJf+GQfY8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B1quyXeUINvPQnKradNXMVOE0EbuJOVUIQbdvFeO6us1v6G9cXnotvEnDT+NMIv+W
	 e9SxzrJyuIh2YBpqq7lersYlsOlDAXxiCUTlguvWkUEzKZFHm/+rAxJlljDpkKT9ic
	 2xBgJN137t6HzalIfMFzUiiSg3fS+w0twPdUUO53u3agSEN7R9+B4q+OI5vSb0kTgh
	 mzBMBKJ+dutZ57O5hhgN1tnoJ/MuacglY9gIaNmpkNjisr+GK+bgvF4s3gSPW2odXF
	 sFrdX15271cBVXJnhFYJO7GrKHe/7abcDgaLOTD228aLqP/YgjyDIYmNII43BGvf2k
	 WmysQ0KW90xLA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcb2eceb3eso4098833e87.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:02:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByNu8kyLnpo5ZI5BgS0x/0323AAKVtlNXFuD37vrX61C1QO3dCfMaLUvw2nuhsqIZqoRvqHJTQKfA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLOC6ttGHW+Lo/jQcj5A66bln6nq+GkNWI9PRZDApullisYxBb1
	Tja243ZOUZkKQ7SR1Fm9RJiU496J1CHf0XGQ8iuxMXuXEdWpNSHoTenH08W9yzH7S4iMG8dY13d
	3rR1jNNkJgSczdyAzlQ8NKkpX/DAnsJc=
X-Received: by 2002:a05:6512:110a:b0:5b8:edeb:5c29 with SMTP id
 2adb3069b0e04-5bcde6caf7cmr5889762e87.43.1792004558562; Wed, 14 Oct 2026
 12:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001155118.1750028-1-briannorris@chromium.org> <20261001085009.v4.1.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
In-Reply-To: <20261001085009.v4.1.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 14 Oct 2026 21:00:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gWtAZq0S1KiGxQOEc-F+CuuzfuFrKuWFxVi96_9xeS6g@mail.gmail.com>
X-Gm-Features: AclHuK8zQ9j5WuHNIYyFttdCRYP73O4C3zpqSyDn3-lMGkkWE_KYkNQJEov19HA
Message-ID: <CAJZ5v0gWtAZq0S1KiGxQOEc-F+CuuzfuFrKuWFxVi96_9xeS6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PM: runtime: Expand introduction with core
 concepts and structure
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Doug Anderson <dianders@chromium.org>, Len Brown <lenb@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 5:51=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
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
> Changes in v4:
>  * Significantly overhaul introduction, based on Rafael's
>    feedback/rewrite
>  * Drop most implementation details (struct fields) and API names from
>    intro
>  * Expand the "in use" and dependencies concepts in the introduction
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
>  Documentation/power/runtime_pm.rst | 114 ++++++++++++++++++++++++-----
>  1 file changed, 95 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index 68903d93a3e7..e4407b687f8b 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -13,31 +13,107 @@ Runtime Power Management Framework for I/O Devices
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
> +Runtime power management (or runtime PM, sometimes also referred to as R=
PM)
> +allows individual I/O devices that are not in active use to be put into
> +low-power states, in which they may not be operational or even accessibl=
e, and
> +go back to the fully operational state as needed.  Power can be reduced =
this
> +way without waiting for a transition into a system-wide sleep state.
> +
> +Core Concepts
> +-------------
> +
> +Runtime PM operates around a few device-level concepts =E2=80=94 whether=
 a device is
> +**active** or **suspended**; whether runtime PM is **enabled** or **disa=
bled**;
> +whether runtime PM is **allowed** or **forbidden**; and whether a device=
 is
> +**in use**.
> +
> +* **Active**: Runtime PM tracks whether or not devices are in active use=
, which
> +  generally means that they are accessible and operational, and may be d=
epended
> +  on by something (for example, other devices or user space).  This is
> +  represented by the **active** meta-state.  By contrast, the **suspende=
d**
> +  meta-state represents a promise that the given device will not be acce=
ssed.
> +  This covers devices in low-power states, but it also may include devic=
es that
> +  are not fully operational.  There are also two transient meta-states,
> +  **suspending** and **resuming**, representing transitions between **ac=
tive**
> +  and **suspended** often referred to as *runtime suspend* and *runtime
> +  resume*, or just *suspend* and *resume*, respectively.  Every device h=
andled
> +  by runtime PM is in one of these four meta-states at any time, and its
> +  meta-state is expected to reflect its actual physical configuration (t=
hat is,
> +  for instance, if the device is not accessible, it must not be **active=
**).
> +  The term "runtime PM status" used in what follows refers to the meta-s=
tates
> +  described above.
> +
> +* **Enabled**: In order to track the runtime PM status and carry out
> +  transitions between **active** and **suspended**, runtime PM needs to =
be
> +  **enabled** for the given device.  If it is **disabled**, runtime PM
> +  generally leaves the device alone.  This means in particular that the =
runtime
> +  PM status of a device and its actual physical configuration may get ou=
t of
> +  sync after disabling runtime PM for it.  Additionally, the runtime PM =
status
> +  of a device may need to be explicitly adjusted to reflect its current
> +  physical configuration before enabling runtime PM for it (e.g., during=
 device
> +  probe).  Once runtime PM is **enabled**, it begins managing PM status =
=E2=80=94
> +  performing *runtime suspend* and *runtime resume* transitions based on=
 its
> +  understanding of whether a device is in use.
> +
> +  As a rule, all devices are initialized with runtime PM **disabled**, t=
hough
> +  some bus types (such as PCI) manage some RPM initialization automatica=
lly,
> +  and therefore probe devices in an **enabled** state.  For other device=
s,
> +  drivers must enable runtime PM on their own to opt in.
> +
> +* **Allowed**: Runtime PM may be **forbidden** even though it has been e=
nabled.
> +  Doing so causes the given device to transition into the **active** met=
a-state
> +  and prevents it from being suspended.  In other words, a device with
> +  forbidden runtime PM remains **active** at least until runtime PM is
> +  **allowed** for it again.  This mechanism can be managed by in-kernel =
APIs,
> +  but more importantly, it is also available to user space via the
> +  ``/sys/devices/.../power/control`` sysfs attribute of the given device=
.
> +  Namely, writing ``on`` to that attribute forbids runtime PM, and writi=
ng
> +  ``auto`` allows it.  User space may modify that attribute at any time,=
 so the
> +  ability to transition a device into the **suspended** meta-state via r=
untime
> +  PM must not be relied on for correctness.
> +
> +* **In use**: Runtime PM determines whether a device should be transitio=
ned to
> +  an **active** state by its understanding of whether a device is in use=
.  The
> +  first way a device is considered **in use** is by its own usage count =
=E2=80=94 a
> +  reference counter driven by a variety of get()/put() APIs.  Additional=
ly, a
> +  device may be considered **in use** by having active dependents =E2=80=
=94 either
> +  child devices, or device-linked consumers.  When a device is no longer=
 in
> +  use, runtime PM may choose to transition it to the **suspended** state=
.
> +
> +  Thus, when a device moves from **suspended** to **active**, it may als=
o cause
> +  its dependencies to resume, unless they are **active** already.  Conve=
rsely,
> +  suspending a device may also cause its otherwise-unused dependencies t=
o
> +  suspend.
> +
> +* **Autosuspend**: Runtime PM also supports a feature called "autosuspen=
d."
> +  This is different than the ``control`` notion of "auto" (i.e., **allow=
ed**).
> +  Autosuspend is covered in `Section 9`_.
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

Applied as 7.4 material, thanks!
