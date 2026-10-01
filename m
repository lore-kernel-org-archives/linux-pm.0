Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CABD37F8DD
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859653; cv=none; b=XwvgB+TSyJbgaOw+JK+Cb9yGOD1JfsUwREYmQMUw9fs/5bk601VOLu2qwylnPEmLwUTRZvZ4BiD1s6MG3qZZ6kv+x8EZUP61tUF8YTGgQhI45GGz41sYgUs9z18LsH8KW3aq8sYP38zFzMvkAoYrpLgrSADEuobssusYE5KMY4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859653; c=relaxed/simple;
	bh=tMljaISo/9I0DG/bN+vAgBnnJUNmlYdFVwga45m9kTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtfkDh6EoP85VkWFxzxcpY/c9xTu/Q3eZinqfV0syMgO5Rq8jamkx9hFskxByv8wbkr0KC/K+FI1CZHpzrgRlZuuUDbmoQEFewr9uEImwDplUToa7dFDjJDyZ5OxBLCaq1EtzUgh7W/9hTeRCjdabKDwJFff5K7mVc6Fd0OkhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7YQviCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7YQviCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F081F00898
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859651;
	bh=KHXUneKs9Jfbf9u4LYiB1pAFKuyeCk45mbKds6KZ8+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=J7YQviCzpgj+utGR3EjCvDmyptDVwT5uKApDcC3Gp+0OXMb2E1WRcGbeR1issrj5F
	 SY/qgo1YG18qjo7DjEKKduABbFr5kiyLcRrQnnZ3ytKVU5JXpYlLHqhAB4Cx/aRDtz
	 HFrkHoVtQvTyJuIPbJ8R2gaxHFLVVRlt0Ew/g58j+aQ8CQOGqsyxS0l4dRaSrLN4zS
	 HbwJ5MDPGcRbUzVEHBSnucj1fI8DOZtEYfP3Wh1BWyDKwx7ux0M9beRrg7ZiHfMfDQ
	 Z3Ic8b7tYilTKfD5PAVEkJkhm1UDY/iO+qTW35JOSiSkzRnbFv2TAZ5Lku+JjHXeFV
	 rjO0Zw7TfPWnA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba31af701aso2466702e87.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 06:00:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxEsI3bCVGtQFI/o3NJ0IRmKlNgKgNrrWUd8JrKaSzN1jG28DpT0ebdw3CAyHIXZG5x5+YMJ77P3w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJrUAQ9Qsp72ZvlBr2tjQJazvdlGXpYq+1hSutV7EXzrI0aB2tG
	39y67mku/0vKh9FEGFQHzxunggIkEauZ6Pw1s7lPzCsDpXoyPEYoU7Rgb8nvfPtbRgsO7bPiBBo
	HgF8h/b//gbCxojKnAz4RV161E3swpIo=
X-Received: by 2002:a05:6512:2398:b0:5bb:7b2a:5b19 with SMTP id
 2adb3069b0e04-5bb7b2a5be3mr126859e87.0.1790859649529; Thu, 01 Oct 2026
 06:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930025044.104824-1-briannorris@chromium.org>
 <20260929194956.v3.7.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
 <CAJZ5v0ifwGx-1H-YVM63-0HUD5cs+5W4Tk8T+2LdLZpy5sLS9w@mail.gmail.com> <ar2d2xCi9ITd3NYH@google.com>
In-Reply-To: <ar2d2xCi9ITd3NYH@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 1 Oct 2026 14:59:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hYOjKMxEdtvqfO_T4K2eiZsNAeqZOymx0vb_q66QB6Hw@mail.gmail.com>
X-Gm-Features: AclHuK8srxPF81keIGu9488uS5H_eERec2uNtQ6Kxk6suulT9ilfC5Id9fj7Sqk
Message-ID: <CAJZ5v0hYOjKMxEdtvqfO_T4K2eiZsNAeqZOymx0vb_q66QB6Hw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] PM: runtime: Expand introduction with core
 concepts and structure
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Ulf Hansson <ulfh@kernel.org>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:40=E2=80=AFAM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> Hi Rafael,
>
> On Wed, Sep 30, 2026 at 05:41:56PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Wed, Sep 30, 2026 at 4:51=E2=80=AFAM Brian Norris <briannorris@chrom=
ium.org> wrote:

[cut]

> > > +
> > > +Core Concepts
> > > +-------------
> > > +
> > > +Understanding runtime PM requires distinguishing between several pai=
rs of
> > > +related but distinct concepts that apply to each device: **enabled**=
 /
> > > +**disabled**, **active** / **suspended**, and **allowed** / **forbid=
den**.
> > > +
> > > +* **Enabled**: To use runtime PM to manage a device's power states, =
it must
> > > +  first be **enabled**. If RPM is never enabled for a device, it gen=
erally
> > > +  stays inactive from an RPM perspective, and the PM core will ignor=
e it.
> > > +  If it is enabled, the PM core can manage the device status (see **=
Active**
> > > +  below) according to its understanding of whether the device is in =
use, and
> > > +  perform state transitions via the appropriate PM callbacks
> > > +  (->runtime_suspend(), ->runtime_resume()).
> > > +
> > > +  Each device has an internal disable counter (``disable_depth``) wh=
ich
> > > +  determines whether runtime PM is currently enabled. Devices are in=
itially
> > > +  registered with runtime PM disabled (``disable_depth =3D=3D 1``), =
though some bus
> > > +  types (such as PCI) may enable it before driver probe.
> > > +
> > > +  To opt into runtime PM, a driver first ensures that the device's r=
ecorded
> > > +  status matches its actual physical state (for example, by calling
> > > +  pm_runtime_set_active() if the device was powered on at probe) and=
 then calls
> > > +  pm_runtime_enable(), decrementing ``disable_depth`` to zero (i.e.,
> > > +  **enabled**). Runtime PM may be disabled again explicitly via
> > > +  pm_runtime_disable() or temporarily during system sleep transition=
s.
> > > +
> > > +* **Active**: The PM core tracks a device's runtime status as either=
 **active**
> > > +  (the device is operational, having completed its resume callback o=
r otherwise
> > > +  marked active) or **suspended** (the device is idle or in a low-po=
wer state,
> > > +  having completed its suspend callback or otherwise marked suspende=
d), along
> > > +  with transitional **suspending** and **resuming** phases. When run=
time PM is
> > > +  **enabled**, state transitions are primarily driven by reference c=
ounting:
> > > +  drivers call pm_runtime_resume_and_get() (or related variants) bef=
ore using
> > > +  the hardware, to ensure the device is active; and pm_runtime_put()=
 (or
> > > +  related variants) once work completes. When a device's usage count=
er drops to
> > > +  zero and its dependencies (children or consumers) are suspended, t=
he PM core
> > > +  can suspend the device immediately or after an autosuspend delay.
> > > +
> > > +  Besides driving the state of the device in question, a device's ru=
ntime
> > > +  status also affects those of its dependencies =E2=80=94 its parent=
 (if the parent's
> > > +  ``power.ignore_children`` is false) and its linked supplier device=
(s) (for
> > > +  links with the ``DL_FLAG_PM_RUNTIME`` flag). An **active** device =
holds
> > > +  reference counts on its dependencies, preventing them from suspend=
ing.
> > > +
> > > +* **Allowed**: System policy and user space govern whether dynamic s=
uspension
> > > +  is permitted through the concepts of **allowed** and **forbidden**=
,
> > > +  manipulated in-kernel via pm_runtime_allow() and pm_runtime_forbid=
() and
> > > +  exposed to user space through the ``/sys/devices/.../power/control=
``
> > > +  attribute. When runtime PM is forbidden (``control`` set to ``on``=
), the PM
> > > +  core increments the device's usage counter, forcing the device to =
remain
> > > +  active regardless of whether the driver is idle. When runtime PM i=
s allowed
> > > +  (``control`` set to ``auto``), this reference is dropped, permitti=
ng the PM
> > > +  core to automatically suspend the device whenever its driver and c=
hild
> > > +  devices are no longer using it.
> > > +
> > > +Notably, runtime PM also has a feature called "autosuspend." This is=
 different
> > > +than the ``control`` notion of "auto" (i.e., "allowed"). Autosuspend=
 is
> > > +described in more detail in `Section 9`_.
> >
> > Regarding the above, I have reconsidered it with the conclusion that
> > it would be better to describe "active" and "suspended" first and
> > "enabled" and "disabled" subsequently,
>
> I also found it to be not-so-great to put "enabled" first, as it still
> requires forward-references to "active" to cover it sufficiently.
>
> > and maybe without going too
> > much into details yet.
>
> Sure. There are probably some details that could be omitted from my
> version. Frankly, some of those details are there because you asked for
> them though...
>
> > Here's my version of it:
>
> Thanks! My general thoughts are:
>
> 1) I think your version adds a few things that are nice to have. For
>    example, a better clarification of what "active" and "suspended" mean
>    from both physical device level, and from abstract RPM meaning. (This
>    may also be where you've insisted on "meta-state" as a term. I don't
>    agree that "meta" adds any value, but I won't insist.)

I just want to make it clear that "active" and "suspended" are
abstract and not tied to any specific device states in principle.
Maybe this is obvious.

>    I also think the "forbidden" implication is a good addition: "the
>    ability to transition a device into the suspended meta-state via
>    runtime PM must not be relied on for correctness" -- that's one
>    reason I wanted to put allowed/forbidden up top; that it throws a
>    wrench in many people's assumptions.
>
>    You spend more time on dependencies. That's a good thing IMO.
>
> 2) I think your version adds some things that are undesirable for an
>    intro. For one, it spends quite some time to talk about the pitfalls
>    of a "disabled+active" device. I think this is not something that
>    goes in an introduction, and is more of an anti-pattern. If we wanted
>    to document anti-patterns, we could write another few essays, I'm
>    sure... It's also somewhat covered in Section 5 already.

Fair enough.

>    You've also completely omitted describing reference counting.

Kind of on purpose because I didn't want to pull up too much internal stuff=
.

>  This is  one of the most fundamental aspects of RPM, IMO. (OTOH, omittin=
g API
>    names is a fine choice.) I think your elaboration of "dependencies"
>    is a good time to just break out a section on what constitutes "in
>    use" -- get()/put() references, and dependents.
>
> 3) Lack of organizational clarity -- your version looks more like a wall
>    of text essay, which IMO doesn't do so well at engaging introductory
>    readers, or those skimming for one concept (e.g., "forbidden"). I
>    still prefer the structure that clearly highlights the main topics,
>    either with bullets or sections or something.

This is a matter of personal preference.

> 4) autosuspend -- I think it deserves a mention in the intro, even if
>    it's a pointer to the existing section. Not sure if you meant to drop
>    it.
>
> 5) Wordy. Your intro has about ~%50% more words. I think the same
>    content could be represented more succinctly, to make for a better
>    read.
>
> ...but:
>
> 6) It's better than not having this introduction at all!
>
> So aside from the general thoughts above, I will:
>
> (a) add minimal direct feedback to the text below, in case you'd still
>     prefer taking a variation of your content. That would be OK with me.
>
> (b) provide my own adaptation of my writing + your writing at the end,
>     in case you'd rather try that.
>
> > "There are some device-level concepts that need to be grasped in order
> > to understand runtime PM as a whole.
>
> I think listing the concepts at the top helps, as a sort of introductory
> paragraph/sentence to the following wall of text and/or bullets.
>
> Also, super-nits: you seem to wrap at about 70 chars, while most of this
> doc (and other docs, I think) wraps at around 78-80.
>
> I also see a difference on two spaces after periods or not. I guess most
> of this doc uses two, even though that's not the dominant style these
> days. I'll try to stick with two spaces now that I noticed. (Fun fact:
> it seems browsers automatically collapse these to one space, when
> viewing the generated HTML.)
>
> > First of all, runtime PM tracks whether or not devices are in active
> > use, which generally means that they are accessible and operational,
> > and may be depended on by something (for example, other devices or
> > user space).  That is represented by the **active** meta-state of a
> > device from the runtime PM perspective.  The other persistent device
> > meta-state used by runtime PM, called **suspended**, represents a
> > promise that the given device will not be accessed.  This covers
> > devices in low-power states, but it also may include devices that are
> > not fully operational, or are regarded as such, for other reasons.
> > There are also two transient meta-states, **suspending** and
> > **resuming**, that represent transitions between **active** and
> > **suspended** often referred to as *runtime suspend* and *runtime
> > resume*, or just *suspend* and *resume*, respectively.  Every device
> > handled by runtime PM is in one of these four meta-states at any time
> > and the meta-state it is in is expected to reflect its actual physical
> > configuration (that is, for instance, if the device is not accessible,
> > it cannot be **active**).  The term "runtime PM state" used in what
>
> Somewhat nitpick: everything else seems to call it "runtime PM status"
> or similar, not "runtime PM state". `enum rpm_status`, most of the
> existing doc language, the 'power.runtime_status' field, etc.
>
> > follows refers to the meta-states described above.
> >
> > Second, in order to track the runtime PM state and carry out
> > transitions between **active** and **suspended**, runtime PM needs to
> > be **enabled** for the given device.  If it is **disabled**, it
> > generally leaves the device alone.  This means in particular that the
> > runtime PM state of a device and its actual physical configuration may
> > get out of sync after disabling runtime PM for it.  Analogously, the
>
> I'm not sure "analogously" is the right word here. It seems like you're
> going for "additionally" or some other similar word.
>
> > runtime PM state of a device may need to be explicitly adjusted to
> > reflect its current physical configuration before enabling runtime PM
> > for it.  Moreover, it is generally not recommended to leave devices in
> > the **active** meta-state after disabling runtime PM for them because
> > that may affect what can be done to their ancestors and suppliers
> > going forward.
> >
> > More specifically, in addition to tracking the runtime PM state of
> > every device, runtime PM tracks dependencies between different
> > devices.  In fact, that dependency tracking mechanism is the main
> > reason for using runtime PM.  The idea is that in order for a device
> > to become **active**, all of the devices it depends on must also be
> > **active** and that is enforced by runtime PM.  Accordingly, an
> > attempt to resume a device causes all of the devices it depends on to
> > become **active** and remain **active** until the given device is
> > suspended.  In turn, an attempt to suspend a device may allow the
> > devices it depends on to also suspend unless they are additionally
> > depended on by something else.  While desirable so long as runtime PM
> > is **enabled**, this may become problematic when runtime PM is
> > **disabled** because the tracking of dependencies does not stop
> > automatically at that point and it may cause some devices to remain
> > **active** unnecessarily.
>
> Like I said above, I like that you went into more detail on
> dependencies. But I think this is a pretty divergent train of thought.
> In my edited version below, I chose to break it out into a new
> bullet/section, kept after the first 3.
>
> > As a rule, runtime PM is **disabled** for all devices to start with,
> > but there are bus types that enable it for every device (for instance,
> > the PCI bus type does so).  Generally speaking, drivers are expected
> > to know which bus they belong to and so they should also know whether
> > or not runtime PM has been enabled for the devices handled by them
> > already.  In the cases in which runtime PM is not enabled by the bus
> > type, drivers are responsible for enabling it if they want to
> > participate in it.  The devices for which runtime PM has never been
> > enabled are black boxes from its point of view.
>
> I think most of this paragraph is a bit too much, and is easily derived
> from just explaining that "most start disabled; some buses (like PCI)
> make more initial choices for you; choose accordingly".
>
> I'm also not sure what the "black box" mention adds on top of the
> earlier, "If it is **disabled**, it generally leaves the device alone."
>
> > Finally, runtime PM may be **forbidden** even though it has been
> > enabled.  Doing so causes the given device to transition into the
> > **active** meta-state (unless it has been **active** already before)
> > and prevents it from being suspended.  In other words, a device with
> > forbidden runtime PM remains **active** at least until runtime PM is
> > **allowed** for it again.  This mechanism is not only available to
> > kernel code, but it may also be used by user space through the
> > ``/sys/devices/.../power/control`` *sysfs* attribute of the given
> > device.  Namely, writing ``on`` to that attribute causes runtime PM to
> > be forbidden for it, and writing ``auto`` to that attribute causes
> > runtime PM to be allowed.  User space may use that attribute at any
> > time, so the ability to transition a device into the **suspended**
> > meta-state via runtime PM must not be relied on for correctness, among
> > other things."
>
> I still think autosuspend belongs in the intro, even if only to link to
> the existing section. (I also think the "auto" vs "autosuspend"
> disambiguation is important, but I'm also open to moving that part to
> Section 9 or similar.)
>
> > I think that it provides all of the information needed to start with
> > without pulling too much stuff documented elsewhere.
> >
> > If you agree with the above, I'll send my version as a separate patch.
>
> I'm obviously biased, but I think there's room for improvement. I'm
> providing my adaptation of your text below, but I'm also open to yours
> however you see fit. Like I said, one of these options is better than
> none.
>
> Let me know if I should send the below in v4, or else please mail your
> own for review!
>
> """
> Runtime PM operates around a few device-level concepts =E2=80=94 whether =
a device is
> **active** or **suspended**; whether runtime PM is **enabled** or **disab=
led**;
> whether runtime PM is **allowed** or **forbidden**; and whether a device =
is "in
> use."
>
> * **Active**: Runtime PM tracks whether or not devices are in active use,=
 which
>   generally means that they are accessible and operational, and may be de=
pended
>   on by something (for example, other devices or user space).  This is
>   represented by the **active** meta-state.  By contrast, the **suspended=
**

So you can just drop the "meta-" prefix here and elsewhere below if
you think that the meaning of "state" is clear enough.  It's up to you
though.

>   meta-state represents a promise that the given device will not be acces=
sed.
>   This covers devices in low-power states, but it also may include device=
s that
>   are not fully operational.  There are also two transient meta-states,
>   **suspending** and **resuming**, representing transitions between **act=
ive**
>   and **suspended** often referred to as *runtime suspend* and *runtime
>   resume*, or just *suspend* and *resume*, respectively.  Every device ha=
ndled
>   by runtime PM is in one of these four meta-states at any time, and its
>   meta-state is expected to reflect its actual physical configuration (th=
at is,
>   for instance, if the device is not accessible, it must not be **active*=
*).
>   The term "runtime PM status" used in what follows refers to the meta-st=
ates
>   described above.
>
> * **Enabled**: In order to track the runtime PM status and carry out
>   transitions between **active** and **suspended**, runtime PM needs to b=
e
>   **enabled** for the given device.  If it is **disabled**, runtime PM
>   generally leaves the device alone.  This means in particular that the r=
untime
>   PM status of a device and its actual physical configuration may get out=
 of
>   sync after disabling runtime PM for it.  Additionally, the runtime PM s=
tatus
>   of a device may need to be explicitly adjusted to reflect its current
>   physical configuration before enabling runtime PM for it (e.g., during =
device
>   probe).  Once runtime PM is **enabled**, it begins managing PM status =
=E2=80=94
>   performing *runtime suspend* and *runtime resume* transitions based on =
its
>   understanding of whether a device is in use.
>
>   As a rule, all devices are initialized with runtime PM **disabled**, th=
ough
>   some bus types (such as PCI) manage some RPM initialization automatical=
ly,
>   and therefore probe devices in an **enabled** state.  For other devices=
,
>   drivers must enable runtime PM on their own to opt in.
>
> * **Allowed**: Runtime PM may be **forbidden** even though it has been en=
abled.
>   Doing so causes the given device to transition into the **active** meta=
-state
>   and prevents it from being suspended.  In other words, a device with
>   forbidden runtime PM remains **active** at least until runtime PM is
>   **allowed** for it again.  This mechanism can be managed by in-kernel A=
PIs,
>   but more importantly, it is also available to user space via the
>   ``/sys/devices/.../power/control`` sysfs attribute of the given device.
>   Namely, writing ``on`` to that attribute forbids runtime PM, and writin=
g
>   ``auto`` allows it.  User space may modify that attribute at any time, =
so the
>   ability to transition a device into the **suspended** meta-state via ru=
ntime
>   PM must not be relied on for correctness.
>
> * **In use**: Runtime PM determines whether a device should be transition=
ed to
>   an **active** state by its understanding of whether a device is in use.=
  The
>   first way a device is considered **in use** is by its own usage count =
=E2=80=94 a
>   reference counter driven by a variety of get()/put() APIs.  Additionall=
y, a
>   device may be considered **in use** by having active dependents =E2=80=
=94 either
>   child devices, or device-linked consumers.  When a device is no longer =
in
>   use, runtime PM may choose to transition it to the **suspended** state.
>
>   Thus, when a device moves from a **suspended** to an **active** state, =
it may

I would say "from **suspended** to **active**" here

>   also cause its dependencies to resume.

Also, I'd say "it causes its dependencies to resume unless they are
**active** already"

>  Conversely, suspending a device may
>   also cause its otherwise-unused dependencies to suspend.
>
> * **Autosuspend**: Runtime PM also supports a feature called "autosuspend=
."
>   This is different than the ``control`` notion of "auto" (i.e., **allowe=
d**).
>   Autosuspend is covered in `Section 9`_.
> """

Apart from the nits above, this looks fine to me.  Please feel free to
send a v4.

Thanks!
