Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED5F58B6B1
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172702; cv=none; b=MNiysdioFDXudEscztdK6mTOl/7EqkQ5j4e33mr8937g5+AOnPNbLrUw3Hs1vlRa24xshAAl1+5b60dPoFhGhiE8Ko/6lADT7ezKnbOwA8GvQq/YJ0fKH1S2clPyRueZWjOUt+BQk8IRIQfGwYMzDIycDjv4i6wr7Se9/4I9eAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172702; c=relaxed/simple;
	bh=6YWqw5adQQTHyDOP+dipmwSrpo7kmtbYWeMfW0Lybi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+gRl17XoDG1bAsi7qfkHu9Emv9Z5YNbRYJA+gvYdytKoK9fmwe/X5+OSOjO7t7JzhEyLXXhpbf35r0ip26ubR/PONebjBIl5P2r0BobwZIzKZ3cmw6dSQ9pz4Sjhd12pJhZm8rJpnf0T5lQxlqETmqO6hVbOXbNsIaiJ+wx3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQEftoNE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQEftoNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB641F000CA
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172700;
	bh=FhZpz0gNx+lODojiEUjkU4/f3Iup9LR+x6EGW2kJ3Jk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WQEftoNEUxGBZeU0u1KvKkeoGyFpimR/tYUa5i9PwDWRt3GwpgsrZn+qT4A1bWLic
	 P377Zz2evfsNLpHLm7POJfVdFj8AYIFJW009i1LEwPoJdLnncVLZ39lLy3w9XcDa3m
	 UiPvdu2XL15jbFSy95xvMXS1uCkuZCfYo1Uu82mO++RQ/7eMZZsz6ZzF1K6YOKcL4E
	 FUXje33gU4TJIbCICtIPQ42QBA31Oe/NyQpw+tnA7K/7eB9jfnmV/jAJKh1pYrs1bb
	 Mxd0ye8LaXoXqrHVF0qZKxrU8ZDrN+/ycMrMbxTE4Oo3W7cLRhyYvLO5Jt72rm3pFz
	 IWAJl983o8rig==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso301015e87.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 10:45:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByJl6MtPybt2L1nXVdLEZzb0ZubKHYzF9emjXNydZPLCdpJwBi1B6BNZhK1zIsnd9NX6j2HaQJlJQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLYeR0PEnSAlQmSVHqRfVmbOVvoH+mvkZMnjMAoSEnN43PWlTOx
	NA1glxj/HCN8SgklibyhT1m1DnE69EMTwpNb5pCTrr2iQYROvZr3h8x9EQqqUgjwlgccVhM09C7
	B7EABo6ITYrClIp4lBp59gRkTNobx4Bc=
X-Received: by 2002:ac2:5696:0:b0:5be:48d2:eecf with SMTP id
 2adb3069b0e04-5be50a45c92mr103560e87.10.1792172698532; Fri, 16 Oct 2026
 10:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001155118.1750028-1-briannorris@chromium.org>
 <20261001085009.v4.2.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
 <CAJZ5v0hMHutu69acgSR7KsmcLs0McZK+-3OFoiqFrU5GnJzTNQ@mail.gmail.com>
 <as_i5MEz3WfnDQmf@google.com> <CAJZ5v0i+77gt-KmMYdxxzS4uGzxFArrYGpoDnjrfknpPOkAuHg@mail.gmail.com>
 <atE9urIHXAJZXu6k@google.com>
In-Reply-To: <atE9urIHXAJZXu6k@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 16 Oct 2026 19:42:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g56J9e9qdiR8W+BfmEbbedvpD8hop4+n9=rkFEsDG_Jw@mail.gmail.com>
X-Gm-Features: AclHuK_QSqbyNDSUeAPeGbmAFi4tvRiNzYZUfuFoEZNOJZW1Dhx4ZOH96CNLtjc
Message-ID: <CAJZ5v0g56J9e9qdiR8W+BfmEbbedvpD8hop4+n9=rkFEsDG_Jw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM: runtime: Add Example Driver Patterns section
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Doug Anderson <dianders@chromium.org>, Len Brown <lenb@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Thu, Oct 15, 2026 at 10:55=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
>
> Hi Rafael,
>
> On Thu, Oct 15, 2026 at 10:11:04PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Wed, Oct 14, 2026 at 10:15=E2=80=AFPM Brian Norris <briannorris@chro=
mium.org> wrote:
> > > On Wed, Oct 14, 2026 at 09:07:54PM +0200, Rafael J. Wysocki (Intel) w=
rote:
> > > > On Thu, Oct 1, 2026 at 5:51=E2=80=AFPM Brian Norris <briannorris@ch=
romium.org> wrote:
> > > > >
> > > > > The runtime PM API surface is pretty large, but there are a few c=
ommon
> > > > > patterns that many drivers should follow. Add some illustrative
> > > > > examples, to help guide the most common audience for runtime PM d=
ocs --
> > > > > driver writers.
> > > > >
> > > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v4:
> > > > >  * "state" to "status", to be consistent with Introduction termin=
ology
> > > > >
> > > > > Changes in v3:
> > > > >  * Rewrite Examples to avoid devm_* at first, to highlight correc=
t
> > > > >    approaches
> > > > >  * Include error-handling and remove() in any probe() Examples
> > > > >  * Advise more caution when using devm_*, as ordering issues are =
subtle
> > > > >
> > > > > Changes in v2:
> > > > >  * Add appropriate teardown to "Probe with Hardware Powered Off"
> > > > >    Example, as the remove() + power-off behavior is subtle here, =
and
> > > > >    easy to get wrong
> > > > >
> > > > >  Documentation/power/runtime_pm.rst | 475 +++++++++++++++++++++++=
+++++-
> > > > >  1 file changed, 473 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/p=
ower/runtime_pm.rst
> > > > > index e4407b687f8b..cb25e0bb4ca7 100644
> > > > > --- a/Documentation/power/runtime_pm.rst
> > > > > +++ b/Documentation/power/runtime_pm.rst
> > > > > @@ -429,7 +429,8 @@ in ->probe(). Usually this means calling pm_r=
untime_disable(),
> > > > >  pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers ca=
n use
> > > > >  devm_pm_runtime_enable() during probe, which automatically takes=
 care of
> > > > >  calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend=
() upon driver
> > > > > -detachment.
> > > > > +detachment. See also the Examples in `Section 10`_ for some effe=
ctive
> > > > > +strategies for driver teardown.
> > > > >
> > > > >  The user space can effectively disallow the driver of the device=
 to power manage
> > > > >  it at run time by changing the value of its /sys/devices/.../pow=
er/control
> > > > > @@ -654,7 +655,9 @@ The implementation is well suited for asynchr=
onous use in interrupt contexts.
> > > > >  However such use inevitably involves races, because the PM core =
can't
> > > > >  synchronize ->runtime_suspend() callbacks with the arrival of I/=
O requests.
> > > > >  This synchronization must be handled by the driver, using its pr=
ivate lock.
> > > > > -Here is a schematic pseudo-code example::
> > > > > +Here is a schematic pseudo-code example:
> > > > > +
> > > > > +.. code-block:: c
> > > > >
> > > > >         foo_read_or_write(struct foo_priv *foo, void *data)
> > > > >         {
> > > > > @@ -720,3 +723,471 @@ pm_runtime_autosuspend_expiration() from wi=
thin the ->runtime_suspend()
> > > > >  callback while holding its private lock.  If the function return=
s a nonzero
> > > > >  value then the delay has not yet expired and the callback should=
 return
> > > > >  -EAGAIN.
> > > > > +
> > > > > +.. _Section 10:
> > > > > +
> > > > > +10. Example Driver Patterns
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > +
> > > > > +The runtime PM API is large and complex, but most device drivers=
 follow a small
> > > > > +set of canonical patterns when interacting with runtime PM. This=
 section
> > > > > +illustrates standard patterns for device probing, performing I/O=
, and handling
> > > > > +interrupts.
> > > > > +
> > > > > +Probe and Initialization
> > > > > +------------------------
> > > > > +
> > > > > +Basic Probe
> > > > > +~~~~~~~~~~~
> > > > > +
> > > > > +A driver that powers on its hardware during probe and does not u=
se autosuspend
> > > > > +can initialize runtime PM using standard helpers:
> > > > > +
> > > > > +.. code-block:: c
> > > > > +
> > > > > +       static int foo_probe(struct platform_device *pdev)
> > > > > +       {
> > > > > +               struct device *dev =3D &pdev->dev;
> > > > > +               struct foo_priv *priv;
> > > > > +               int ret;
> > > > > +
> > > > > +               priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KER=
NEL);
> > > > > +               if (!priv)
> > > > > +                       return -ENOMEM;
> > > > > +
> > > > > +               platform_set_drvdata(pdev, priv);
> > > > > +
> > > > > +               /* Power on and initialize hardware registers... =
*/
> > > > > +
> > > > > +               /*
> > > > > +                * The code above left hardware powered on and op=
erational, so
> > > > > +                * tell the PM core that the device is active bef=
ore enabling
> > > > > +                * runtime PM.
> > > > > +                */
> > > > > +               pm_runtime_set_active(dev);
> > > > > +               pm_runtime_enable(dev);
> > > > > +
> > > > > +               /*
> > > > > +                * Perform remaining driver setup (e.g. register =
interrupts, device nodes).
> > > > > +                * If any step fails after enabling runtime PM:
> > > > > +                */
> > > > > +               ret =3D foo_register_device(priv);
> > > > > +               if (ret)
> > > > > +                       goto err_pm_disable;
> > > > > +
> > > > > +               /*
> > > > > +                * Upon successful return from ->probe(), the dri=
ver core
> > > > > +                * automatically executes pm_request_idle(dev), a=
llowing the
> > > > > +                * device to suspend asynchronously if its usage =
counter is zero.
> > > > > +                */
> > > > > +               return 0;
> > > > > +
> > > > > +       err_pm_disable:
> > > > > +               pm_runtime_disable(dev);
> > > > > +               if (!pm_runtime_status_suspended(dev)) {
> > > > > +                       /*
> > > > > +                        * Power back off, in case device did not=
 suspend yet.
> > > > > +                        * For example, leverage your .runtime_su=
spend()
> > > > > +                        * implementation:
> > > > > +                        */
> > > > > +                       foo_runtime_suspend(dev);
> > > >
> > > > There are two reasons why this may not work, here and below.
> > > >
> > > > First off, if a non-trivial PM domain or bus type etc is involved, =
its
> > > > .runtime_suspend() callback may need to be invoked in addition to
> > > > foo_runtime_suspend() to actually power off the device.
> > >
> > > Good point. While it's a platform_device (not a complex bus), I suppo=
se
> > > the PM domain may be relevant, at least for remove(). (probe() is
> > > already handled automatically by the device core.)
> >
> > If this is a platform device, the PM domain detach will power it off,
> > which I forgot about,
>
> I kinda get lost in that too sometimes... so even remove() is OK
> actually. Good.
>
> > so the driver only needs to prepare the device
> > for that.  If there is no PM domain, the driver runtime suspend
> > callback function can be used for the power off in principle.
>
> What's the distinction?

First, note that "PM domain" is not a synonym for "power domain".

A PM domain is essentially a set of PM callbacks that are invoked by
the PM core for the devices the PM domain is attached to instead of
their bus type callbacks.

There can be only one PM domain attached to a device at any time and
the idea is that it will amend driver PM callbacks with whatever is
needed to power manage the device from the platform or board
perspective.

For example, the ACPI PM domain uses ACPI power management (which is
based on platform-specific and board-specific information) to amend
platform driver PM callbacks.  In the presence of the ACPI PM domain,
platform device drivers may expect the devices to be ready to use at
probe time and to be turned off after driver removal.

When genpd was introduced, the idea was that it would work in analogy
with the ACPI PM domain, but I'm not sure if and to what extent that
is the case now.

Anyway, in the absence of a PM domain, the driver is responsible for
doing all of the PM-related work which may make a difference at least
in some cases.

> To me, power domains are not the only thing that
> constitute "powering on the device" -- drivers may be handling resets,
> clocks, regulators, etc., too. In either case, those are things that the
> driver is powering on in probe(), and should be torn down in error-exit
> and in remove().
>
> But in either case, those are probably things the driver is doing in its
> runtime_suspend callback.
>
> Maybe I'm clouding things by mentioning "runtime_suspend" here; the
> concept here is "power off anything you turned on in probe". So if you'd
> like another spin here, I may just call it foo_initialize() and
> foo_uninitialize(), with some comments about "power on any necessary
> resources: clocks, regulators, resets, ...".

I think that this would be somewhat better or at least less confusing.

> > So I think that the original code flow here is fine with the caveat
> > that if a PM domain is there, the driver may not actually need to
> > carry out the power off by itself.
>
> I kinda think the point of most of this power domain architecture is
> that a typical driver just doesn't have to worry about it at all (in
> probe(), and if you use runtime PM properly), so I'd prefer not
> mentioning it in the Basic example. But sure.

Well, your basic example needs to be put in a certain context because
it may not be generally applicable everywhere.

I think that you should make it clear what the driver's expectations
regarding the physical state of the device at the probe time are and
the general rule is that it is better to leave the device in the same
state in which it is expected to be found next time.

> > > > That's why
> > > > pm_runtime_force_suspend() looks for the callback to invoke.
> > >
> > > Would you be OK with pm_runtime_force_suspend() as an alternative her=
e?
> > > It seems like some drivers have started using that in remove(), which
> > > doesn't quite match its docs, but otherwise seems OK to me. I was
> > > considering that already here, and I even think it might be a good id=
ea
> > > to do automatically in devm_*, as I noted here:
> > >
> > >   https://lore.kernel.org/all/arVWVA3lks7SopQH@google.com/
> > >
> > >   (note: there's definitely at least one typo in there; should be
> > >   !pm_runtime_status_suspended(); and it needs some other adjustments=
 to
> > >   actually verify the device was suspended at time of enable(); ... s=
o
> > >   consider it a concept, not a patch.)
> > >
> > > But I kinda wanted a maintainer opinion before I went too far on that=
.
> >
> > That shouldn't be necessary as per the above.
>
> OK, yes, not necessary in this particular example.
>
> But my hope is that devm_pm_runtime_enable() can be made easier to use.
> It would be nice if we had the property:
>
>   If your device was suspended (most resources powered off) when
>   devm_pm_runtime_enable() is called, the PM helpers will suspend it
>   (power it back off) on remove().

I'm not quite convinced that runtime PM is suitable for devm_ type of
management.

IIRC, devm_pm_runtime_enable() was introduced to avoid some code
duplication between drivers, but I don't think that it may be expected
to be universally applicable.

> To me, PM runtime is pretty unique relative to other devm-supported
> subsystems: even if you carefully undo everything you did in probe in
> exactly the right inverse order, you still get things wrong -- because
> PM runtime is so stateful (especially forbid()), and so you have to
> account for an extra unwind step (call runtime_suspend-like functions in
> remove()).
>
> And to be clear, that proposal would only be useful for the "Probe with
> Hardware Powered Off" case (which I think is actually quite common, and
> quite common to do incorrectly), and not this "Basic Probe" (that powers
> on during probe).

Certainly, helpers that cover sufficiently common scenarios and help
to avoid code duplication are useful, but it needs to be clear when
exactly they are applicable and to what extent.

> > > > Second, if the driver expects the device to be powered up and
> > > > operational at the beginning of probe, which this one does AFAICS,
> > >
> > > No, that's not the intention. See:
> > >
> > >   "A driver that powers on its hardware during probe"
> >
> > So this effectively assumes no PM domain because platform_probe()
> > calls dev_pm_domain_attach() with PD_FLAG_ATTACH_POWER_ON set.
>
> Yes or no, depending on your understanding of what "powers on its
> hardware" means. Holistically, I don't usually consider something "on"
> if its power domain is on but it's still in reset, or its clocks are
> off, or its regulators are off, or ...
>
> Is there some better terminology you'd prefer here?

You may say "operational" to refer to a state in which the device is
accessible and functional, which should also be the case when the
device is "active" from the runtime PM perspective.

> > > And the pseudocode/comment:
> > >
> > >                /* Power on and initialize hardware registers... */
> > >
> > > i.e., probe() is doing the power-on work, but it's elided.
> > >
> > > Perhaps that wasn't obvious enough, so I can replace that with
> >
> > No, it's fine with me except that there is a difference between the
> > "PM domain present" and "no PM domain" cases and at least some drivers
> > may need to take it into account.
>
> I'm not really getting what the distinction is, from a driver writer
> point of view. With or without a PM domain, the driver most likely
> doesn't need to worry about the distinction. (Caveat: if you have 2 or
> more domains, you have to manage that yourself as the driver core
> doesn't handle it. But that becomes obvious rather quickly.)

I've tried to explain that above.

Thanks,
Rafael
