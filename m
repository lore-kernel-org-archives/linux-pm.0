Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537447;
	b=g8LSFGw7ABdx1WaBI5BdfIWHYINcv7geXiqTWdGh+trn7rWnYfFyhlb4ouJlgmlQqNoi
	 JPBT+wEUJ4gTYkRJeH0sL9MSp9iFnGz/IDmXty6Od86Vl67o4c3agXD5668a9AoXD7tS2
	 8iDILrgybUW4cmDHGXvXCTSR4cIdK13wYvNpDjK4VkSHaxVs6qLWoPWPCfwMTr8NF29yX
	 YOSZUJbDxvO7dH+Mf2b/DpvUEL0Umqn8fs9W3uRBo60NP6HH/uTG9R8WaJO2GvP/FheR8
	 2Igbqwld4CVyow0tid5LmAF5+Yu/BABXNGJPgTyhhHzaco99vCiQBjIvWY/nc0VJ2KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537447;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+43/7mHj0ouigqaHkZDieatZLEydckhRG4Sy0IdZyzc=;
	b=fWr1le/rHBSM7qZDi1BtW2r/SQQhQ2NSCh24KnsP1q33KFumFLQvJKzoFeJgEgLRXsh5
	 9OZwT+4Yn5JDmicgWZzfG+bz0XokBKRprfji+SEwUC1IUDiXlAmXG9InmUvR5qTWsrHdk
	 ObpECa9QSLs6xk8RCpjPKONR1M9QKIJMZGLzBrJce4+rSmw6QqfFHC2aaigvf+XiqPVc3
	 pajGPI/uJkx5qkNGmz0emkvqvKS0y5Nk6Zr69RmizS8WI1u/GJcY93vMihSMgVrZ6Yh3g
	 CdpICiEIUGGBVwVYUuHLbLhYnOLKoAPT1ECSjSbEt8b9Fb5BZOcolGSG1yj6OlkfNAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYqRSE0l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B8F606A331
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYqRSE0l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6038C1F000D0
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537446;
	bh=+43/7mHj0ouigqaHkZDieatZLEydckhRG4Sy0IdZyzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DYqRSE0lzhEhAaRhI8MqJ80yek0rhGr36xxJaEqB9/ccMtZn7NF0LJFSIsWUttcX5
	 hB+NSp2/jEMON8fiZPKZURdVU2MDLQOyhYUnZHWaLmZt2vGoo73ihZZJbaG43eA6Kz
	 CfoLC/+2E1O9cHF0olw4oHDFQSGKUZ+0HbzJEX7fls69Tdq+EzvpToCcnJFXcZpCAT
	 NJwLT/ssmri/Hltg5AiVpNxMVipCHnxuyMlo+FNG2YzU4m+8M+261xM8Bmpx6FtUYt
	 Mwud2hMzCAzr1xhC9SuVt6nOK+LouBlKF6AIaDC+6A5TWSe43BgGH/k0QU4yanK9Dj
	 mP3EbwjkhuJPA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c0a520df2eso4631965e87.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 08:24:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGqkh+dogsysM75dMj1EA4SSfpc0e0+dKtdLEhXYbCryQ8wGSKzKaDH8JE9lFSChxj9sp7Slo5+8A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8p2T+5eC/GWLALWhw4DW1XXOl03r8oUMVaoQIrT+9pANNigrqm
	y7E1BxXrjIZUgxvJzSOvffMQVXbTaMwso2pKTpEsuEYusDlIm2f+gTGEZuhZ+NZrXurlitM+nl2
	dyQ6BycwUGEAqjRAIPBJBEprd/0oMp6A=
X-Received: by 2002:a05:6512:32cd:b0:5c1:57cd:50b with SMTP id
 2adb3069b0e04-5c1bc847888mr4656395e87.14.1795537444782; Tue, 24 Nov 2026
 08:24:04 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1978814.tdWV9SEqCh@rafael.j.wysocki> <10954171.nUPlyArG6x@rafael.j.wysocki>
 <awC1xx1Wi2BYo5rb@google.com>
In-Reply-To: <awC1xx1Wi2BYo5rb@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 24 Nov 2026 17:23:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jgBeJkeKfzaMnSx3c7HV6EpXrUoKJCyAZNHwfkvh=PZQ@mail.gmail.com>
X-Gm-Features: Aa3M54rw5KHnKZaBLVNo7BZcnw31BxC14ZrqNAgCzeVwxMBiXCJmOlcFrDsYbKw
Message-ID: <CAJZ5v0jgBeJkeKfzaMnSx3c7HV6EpXrUoKJCyAZNHwfkvh=PZQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] PM: runtime: Let devices suspend after an
 attempted resume
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 10:04=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
>
> On Thu, Nov 19, 2026 at 09:17:51PM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > On a successful runtime resume of a device, rpm_idle() is called by
> > rpm_resume(), but only if the runtime PM status of the device was not
> > RPM_ACTIVE when rpm_resume() was called, which is inconsistent.  For
> > instance, if the given device uses autosuspend, an autosuspend timer
> > will most likely be started for it after it has been actually resumed
> > by rpm_resume(), which will not happen if it is already active when it
> > is passed to that function.  This may lead to observable differences in
> > behavior going forward.
> >
> > Address it by rearranging rpm_resume() to call rpm_idle() also if the
> > device has been active to start with.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.=
c
> > index 5a0b4600c244..1a3b32e299d8 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -794,7 +794,8 @@ static int rpm_suspend(struct device *dev, int rpmf=
lags)
> >   * suspending (deferred_resume) or wait for it to finish.  If the RPM_=
ASYNC
> >   * flag is set then queue a resume request; otherwise run the
> >   * ->runtime_resume() callback directly.  Queue an idle notification f=
or the
> > - * device if the resume succeeded.
> > + * device if the resume succeeded or the device's runtime PM status wa=
s
> > + * RPM_ACTIVE to start with.
> >   *
> >   * This function must be called under dev->power.lock with interrupts =
disabled.
> >   */
> > @@ -840,7 +841,7 @@ static int rpm_resume(struct device *dev, int rpmfl=
ags)
> >                */
> >               pm_runtime_mark_last_busy(dev);
> >               retval =3D 1;
> > -             goto out;
> > +             goto success;
> >       }
> >
> >       if (dev->power.runtime_status =3D=3D RPM_RESUMING ||
> > @@ -971,8 +972,11 @@ static int rpm_resume(struct device *dev, int rpmf=
lags)
> >       }
> >       wake_up_all(&dev->power.wait_queue);
> >
> > -     if (retval >=3D 0)
> > -             rpm_idle(dev, RPM_ASYNC);
> > +     if (retval < 0)
> > +             goto out;
> > +
> > +success:
> > +     rpm_idle(dev, RPM_ASYNC);
>
> It's super common for rpm_resume() to be called with a non-zero
> usage_count (e.g., all pm_runtime_get*(), pm_runtime_forbid()). Do we
> really want them all to turn into rpm_idle() (and predictably fail)? For
> one, it adds a lot more trace_event noise.
>
> Maybe we could check RPM_GET_PUT before doing this? Or check
> usage_count? I wouldn't want to go too far on re-implementing all the
> rpm_idle() pre-conditions though...

I'm not sure why this is an issue if the device is already active when
rpm_resume() is called and not when the device is resumed by
rpm_resume().  It doesn't look like this should be an issue only in
one of those cases.

> Also: I'm not quite sure what's *really* expected here, but drivers like
> drivers/net/ethernet/intel/e1000e/netdev.c (no autosuspend; they use
> .runtime_idle() to re-implement autosuspend, more or less) might see a
> change in behavior.

Everybody may see a change in behavior, but it only applies to one of
the two cases which are handled differently now.

> For example, see its watchdog, which does:
>
>         /* Cancel scheduled suspend requests. */
>         pm_runtime_resume(netdev->dev.parent);
>
> For cases where the device stayed RPM_ACTIVE but usage_count =3D=3D 0 (ve=
ry
> common, I think), this does indeed cancel any pending suspend timers,

No, it doesn't cancel running autosuspend timers, for example.

> but then it immediately queues another idle request. (That idle request
> will end up failing anyway, so no functional issue. It just means the
> comments are a little confusing.)

So the comment is confusing regardless of the $subject patch.

> Do we really want that? Or maybe these drivers are just outliers, and
> should be rewritten anyway.

Probably.

If the device is RPM_ACTIVE to start with, all of the rpm_resume()
actions related to resuming it may be skipped, quite obviously, but
I'm not sure why any other rpm_resume() handling of the device should
be different in that case.  This only causes the behavior to be less
consistent and less predictable IMV.  In particular, if the device
uses autosuspend, an autosuspend timer should be started for it
regardless of whether or not it is RPM_ACTIVE to start with.  Failing
to do so may cause it to never suspend going forward in theory.
