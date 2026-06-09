Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4253FD12D
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003300; cv=none; b=oM6zzMXYYuhGNIhQuZlUTxiCqbtB1WmdWkL58s+7XR0YeHCic8GA7hfoKThJuiSalQwKPCult/L0N7MhcmiBWxkxnsuLMtFqz1yeNsW6WyUOcZA6H3Y0ad+eKdp79MPQxdgiPyjijDzis1E7dFRIMicQ2a8PEzqS3jyUnyb13go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003300; c=relaxed/simple;
	bh=WnpEEbeV6Xf8HOrAvMNaDaoMIMuMt0nxS5cI/2qJSD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSkeSznHrSxoKA/CrszpZ5Fz+dCDJNPEsRE97Hy2z5XKKss2UNTxXgzrobclTx3wUbbqvsVFOiIMMPDISFXtFGlUDY34Gay2yCrg6lidJhTGcLmVTb+jSCzOgzYiUpQbvr7PVa+hlqGUwoB4Mcmu+DWC7aa3jT9BkCTLXLL7yQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMlt9VeW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMlt9VeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B811F0089F
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781003299;
	bh=uAcx1TLJhxHxE1DspdQDFqFbxQb8Zirx9f+KX82czck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WMlt9VeWVQHy3iBMNR1/23qeLuPvROgoJSbvw9dujLcNO71APQQmufKz/kVTemajv
	 ImESC5mCRGD3Iah2N49TstG5nSvRVCIeSWcFP4IwUAR8+emql84ksfO21OwCUwxBn8
	 lAJ8d1DpssI6nzObdD/ouH8/WviYLpRt3/g9oFzO+Hzqrhb66sNpXSP8MJ0AsBY2Z9
	 vGrRGwfwcVY6wAwTm7b58KuLdunpfVtNHazDmUHIdQOr6T0h83qJkQ9XH8l44OoiRX
	 NJDhnsGGSKJSwxieRfSA/TMrdG1rFEiEjijs6gCWg/aqlpBa06aWibIIYQLVFQNl30
	 SaBXgU/UJzKAQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so4665089e87.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 04:08:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ87uRka0E/Pjj+MAKGntQ2yR+87qmmOBvCQvmyzhX/Simkzgrl2NtGLYIOtpw4NWCdQpZvcx/FqzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlbHncNgDhiJfu23YLW10Gyn8BSj/LowpxyrQkZSSIB1WUKfb
	+Mq3TLMrlA9//FRKkVVCqch1wpVJVWvTxc6uNUT0vScSX7GE9BveFM9dlFysqOk/lKPNOhntltt
	RRW3NpJKn464H9ohIC0fHRGxLCiOwiFM=
X-Received: by 2002:a05:6512:3ca8:b0:5aa:64b4:13dc with SMTP id
 2adb3069b0e04-5aa87b3ff0fmr6452458e87.5.1781003297675; Tue, 09 Jun 2026
 04:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608021526.1023248-1-tzungbi@kernel.org> <20260608021526.1023248-4-tzungbi@kernel.org>
 <CAJZ5v0j=Uey90jN-TiUkx+FEPKtNUWhDGrfhxke65Em_ycbc+w@mail.gmail.com> <aifWjW93SOQiv_Eh@google.com>
In-Reply-To: <aifWjW93SOQiv_Eh@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jun 2026 13:08:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jHutbyvPRfzLYLkxiP=iAejGyC6n-czzOcLScKwGWx1A@mail.gmail.com>
X-Gm-Features: AVVi8Ce605rLSlVkeJ9Nh1ILn9h0ylh1zgMK9ZdLiNODLKV3i_tgNr8o99GPckQ
Message-ID: <CAJZ5v0jHutbyvPRfzLYLkxiP=iAejGyC6n-czzOcLScKwGWx1A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PM: dpm_watchdog: Add sysctl interface for DPM
 watchdog timeouts
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, tfiga@chromium.org, 
	senozhatsky@chromium.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 11:02=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Mon, Jun 08, 2026 at 04:22:35PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 8, 2026 at 4:16=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.or=
g> wrote:
> > >
> > > Introduce sysctl knobs to allow configuring DPM watchdog timeouts at
> > > runtime.
> > >
> > > Currently, these timeouts are fixed at compile time via
> > > CONFIG_DPM_WATCHDOG_TIMEOUT and CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT.
> > > This limits flexibility if the timeouts need to be adjusted for
> > > different testing scenarios or hardware behaviors without rebuilding
> > > the kernel.
> > >
> > > Add the following sysctl files under /proc/sys/kernel/:
> > > - dpm_watchdog_timeout_secs: The total timeout before panic. The
> > >   maximum value is capped at CONFIG_DPM_WATCHDOG_TIMEOUT to prevent
> > >   unreasonably large timeouts.
> > > - dpm_watchdog_warning_timeout_secs: The warning timeout. The maximum
> > >   value is capped at the current dpm_watchdog_timeout_secs.
> > > Both sysctls have a minimum value of 1.
> > >
> > > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > ---
> > > v3:
> > > - No changes.
> > >
> > > v2: https://lore.kernel.org/all/20260604090756.2884671-4-tzungbi@kern=
el.org
> > > - New to the series.
> > >
> > > v1: Doesn't exist.
> > >
> > >  drivers/base/power/main.c | 61 ++++++++++++++++++++++++++++++++++++-=
--
> > >  1 file changed, 57 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 7822c29b7c8d..c1a4b30fafb2 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -28,6 +28,7 @@
> > >  #include <linux/interrupt.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/sched/debug.h>
> > > +#include <linux/sysctl.h>
> > >  #include <linux/async.h>
> > >  #include <linux/suspend.h>
> > >  #include <trace/events/power.h>
> > > @@ -539,6 +540,58 @@ static bool __read_mostly dpm_watchdog_enabled =
=3D
> > >  module_param(dpm_watchdog_enabled, bool, 0644);
> > >  MODULE_PARM_DESC(dpm_watchdog_enabled, "Enable DPM watchdog");
> > >
> > > +static unsigned int __read_mostly dpm_watchdog_timeout =3D CONFIG_DP=
M_WATCHDOG_TIMEOUT;
> > > +static unsigned int __read_mostly dpm_watchdog_warning_timeout =3D
> > > +                                               CONFIG_DPM_WATCHDOG_W=
ARNING_TIMEOUT;
> > > +static const unsigned int dpm_watchdog_timeout_max =3D CONFIG_DPM_WA=
TCHDOG_TIMEOUT;
> > > +
> > > +static int proc_dodpm_watchdog_timeout_secs(const struct ctl_table *=
table,
> > > +                                           int write, void *buffer,
> > > +                                           size_t *lenp, loff_t *ppo=
s)
> > > +{
> > > +       struct ctl_table ctl =3D *table;
> > > +       unsigned int val =3D dpm_watchdog_timeout;
> > > +       int ret;
> > > +
> > > +       ctl.data =3D &val;
> > > +       ret =3D proc_douintvec_minmax(&ctl, write, buffer, lenp, ppos=
);
> > > +       if (ret || !write)
> > > +               return ret;
> > > +
> > > +       if (val < dpm_watchdog_warning_timeout)
> > > +               dpm_watchdog_warning_timeout =3D val;
> > > +       dpm_watchdog_timeout =3D val;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct ctl_table dpm_watchdog_sysctls[] =3D {
> > > +       {
> > > +               .procname       =3D "dpm_watchdog_timeout_secs",
> > > +               .maxlen         =3D sizeof(unsigned int),
> > > +               .mode           =3D 0644,
> > > +               .proc_handler   =3D proc_dodpm_watchdog_timeout_secs,
> > > +               .extra1         =3D SYSCTL_ONE,
> > > +               .extra2         =3D (void *)&dpm_watchdog_timeout_max=
,
> > > +       },
> > > +       {
> > > +               .procname       =3D "dpm_watchdog_warning_timeout_sec=
s",
> > > +               .data           =3D &dpm_watchdog_warning_timeout,
> > > +               .maxlen         =3D sizeof(unsigned int),
> > > +               .mode           =3D 0644,
> > > +               .proc_handler   =3D proc_douintvec_minmax,
> > > +               .extra1         =3D SYSCTL_ONE,
> > > +               .extra2         =3D (void *)&dpm_watchdog_timeout,
> > > +       },
> > > +};
> > > +
> > > +static int __init dpm_watchdog_sysctl_init(void)
> > > +{
> > > +       register_sysctl_init("kernel", dpm_watchdog_sysctls);
> > > +       return 0;
> > > +}
> > > +subsys_initcall(dpm_watchdog_sysctl_init);
> > > +
> > >  /**
> > >   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
> > >   * @t: The timer that PM watchdog depends on.
> > > @@ -564,9 +617,9 @@ static void dpm_watchdog_handler(struct timer_lis=
t *t)
> > >                         dev_driver_string(wd->dev), dev_name(wd->dev)=
);
> > >         }
> > >
> > > -       time_left =3D CONFIG_DPM_WATCHDOG_TIMEOUT - CONFIG_DPM_WATCHD=
OG_WARNING_TIMEOUT;
> > > +       time_left =3D dpm_watchdog_timeout - dpm_watchdog_warning_tim=
eout;
> > >         dev_warn(wd->dev, "**** DPM device timeout after %u seconds; =
%u seconds until panic ****\n",
> > > -                CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT, time_left);
> > > +                dpm_watchdog_warning_timeout, time_left);
> > >         show_stack(wd->tsk, NULL, KERN_WARNING);
> > >
> > >         wd->fatal =3D true;
> > > @@ -587,11 +640,11 @@ static void dpm_watchdog_set(struct dpm_watchdo=
g *wd, struct device *dev)
> > >
> > >         wd->dev =3D dev;
> > >         wd->tsk =3D current;
> > > -       wd->fatal =3D CONFIG_DPM_WATCHDOG_TIMEOUT =3D=3D CONFIG_DPM_W=
ATCHDOG_WARNING_TIMEOUT;
> > > +       wd->fatal =3D dpm_watchdog_timeout =3D=3D dpm_watchdog_warnin=
g_timeout;
> > >
> > >         timer_setup_on_stack(timer, dpm_watchdog_handler, 0);
> > >         /* use same timeout value for both suspend and resume */
> > > -       timer->expires =3D jiffies + HZ * CONFIG_DPM_WATCHDOG_WARNING=
_TIMEOUT;
> > > +       timer->expires =3D jiffies + HZ * dpm_watchdog_warning_timeou=
t;
> > >         add_timer(timer);
> > >  }
> > >
> > > --
> >
> > I think that this can be applied without the other two patches in the
> > series, so please let me know if you want me to apply it separately.
>
> Ack.  The patch does have adjacent hunks with the preceding patch, which
> might cause minor contextual conflicts if applied independently.

That's not a problem.

> Would you want me to reorder the series in the next version to make this
> the first patch?  In case the rest two patches may still take some time
> to review.

I'll pick it up as is, so it can make it into 7.2.
