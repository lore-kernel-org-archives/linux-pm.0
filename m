Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DEA4A0F1D
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008938; cv=none; b=ua014wkN0ghDY1M+b5GXTNQ65U9mp8ppmDBCKsljc/MAZU8/LiXN+Aj58W8RIe4G2gabx6cPxIPeEw2Us9j2Q+UkI+0BnDhSghGDwX9pspT2QcpjPi+GYfXTYesuKvPsTV9XQZTQwXjUpsScNsRNGwQ3nXXQORAqC2vENRxs7uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008938; c=relaxed/simple;
	bh=4t3B1O5uccpSjVayby3DtFX+i7PWbaCzjTIB7y2+3dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F20ziYW9wpxeBMz74o1tTN+W6vb2aMNTlFNkr33Ib5/Akpn2uBXIq4gI5wE5ALirhX56tf6pLweUwrSANp4An9BEJrZef2fvcO8mcC4uX54T2pJI5WnxohvGjmYdTyfGh4ff5TzyKm+su3Wb1I7nt7gtSAZxe1nC5hVP21EhWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l4yk7RoZ; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l4yk7RoZ"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-141395927feso8786725c88.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792008936; x=1792613736; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u8y8daHQJvx7IZRNrkHqWqeIGgkxG27eFv9rVDwmEAE=;
        b=l4yk7RoZe664eAecJRed9SllqkGCvn9TrWg9J67w1qJH1qJQs6nDA9Dr1dbAzeVgUf
         7cjF1hiF1UJhg4gGiVEDaRgodISQZIoJBIEkbow57zhulopSwNiulXTj9iEaudOiCfUv
         VAWpwr1yYhTbwfmujhffVliwaM34BRndw3iec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792008936; x=1792613736;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u8y8daHQJvx7IZRNrkHqWqeIGgkxG27eFv9rVDwmEAE=;
        b=hfZVfGDvJfkkmX7F4TftgsIa4PvOj+RJW4pkQiB6+hrtzQbE9ix0Wam9oazF9dKNPH
         XsHpAe/3kNxGLI7Wjl9TzZaOONKkS7TyqU+2ksffj4W25bjnQ5WwXa5MBulwClBwvrRC
         U4mCl4l0NnCDDb4wDQA6Ynhh4Z/8rdb/3DlPiZkpwnd+kJycLDwnRrOmCiBm3OJO3ZlH
         JJfFwuS3kv3MVuiQqdQbfQjZXaNTQ58N/l5MIKLCmtJhzLmJt+3rfx0MQyWKQ6Ckc/tx
         6QTMO9fZqTKIizBpuriYELKvb6dXx2+V7VVbInWcCWbTrQ2sqLE5tzya6USvUJ82Ewcf
         nhhA==
X-Forwarded-Encrypted: i=1; AKwUvBxeMuCue/9l8wZJGS76YmEVlQMRP+1eESEPgD6tDqqRc0XF8eru9tchgvDagxYu/1hNn4vhNG3VmA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL2nDiKQB0Gk0MzOBFcsjn/vdE6qZA0M34q6hctlXlPs14TjpeT
	9sjfA95K6wts9YbXykO3wRHS1cV/9rTgu9J6CGhBlxCfyfSAbp/Drc/Qmb48ge90Kg==
X-Gm-Gg: AYBFou330gQmaZxQyFg4NTG+riTHJpEZmymrXlIDoQmFMuovwFum2yibiGzHgTVvni0
	WaJ6z21oC9Dfh9VuInP8SWx7f92+9djvQEpN8kyKz0GyzeAcciQkZdwU/eFTCG7fp/kuVeIaKOu
	x2uG8ebpnFvNCtcCbqFjh+NZjC3AoCdePSMia7OglFPYlCywbF4XRooaIJnpNJaC7JlmhSw3q0X
	2URu22b30jJbw5QzGU9BXQ+MzlMRA8H6OJsJlfCswlCPCa5ehD+q5k5gB6uodpjLI08tFasSFXT
	py+hg8G3oml2x5zRWGcU6kzYOU5zQOMyhYeCI6jamxnZ8BEv0jyeWWd1OtQWTHElmx3z8Klm35d
	58UxUuSHwLydaFd8rJCH0WZ73pMQGMMIukjbpXm+fg7n8bO/MKatKSiHcSk3f0AzQfXeomt77vK
	1Yd7PZtZj3W4/83sDNxmlLqdrQRS8GDmrtK7gdJSfJ4rMyncdFx1pGXEEhXR9aqyDRMx+pK3ohd
	yl85QefYNDkA2gB27JJkF+JEbaQ55C2w6Z7YeyKYwoF2pBS
X-Received: by 2002:a05:701b:291c:b0:141:4951:f150 with SMTP id a92af1059eb24-16a5ea5d6famr21123974c88.18.1792008935130;
        Wed, 14 Oct 2026 13:15:35 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:88d4:aeca:306c:242a])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1698de65af7sm52561502c88.0.2026.10.14.13.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 13:15:34 -0700 (PDT)
Date: Wed, 14 Oct 2026 13:15:32 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>, Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v4 2/2] PM: runtime: Add Example Driver Patterns section
Message-ID: <as_i5MEz3WfnDQmf@google.com>
References: <20261001155118.1750028-1-briannorris@chromium.org>
 <20261001085009.v4.2.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
 <CAJZ5v0hMHutu69acgSR7KsmcLs0McZK+-3OFoiqFrU5GnJzTNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hMHutu69acgSR7KsmcLs0McZK+-3OFoiqFrU5GnJzTNQ@mail.gmail.com>

Hi Rafael,

On Wed, Oct 14, 2026 at 09:07:54PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Thu, Oct 1, 2026 at 5:51 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > The runtime PM API surface is pretty large, but there are a few common
> > patterns that many drivers should follow. Add some illustrative
> > examples, to help guide the most common audience for runtime PM docs --
> > driver writers.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> > Changes in v4:
> >  * "state" to "status", to be consistent with Introduction terminology
> >
> > Changes in v3:
> >  * Rewrite Examples to avoid devm_* at first, to highlight correct
> >    approaches
> >  * Include error-handling and remove() in any probe() Examples
> >  * Advise more caution when using devm_*, as ordering issues are subtle
> >
> > Changes in v2:
> >  * Add appropriate teardown to "Probe with Hardware Powered Off"
> >    Example, as the remove() + power-off behavior is subtle here, and
> >    easy to get wrong
> >
> >  Documentation/power/runtime_pm.rst | 475 ++++++++++++++++++++++++++++-
> >  1 file changed, 473 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > index e4407b687f8b..cb25e0bb4ca7 100644
> > --- a/Documentation/power/runtime_pm.rst
> > +++ b/Documentation/power/runtime_pm.rst
> > @@ -429,7 +429,8 @@ in ->probe(). Usually this means calling pm_runtime_disable(),
> >  pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can use
> >  devm_pm_runtime_enable() during probe, which automatically takes care of
> >  calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() upon driver
> > -detachment.
> > +detachment. See also the Examples in `Section 10`_ for some effective
> > +strategies for driver teardown.
> >
> >  The user space can effectively disallow the driver of the device to power manage
> >  it at run time by changing the value of its /sys/devices/.../power/control
> > @@ -654,7 +655,9 @@ The implementation is well suited for asynchronous use in interrupt contexts.
> >  However such use inevitably involves races, because the PM core can't
> >  synchronize ->runtime_suspend() callbacks with the arrival of I/O requests.
> >  This synchronization must be handled by the driver, using its private lock.
> > -Here is a schematic pseudo-code example::
> > +Here is a schematic pseudo-code example:
> > +
> > +.. code-block:: c
> >
> >         foo_read_or_write(struct foo_priv *foo, void *data)
> >         {
> > @@ -720,3 +723,471 @@ pm_runtime_autosuspend_expiration() from within the ->runtime_suspend()
> >  callback while holding its private lock.  If the function returns a nonzero
> >  value then the delay has not yet expired and the callback should return
> >  -EAGAIN.
> > +
> > +.. _Section 10:
> > +
> > +10. Example Driver Patterns
> > +===========================
> > +
> > +The runtime PM API is large and complex, but most device drivers follow a small
> > +set of canonical patterns when interacting with runtime PM. This section
> > +illustrates standard patterns for device probing, performing I/O, and handling
> > +interrupts.
> > +
> > +Probe and Initialization
> > +------------------------
> > +
> > +Basic Probe
> > +~~~~~~~~~~~
> > +
> > +A driver that powers on its hardware during probe and does not use autosuspend
> > +can initialize runtime PM using standard helpers:
> > +
> > +.. code-block:: c
> > +
> > +       static int foo_probe(struct platform_device *pdev)
> > +       {
> > +               struct device *dev = &pdev->dev;
> > +               struct foo_priv *priv;
> > +               int ret;
> > +
> > +               priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +               if (!priv)
> > +                       return -ENOMEM;
> > +
> > +               platform_set_drvdata(pdev, priv);
> > +
> > +               /* Power on and initialize hardware registers... */
> > +
> > +               /*
> > +                * The code above left hardware powered on and operational, so
> > +                * tell the PM core that the device is active before enabling
> > +                * runtime PM.
> > +                */
> > +               pm_runtime_set_active(dev);
> > +               pm_runtime_enable(dev);
> > +
> > +               /*
> > +                * Perform remaining driver setup (e.g. register interrupts, device nodes).
> > +                * If any step fails after enabling runtime PM:
> > +                */
> > +               ret = foo_register_device(priv);
> > +               if (ret)
> > +                       goto err_pm_disable;
> > +
> > +               /*
> > +                * Upon successful return from ->probe(), the driver core
> > +                * automatically executes pm_request_idle(dev), allowing the
> > +                * device to suspend asynchronously if its usage counter is zero.
> > +                */
> > +               return 0;
> > +
> > +       err_pm_disable:
> > +               pm_runtime_disable(dev);
> > +               if (!pm_runtime_status_suspended(dev)) {
> > +                       /*
> > +                        * Power back off, in case device did not suspend yet.
> > +                        * For example, leverage your .runtime_suspend()
> > +                        * implementation:
> > +                        */
> > +                       foo_runtime_suspend(dev);
> 
> There are two reasons why this may not work, here and below.
> 
> First off, if a non-trivial PM domain or bus type etc is involved, its
> .runtime_suspend() callback may need to be invoked in addition to
> foo_runtime_suspend() to actually power off the device.

Good point. While it's a platform_device (not a complex bus), I suppose
the PM domain may be relevant, at least for remove(). (probe() is
already handled automatically by the device core.)

> That's why
> pm_runtime_force_suspend() looks for the callback to invoke.

Would you be OK with pm_runtime_force_suspend() as an alternative here?
It seems like some drivers have started using that in remove(), which
doesn't quite match its docs, but otherwise seems OK to me. I was
considering that already here, and I even think it might be a good idea
to do automatically in devm_*, as I noted here:

  https://lore.kernel.org/all/arVWVA3lks7SopQH@google.com/

  (note: there's definitely at least one typo in there; should be
  !pm_runtime_status_suspended(); and it needs some other adjustments to
  actually verify the device was suspended at time of enable(); ... so
  consider it a concept, not a patch.)

But I kinda wanted a maintainer opinion before I went too far on that.

> Second, if the driver expects the device to be powered up and
> operational at the beginning of probe, which this one does AFAICS,

No, that's not the intention. See:

  "A driver that powers on its hardware during probe"

And the pseudocode/comment:

               /* Power on and initialize hardware registers... */

i.e., probe() is doing the power-on work, but it's elided.

Perhaps that wasn't obvious enough, so I can replace that with
more-convincing code-like structures
(regulator_get()/regulator_enable(), etc., for example) if you think
that would help.

Brian

> it
> better should leave the device in that state on failing probe and
> remove or its own expectations regarding the initial state will not be
> met when it is re-probed.
> 
> > +                       pm_runtime_set_suspended(dev);
> > +               }
> > +               return ret;
> > +       }
> > +
> > +       static void foo_remove(struct platform_device *pdev)
> > +       {
> > +               struct device *dev = &pdev->dev;
> > +               struct foo_priv *priv = platform_get_drvdata(pdev);
> > +
> > +               foo_unregister_device(priv);
> > +
> > +               pm_runtime_disable(dev);
> > +               /*
> > +                * The runtime PM status is not guaranteed at this point. We
> > +                * could be either suspended or active, so we need to handle
> > +                * both.
> > +                */
> > +               if (!pm_runtime_status_suspended(dev)) {
> > +                       /* Power back off, in case device did not suspend yet. */
> > +                       foo_runtime_suspend(dev);
> > +                       pm_runtime_set_suspended(dev);
> > +               }
> > +       }
> > +
