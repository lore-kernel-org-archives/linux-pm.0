Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611535;
	b=b+IA7Dk1h2AEG19FebXF4kETZotUqIZD54RhYjj8/Ez/Duc/yRtBdeAV/xRgmLjmJtjf
	 0t6fQcHIXQJ7UB3WkBZaAT+8xt3r8OxzgiYmDHfprfjp6dTNA4bYg7pkRDHbfPhOLzmdA
	 m+jKNNPx4OttbudEGvOCIJNZ/BuTOv75/2OUyFqg53bYVac1K0WO9LLa6rXYqxN54u6pE
	 4IjMA/SHGq2+m0B6qSWAF7nnTNlEjhAmhNI28Zh7AOkVtrSHT1EdWEPQmNPMasj2+m3vh
	 A2ib+M2ERogtbyVaZapxF7JVjiUsqB7zMi7IiNzxVRVbbhTAzU+0b45Bs4e/3YoalDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611535;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FVmqX9e299gcsPkpyqf7SPDVELCZlYZjwwVu+fBIzo4=;
	b=b/By0XvBrmZzBMMmMUGRjOFMDHtqCdpf1EWW++vlkajUt2vUfzcPUE9K3N3hw4RIxQdc
	 v66DpeGL9M1OqTeyGN/m4Kk5kHQlBuT6gDG0xn781B5JqeMyVT4jutHKtb49AUZ4NyDrx
	 BHqtA5pAZ+DpJMf4vOKJmyReKwayml2K5oGYbF7okBRyIjquTuVSn1SWUnS4yVO5WvXid
	 7i1tK6HuxF33l7FcOr8ygUgj81IB089sdYGigkK65Mw35neSaRMptsN39EZeWVus27KPA
	 EU4tBwSRiRRegaryqcxQrb9yNLIEyD4DeFwoD1mYR/popzc+bkFqB3uhNzIATr+iUnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4d5mx3T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DC606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4d5mx3T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831951F000C4
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795611534;
	bh=FVmqX9e299gcsPkpyqf7SPDVELCZlYZjwwVu+fBIzo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=D4d5mx3Tod8gHVIHaCo2VKjmvMMjuKNYlytVfchc90cIGL51/MA481qFT9XFBXSja
	 yqLlJSM1PK7PX3/xSqxhsh9eZ8hydZT8RFBFfwJV381baIOEsC78pfvj+5a4mXD7ak
	 MVPnWQrq+/5m4dCBtswuMukH4CiaxhB+aQhmxxWP6Mt6tPxWSKjn0UpwyQ2JZ0Dfih
	 QguR1pgW9eSjGcYQo493vbGqAtP3yV+AmuntKw1aUVF6xGZDKELugoX7SgvIe0Qngz
	 SMhB/lsxiHh8chnzFa59/YVUy4ieydeyJvXXg/49pjhoduqL3HNLLFjvhdIOG2hojs
	 7OZ6odFPjKygg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5be4a2d94adso5096606e87.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 04:58:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF842QuELPHarAlPsraVPaoJ4DSC3sSt/XW/h7h3HXnKCoSz1PJEAhL+17E3R/3kWzuuOM80INzVQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9YY5PwjJ9JDfleCQZkrxhsu1Dd1q9mQi7cIMh2pcup6XlX9NDi
	mcPJ+1qr0WXhWiu4vVtMnOnxpdpzuD3A8Y2vu4BRnMge6sCUl7Fc0HL4n/EVQBaRHwrh7NSGVIZ
	7qZlCrhbPtxl9eNyP6Z9s82yqWlQ04uQ=
X-Received: by 2002:a05:6512:1102:b0:5c1:57c0:50a with SMTP id
 2adb3069b0e04-5c1bc6803a3mr5385444e87.6.1795611532957; Wed, 25 Nov 2026
 04:58:52 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-pm-runtime-summary-v3-0-81a966953a81@kernel.org>
 <20261123-pm-runtime-summary-v3-1-81a966953a81@kernel.org> <CAJZ5v0hpnoGw89WHyofLr3SxnrJNs99LnhndeOv245y_LgGWXQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hpnoGw89WHyofLr3SxnrJNs99LnhndeOv245y_LgGWXQ@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 25 Nov 2026 13:58:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jGBt522c90xDKq_tkAea9kxG3juwcoTemLYr=JHwyhOA@mail.gmail.com>
X-Gm-Features: Aa3M54qkzgYCu-C4blamcbtptpXU2e-PXH3AIkBR0zn0Zm0nHYMZath8Y3s6Kck
Message-ID: <CAJZ5v0jGBt522c90xDKq_tkAea9kxG3juwcoTemLYr=JHwyhOA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: runtime: add additional suspend/resume metrics
To: Joshua Crofts <crofts@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Samuel Wu <wusamuel@google.com>, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 1:54=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Mon, Nov 23, 2026 at 10:07=E2=80=AFAM Joshua Crofts <crofts@kernel.org=
> wrote:
> >
> > The current implementation only logs the total accumulated time a devic=
e
> > spends in suspended or active states.
> >
> > Add tracking for:
> > - resume_count : number of successful transitions to active
> > - suspend_count: number of successful transitions to suspended
> > - last_suspended_time: duration of the most recent sleep cycle (ns)
> > - min_suspended_time / max_suspended_time: shortest and longest sleep
> >   cycle durations to help detect power thrashing (ns)
>
> I would mention that they would be only reachable through a debugfs inter=
face.
>
> > Signed-off-by: Joshua Crofts <crofts@kernel.org>
> > ---
> >  drivers/base/power/runtime.c | 93 ++++++++++++++++++++++++++++++++++++=
+++++---
> >  include/linux/pm.h           | 16 +++++++-
> >  2 files changed, 103 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.=
c
> > index 4e9c23059a40..17aee68366cf 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -5,6 +5,8 @@
> >   * Copyright (c) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
> >   * Copyright (C) 2010 Alan Stern <stern@rowland.harvard.edu>
> >   */
> > +#include <linux/pm.h>
> > +#include <linux/timekeeping.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/ktime.h>
> >  #include <linux/hrtimer.h>
> > @@ -103,11 +105,70 @@ static void update_pm_runtime_accounting(struct d=
evice *dev)
> >                 dev->power.active_time +=3D delta;
> >  }
> >
> > +#ifdef CONFIG_DEBUG_FS
> > +static void rpm_account_suspend(struct device *dev)
> > +{
> > +       dev->power.suspend_time =3D dev->power.accounting_timestamp;
> > +       dev->power.suspend_count++;
> > +}
> > +
> > +static void rpm_account_sleep_end(struct device *dev)
> > +{
> > +       u64 duration;
> > +
> > +       if (!dev->power.suspend_time)
> > +               return;
> > +
> > +       if (dev->power.accounting_timestamp <=3D dev->power.suspend_tim=
e)
> > +               return;
> > +
> > +       duration =3D dev->power.accounting_timestamp - dev->power.suspe=
nd_time;
> > +       dev->power.last_suspended_time =3D duration;
> > +
> > +       /* Update min/max extrema at the exact same moment as last_susp=
ended_time */
> > +       if (!dev->power.min_suspended_time || duration < dev->power.min=
_suspended_time)
> > +               dev->power.min_suspended_time =3D duration;
> > +
> > +       if (duration > dev->power.max_suspended_time)
> > +               dev->power.max_suspended_time =3D duration;
> > +}
> > +
> > +static void rpm_account_resume_complete(struct device *dev)
> > +{
> > +       dev->power.resume_count++;
> > +       dev->power.suspend_time =3D 0;
> > +}
> > +#endif /* CONFIG_DEBUG_FS */
> > +
> >  static void __update_runtime_status(struct device *dev, enum rpm_statu=
s status)
> >  {
> > +#ifdef CONFIG_DEBUG_FS
> > +       enum rpm_status old_status =3D dev->power.runtime_status;
> > +#endif /* CONFIG_DEBUG_FS */
> > +
> >         update_pm_runtime_accounting(dev);
> >         trace_rpm_status(dev, status);
> >         dev->power.runtime_status =3D status;
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +       if (dev->power.disable_depth > 0) {
> > +               if (status =3D=3D RPM_ACTIVE)
> > +                       dev->power.suspend_time =3D 0;
> > +               return;
> > +       }
> > +
> > +       if ((old_status =3D=3D RPM_SUSPENDING || old_status =3D=3D RPM_=
ACTIVE) &&
> > +           status =3D=3D RPM_SUSPENDED)
> > +               rpm_account_suspend(dev);
> > +       else if (old_status =3D=3D RPM_RESUMING && status =3D=3D RPM_SU=
SPENDED)
> > +               dev->power.suspend_time =3D dev->power.accounting_times=
tamp;
> > +       else if (old_status =3D=3D RPM_SUSPENDED && status !=3D RPM_SUS=
PENDED)
> > +               rpm_account_sleep_end(dev);
> > +
> > +       if ((old_status =3D=3D RPM_RESUMING || old_status =3D=3D RPM_SU=
SPENDED) &&
> > +           status =3D=3D RPM_ACTIVE)
> > +               rpm_account_resume_complete(dev);
> > +#endif /* CONFIG_DEBUG_FS */
>
> Please move the code under CONFIG_DEBUG_FS in this function to a
> separate function called by it and defined as an empty stub if
> CONFIG_DEBUG_FS is unset.
>
> >  }
> >
> >  static u64 rpm_get_accounted_time(struct device *dev, bool suspended)
> > @@ -1580,6 +1641,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_disable);
> >  void pm_runtime_enable(struct device *dev)
> >  {
> >         unsigned long flags;
> > +       u64 now;
> >
> >         spin_lock_irqsave(&dev->power.lock, flags);
> >
> > @@ -1596,12 +1658,24 @@ void pm_runtime_enable(struct device *dev)
> >                 dump_stack();
> >         }
> >         dev->power.last_status =3D RPM_INVALID;
> > -       dev->power.accounting_timestamp =3D ktime_get_mono_fast_ns();
> > +       now =3D ktime_get_mono_fast_ns();
> >
> > -       if (dev->power.runtime_status =3D=3D RPM_SUSPENDED &&
> > -           !dev->power.ignore_children &&
> > -           atomic_read(&dev->power.child_count) > 0)
> > -               dev_warn(dev, "Enabling runtime PM for inactive device =
with active children\n");
> > +       if (dev->power.runtime_status =3D=3D RPM_SUSPENDED) {
> > +#ifdef CONFIG_DEBUG_FS
> > +               if (dev->power.suspend_time) {
> > +                       if (dev->power.accounting_timestamp
> > +                           && now > dev->power.accounting_timestamp)
> > +                               dev->power.suspend_time +=3D now - dev-=
>power.accounting_timestamp;
> > +               } else {
> > +                       dev->power.suspend_time =3D now;
> > +               }
> > +#endif /* CONFIG_DEBUG_FS */
>
> Same here.
>
> Plus you can use dev->power.accounting_timestamp as "now" in the new
> function after setting it above.
>
> > +               if (!dev->power.ignore_children &&
> > +                   atomic_read(&dev->power.child_count) > 0)
> > +                       dev_warn(dev, "Enabling runtime PM for inactive=
 device with active children\n");
> > +       }
> > +
> > +       dev->power.accounting_timestamp =3D now;
> >
> >  out:
> >         spin_unlock_irqrestore(&dev->power.lock, flags);
> > @@ -1870,6 +1944,15 @@ void pm_runtime_init(struct device *dev)
> >         pm_suspend_ignore_children(dev, false);
> >         dev->power.runtime_auto =3D true;
> >
> > +#ifdef CONFIG_DEBUG_FS
> > +       dev->power.resume_count =3D 0;
> > +       dev->power.suspend_count =3D 0;
> > +       dev->power.suspend_time =3D 0;
> > +       dev->power.last_suspended_time =3D 0;
> > +       dev->power.min_suspended_time =3D 0;
> > +       dev->power.max_suspended_time =3D 0;
> > +#endif /* CONFIG_DEBUG_FS */
>
> And here too.
>
> > +
> >         dev->power.request_pending =3D false;
> >         dev->power.request =3D RPM_REQ_NONE;
> >         dev->power.deferred_resume =3D false;
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index ef3f1310e749..caa4ba4a65de 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -747,6 +747,12 @@ struct pm_subsys_data {
> >   *   state.
> >   * @accounting_timestamp: Timestamp in nanoseconds of the last runtime=
 PM state
> >   *   accounting update.
> > + * @resume_count: Number of transitions from suspended -> active
> > + * @suspend_count: Number of transitions from active -> suspended
> > + * @suspend_time: Timestamp when device entered RPM_SUSPENDED
> > + * @last_suspended_time: Residency of the last sleep period (ns)

It is better to say "suspension" instead of "sleep" in this comment
and the two comments below to avoid confusion.

> > + * @min_suspended_time: Shortest sleep duration
> > + * @max_suspended_time: Longest sleep duration
> >   * @subsys_data: Subsystem-specific power management data.
> >   * @set_latency_tolerance: Callback for setting latency tolerance.
> >   * @qos: Per-device PM Quality of Service (QoS) constraints.
> > @@ -816,7 +822,15 @@ struct dev_pm_info {
> >         u64                     active_time;
> >         u64                     suspended_time;
> >         u64                     accounting_timestamp;
> > -#endif
> > +#ifdef CONFIG_DEBUG_FS
> > +       u64                     resume_count;
> > +       u64                     suspend_count;
> > +       u64                     suspend_time;
> > +       u64                     last_suspended_time;
> > +       u64                     min_suspended_time;
> > +       u64                     max_suspended_time;
> > +#endif /* CONFIG_DEBUG_FS */
> > +#endif /* CONFIG_PM */
> >         struct pm_subsys_data   *subsys_data;  /* Owned by the subsyste=
m. */
> >         void (*set_latency_tolerance)(struct device *, s32);
> >         struct dev_pm_qos       *qos;
> >
> > --
> > 2.47.3
> >
