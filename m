Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63162DCF41
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774623038; cv=none; b=VsXbqlVQLD7BiTfQcFsZyb2b2pTn6QNCp2Ej7c9GXOkwkg8yqKgSgo+kL9dVHjRjcwghtaudiNRuIRpORI8hWJrxshyYiqtVxOxfyNT1wzPrzdMINcX7tSyoZS0s8pSt2jHDV/Y24H/ujNUiUoiqKTTApaqN4QbB+hM6XgtPnQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774623038; c=relaxed/simple;
	bh=XmY2ZYHEqS/t8NJRHRB/bZIOo4mw36BvNz8aMj1pZBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8eh3BsdmcQR0b6pk7WiZBcvPdut1jBv/wMkNtpucbQljKnUsV4Bp63G2tZLGbXgKMKo13sKY6hXPzjuK5hhuTzMCcaxSJEx/S3mdDHvTHXQmDN3PXCrIaDHL5CsxBkrMAd4T1PaPv2iLBHyi/RjEE50uo354TjClaKZChx9w98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN6eo4t2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN6eo4t2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88590C2BCB3
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774623037;
	bh=XmY2ZYHEqS/t8NJRHRB/bZIOo4mw36BvNz8aMj1pZBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fN6eo4t2o093hUA4wfZWZonDZdmT1KtQ/RZ3bmqkexoQUYtVbx2PJDDKZgBtgc85i
	 vavtpZxN5aRNAJmu1zeX2d4g2LTDPrkFPLhBtzUkwpPzCtJEAsPWcS6Qwy+FtFqXXr
	 l/DUl8kQs++QEEfDOaaMdGQeabVyzZfLiMJAeveKQOM5aOOc8GiA4fIxZgZcgxMdWn
	 /n8h2aAlUu1qQqDukB57M2WYIFRDiCAffRmUaZRUX+j/uWg6q1QgXjrXbqUFLg37nb
	 1iYuRdJiFTX0eYXnp5sgjWi9dFES5R0yQMEhoz4+m8Hhn+HH3jLef1DIrWOZJUG+S6
	 jVVUAVo5dkThA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4043b909ed4so1381940fac.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 07:50:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaMAIyN8F0tnY4ZJZbJJXUOAYUnHQEyDGNc+OPeYK9a2oPCpJKzr4CRPJx8Cv3eQV9r6FP+JmO0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuCGpo8O2XRmn/7TXsDwQMcfgWYYXLzK8meWJxZjgTDrfmg321
	W9dUYj/IaCNHVPq2KU9Dks8pn+u/r1MqiGY11ejL6TuibKU/4WYMe7kxZzEz8uZT1rfDScpSwlp
	z46lJGRW0/vzJ6buxCRdvCkCcgYtyNI4=
X-Received: by 2002:a05:6870:5115:b0:417:ab68:fbaf with SMTP id
 586e51a60fabf-41cec173ca8mr1576664fac.20.1774623036517; Fri, 27 Mar 2026
 07:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6267615.lOV4Wx5bFT@rafael.j.wysocki> <00a83964cc75f86bed096bac6256b890@igalia.com>
In-Reply-To: <00a83964cc75f86bed096bac6256b890@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Mar 2026 15:50:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gM1H4ajBO4STzBeLBqk+5rjf1vP=iV8KW6Yj6kjfu_2g@mail.gmail.com>
X-Gm-Features: AQROBzAo-J66Qsur4mDexNUI-f7viFPbHQnQqCsV7Z83TqLFMW5XrzGtgtc8Qts
Message-ID: <CAJZ5v0gM1H4ajBO4STzBeLBqk+5rjf1vP=iV8KW6Yj6kjfu_2g@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: core: Address thermal zone removal races with resume
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Kernel Dev <kernel-dev@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 3:47=E2=80=AFPM Mauricio Faria de Oliveira
<mfo@igalia.com> wrote:
>
> On 2026-03-27 06:49, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Since thermal_zone_pm_complete() and thermal_zone_device_resume()
> > re-initialize the poll_queue delayed work for the given thermal zone,
> > the cancel_delayed_work_sync() in thermal_zone_device_unregister()
> > may miss some already running work items and the thermal zone may
> > be freed prematurely [1].
> >
> > There are two failing scenarios that both start with
> > running thermal_pm_notify_complete() right before invoking
> > thermal_zone_device_unregister() for one of the thermal zones.
> >
> > In the first scenario, there is a work item already running for
> > the given thermal zone when thermal_pm_notify_complete() calls
> > thermal_zone_pm_complete() for that thermal zone and it continues to
> > run when thermal_zone_device_unregister() starts.  Since the poll_queue
> > delayed work has been re-initialized by thermal_pm_notify_complete(), t=
he
> > running work item will be missed by the cancel_delayed_work_sync() in
> > thermal_zone_device_unregister() and if it continues to run past the
> > freeing of the thermal zone object, a use-after-free will occur.
> >
> > In the second scenario, thermal_zone_device_resume() queued up by
> > thermal_pm_notify_complete() runs right after the thermal_zone_exit()
> > called by thermal_zone_device_unregister() has returned.  The poll_queu=
e
> > delayed work is re-initialized by it before cancel_delayed_work_sync() =
is
> > called by thermal_zone_device_unregister(), so it may continue to run
> > after the freeing of the thermal zone object, which also leads to a
> > use-after-free.
> >
> > Address the first failing scenario by ensuring that no thermal work
> > items will be running when thermal_pm_notify_complete() is called.
> > For this purpose, first move the cancel_delayed_work() call from
> > thermal_zone_pm_complete() to thermal_zone_pm_prepare() to prevent
> > new work from entering the workqueue going forward.  Next, switch
> > over to using a dedicated workqueue for thermal events and update
> > the code in thermal_pm_notify() to flush that workqueue after
> > thermal_pm_notify_prepare() has returned which will take care of
> > all leftover thermal work already on the workqueue (that leftover
> > work would do nothing useful anyway because all of the thermal zones
> > have been flagged as suspended).
> >
> > The second failing scenario is addressed by adding a tz->state check
> > to thermal_zone_device_resume() to prevent it from re-initializing
> > the poll_queue delayed work if the thermal zone is going away.
> >
> > Note that the above changes will also facilitate relocating the suspend
> > and resume of thermal zones closer to the suspend and resume of devices=
,
> > respectively.
> >
> > Fixes: 5a5efdaffda5 ("thermal: core: Resume thermal zones asynchronousl=
y")
> > Reported-by: Mauricio Faria de Oliveira <mfo@igalia.com>
> > Closes: https://lore.kernel.org/linux-pm/20260324-thermal-core-uaf-init=
_delayed_work-v1-1-6611ae76a8a1@igalia.com/ [1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> I spent some hours reviewing and thinking of corner cases for this
> patch,
> and found the code to correctly handle all cases I thought of.
>
> I also tested it with the synthetic reproducers for the 2 cases reported
> in [1], and it prevented the errors.
>
> Please feel free to add:
>
> Reviewed-by: Mauricio Faria de Oliveira <mfo@igalia.com>
> Tested-by: Mauricio Faria de Oliveira <mfo@igalia.com>
>
> And please carry these from [1], if that's OK with you:
>
> Reported-by: syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=3D3b3852c6031d0f30dfaf

I will, thank you!

> >
> > v1 -> v2: Return -ENOMEM from thermal_init() when the workqueue allocat=
ion
> >    fails (Sashiko)
> >
> > Lukasz, Daniel, I'm quite confident about this patch, but I would appre=
ciate
> > your feedback.
> >
> > ---
> >  drivers/thermal/thermal_core.c |   31 ++++++++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> >
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -42,6 +42,8 @@ static struct thermal_governor *def_gove
> >
> >  static bool thermal_pm_suspended;
> >
> > +static struct workqueue_struct *thermal_wq __ro_after_init;
> > +
> >  /*
> >   * Governor section: set of functions to handle thermal governors
> >   *
> > @@ -314,7 +316,7 @@ static void thermal_zone_device_set_poll
> >       if (delay > HZ)
> >               delay =3D round_jiffies_relative(delay);
> >
> > -     mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_q=
ueue, delay);
> > +     mod_delayed_work(thermal_wq, &tz->poll_queue, delay);
> >  }
> >
> >  static void thermal_zone_recheck(struct thermal_zone_device *tz, int e=
rror)
> > @@ -1795,6 +1797,10 @@ static void thermal_zone_device_resume(s
> >
> >       guard(thermal_zone)(tz);
> >
> > +     /* If the thermal zone is going away, there's nothing to do. */
> > +     if (tz->state & TZ_STATE_FLAG_EXIT)
> > +             return;
> > +
> >       tz->state &=3D ~(TZ_STATE_FLAG_SUSPENDED | TZ_STATE_FLAG_RESUMING=
);
> >
> >       thermal_debug_tz_resume(tz);
> > @@ -1825,6 +1831,9 @@ static void thermal_zone_pm_prepare(stru
> >       }
> >
> >       tz->state |=3D TZ_STATE_FLAG_SUSPENDED;
> > +
> > +     /* Prevent new work from getting to the workqueue subsequently. *=
/
> > +     cancel_delayed_work(&tz->poll_queue);
> >  }
> >
> >  static void thermal_pm_notify_prepare(void)
> > @@ -1843,8 +1852,6 @@ static void thermal_zone_pm_complete(str
> >  {
> >       guard(thermal_zone)(tz);
> >
> > -     cancel_delayed_work(&tz->poll_queue);
> > -
> >       reinit_completion(&tz->resume);
> >       tz->state |=3D TZ_STATE_FLAG_RESUMING;
> >
> > @@ -1854,7 +1861,7 @@ static void thermal_zone_pm_complete(str
> >        */
> >       INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume);
> >       /* Queue up the work without a delay. */
> > -     mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_q=
ueue, 0);
> > +     mod_delayed_work(thermal_wq, &tz->poll_queue, 0);
> >  }
> >
> >  static void thermal_pm_notify_complete(void)
> > @@ -1877,6 +1884,11 @@ static int thermal_pm_notify(struct noti
> >       case PM_RESTORE_PREPARE:
> >       case PM_SUSPEND_PREPARE:
> >               thermal_pm_notify_prepare();
> > +             /*
> > +              * Allow any leftover thermal work items already on the
> > +              * worqueue to complete so they don't get in the way late=
r.
> > +              */
> > +             flush_workqueue(thermal_wq);
> >               break;
> >       case PM_POST_HIBERNATION:
> >       case PM_POST_RESTORE:
> > @@ -1909,9 +1921,16 @@ static int __init thermal_init(void)
> >       if (result)
> >               goto error;
> >
> > +     thermal_wq =3D alloc_workqueue("thermal_events",
> > +                                   WQ_FREEZABLE | WQ_POWER_EFFICIENT |=
 WQ_PERCPU, 0);
> > +     if (!thermal_wq) {
> > +             result =3D -ENOMEM;
> > +             goto unregister_netlink;
> > +     }
> > +
> >       result =3D thermal_register_governors();
> >       if (result)
> > -             goto unregister_netlink;
> > +             goto destroy_workqueue;
> >
> >       thermal_class =3D kzalloc_obj(*thermal_class);
> >       if (!thermal_class) {
> > @@ -1938,6 +1957,8 @@ static int __init thermal_init(void)
> >
> >  unregister_governors:
> >       thermal_unregister_governors();
> > +destroy_workqueue:
> > +     destroy_workqueue(thermal_wq);
> >  unregister_netlink:
> >       thermal_netlink_exit();
> >  error:
>
> --
> Mauricio
