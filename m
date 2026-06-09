Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A741B360;
	Tue,  9 Jun 2026 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010236; cv=none; b=DwjbloUCzyEzBonnqHGvsfz02AAA6+5U+GKfRsnrM5CziLbsUT9pfMKcqpvViEwQichr9fnN6nGAiz+W1ty2glkX2srZY65us408BV+iZjoAMnlB1YJ3yoBuMDh2JcnNCvq+E3kvU8ph40VaFwYzhJWm7JZhHkYseFbBa/g+U/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010236; c=relaxed/simple;
	bh=IzcIwAgeu5g9b/Dm6TzINp0tnJYPRqYW2izczkU+iRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHCEzk9GP+PuKOHDRaoVVG6JL6jzBwfryhLkPUjOlSQDSKM4+4rLcdpDSljQGid5paEWofQ+M/o2UvVAhK6zQV2aW6tvSVwAE1oMRPZacJfC9Q920kkm5r176meTedDPR6H4RsrjiyUKIwYe51y9syuwX8BqYXWXbJ+n5CqJ5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esRiNA6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esRiNA6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899CD1F00893;
	Tue,  9 Jun 2026 13:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781010234;
	bh=ypSCT+yCDv3So4rWXqiD7NaMasRWExLy8kpG5iclicw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=esRiNA6aKpEnnihxRJMi/sRE+2rkTw0xeaed5IzKY7bdizx6hXouNGj55EHvQkzjI
	 E0T/CYlRoLeZ8iTWSrqug32IFeR7LJKmmlI9X8I/8RoYethMACCHMwJXhUCM2ucVyZ
	 lv9HrFFz10DHEVCvYcMoEM73WLqv1ne461tWDUXnjM07PybVCA2sXK39o6b8CogbJo
	 Crnh2GMCLzzyndrNsh+ZseYgx42QNI4b9HYmwB1B1/W+bWqrQ+XFYRsTE5KTVtqIQY
	 MUqSY0CqbPvJ0yM0vsHxbZiwjT2b3Xyu6C5GCZdkqwx8Ibu0Vqx8lPvAYJKjsLeMo5
	 zTauzj0tbwNqg==
Date: Tue, 9 Jun 2026 13:03:50 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Tomasz Figa <tfiga@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	senozhatsky@chromium.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 1/3] PM: core: Rename module parameters prefix to
 "power"
Message-ID: <aigPNvkxRIz36dWm@google.com>
References: <20260608021526.1023248-1-tzungbi@kernel.org>
 <20260608021526.1023248-2-tzungbi@kernel.org>
 <CAJZ5v0jy75R24NztKJ0w4NMyRB7G+DcsC+gaQ0xZOQMfTfA5Ww@mail.gmail.com>
 <aifWwEyHuFejW4ac@google.com>
 <CAJZ5v0ja1ocM+W4hbVsHoZ=fFdmQ-=z4xzviNwo0eEyWT8ssBA@mail.gmail.com>
 <CAAFQd5Bmm4VeJ2ygOJeQYmdTq1DLBsQdvDkhstA-tUPZr0rB1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFQd5Bmm4VeJ2ygOJeQYmdTq1DLBsQdvDkhstA-tUPZr0rB1A@mail.gmail.com>

On Tue, Jun 09, 2026 at 08:17:03PM +0900, Tomasz Figa wrote:
> On Tue, Jun 9, 2026 at 8:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jun 9, 2026 at 11:03 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > >
> > > On Mon, Jun 08, 2026 at 04:11:30PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Jun 8, 2026 at 4:16 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > > >
> > > > > Currently, the module parameters defined in drivers/base/power/main.c
> > > > > use the default prefix "main" (derived from the filename).  The prefix
> > > > > "main" is too generic and non-descriptive for power management
> > > > > parameters.
> > > > >
> > > > > Redefine MODULE_PARAM_PREFIX to "power." at the beginning of the file
> > > > > to group the module parameters under the "power" namespace instead.
> > > > > This makes the parameters more descriptive.
> > > > >
> > > > > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > > > ---
> > > > > v3:
> > > > > - No changes.
> > > > >
> > > > > v2: https://lore.kernel.org/all/20260604090756.2884671-2-tzungbi@kernel.org
> > > > > - New to the series.
> > > > >
> > > > > v1: Doesn't exist.
> > > > >
> > > > >  drivers/base/power/main.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > > index ed48c292f575..cd864f3a2799 100644
> > > > > --- a/drivers/base/power/main.c
> > > > > +++ b/drivers/base/power/main.c
> > > > > @@ -40,6 +40,9 @@
> > > > >  #include "../base.h"
> > > > >  #include "power.h"
> > > > >
> > > > > +#undef MODULE_PARAM_PREFIX
> > > > > +#define MODULE_PARAM_PREFIX "power."
> > > >
> > > > "power" may be confused with the power supply support, so I'd rather
> > > > use "pm" or even "pm_sleep" (in which case the "dpm_" prefix could be
> > > > dropped from the new module param name in the next patch).
> > >
> > > Ack, will use "pm_sleep" in the next version.
> > >
> > > Regarding dropping the "dpm_" prefix, should this also apply to the existing
> > > dpm_watchdog_all_cpu_backtrace parameter?  Or should we leave it as-is to
> > > avoid breaking existing configurations?
> >
> > Breaking things for someone would be unfortunate.
> >
> > For consistency, let's retain the "dpm_watchdog" part in this name and
> > use it in the new one.
> 
> Hmm, doesn't the prefix change already break things?

Theoretically yes, though it's worth noting that this parameter is
relatively new.  It was introduced in v6.19 (Oct 2025) via commit
a67818f74512 ("PM: dpm_watchdog: add module param to backtrace all CPUs").

To my knowledge, the flag was originally introduced for ChromeOS [1], which
doesn't actually rely on this module parameter in its production
configuration yet [2].

That said, I can't know the status of all other Linux distributions.  If we
want to be 100% safe against breaking existing setups, retaining the "main"
prefix is definitely the safest.

Given its recent introduction and limited known usage, this might be the
best window to rename the prefix before it gains wider adoption.

What are your thoughts?

[1] https://chromium-review.git.corp.google.com/c/chromiumos/third_party/kernel/+/7414781
[2] https://chromium-review.git.corp.google.com/c/chromiumos/third_party/kernel/+/7414721
