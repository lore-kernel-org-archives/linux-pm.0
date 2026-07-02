Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C360375F81;
	Thu,  2 Jul 2026 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972755; cv=none; b=kcE4LOFEIQ5ivxRmKbOvMcYf2ZfJS7YP9IvU4vBa8fDAnIB3hUvslmcvsw2wjddW0yG6DB/IV92PnVE7d3fI6tgPVGtLCEKoMEzYYq5iwZXQ9DneDeF+tPRueiyG4ju5wPadQ7KrXXiKljDZstRdMtRWpbXPcUJvwWA/F/ux2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972755; c=relaxed/simple;
	bh=DJIuscRTaAjtMWnc4698PNWAw7LLTT0m9/hosL4X6pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3g6X/nKGDGZzQ5cxbywT3WsLwoIwW5Ic67Q2sONpfk1DJRIdcRZYLAiSndTCHBwueVUlvAlGqM1GeX/CgeKM+RQlkFuYD+SJFUUdvlw4Cl6RQl9rB8aALl6JN6i2Bd8ruZ0bXiJoXtKlsF/LAjf6Jf5tNUJS2LxhqGy6HF/XM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6pHxkxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6pHxkxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B471F000E9;
	Thu,  2 Jul 2026 06:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782972753;
	bh=2Pz7VNLrEMNrLBDs+5aAtRtpYCC8kLZD9CTOtu2AAic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m6pHxkxrOm6eAkhVC5wcskecggqtHEonXSjol7RRbstxTWw1wiUkBXUXtFMH7SxJx
	 hK2zOwqUEvGPz3tPhitFUCt2xjyLfvzbA/Tn4P2VrXXCEcfbNW/RVnFl5Ux+jD73Zz
	 tPJ2qcp9fpLF/190On8Ul6EcALUWF8dkt/yv5fP2zZ18L1OBcYfnmUGuIa1oox2/+5
	 HjgeRUPBdTojTFMljv9X7/BgWuhtISRi/rWplGz7DaEYxTihL99yCP7EkDy0lCrNYp
	 Tu4j+3ZfA2C2KHzjy6kglcRx8InNij+luqaAQJlB0iI+y3i2aES74jTjoGhuxusOkU
	 M3XmzAzFX279w==
Date: Thu, 2 Jul 2026 06:12:29 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	tfiga@chromium.org, senozhatsky@chromium.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 2/2] PM: dpm_watchdog: Allow disabling DPM watchdog by
 default
Message-ID: <akYBTbV61YKcRjZ4@google.com>
References: <20260701045640.3130090-1-tzungbi@kernel.org>
 <20260701045640.3130090-3-tzungbi@kernel.org>
 <2026070140-rally-prowling-4d66@gregkh>
 <CAJZ5v0goFxWOjjm1_JyaORKViEEc99-Tj-Yq4K0guYqZEvU9gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0goFxWOjjm1_JyaORKViEEc99-Tj-Yq4K0guYqZEvU9gg@mail.gmail.com>

On Wed, Jul 01, 2026 at 02:53:18PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Wed, Jul 1, 2026 at 9:22 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 01, 2026 at 04:56:40AM +0000, Tzung-Bi Shih wrote:
> > > Introduce the "dpm_watchdog_enabled" module parameter to allow the DPM
> > > watchdog to be enabled or disabled at boot time and runtime.
> >
> > As I say all the time, this isn't the 1990's, please don't add new
> > module parameters as they are a pain to manage and maintain over time
> > (as you found out with my rejection of patch 1/2 here...)
> 
> Let me challenge this though because there are use cases for something
> like module parameters AFAICS.
> 
> There are things that are "on" by default that people want to turn
> "off" and ideally at init time.  If that happens in a loadable module,
> the only way to do so I'm aware of is using a module parameter.
> 
> There are also diagnostic features that are generally "off", but it is
> useful to turn them "on" occasionally, both at run time and at init
> time.  Adding a special kernel command line option and a separate
> special sysfs switch (for example) for that is kind of a pain and
> using a module parameter in such cases appears to be more
> straightforward to me, so what really is the problem with that?
> 
> Moreover, there are those cases in which updating the kernel command
> line is more straightforward than updating user space to write into a
> specific file in sysfs after boot, so using a module parameter helps.
> 
> So in general, assuming that the underlying use case is good enough,
> is a module parameter really worse than a combination of a special
> sysfs file and a special kernel command line argument and if so, then
> why?
> 
> Of course, whether or not the underlying use case is good enough is a
> different matter.
> 
> > > Additionally, introduce the CONFIG_DPM_WATCHDOG_ENABLED Kconfig option
> > > to set default value of the module parameter at compile time.
> > >
> > > This provides flexibility for systems that want the watchdog code
> > > compiled in but inactive by default, allowing it to be enabled only when
> > > needed.
> > >
> > > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > ---
> > > v5: No changes.
> > >
> > > v4: https://lore.kernel.org/all/20260611021219.2093476-2-tzungbi@kernel.org
> > > - Rewrite the commit message to indicate the module parameter is the
> > >   main change in the patch.
> > > - DPM_WATCHDOG_DEFAULT_ENABLED -> DPM_WATCHDOG_ENABLED.
> > >
> > > v3: https://lore.kernel.org/all/20260608021526.1023248-3-tzungbi@kernel.org
> > > - Add "PM" tag (was missing).
> > > - Update the format and specify dependencies in kernel-parameters.txt.
> > > - Update the help message in Kconfig to reflect that dpm_watchdog_enabled
> > >   can be set at runtime as well.
> > >
> > > v2: https://lore.kernel.org/all/20260604090756.2884671-3-tzungbi@kernel.org
> > > - Use module parameter and bool for dpm_watchdog_enabled.
> > > - Use IS_ENABLED().
> > >
> > > v1: https://lore.kernel.org/all/20260528103215.505795-1-tzungbi@kernel.org
> > > ---
> > >  Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
> > >  drivers/base/power/main.c                       | 11 +++++++++++
> > >  kernel/power/Kconfig                            | 10 ++++++++++
> > >  3 files changed, 28 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index b5493a7f8f22..46c20e1b5f05 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -47,6 +47,7 @@
> > >       PCI     PCI bus support is enabled.
> > >       PCIE    PCI Express support is enabled.
> > >       PCMCIA  The PCMCIA subsystem is enabled.
> > > +     PM      Power Management support is enabled.
> > >       PNP     Plug & Play support is enabled.
> > >       PPC     PowerPC architecture is enabled.
> > >       PPT     Parallel port support is enabled.
> > > @@ -5354,6 +5355,12 @@ Kernel parameters
> > >       pm_debug_messages       [SUSPEND,KNL]
> > >                       Enable suspend/resume debug messages during boot up.
> > >
> > > +     pm_sleep.dpm_watchdog_enabled=
> > > +                     [PM] Enable or disable the DPM watchdog.  Requires
> > > +                     CONFIG_PM_SLEEP and CONFIG_DPM_WATCHDOG enabled.
> > > +                     Format: <bool>
> > > +                     Default value is set by CONFIG_DPM_WATCHDOG_ENABLED.
> > > +
> > >       pnp.debug=1     [PNP]
> > >                       Enable PNP debug messages (depends on the
> > >                       CONFIG_PNP_DEBUG_MESSAGES option).  Change at run-time
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index c6a3300cfb7a..f58945758868 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -535,6 +535,11 @@ module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
> > >  MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> > >                "Backtrace all CPUs on DPM watchdog timeout");
> > >
> > > +static bool __read_mostly dpm_watchdog_enabled =
> > > +                             IS_ENABLED(CONFIG_DPM_WATCHDOG_ENABLED);
> > > +module_param(dpm_watchdog_enabled, bool, 0644);
> > > +MODULE_PARM_DESC(dpm_watchdog_enabled, "Enable DPM watchdog");
> > > +
> > >  static unsigned int __read_mostly dpm_watchdog_timeout = CONFIG_DPM_WATCHDOG_TIMEOUT;
> > >  static unsigned int __read_mostly dpm_watchdog_warning_timeout =
> > >                                               CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
> > > @@ -630,6 +635,9 @@ static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
> > >  {
> > >       struct timer_list *timer = &wd->timer;
> > >
> > > +     if (!dpm_watchdog_enabled)
> > > +             return;
> > > +
> > >       wd->dev = dev;
> > >       wd->tsk = current;
> > >       wd->fatal = dpm_watchdog_timeout == dpm_watchdog_warning_timeout;
> > > @@ -648,6 +656,9 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
> > >  {
> > >       struct timer_list *timer = &wd->timer;
> > >
> > > +     if (!dpm_watchdog_enabled)
> > > +             return;
> > > +
> > >       timer_delete_sync(timer);
> > >       timer_destroy_on_stack(timer);
> > >  }
> > > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > > index 530c897311d4..508ceabc4d2e 100644
> > > --- a/kernel/power/Kconfig
> > > +++ b/kernel/power/Kconfig
> > > @@ -268,6 +268,16 @@ config DPM_WATCHDOG
> > >         captured in pstore device for inspection in subsequent
> > >         boot session.
> > >
> > > +config DPM_WATCHDOG_ENABLED
> > > +     bool "Enable DPM watchdog by default"
> > > +     depends on DPM_WATCHDOG
> > > +     default y
> >
> > Only do this if you can not boot without the option enabled, which I do
> > not think is the case here.
> 
> So in this particular case, there is a way to adjust the watchdog
> timeout and if it is set to a very large value, the watchdog gets
> effectively disabled for all purposes.
> 
> I'm not entirely sure if another switch to disable/enable it is needed
> in addition to that TBH.

They are still different.  Setting a very large timeout effectively delays
the timeout, but doesn't disable the DPM watchdog.

For devices that are unaware of the watchdog, a long suspend/resume cycle
might still eventually reach that large timeout and trigger unexpectedly.

More importantly, the timeout currently has a strict upper bound of 120
seconds.  Setting it to a "very large value" is infeasible without changing
the Kconfig:

        config DPM_WATCHDOG_TIMEOUT
                int "Watchdog timeout to panic in seconds"
                range 1 120
                default 120

To provide a bit more context on our use case:
Our primary intent here revolves around Android GKI (Generic Kernel Image).
We want to enable CONFIG_DPM_WATCHDOG in the GKI so the feature is available.
However, because the GKI is shared across many different devices, we don't
want to affect devices that are unaware of this feature.  We need a way to
compile it in, but keep it disabled by default for those devices.
