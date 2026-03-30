Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A18635D
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870887; cv=none; b=ao30s1I+w8SypvyvbzH0OR2OPlr8cMA0kNYmaP1dSHZCogTdJRaKa0Nsnw7kCYHUfaKVNR2j+TB771vpdObrJ++5UITSbUz1QpE/xTDpnRtW5wqkQlcGXfPtdWluoMtOsOT0AvWSAxvgWGOj7lxSLiXszpKGUlYQ+9OBB/oq1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870887; c=relaxed/simple;
	bh=3ZsH28Jc/O1zHfos9IyDvnhBI+5B1Gn1wG8BmmCljP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxpU/pIbnI85AmHS4mGBClBPy276MoRycQ7UesCjeBo2VMI/jH381JKhegUqhySjEAbZCk8Gy1cYEzIgkCKPmCfM0Q0odibR3IsfqWc+CDPrQ8a0A8l5IAZqr5N/vMdhAnMK2NSS1LNsintMv5VuDyCrZ+QCIbn+P5vSfq66zwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id3Slb/l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id3Slb/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CF9C2BCB5
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 11:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774870887;
	bh=3ZsH28Jc/O1zHfos9IyDvnhBI+5B1Gn1wG8BmmCljP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=id3Slb/l98R80JxvVIG3mqM3QGZF5h69GyAWEYvAWoz3pwn7giVKw3AHZ1BemaQOp
	 wsQYvjJ/WL9be8iKW3wLiuZdb7cVQWFPg++QfpOvKc/hTh70eiB+DM6NtZm8f1urkq
	 bl6bXCL9FGutGz5AdQf3NwwbIMbB/huD2K0eWcZBYaNRf6fHBqcrUWtB/zq285AOB2
	 46X1lRFj7J1CzekIh4R/XrjgZwE8QGPkFDRur8fQCBVSoow0+xFxuiATi8eWQkf4Mk
	 IR2N5octXLbV9bf4Sf6Pk7i5D5joUagM/5LWRIG3N4K6H4KhWNqeSR7xHDlZ0gVHXr
	 oyMxhWcSfaYyg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so1722802fac.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 04:41:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFnBun5CUZjWwEOxJKUlSZAfXEHNWEi8LxmYdyLKZwao78TfVqNyMQou1rLo5xvAbWEsfZb8Ocqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BqMaKn62oe/umj4hb8tO/oYP2xU1IhtttBB0MRzDFKIDA4DT
	Ecr7MLBxBQ9VGya+cEWg1gejvYNMOMR0kJJdDDcsLfeZ+Rdbfp65Wnw35B2s30t3SX2CW/NDBMi
	Y7spPgMqbXq5KRe1awJWkhw8yuRNQyAs=
X-Received: by 2002:a05:6871:7415:b0:417:4888:3292 with SMTP id
 586e51a60fabf-41cec2aa529mr6978690fac.27.1774870885976; Mon, 30 Mar 2026
 04:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6267615.lOV4Wx5bFT@rafael.j.wysocki> <5321acf9-0de4-4b8a-811d-e1d71b152887@arm.com>
In-Reply-To: <5321acf9-0de4-4b8a-811d-e1d71b152887@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Mar 2026 13:41:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i82o40kS8=KsWjpB1QaCWLTrk9jmM8ZymW_tdz6b0sRA@mail.gmail.com>
X-Gm-Features: AQROBzBdYALw-vxnNM-MZRAaSfVoKObpkfwYsBVfjIH7VnsiZD2dUncOXnvJeo0
Message-ID: <CAJZ5v0i82o40kS8=KsWjpB1QaCWLTrk9jmM8ZymW_tdz6b0sRA@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: core: Address thermal zone removal races with resume
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mauricio Faria de Oliveira <mfo@igalia.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 11:14=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 3/27/26 09:49, Rafael J. Wysocki wrote:
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
> >
> > v1 -> v2: Return -ENOMEM from thermal_init() when the workqueue allocat=
ion
> >     fails (Sashiko)
> >
> > Lukasz, Daniel, I'm quite confident about this patch, but I would appre=
ciate
> > your feedback.
>
> My apologies for delay...
>
> >
> > ---
> >   drivers/thermal/thermal_core.c |   31 ++++++++++++++++++++++++++-----
> >   1 file changed, 26 insertions(+), 5 deletions(-)
> >
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -42,6 +42,8 @@ static struct thermal_governor *def_gove
> >
> >   static bool thermal_pm_suspended;
> >
> > +static struct workqueue_struct *thermal_wq __ro_after_init;
> > +
> >   /*
> >    * Governor section: set of functions to handle thermal governors
> >    *
> > @@ -314,7 +316,7 @@ static void thermal_zone_device_set_poll
> >       if (delay > HZ)
> >               delay =3D round_jiffies_relative(delay);
> >
> > -     mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_q=
ueue, delay);
> > +     mod_delayed_work(thermal_wq, &tz->poll_queue, delay);
> >   }
> >
> >   static void thermal_zone_recheck(struct thermal_zone_device *tz, int =
error)
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
> >   }
> >
> >   static void thermal_pm_notify_prepare(void)
> > @@ -1843,8 +1852,6 @@ static void thermal_zone_pm_complete(str
> >   {
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
> >   }
> >
> >   static void thermal_pm_notify_complete(void)
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
>
>
> Why we need those workqueue instances per-cpu?

That's to limit the changes in this fix to what's needed to address
the problem at hand.

The previously used workqueue was also per-CPU and freezable.

> It isn't a concurrent work, only one CPU can manage the cpufreq domain.
>
> I would drop that flag and allow to have single instance and migrate
> between cpus (to not wake up the one which queued the work).

I have a separate patch for that on top of this one, will post it later.

Let's avoid mixing fixes with changes that aren't directly related to them.
