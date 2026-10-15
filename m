Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F24A3F12
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097729; cv=none; b=LsiPRnnOs1DCkpGd+DnG7lh/sknq+/OKr4HbPCnNFaPTn/BLh0zHH41KtAJ+j1cEa0gO+OdDO1rRTs5MvAK0f0kNH7TFRAEX/AY4qwSYM1fQ8Ky6v0tyhzuFE2841kwb5TdL3kL8OrzFhEtwhPLdltyP4G5m/BFWeMGlF/J8IZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097729; c=relaxed/simple;
	bh=c9Qtluf7ZshU0aR17BFxWix7GUKxN5ZbaE9FyW9jvEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3P+4B1HyWcmPMteQJSrXZ10hX7eQqyCXzoxbZ9rl7sOpa/bDU/7+KNCSGAdGeYeHf3o3iZfwWhWr3eLZPlx4p0IunSxlMmiJBC4EyxiO+9YhZaLweJCwBB7k390B1HR8J3J9MVnN0vD3D3EfiSu8+pHOq2piTxZ09UV0JJ8WUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g/mWTsAw; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g/mWTsAw"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-144f79153f5so342780c88.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792097726; x=1792702526; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X8bEIgitrkqvRtRsMZkLu96+O326LNdToqWMo5vbB8k=;
        b=g/mWTsAwWzzrGBq7cUkQ0Lrt2c0Nfc0bOKkiRv+2Hyi1GBD3MrSpKWtwY+bgEqA3rx
         BWBxO4PHjWH1ggG9jZ/DBy+I5v9YeVWUNDWVL7E6pukftmvHMFvrToHUFOh0olBJVvWm
         L3yd5JPVtZ/m0+BPAK1JvJJnJhWPGhaU1ncjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097726; x=1792702526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X8bEIgitrkqvRtRsMZkLu96+O326LNdToqWMo5vbB8k=;
        b=kffWGlW5d331+9yegiA+/lBFZLkRpoAY3+GzOoAMuLekZGn5ArUAVc9ap8TimUET+t
         w30XGS+aDEqbUkD4Sjwk/lNhJDxi0v8Ga4TDfUt2IRCIUs7gtDKPXWKFsxZeaONevvD2
         aE9Ui+5dLGVe2pF2IjPhje1NoKGuHGL11+ohISA3hvvPhLrk/zT4SPKfHSisKwDBN9aP
         8ffnPb6Bd+bSDCBkSAeFa1FM1ih0SD4JBSFequftpaM3mzAoVJR3jBXyQryRMUccL7nD
         /Gy8gUwQRFo0q1FMNSpu/ouwbBLPbToNYbHLiM0K5WBITiUCdbhEtiyqa69nTUw7uw9Q
         jYMA==
X-Forwarded-Encrypted: i=1; AKwUvByAgBH1Xg+KxeQJkAqJW1I6u4DeSODKkp6dJ/vom4O5fGb+5p+bSJ7fYBd1UtQbW+mPAxw/Cba7Cg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJRIk6HYi0YyIx37bO2crz0dVQHoEV7TxncIPjVCEJqfTMC1snM
	KnAQZjT6GdZTzFiVvSBF5i9Z9pM1UYF84GbyPSA5OG12qkDzwUpS9ZpPhRMj5IEWPA==
X-Gm-Gg: AYBFou112K7rmaD9Cei6a8K+23rwi8kX/XGSLf7FgTd8EsNBsnAgy1IzDtaNuTNrx9e
	2NF+YwQIv2D5MBu87OUyHbWWtEF8ajihRzguHPCaocOt/NpE8/Dso7xJnfQsHAXOw7pOPTytYW5
	7LsfrmI5b8/LfgD6aKEq5mkhY+iQfhu/rBBYH6/iIv0/xUfZdGxbOX7yDze1e7HoKX7cxuPi0o5
	3mWoAAzuUyVk6ykTqMaV5tvnxVdXFviZqzUtlED8y1DFk1sQNqeuISDKtYFdJICdRimRBzvY9i0
	icHMr/5LqoCpUuOOx5UX4finjLYNPEk345EXeC9+6pm7TI16zefNoJGUafVwnoxVWvwixechv8U
	l3py18cY1zVd6J9AtigXvLYYuP/zq+/Zg0ox9NIVCwOwbg0klquxL2HXsyhSRyoJ5KdIRDGOTHi
	q6GjgH4XXQGeyT92IIifSRTeuWTz1cIfOlZK5k8to3bNuzmWmoYMyiUv4+IE9PcTTeABWl1pwHQ
	yvnRAnCKn8OgVVQzaosa3bWtvRLtDkyg09s
X-Received: by 2002:a05:7023:c005:b0:14a:a6dc:9cbf with SMTP id a92af1059eb24-1824fa8be2dmr1049688c88.4.1792097726108;
        Thu, 15 Oct 2026 13:55:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:6dd8:32ff:d05c:7c])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1831919fc14sm200874c88.6.2026.10.15.13.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 13:55:25 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:55:22 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>, Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v4 2/2] PM: runtime: Add Example Driver Patterns section
Message-ID: <atE9urIHXAJZXu6k@google.com>
References: <20261001155118.1750028-1-briannorris@chromium.org>
 <20261001085009.v4.2.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
 <CAJZ5v0hMHutu69acgSR7KsmcLs0McZK+-3OFoiqFrU5GnJzTNQ@mail.gmail.com>
 <as_i5MEz3WfnDQmf@google.com>
 <CAJZ5v0i+77gt-KmMYdxxzS4uGzxFArrYGpoDnjrfknpPOkAuHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i+77gt-KmMYdxxzS4uGzxFArrYGpoDnjrfknpPOkAuHg@mail.gmail.com>

Hi Rafael,

On Thu, Oct 15, 2026 at 10:11:04PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Wed, Oct 14, 2026 at 10:15 PM Brian Norris <briannorris@chromium.org> wrote:
> > On Wed, Oct 14, 2026 at 09:07:54PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > On Thu, Oct 1, 2026 at 5:51 PM Brian Norris <briannorris@chromium.org> wrote:
> > > >
> > > > The runtime PM API surface is pretty large, but there are a few common
> > > > patterns that many drivers should follow. Add some illustrative
> > > > examples, to help guide the most common audience for runtime PM docs --
> > > > driver writers.
> > > >
> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > ---
> > > >
> > > > Changes in v4:
> > > >  * "state" to "status", to be consistent with Introduction terminology
> > > >
> > > > Changes in v3:
> > > >  * Rewrite Examples to avoid devm_* at first, to highlight correct
> > > >    approaches
> > > >  * Include error-handling and remove() in any probe() Examples
> > > >  * Advise more caution when using devm_*, as ordering issues are subtle
> > > >
> > > > Changes in v2:
> > > >  * Add appropriate teardown to "Probe with Hardware Powered Off"
> > > >    Example, as the remove() + power-off behavior is subtle here, and
> > > >    easy to get wrong
> > > >
> > > >  Documentation/power/runtime_pm.rst | 475 ++++++++++++++++++++++++++++-
> > > >  1 file changed, 473 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > > > index e4407b687f8b..cb25e0bb4ca7 100644
> > > > --- a/Documentation/power/runtime_pm.rst
> > > > +++ b/Documentation/power/runtime_pm.rst
> > > > @@ -429,7 +429,8 @@ in ->probe(). Usually this means calling pm_runtime_disable(),
> > > >  pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can use
> > > >  devm_pm_runtime_enable() during probe, which automatically takes care of
> > > >  calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() upon driver
> > > > -detachment.
> > > > +detachment. See also the Examples in `Section 10`_ for some effective
> > > > +strategies for driver teardown.
> > > >
> > > >  The user space can effectively disallow the driver of the device to power manage
> > > >  it at run time by changing the value of its /sys/devices/.../power/control
> > > > @@ -654,7 +655,9 @@ The implementation is well suited for asynchronous use in interrupt contexts.
> > > >  However such use inevitably involves races, because the PM core can't
> > > >  synchronize ->runtime_suspend() callbacks with the arrival of I/O requests.
> > > >  This synchronization must be handled by the driver, using its private lock.
> > > > -Here is a schematic pseudo-code example::
> > > > +Here is a schematic pseudo-code example:
> > > > +
> > > > +.. code-block:: c
> > > >
> > > >         foo_read_or_write(struct foo_priv *foo, void *data)
> > > >         {
> > > > @@ -720,3 +723,471 @@ pm_runtime_autosuspend_expiration() from within the ->runtime_suspend()
> > > >  callback while holding its private lock.  If the function returns a nonzero
> > > >  value then the delay has not yet expired and the callback should return
> > > >  -EAGAIN.
> > > > +
> > > > +.. _Section 10:
> > > > +
> > > > +10. Example Driver Patterns
> > > > +===========================
> > > > +
> > > > +The runtime PM API is large and complex, but most device drivers follow a small
> > > > +set of canonical patterns when interacting with runtime PM. This section
> > > > +illustrates standard patterns for device probing, performing I/O, and handling
> > > > +interrupts.
> > > > +
> > > > +Probe and Initialization
> > > > +------------------------
> > > > +
> > > > +Basic Probe
> > > > +~~~~~~~~~~~
> > > > +
> > > > +A driver that powers on its hardware during probe and does not use autosuspend
> > > > +can initialize runtime PM using standard helpers:
> > > > +
> > > > +.. code-block:: c
> > > > +
> > > > +       static int foo_probe(struct platform_device *pdev)
> > > > +       {
> > > > +               struct device *dev = &pdev->dev;
> > > > +               struct foo_priv *priv;
> > > > +               int ret;
> > > > +
> > > > +               priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > > +               if (!priv)
> > > > +                       return -ENOMEM;
> > > > +
> > > > +               platform_set_drvdata(pdev, priv);
> > > > +
> > > > +               /* Power on and initialize hardware registers... */
> > > > +
> > > > +               /*
> > > > +                * The code above left hardware powered on and operational, so
> > > > +                * tell the PM core that the device is active before enabling
> > > > +                * runtime PM.
> > > > +                */
> > > > +               pm_runtime_set_active(dev);
> > > > +               pm_runtime_enable(dev);
> > > > +
> > > > +               /*
> > > > +                * Perform remaining driver setup (e.g. register interrupts, device nodes).
> > > > +                * If any step fails after enabling runtime PM:
> > > > +                */
> > > > +               ret = foo_register_device(priv);
> > > > +               if (ret)
> > > > +                       goto err_pm_disable;
> > > > +
> > > > +               /*
> > > > +                * Upon successful return from ->probe(), the driver core
> > > > +                * automatically executes pm_request_idle(dev), allowing the
> > > > +                * device to suspend asynchronously if its usage counter is zero.
> > > > +                */
> > > > +               return 0;
> > > > +
> > > > +       err_pm_disable:
> > > > +               pm_runtime_disable(dev);
> > > > +               if (!pm_runtime_status_suspended(dev)) {
> > > > +                       /*
> > > > +                        * Power back off, in case device did not suspend yet.
> > > > +                        * For example, leverage your .runtime_suspend()
> > > > +                        * implementation:
> > > > +                        */
> > > > +                       foo_runtime_suspend(dev);
> > >
> > > There are two reasons why this may not work, here and below.
> > >
> > > First off, if a non-trivial PM domain or bus type etc is involved, its
> > > .runtime_suspend() callback may need to be invoked in addition to
> > > foo_runtime_suspend() to actually power off the device.
> >
> > Good point. While it's a platform_device (not a complex bus), I suppose
> > the PM domain may be relevant, at least for remove(). (probe() is
> > already handled automatically by the device core.)
> 
> If this is a platform device, the PM domain detach will power it off,
> which I forgot about,

I kinda get lost in that too sometimes... so even remove() is OK
actually. Good.

> so the driver only needs to prepare the device
> for that.  If there is no PM domain, the driver runtime suspend
> callback function can be used for the power off in principle.

What's the distinction? To me, power domains are not the only thing that
constitute "powering on the device" -- drivers may be handling resets,
clocks, regulators, etc., too. In either case, those are things that the
driver is powering on in probe(), and should be torn down in error-exit
and in remove().

But in either case, those are probably things the driver is doing in its
runtime_suspend callback.

Maybe I'm clouding things by mentioning "runtime_suspend" here; the
concept here is "power off anything you turned on in probe". So if you'd
like another spin here, I may just call it foo_initialize() and
foo_uninitialize(), with some comments about "power on any necessary
resources: clocks, regulators, resets, ...".

> So I think that the original code flow here is fine with the caveat
> that if a PM domain is there, the driver may not actually need to
> carry out the power off by itself.

I kinda think the point of most of this power domain architecture is
that a typical driver just doesn't have to worry about it at all (in
probe(), and if you use runtime PM properly), so I'd prefer not
mentioning it in the Basic example. But sure.

> > > That's why
> > > pm_runtime_force_suspend() looks for the callback to invoke.
> >
> > Would you be OK with pm_runtime_force_suspend() as an alternative here?
> > It seems like some drivers have started using that in remove(), which
> > doesn't quite match its docs, but otherwise seems OK to me. I was
> > considering that already here, and I even think it might be a good idea
> > to do automatically in devm_*, as I noted here:
> >
> >   https://lore.kernel.org/all/arVWVA3lks7SopQH@google.com/
> >
> >   (note: there's definitely at least one typo in there; should be
> >   !pm_runtime_status_suspended(); and it needs some other adjustments to
> >   actually verify the device was suspended at time of enable(); ... so
> >   consider it a concept, not a patch.)
> >
> > But I kinda wanted a maintainer opinion before I went too far on that.
> 
> That shouldn't be necessary as per the above.

OK, yes, not necessary in this particular example.

But my hope is that devm_pm_runtime_enable() can be made easier to use.
It would be nice if we had the property:

  If your device was suspended (most resources powered off) when
  devm_pm_runtime_enable() is called, the PM helpers will suspend it
  (power it back off) on remove().

To me, PM runtime is pretty unique relative to other devm-supported
subsystems: even if you carefully undo everything you did in probe in
exactly the right inverse order, you still get things wrong -- because
PM runtime is so stateful (especially forbid()), and so you have to
account for an extra unwind step (call runtime_suspend-like functions in
remove()).

And to be clear, that proposal would only be useful for the "Probe with
Hardware Powered Off" case (which I think is actually quite common, and
quite common to do incorrectly), and not this "Basic Probe" (that powers
on during probe).

> > > Second, if the driver expects the device to be powered up and
> > > operational at the beginning of probe, which this one does AFAICS,
> >
> > No, that's not the intention. See:
> >
> >   "A driver that powers on its hardware during probe"
> 
> So this effectively assumes no PM domain because platform_probe()
> calls dev_pm_domain_attach() with PD_FLAG_ATTACH_POWER_ON set.

Yes or no, depending on your understanding of what "powers on its
hardware" means. Holistically, I don't usually consider something "on"
if its power domain is on but it's still in reset, or its clocks are
off, or its regulators are off, or ...

Is there some better terminology you'd prefer here?

> > And the pseudocode/comment:
> >
> >                /* Power on and initialize hardware registers... */
> >
> > i.e., probe() is doing the power-on work, but it's elided.
> >
> > Perhaps that wasn't obvious enough, so I can replace that with
> 
> No, it's fine with me except that there is a difference between the
> "PM domain present" and "no PM domain" cases and at least some drivers
> may need to take it into account.

I'm not really getting what the distinction is, from a driver writer
point of view. With or without a PM domain, the driver most likely
doesn't need to worry about the distinction. (Caveat: if you have 2 or
more domains, you have to manage that yourself as the driver core
doesn't handle it. But that becomes obvious rather quickly.)

Brian

> > more-convincing code-like structures
> > (regulator_get()/regulator_enable(), etc., for example) if you think
> > that would help.
