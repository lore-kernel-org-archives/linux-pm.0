Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176629BD9A;
	Tue,  2 Jun 2026 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366140; cv=none; b=RkaHGgzrWC6mAYxxsaHcAQIzuljoYEa0gseDXA1kawbIz1XBhuqLqlKxAXDtV3IAy/ypwzo9fGafzmrH5bdu9cgRKIzB1ZE2ES9GGXrqqeB3QF81DH5nPowlCJamTyyeIc3EPzQE+/4i5HSG1ijZPwTBhORiYoFjlubC/whfV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366140; c=relaxed/simple;
	bh=4BHZ55I8M0TXApvgSlwo8lyoRxkRAi6JT5lTq6rvfgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYk0XiDFrXPItX0M6AN4gUn8eMbL9EF79maJt6PF90YuoyBqnfXSoyvDf5xhSMaZWM8JDxoBts0T2KB7K6EYJc5nNfTOd1SPV2NVQlCIrR2P8AtA5S5PYrvgHlgEY3vxAeozG5R/13Chslt8eLwPuJIw5Zn6k2Z0Y1wY8vD1/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX8uy/GT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX8uy/GT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE3D1F00893;
	Tue,  2 Jun 2026 02:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780366139;
	bh=+t0RYdIJ0r5/9fVdph4K07Ttv4KwZnct+mLmE7GxiC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IX8uy/GTnMQZfAsvfMSS0CXCI/UCCofijMSMW/t3449FxNaXQHu1lJAOtLRwrf+xB
	 Wm9ThH+5EAm1ThOxktJmpm9+t7u0x7XU0PJHKBN+a0ySWyuC+ttkbePvcArfBi30Yc
	 qEClD+isYN9frA7DCjFVks1IPZUJDY3gLfoBhK6FuHgp+sPqm64LSYdBE+XJom6A7B
	 mqNC3i42f8EqNuVTrUWH4cNFi8vEuyt4ycE6cyZmrUxRxR7sWtj564qbkQ+RlOBeFX
	 iESr27DEOYC+1TWTUODyJVcRacYoLQjDHxz0Fd1LEhaMdRoaLmS8dsQPSMGj2uGmwE
	 SXZn60Nj/cS2A==
Date: Tue, 2 Jun 2026 02:08:55 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	tfiga@chromium.org
Subject: Re: [PATCH] PM: sleep: Allow disabling DPM watchdog by default
Message-ID: <ah47N8Ng9zfcASmk@google.com>
References: <20260528103215.505795-1-tzungbi@kernel.org>
 <CAJZ5v0gc7AtOjWd+cg6tFgzPBovu=wmYmavjaRRjTdNNd8q-0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gc7AtOjWd+cg6tFgzPBovu=wmYmavjaRRjTdNNd8q-0g@mail.gmail.com>

On Mon, Jun 01, 2026 at 08:39:42PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 28, 2026 at 12:32 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index e1b550664bab..4f92905f3edf 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -527,6 +527,20 @@ module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
> >  MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> >                  "Backtrace all CPUs on DPM watchdog timeout");
> >
> > +#ifdef CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED
> > +static unsigned int __read_mostly dpm_watchdog_enabled = 1;
> > +#else
> > +static unsigned int __read_mostly dpm_watchdog_enabled;
> > +#endif
> > +
> > +static int __init dpm_watchdog_setup(char *str)
> > +{
> > +       if (kstrtouint(str, 0, &dpm_watchdog_enabled) == 0)
> > +               return 1;
> > +       return 0;
> > +}
> > +__setup("dpm_watchdog_enabled=", dpm_watchdog_setup);
> 
> You might as well use a module parameter to allow this to be set or
> clear at run time.  Is there a particular reason why you only want it
> to be enabled or disabled via the kernel command line?

Thanks for the suggestion.  Mainly because in our use cases, we only need
to set it once at boot time.

Also, I was wondering if we need to consider potential races if the flag
can be set at runtime.  E.g.:
1) The flag is set.
2) dpm_watchdog_set() is called and the timer is started.
3) The flag is then unset.
4) The subsequent dpm_watchdog_clear() isn't stop the timer.

Given this, would you still suggest providing the module parameter for
completeness?

> 
> > +
> >  /**
> >   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
> >   * @t: The timer that PM watchdog depends on.
> > @@ -570,6 +584,9 @@ static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
> >  {
> >         struct timer_list *timer = &wd->timer;
> >
> > +       if (!dpm_watchdog_enabled)
> > +               return;
> > +
> >         wd->dev = dev;
> >         wd->tsk = current;
> >         wd->fatal = CONFIG_DPM_WATCHDOG_TIMEOUT == CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
> > @@ -588,6 +605,9 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
> >  {
> >         struct timer_list *timer = &wd->timer;
> >
> > +       if (!dpm_watchdog_enabled)
> > +               return;
> > +
> >         timer_delete_sync(timer);
> >         timer_destroy_on_stack(timer);
> >  }
