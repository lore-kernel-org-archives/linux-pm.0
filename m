Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1003DD51C
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023851; cv=none; b=eurNu3LGnEqrbniJg+wchRGILEtz3PYdcN41UL/hNDoBxo4jjEge0kbCARSivU/NZQbw7od34ine+Xq99n7x5d85z6yMkDAPl0KgvXKGzpAD49j8NWS238spMXlzh7q1j8p/kuTdmgR5E8z+PAUQK5qN4WcYWM/hGUh7Eh5KZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023851; c=relaxed/simple;
	bh=200nLAtn9qL/3H6PIiUZgKhSboJrmJ+If5PphdBQ4Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9CnREF/96Qiq0j17TRZuXB+RjFtfBXpqK2bJqt30ZpOOcKzwvJrHtiBKDTHIM72cAg3D5qVt0RarnaelB1kfKIsZIfz1LDpsMtPntbXFKQLzyS54b9rpmDilKqsCzJj53SjSpWCQduuoJ4kLQ4wLqAjYkGlkdwpZs42ogzoRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7X9uCQq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7X9uCQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04C31F00893
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 20:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023849;
	bh=jW35yJ7+RnpL2QAo+nhnd7Nq53QwZe1JY6E75LV16WU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=L7X9uCQqZZz/HdEldbJX0Upm0aSMrJ93VpP0TcKNC8+yLH80ePkARjoVv/n/wweSg
	 0bBEi4ZevotJJmBwRxTz7/S4UW6eLbgIPywNayZNpZZzO67D7BYZuziq0eZMTPQj4i
	 FIddtUfDevT11qSE11rdZdXcv/L5QlRru+jOLi174S9r6lun0+Hou6aEwMoZp0qwn+
	 D9lK3cb4TDJ6orK9x+i2gqw5sx0y793eChzNxmRjqCD0Mo6lRmAESR++xYWWgAOw/n
	 Y1kD+UdBsvfQ5UzzBS5B3E3nNtXLEgJUc58vHVKZf6Abb6ElgoINhnlmKLQ7qucBmp
	 dDf+Ag78CwLaA==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a302c06eceso26106871fa.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 13:50:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByZ0qekJ+V/DuSy9APrvjRFnreZufiD69U4aMKB9z99fvrKA2wfxSRyuqCuKUM8yoB3ylXWZv+ttQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nbyZ/BwwfMRZuC5YMgIT4Qs40iRUPk5YtaofYEjY85gatF/37e
	/r5vejMG+T0xEWPJKHgaiwhMLrdz+uc9ehvMV8KkcmYx4J9stYtvloQMkugZIxOmQPZEaAJR0TI
	RIt65EW7onLY8NQZ42gfE+Pn+1+MPW3I=
X-Received: by 2002:a05:651c:222a:b0:3a3:a3:3560 with SMTP id
 38308e7fff4ca-3a5fbeb4f1dmr29678601fa.6.1790023848106; Mon, 21 Sep 2026
 13:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904212000.4167880-1-briannorris@chromium.org>
 <20260904141215.6.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
 <CAJZ5v0ivQ25s_+fvhSaBJX+F80fjvBsrKtibMf=xEsi6n0FOAw@mail.gmail.com> <arGMJpS5ZU3E8ncx@google.com>
In-Reply-To: <arGMJpS5ZU3E8ncx@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 21 Sep 2026 22:49:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hpFZPpqVks=XMdaK3-s_5AkOW6fM9FLmb_zd4X4gNgcg@mail.gmail.com>
X-Gm-Features: AcwNN1WvCgB7b844BU9JNoMOeR2RruO3hM7InuGxJnBmqA-ZWlurok_JfuhTYVA
Message-ID: <CAJZ5v0hpFZPpqVks=XMdaK3-s_5AkOW6fM9FLmb_zd4X4gNgcg@mail.gmail.com>
Subject: Re: [PATCH 06/11] PM: runtime: Expand introduction with core concepts
 and structure
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 9:57=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> Hi Rafael,
>
> Thanks for the review!
>
> On Thu, Sep 17, 2026 at 09:59:36PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Fri, Sep 4, 2026 at 11:20=E2=80=AFPM Brian Norris <briannorris@chrom=
ium.org> wrote:
> > >
> > > I commonly see people have difficulty learning how runtime PM works
> > > because of the following key points [*]:
> > >
> > >  1) there are several boolean concepts in runtime PM, with somewhat
> > >     similar meanings:
> > >
> > >      enabled / disabled
> > >      active / suspended
> > >      allowed / forbidden
> > >
> > >  2) if these concepts are documented at all, they're scattered across
> > >     the kerneldoc or Documentation/
> > >
> > >  3) the runtime_pm.rst docs don't make any attempt to ease a reader i=
nto
> > >     understanding the concepts, and instead jump straight into how it=
's
> > >     implemented (queues, 'struct device' fields, helpers).
> > >
> > > Let's try to remedy this a bit by discussing the core concepts and
> > > highlights at the top of the introduction, and introduce a few
> > > sub-headings, so it's easier to navigate different aspects of the
> > > introduction.
> > >
> > > While shuffling the intro around, I also see that the existing text
> > > largely mirrors the layout of the following sections (2, 3, and 4), b=
ut
> > > does so out of order. Reorder those, and point to section numbers.
> > >
> > > [*] In addition to API complexity. I count 61 pm_*() helpers, 7 of wh=
ich
> > >     are variations of put() and 8 of which are variations of get().
> > >
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > >
> > >  Documentation/power/runtime_pm.rst | 87 +++++++++++++++++++++++-----=
--
> > >  1 file changed, 68 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power=
/runtime_pm.rst
> > > index 39fdeeda7a1e..620b6988deca 100644
> > > --- a/Documentation/power/runtime_pm.rst
> > > +++ b/Documentation/power/runtime_pm.rst
> > > @@ -11,31 +11,80 @@ Runtime Power Management Framework for I/O Device=
s
> > >  1. Introduction
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > -Support for runtime power management (runtime PM) of I/O devices is =
provided
> > > -at the power management core (PM core) level by means of:
> > > -
> > > -* The power management workqueue pm_wq in which bus types and device=
 drivers can
> > > -  put their PM-related work items.  It is strongly recommended that =
pm_wq be
> > > -  used for queuing all work items related to runtime PM, because thi=
s allows
> > > -  them to be synchronized with system-wide power transitions (suspen=
d to RAM,
> > > -  hibernation and resume from system sleep states).  pm_wq is declar=
ed in
> > > -  include/linux/pm_runtime.h and defined in kernel/power/main.c.
> > > -
> > > -* A number of runtime PM fields in the 'power' member of 'struct dev=
ice' (which
> > > -  is of the type 'struct dev_pm_info', defined in include/linux/pm.h=
) that can
> > > -  be used for synchronizing runtime PM operations with one another.
> > > +Runtime power management (or runtime PM, sometimes shortened to RPM)=
 allows
> > > +individual I/O devices to transition between high and low-power stat=
es
> > > +dynamically while the system is running, conserving power without wa=
iting for a
> > > +system-wide sleep state.
> > > +
> > > +Core Concepts
> > > +-------------
> > > +
> > > +Understanding runtime PM requires distinguishing between several pai=
rs of
> > > +complementary states that operate orthogonally: **active** / **suspe=
nded**,
> > > +**enabled** / **disabled**, and **allowed** / **forbidden**.
> > > +
> > > +* **Active**: The PM core tracks a device's runtime status as either=
 **active**
> > > +  (the device is operational, having completed its resume callback) =
or
> > > +  **suspended** (the device is idle or in a low-power state, having
> > > +  completed its suspend callback), along with transitional **suspend=
ing**
> > > +  and **resuming** phases. State transitions are primarily driven by
> > > +  reference counting: drivers call pm_runtime_get() (or related vari=
ants)
> > > +  when the hardware is needed (ensuring the device is active) and
> > > +  pm_runtime_put() when work completes, allowing the PM core to init=
iate
> > > +  suspension (immediately or after an autosuspend delay) once the us=
age
> > > +  counter and any active child dependencies reach zero.
> >
> > While the above is fine IMV, the enabled/disabled concept is more
> > fundamental
>
> Sure. So perhaps "enabled" should come first in the introduction? And
> then the (non-orthogonal, per below) relationships can be described when
> introducing the others?

Yes, something like that.

> > because "active" and "suspended" are not really relevant
> > when runtime PM is disabled.  Yes, they need to be set properly before
> > enabling it and there is some complexity related to the integration
> > with system-wide PM, but generally speaking, if runtime PM is disabled
> > for a given device, its active/suspended status is irrelevant.
>
> I think you've hit on a key point here, which makes it hard to
> understand RPM sometimes. Indeed enabled-vs-active are not fully
> orthogonal, but then, I also think your "generally speaking" qualifier
> is holding a lot of weight here -- there are quite a few ways in which
> active/suspended are relevant independently of enabled/disabled.
>
> For one, an active disabled device *will* prevent its parent from
> suspending, while a suspended disabled device will not. (Now, is that an
> *important* state? An expected state? Maybe not really, but it at least
> clouds a reader's mental model.)

So there are two things, the status and the reference counters.

The runtime suspend of a parent/supplier is prevented by the latter,
not by the former, so if you never enable runtime PM for a device or
otherwise cause the runtime PM reference counters of the parent and
suppliers to get updated, it will never affect the parent or
suppliers.

However, if you enable runtime PM for a device, you runtime-resume it
and then you disable runtime PM, the reference counters will remain
unchanged.

> And then, reading these 3 helpers, I constantly have to refer back to
> their implementation:
>
>         pm_runtime_active()
>         pm_runtime_suspended()
>         pm_runtime_status_suspended()
>
> The existence of pm_runtime_status_suspended() (which ignores
> disable_depth) means I can never fully apply the reasoning you suggest.
> I need to consider both the disable_depth and the runtime_status when
> understanding how a device will behave.

Well, as I said above, runtime_status doesn't really matter if
disable_depth is nonzero.  Reference counters are a different matter,
which I guess is the source of confusion here.

But basically, nonzero disable_depth really only means that the
device's runtime PM callbacks cannot run and its status will not
change unless explicitly updated with
pm_runtime_set_active/suspended().

> > > +
> > > +* **Enabled**: Orthogonal to whether a device is currently active or=
 suspended
> > > +  is whether runtime PM is **enabled** or **disabled**.
> >
> > So it is not orthogonal.
>
> Perhaps "independent" is a better term? I agree they're not fully
> unrelated, but they're also not fully dependent -- active/suspended has
> significant meaning even when disabled.
>
> In any case, I'll try to incorporate some more color about how they do
> relate.

IMV, "enabled" and "disabled" are not really states, they just tell
you what can happen to the device and what can be done to it.

"Active" and "suspended" are (meta)states that tell you what has
happened to the device most recently.

They aren't completely orthogonal (or independent) because "disabled"
means that whatever has happened to the device recently is now sticky
until something is explicitly done to it.

> > > This is governed by an
> > > +  internal disable counter (``disable_depth``). All devices are init=
ialized
> > > +  with runtime PM disabled (``disable_depth =3D=3D 1``)
> >
> > This is only partially true because the PCI bus type, for instance,
> > enables runtime PM for all PCI devices and so it is enabled when
> > drivers get to them.
>
> Ack. I had this in mind at some point during the drafting, but when RPM
> is so complicated, it's hard to choose where and when to document all
> the exceptions.
>
> > > and can also be disabled
> > > +  during system sleep transitions or explicitly via pm_runtime_disab=
le(). In
> > > +  the disabled state, the PM core ignores idle and suspend requests =
and will
> > > +  not execute runtime PM callbacks (->runtime_suspend(), ->runtime_r=
esume(),
> > > +  ->runtime_idle()).
> >
> > Moreover, parent-child and supplied-consumer dependencies are
> > generally not tracked for devices with disabled runtime PM.
>
> Is that really true? A disabled-but-active device still prevents its
> parents and suppliers from suspending, as far as I can tell.

Well, OK, but I've already covered this above.

> If I can interpret *your* intended mental model: if we intend not to
> RPM-manage a device, it should be left disabled and suspended, in which
> case it will generally be ignored by RPM. (Or alternatively:
> disabled-but-active is not generally an expected long-term "steady"
> state.)

Right.  More precisely, its references to the parent and suppliers
need to be dropped.

> But if that's all true, I'm still not sure what to document, to balance
> focus and simplicity (for an introduction) vs covering all the edge
> cases and complexities. Perhaps for an intro: we start with
> "enabled/disabled", and suggest that if a driver never touches RPM (and
> never "enables" the device), RPM mostly stays out of the way.

I would do that.

> But if we want to opt into RPM, then we enable() (and then start to
> think about active/suspended, per the 2nd key state).

Well, actually enable() may need to be preceded with taking references
to the parent and suppliers.

> [ Side note: since you mentioned PCI... that gets into a real-world case
>   of confusion: I've dealt with PCI driver authors that want to "prevent
>   runtime PM" in their driver [*], since they hadn't finished validating
>   all the runtime_suspend/resume behavior for a particular device. In
>   that case, pm_runtime_disable() was actually an OK choice, because the
>   PCI device was already active. But if they applied your quoted
>   reasoning, they'd have to choose something else. (And frankly, they
>   probably should.) But would that be forbid()? Or get()? That's exactly
>   the sort of question I'd hope this document can help clarify.
>
>   [*] ...yes, the PCI bus purposely holds a usage count, requiring
>   drivers to opt into RPM by pm_runtime_put_noidle() or similar... But
>   the question arises nonetheless, when people aren't really RPM
>   experts, and they're dealing with vendor drivers with odd code
>   structure. ]

I can totally agree that this whole thing is not easy to use.  I'm not
sure though if it might be made (much) easier to use TBH.
