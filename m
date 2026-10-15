Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01283480DE8
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095200; cv=none; b=J+8hWOBuS5EgDwIQFdF9sShqUN8V1bGjse0xpv3CJGa0wekgnYc5g6+At9Zz/iz6BznvPJllotDtTVHSo7DTnGwOaxDmWVyvOTyGYebNAfOl9l5JSgjs7OEqk4XRHlgk39hSc5wTo5JcYMkdz9/4dWMtWLQEg1Qk8gbooANIE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095200; c=relaxed/simple;
	bh=puljsiBncNir51HENmYDqQYvkJWr++Qpsxmt3QVVOh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSjJ0gn/RZg4No4Oc3wErNU14gBnZxJBxhAbK0Sb3UMmTPXHKkF50nhR1u5qIjM+Za3Mz3ZYuX+0ypyFkmpLIIDTNxFIiDcIvVgV/YONEnU8YD+KqtQRvtkf0K5g9aheqHussfmrW4YZTzKUj/ZjbksjA+EZt/c9dm2aJw1QCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmWSkgEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmWSkgEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EDD1F000C5
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 20:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792095197;
	bh=zg1Fcqd9aOaP7LnSdGUbj9RofhX1aHB9kDv3Ci8HRAQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hmWSkgEuNUdgBZZeYKXqLrjmhoFPyEBn8SUuaDVR05mKHszsvu1mrzRS6CN7Iy9KL
	 Cc+1wfhms20sHmCKmptFf/IZDSFQUuG+UAYCPLOSVl9IlNuOWrRwrwC1emlG9x+Do6
	 Oaq2geaoVtGyqAUiizoAfHkPZSUmMR1aniAeCoMDWK7NTcKXT4F5Dv9PM7IXtwdmwa
	 2Q7yD7xsfV6dnyoqGJ51z0rPBl7Fp52Ed6ihi/v/+IlvtMehxDjPIX9K1fb2hZnk1I
	 d8mlwBijOShVRdtGKZlij1urCbYIcJ14xb2Bso5jEsv+cqbnp9hjjCupR6WBoahtgB
	 kxE4mhdHgPKlA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a5a26c8412so53617201fa.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:13:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzdwNzKcen7wJEwa1YuPRMQ2M1C4uln/dDf6NRSZ8DE1DuiPul4OJLxnmz0fmVoPcCiWVdSDfKAcw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJyI/ixc2rG2ALUqW2heYjs3EkdxmrK86kYZXJ08PvXEZFyKpLe
	95ugg0mC4+jj+p3z/Rvvcn6qcJGh5Rb+3ss0CkL1FqXS/7O0OvYXGvrqPO9L4z29PmlDDfdyPhz
	L2/GixHs+rCA0aFyKVncrSeH2hoE2M7o=
X-Received: by 2002:a05:6512:682:b0:5ba:4296:cb8d with SMTP id
 2adb3069b0e04-5bcde8cb267mr7259163e87.57.1792095196023; Thu, 15 Oct 2026
 13:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001155118.1750028-1-briannorris@chromium.org>
 <20261001085009.v4.2.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
 <CAJZ5v0hMHutu69acgSR7KsmcLs0McZK+-3OFoiqFrU5GnJzTNQ@mail.gmail.com> <as_i5MEz3WfnDQmf@google.com>
In-Reply-To: <as_i5MEz3WfnDQmf@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 15 Oct 2026 22:11:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i+77gt-KmMYdxxzS4uGzxFArrYGpoDnjrfknpPOkAuHg@mail.gmail.com>
X-Gm-Features: AclHuK8mMQkjXiiDqDXWjOSaTWHNWM8laVY-TcPVYuhIWw64OjtDDNvcCixv618
Message-ID: <CAJZ5v0i+77gt-KmMYdxxzS4uGzxFArrYGpoDnjrfknpPOkAuHg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM: runtime: Add Example Driver Patterns section
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Doug Anderson <dianders@chromium.org>, Len Brown <lenb@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Wed, Oct 14, 2026 at 10:15=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
>
> Hi Rafael,
>
> On Wed, Oct 14, 2026 at 09:07:54PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Thu, Oct 1, 2026 at 5:51=E2=80=AFPM Brian Norris <briannorris@chromi=
um.org> wrote:
> > >
> > > The runtime PM API surface is pretty large, but there are a few commo=
n
> > > patterns that many drivers should follow. Add some illustrative
> > > examples, to help guide the most common audience for runtime PM docs =
--
> > > driver writers.
> > >
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > >
> > > Changes in v4:
> > >  * "state" to "status", to be consistent with Introduction terminolog=
y
> > >
> > > Changes in v3:
> > >  * Rewrite Examples to avoid devm_* at first, to highlight correct
> > >    approaches
> > >  * Include error-handling and remove() in any probe() Examples
> > >  * Advise more caution when using devm_*, as ordering issues are subt=
le
> > >
> > > Changes in v2:
> > >  * Add appropriate teardown to "Probe with Hardware Powered Off"
> > >    Example, as the remove() + power-off behavior is subtle here, and
> > >    easy to get wrong
> > >
> > >  Documentation/power/runtime_pm.rst | 475 +++++++++++++++++++++++++++=
+-
> > >  1 file changed, 473 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power=
/runtime_pm.rst
> > > index e4407b687f8b..cb25e0bb4ca7 100644
> > > --- a/Documentation/power/runtime_pm.rst
> > > +++ b/Documentation/power/runtime_pm.rst
> > > @@ -429,7 +429,8 @@ in ->probe(). Usually this means calling pm_runti=
me_disable(),
> > >  pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can us=
e
> > >  devm_pm_runtime_enable() during probe, which automatically takes car=
e of
> > >  calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() u=
pon driver
> > > -detachment.
> > > +detachment. See also the Examples in `Section 10`_ for some effectiv=
e
> > > +strategies for driver teardown.
> > >
> > >  The user space can effectively disallow the driver of the device to =
power manage
> > >  it at run time by changing the value of its /sys/devices/.../power/c=
ontrol
> > > @@ -654,7 +655,9 @@ The implementation is well suited for asynchronou=
s use in interrupt contexts.
> > >  However such use inevitably involves races, because the PM core can'=
t
> > >  synchronize ->runtime_suspend() callbacks with the arrival of I/O re=
quests.
> > >  This synchronization must be handled by the driver, using its privat=
e lock.
> > > -Here is a schematic pseudo-code example::
> > > +Here is a schematic pseudo-code example:
> > > +
> > > +.. code-block:: c
> > >
> > >         foo_read_or_write(struct foo_priv *foo, void *data)
> > >         {
> > > @@ -720,3 +723,471 @@ pm_runtime_autosuspend_expiration() from within=
 the ->runtime_suspend()
> > >  callback while holding its private lock.  If the function returns a =
nonzero
> > >  value then the delay has not yet expired and the callback should ret=
urn
> > >  -EAGAIN.
> > > +
> > > +.. _Section 10:
> > > +
> > > +10. Example Driver Patterns
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > +
> > > +The runtime PM API is large and complex, but most device drivers fol=
low a small
> > > +set of canonical patterns when interacting with runtime PM. This sec=
tion
> > > +illustrates standard patterns for device probing, performing I/O, an=
d handling
> > > +interrupts.
> > > +
> > > +Probe and Initialization
> > > +------------------------
> > > +
> > > +Basic Probe
> > > +~~~~~~~~~~~
> > > +
> > > +A driver that powers on its hardware during probe and does not use a=
utosuspend
> > > +can initialize runtime PM using standard helpers:
> > > +
> > > +.. code-block:: c
> > > +
> > > +       static int foo_probe(struct platform_device *pdev)
> > > +       {
> > > +               struct device *dev =3D &pdev->dev;
> > > +               struct foo_priv *priv;
> > > +               int ret;
> > > +
> > > +               priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL)=
;
> > > +               if (!priv)
> > > +                       return -ENOMEM;
> > > +
> > > +               platform_set_drvdata(pdev, priv);
> > > +
> > > +               /* Power on and initialize hardware registers... */
> > > +
> > > +               /*
> > > +                * The code above left hardware powered on and operat=
ional, so
> > > +                * tell the PM core that the device is active before =
enabling
> > > +                * runtime PM.
> > > +                */
> > > +               pm_runtime_set_active(dev);
> > > +               pm_runtime_enable(dev);
> > > +
> > > +               /*
> > > +                * Perform remaining driver setup (e.g. register inte=
rrupts, device nodes).
> > > +                * If any step fails after enabling runtime PM:
> > > +                */
> > > +               ret =3D foo_register_device(priv);
> > > +               if (ret)
> > > +                       goto err_pm_disable;
> > > +
> > > +               /*
> > > +                * Upon successful return from ->probe(), the driver =
core
> > > +                * automatically executes pm_request_idle(dev), allow=
ing the
> > > +                * device to suspend asynchronously if its usage coun=
ter is zero.
> > > +                */
> > > +               return 0;
> > > +
> > > +       err_pm_disable:
> > > +               pm_runtime_disable(dev);
> > > +               if (!pm_runtime_status_suspended(dev)) {
> > > +                       /*
> > > +                        * Power back off, in case device did not sus=
pend yet.
> > > +                        * For example, leverage your .runtime_suspen=
d()
> > > +                        * implementation:
> > > +                        */
> > > +                       foo_runtime_suspend(dev);
> >
> > There are two reasons why this may not work, here and below.
> >
> > First off, if a non-trivial PM domain or bus type etc is involved, its
> > .runtime_suspend() callback may need to be invoked in addition to
> > foo_runtime_suspend() to actually power off the device.
>
> Good point. While it's a platform_device (not a complex bus), I suppose
> the PM domain may be relevant, at least for remove(). (probe() is
> already handled automatically by the device core.)

If this is a platform device, the PM domain detach will power it off,
which I forgot about, so the driver only needs to prepare the device
for that.  If there is no PM domain, the driver runtime suspend
callback function can be used for the power off in principle.

So I think that the original code flow here is fine with the caveat
that if a PM domain is there, the driver may not actually need to
carry out the power off by itself.

> > That's why
> > pm_runtime_force_suspend() looks for the callback to invoke.
>
> Would you be OK with pm_runtime_force_suspend() as an alternative here?
> It seems like some drivers have started using that in remove(), which
> doesn't quite match its docs, but otherwise seems OK to me. I was
> considering that already here, and I even think it might be a good idea
> to do automatically in devm_*, as I noted here:
>
>   https://lore.kernel.org/all/arVWVA3lks7SopQH@google.com/
>
>   (note: there's definitely at least one typo in there; should be
>   !pm_runtime_status_suspended(); and it needs some other adjustments to
>   actually verify the device was suspended at time of enable(); ... so
>   consider it a concept, not a patch.)
>
> But I kinda wanted a maintainer opinion before I went too far on that.

That shouldn't be necessary as per the above.

> > Second, if the driver expects the device to be powered up and
> > operational at the beginning of probe, which this one does AFAICS,
>
> No, that's not the intention. See:
>
>   "A driver that powers on its hardware during probe"

So this effectively assumes no PM domain because platform_probe()
calls dev_pm_domain_attach() with PD_FLAG_ATTACH_POWER_ON set.

> And the pseudocode/comment:
>
>                /* Power on and initialize hardware registers... */
>
> i.e., probe() is doing the power-on work, but it's elided.
>
> Perhaps that wasn't obvious enough, so I can replace that with

No, it's fine with me except that there is a difference between the
"PM domain present" and "no PM domain" cases and at least some drivers
may need to take it into account.

> more-convincing code-like structures
> (regulator_get()/regulator_enable(), etc., for example) if you think
> that would help.
