Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D33C09F3
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005005; cv=none; b=FcwVxuAvLCQJhAlM3zGZVMWShVdYUNZdSGHdjVlghaAGRsCDYijOyf2VrJraMQcD012BXi6gbTteAcl18EZvt5Caf+3lBXqfcIXDe1594Sm625iL32WfNUa+Abzvmoiehst+1pUxbFUoyHJ4zesKBG1zxwjqsKaJLlcvfUifa78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005005; c=relaxed/simple;
	bh=CPb4WsqW5lDxN5DmQve2puOIjx/DnRYWQ2pGqcxR37k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhVpA7xgirgT0d1t4b+xjWebN5qdBsSJtXe+oyMRusAQc5rGAmDCTPO00LEzgMab3hhvE9CM9mg137fyrnrY2PN5oLC1XtL3bwA+1nZALu89yPXKLl+PjbZf9UiNFKE2ADmcTkZG4D4n091SlRmZPQ5mrekOcplvHSq/GtKVFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4+njpI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4+njpI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295581F000C9
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 19:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792005004;
	bh=LBewyNKx8kNLRf8WZ/HnKHYFZ2VU7KYZ/2nmLm9r2KI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=e4+njpI6WWX3EU++CLYVdgOBZ71ItvDtGZEcGnJd1xuQcyW9l4sR8gYcpVoZg26CF
	 mL1RklmSE7vI1jw4+BgS8kC0fo0D7KOYjcqzfDqvTikmD/z5KIlobnmOgWf5l9bzh0
	 FlIn9MfSi8ZLWfp8rsnAgwUL+iNXWNT4lUCOZ3l/mI8AnnOKdKlSzPUNWudVkIz6XJ
	 vW/Tg9Xnrpy5GxJhdO1kjsiW6QHIQCHKqox/ZfM/yr1vDpVunC3hzsEw/HYtN5Sb7e
	 y/VQVPMLdkdMJ3CTAxxyfah26bZauFigfL+7QrWLeB0HXqzWlSKTHH5tzaUJWzhcnj
	 DZ2sJ2ava5J7Q==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a49a022221so31368741fa.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:10:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxCamtYpZdbCNu86KPa3YqHqAJ4Mj03Xj1olclKPB3JKaWWkC+0fgFKXjKPPZiUDR5SDM3qPHjOIA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKowN7W/N2ykwyyCcpGH6Ez4xvxCof9SUOrqD5GKWeV4JJIv7Iu
	qtHMWoLnryW7ggNp6AXhpmKRu602ov7bYGP3Ga+y1W+skQWvu5goz6TR1wAcdM6055sIFn5WSpe
	7mNMfwisuS0BGUWXlcjC93VtqWL7YzVA=
X-Received: by 2002:a05:6512:3047:b0:5b8:f4d4:8004 with SMTP id
 2adb3069b0e04-5bcde6b4604mr6317929e87.15.1792005002482; Wed, 14 Oct 2026
 12:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001155118.1750028-1-briannorris@chromium.org> <20261001085009.v4.2.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
In-Reply-To: <20261001085009.v4.2.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 14 Oct 2026 21:07:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hMHutu69acgSR7KsmcLs0McZK+-3OFoiqFrU5GnJzTNQ@mail.gmail.com>
X-Gm-Features: AclHuK9F865un8J1qhb-2gPhSak0oWK8xKAT4V2S2G2tepc2x7QVPaA-2eJ46Xg
Message-ID: <CAJZ5v0hMHutu69acgSR7KsmcLs0McZK+-3OFoiqFrU5GnJzTNQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM: runtime: Add Example Driver Patterns section
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Doug Anderson <dianders@chromium.org>, Len Brown <lenb@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 5:51=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> The runtime PM API surface is pretty large, but there are a few common
> patterns that many drivers should follow. Add some illustrative
> examples, to help guide the most common audience for runtime PM docs --
> driver writers.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v4:
>  * "state" to "status", to be consistent with Introduction terminology
>
> Changes in v3:
>  * Rewrite Examples to avoid devm_* at first, to highlight correct
>    approaches
>  * Include error-handling and remove() in any probe() Examples
>  * Advise more caution when using devm_*, as ordering issues are subtle
>
> Changes in v2:
>  * Add appropriate teardown to "Probe with Hardware Powered Off"
>    Example, as the remove() + power-off behavior is subtle here, and
>    easy to get wrong
>
>  Documentation/power/runtime_pm.rst | 475 ++++++++++++++++++++++++++++-
>  1 file changed, 473 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index e4407b687f8b..cb25e0bb4ca7 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -429,7 +429,8 @@ in ->probe(). Usually this means calling pm_runtime_d=
isable(),
>  pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can use
>  devm_pm_runtime_enable() during probe, which automatically takes care of
>  calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() upon =
driver
> -detachment.
> +detachment. See also the Examples in `Section 10`_ for some effective
> +strategies for driver teardown.
>
>  The user space can effectively disallow the driver of the device to powe=
r manage
>  it at run time by changing the value of its /sys/devices/.../power/contr=
ol
> @@ -654,7 +655,9 @@ The implementation is well suited for asynchronous us=
e in interrupt contexts.
>  However such use inevitably involves races, because the PM core can't
>  synchronize ->runtime_suspend() callbacks with the arrival of I/O reques=
ts.
>  This synchronization must be handled by the driver, using its private lo=
ck.
> -Here is a schematic pseudo-code example::
> +Here is a schematic pseudo-code example:
> +
> +.. code-block:: c
>
>         foo_read_or_write(struct foo_priv *foo, void *data)
>         {
> @@ -720,3 +723,471 @@ pm_runtime_autosuspend_expiration() from within the=
 ->runtime_suspend()
>  callback while holding its private lock.  If the function returns a nonz=
ero
>  value then the delay has not yet expired and the callback should return
>  -EAGAIN.
> +
> +.. _Section 10:
> +
> +10. Example Driver Patterns
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +The runtime PM API is large and complex, but most device drivers follow =
a small
> +set of canonical patterns when interacting with runtime PM. This section
> +illustrates standard patterns for device probing, performing I/O, and ha=
ndling
> +interrupts.
> +
> +Probe and Initialization
> +------------------------
> +
> +Basic Probe
> +~~~~~~~~~~~
> +
> +A driver that powers on its hardware during probe and does not use autos=
uspend
> +can initialize runtime PM using standard helpers:
> +
> +.. code-block:: c
> +
> +       static int foo_probe(struct platform_device *pdev)
> +       {
> +               struct device *dev =3D &pdev->dev;
> +               struct foo_priv *priv;
> +               int ret;
> +
> +               priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +               if (!priv)
> +                       return -ENOMEM;
> +
> +               platform_set_drvdata(pdev, priv);
> +
> +               /* Power on and initialize hardware registers... */
> +
> +               /*
> +                * The code above left hardware powered on and operationa=
l, so
> +                * tell the PM core that the device is active before enab=
ling
> +                * runtime PM.
> +                */
> +               pm_runtime_set_active(dev);
> +               pm_runtime_enable(dev);
> +
> +               /*
> +                * Perform remaining driver setup (e.g. register interrup=
ts, device nodes).
> +                * If any step fails after enabling runtime PM:
> +                */
> +               ret =3D foo_register_device(priv);
> +               if (ret)
> +                       goto err_pm_disable;
> +
> +               /*
> +                * Upon successful return from ->probe(), the driver core
> +                * automatically executes pm_request_idle(dev), allowing =
the
> +                * device to suspend asynchronously if its usage counter =
is zero.
> +                */
> +               return 0;
> +
> +       err_pm_disable:
> +               pm_runtime_disable(dev);
> +               if (!pm_runtime_status_suspended(dev)) {
> +                       /*
> +                        * Power back off, in case device did not suspend=
 yet.
> +                        * For example, leverage your .runtime_suspend()
> +                        * implementation:
> +                        */
> +                       foo_runtime_suspend(dev);

There are two reasons why this may not work, here and below.

First off, if a non-trivial PM domain or bus type etc is involved, its
.runtime_suspend() callback may need to be invoked in addition to
foo_runtime_suspend() to actually power off the device.  That's why
pm_runtime_force_suspend() looks for the callback to invoke.

Second, if the driver expects the device to be powered up and
operational at the beginning of probe, which this one does AFAICS, it
better should leave the device in that state on failing probe and
remove or its own expectations regarding the initial state will not be
met when it is re-probed.

> +                       pm_runtime_set_suspended(dev);
> +               }
> +               return ret;
> +       }
> +
> +       static void foo_remove(struct platform_device *pdev)
> +       {
> +               struct device *dev =3D &pdev->dev;
> +               struct foo_priv *priv =3D platform_get_drvdata(pdev);
> +
> +               foo_unregister_device(priv);
> +
> +               pm_runtime_disable(dev);
> +               /*
> +                * The runtime PM status is not guaranteed at this point.=
 We
> +                * could be either suspended or active, so we need to han=
dle
> +                * both.
> +                */
> +               if (!pm_runtime_status_suspended(dev)) {
> +                       /* Power back off, in case device did not suspend=
 yet. */
> +                       foo_runtime_suspend(dev);
> +                       pm_runtime_set_suspended(dev);
> +               }
> +       }
> +
