Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC853C9899;
	Tue,  2 Jun 2026 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397298; cv=none; b=ksNxeAcUE7h7Cg0B7uEeyJiE3zGGa8yBR4mevkBod70pTdwEx7anLXzSFPlX57GFc6pVTYUgl6jcTpoZDtLyaVp3CB6yJBHuX9m64GJ9dbV/xVHE2Q/DV4aE0yuoHJjMnl+/8a2Epa4QqI9aNhsv9WebMXNX27DyTJ1QwmJRFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397298; c=relaxed/simple;
	bh=B4CKpiaUZCSxxkW/73r3zDFW0NKlGkUpiM/8pseozZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXb8kIrjN/QICYYRhdpbHhRg8gquUaeiB4Lk0ew3RwyE7dyFq8qMepkdpZ1Hx0BN2FAU/ZGGfjBiCGSlEBlOfCBd/6v0o+8QIJc7rXPooLtiFppVcXFVrQR9f4184/qABoEzsxNB1sOIQrX5GcYy/T3l1LT/nkLWz9HuwIejBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/fCq/iv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/fCq/iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5981F00893;
	Tue,  2 Jun 2026 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780397297;
	bh=tGgC4rIykQ3vI8+aBBTzSeILiADhagNEiS7yfs4f4z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K/fCq/iv5hMN588bwdg9gYjWLuiUNFwJp4nehXWTP5KMC7XZVB5Njdn3/C06JHJRa
	 ngcJ5LVTQLb+CvrKdDNX0HEvCbP/BiS0B89HZwdwPj2BpyNSwmagyjEuFXVNui8zp9
	 Zn4wpBAPV9I1+YRaYuzWUutZbGHaXXPnCcAwi8rLY29cfX0lkPruANsGA1epPcIZMm
	 +NHpkl1p1qerA/JPwwGh8XdVj5wc6zJdo4gZGF9h55zaOWApP4GqjepX36bN5EJ6rz
	 QLIBR3vkhp4s95cRtozXdcUfDynUFDUtP/XMq1mP6uteU72rxFizoxfO8UDIgixiHN
	 ytN7dUi6RZZNg==
Date: Tue, 2 Jun 2026 10:48:13 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Tomasz Figa <tfiga@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH] PM: sleep: Allow disabling DPM watchdog by default
Message-ID: <ah607VQjZeVKqOP0@google.com>
References: <20260528103215.505795-1-tzungbi@kernel.org>
 <CAJZ5v0gc7AtOjWd+cg6tFgzPBovu=wmYmavjaRRjTdNNd8q-0g@mail.gmail.com>
 <ah47N8Ng9zfcASmk@google.com>
 <CAAFQd5Drvq0iPAb2Ly=K7WLOmbRAcLY4TzZxHmhzarK4cvx1xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFQd5Drvq0iPAb2Ly=K7WLOmbRAcLY4TzZxHmhzarK4cvx1xA@mail.gmail.com>

On Tue, Jun 02, 2026 at 05:37:13PM +0900, Tomasz Figa wrote:
> On Tue, Jun 2, 2026 at 11:09 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Mon, Jun 01, 2026 at 08:39:42PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, May 28, 2026 at 12:32 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > index e1b550664bab..4f92905f3edf 100644
> > > > --- a/drivers/base/power/main.c
> > > > +++ b/drivers/base/power/main.c
> > > > @@ -527,6 +527,20 @@ module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
> > > >  MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> > > >                  "Backtrace all CPUs on DPM watchdog timeout");
> > > >
> > > > +#ifdef CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED
> > > > +static unsigned int __read_mostly dpm_watchdog_enabled = 1;
> > > > +#else
> > > > +static unsigned int __read_mostly dpm_watchdog_enabled;
> > > > +#endif
> > > > +
> > > > +static int __init dpm_watchdog_setup(char *str)
> > > > +{
> > > > +       if (kstrtouint(str, 0, &dpm_watchdog_enabled) == 0)
> > > > +               return 1;
> > > > +       return 0;
> > > > +}
> > > > +__setup("dpm_watchdog_enabled=", dpm_watchdog_setup);
> > >
> > > You might as well use a module parameter to allow this to be set or
> > > clear at run time.  Is there a particular reason why you only want it
> > > to be enabled or disabled via the kernel command line?
> >
> > Thanks for the suggestion.  Mainly because in our use cases, we only need
> > to set it once at boot time.
> >
> > Also, I was wondering if we need to consider potential races if the flag
> > can be set at runtime.  E.g.:
> > 1) The flag is set.
> > 2) dpm_watchdog_set() is called and the timer is started.
> > 3) The flag is then unset.
> > 4) The subsequent dpm_watchdog_clear() isn't stop the timer.
> >
> > Given this, would you still suggest providing the module parameter for
> > completeness?
> 
> Would that lead to anything bad, though? If I'm remembering correctly,
> would that mean that any already ongoing PM operations would still be
> subject to the timer, but not any new ones.

I was overthinking the race.  All userspace programs should be frozen when
the DPM watchdog is active.  The race I was concerned about isn't possible.

Would you still suggest providing the module parameter for completeness?

> 
> My suggestion would also be to actually make the timeout and warning
> timeout configurable at runtime.

I'm working on that and I think that should be in a separate patch.
