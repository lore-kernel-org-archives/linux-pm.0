Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA32534A797
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389454; cv=none; b=hzX3OC7KFOFOEtMstrM0yl3MgS9r+JNUKfsiLaR7U9eeloOev/gj+Y0amgAp5uNF4asatEdEVDT6EuMsieOS0Os8Sx6dfT1WD7hVzXpobknJQIOJ8WjMV8ORSuO7/+lL3drdVcAH9DChaOIjprDzpsZQIiI5k8F0QxJ2iXGj8OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389454; c=relaxed/simple;
	bh=poHSp7k/wRwcxK6tvRyRthUfYkyEmfrgLwiq0NjfV98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uurOigBKJffXp76Zzl4owQA2RzWh9j6w/8FSYF1iQEP9RgzpiGov1xJWnS1uu+oOq6Bh4958zH9kRRW5oTKDSuxXn5TNkKZ8J/Pp8EfBd1lFBDLUr+l/mypcYsoH5ZlM1R+vUgA0qOZpJirM53cnTomNkznFN9PiTW9qq4j4X6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X3Hwa5tz; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X3Hwa5tz"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91550eceb4cso215084885a.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780389453; x=1780994253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2pO+fzMv1bHxu8FRKBOMPKrC8LbuYvxk/rUchVdGVI=;
        b=X3Hwa5tzWgOpZtW1zJ2W9eDah0J5JvQzRJrUVN2KdlZS8wHFGqm//KLmNGFiC2YolS
         T1mG9mT7pajmuTESmqzAcCVGdb3pt5GyINCFin7K35TtJuq8iE9OsRuxf5mle5qcv20n
         OE2ltGuUsxNy4bfglO+C2pbWqt9IX1/jFmBpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780389453; x=1780994253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2pO+fzMv1bHxu8FRKBOMPKrC8LbuYvxk/rUchVdGVI=;
        b=G/l2YTuibHQqGtHNfa45PV5rpg2xFnybC5ib2l0GaDK5w+VKsyjqJ9NSjym062hETh
         Lzcf/hPFtUydJikzZXhy9jL6/M82RvANN4x3uAoH0p9q6wCh3k0kWLPYzi3hbDDfhEQq
         CoWd0rJaAkkV2Da5BR9RKiJFaIFQ8TALcW7FYzBWkp5CenwDobqqiTZ/oPWcxqzy4YWy
         5dJSXcuBAKoYAw5quudSzSqdPxycKPrCecVdb1q0zwZkw/YW9fKpUjVIEgMtXD8aT5SL
         lVk2Mcf6TH8FyoEkB/4ke4keKafHvUofg+FG3YJVJ9FxIMuk0B6ye/bCQRxXiIfCCXNY
         KGkw==
X-Forwarded-Encrypted: i=1; AFNElJ+7+T9d9amyVAHj5OpCqrNqoeLls1Du4+G8IOmbMieHy10Xks9yGGSk3ARuudqL9BYvqNZdWv5Gpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwJXlfKWyBnhSupxmo5VyXWt87NTp45UgKACihGDlUWGuNfKd
	CKULLc4L1geOx40ZGUolfH4gpEs4Klgi39PB3UE40KfeWI2ZRZKiU/Jh2Rjp30VMsdOHPm5+eBE
	DqYPMew==
X-Gm-Gg: Acq92OF6CAlS8ncScLgPSdrAqzp7aC76yXA9HtgOQQHgApHfoBtl3YhuaS5aFDmSeGZ
	PbhC1bHRp/aUDs3lBXLNmiPWL9bVlTZlj27PT1zk6pOI/tm1VJfkKbzRe9DZzJNOw2E0yqRXYZC
	PNQngkR74+oI5kDfmL+KhxIAkHvtnxHL2o+s+Ei9XTf/MH1bxN8i2grIwkDWkoY+Wds+YR8jcVF
	LlQevSjIWcFZjvz8iWsiPqkKkxDMYhORWZk6ZZbtn+wOSD1m1XPFD7ia76GM3eC1a7+pABKPp0k
	RrrJB2UZfW7izCvK//ZLJYouLnxy+Gf01dFWP53DD4ORL59QRcw38cqj1htdV/CMKwrJKjRp0eX
	fi5ieWpKa8G1Y5nqzCju3Fvb8lfQj3g1aroy4rdHLDBVXkj4eRHhyFc+wCtp1HBYIWDue1ulvWd
	bBNaQGkvqUBqIg7fYw1I+z1EZkVX34H8CZVc0pNDzEdbjeyLkqIz9R0XK1tQOW55s5ch27fCbo
X-Received: by 2002:a05:620a:7005:b0:914:d093:abbe with SMTP id af79cd13be357-9153d9374e9mr2353862485a.12.1780389452765;
        Tue, 02 Jun 2026 01:37:32 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea1cadd2sm116258886d6.24.2026.06.02.01.37.31
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 01:37:32 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e61648f10so2551cf.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 01:37:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/v7ggczv7eQYDCwIeTDsOgIKqL2RG0yGoIH1aPsQqjOzMTB751t0e3t7oArX39vjUsM5UfK9gKjw==@vger.kernel.org
X-Received: by 2002:ac8:7209:0:b0:516:4f62:85e7 with SMTP id
 d75a77b69052e-517670f60e6mr7875761cf.18.1780389450588; Tue, 02 Jun 2026
 01:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528103215.505795-1-tzungbi@kernel.org> <CAJZ5v0gc7AtOjWd+cg6tFgzPBovu=wmYmavjaRRjTdNNd8q-0g@mail.gmail.com>
 <ah47N8Ng9zfcASmk@google.com>
In-Reply-To: <ah47N8Ng9zfcASmk@google.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 2 Jun 2026 17:37:13 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Drvq0iPAb2Ly=K7WLOmbRAcLY4TzZxHmhzarK4cvx1xA@mail.gmail.com>
X-Gm-Features: AVHnY4IK1BCekzEUvFQ7W25XhRgP5hRYDeCrICdpzLPF12YauXFtWy2YZIHikXM
Message-ID: <CAAFQd5Drvq0iPAb2Ly=K7WLOmbRAcLY4TzZxHmhzarK4cvx1xA@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Allow disabling DPM watchdog by default
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 11:09=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Mon, Jun 01, 2026 at 08:39:42PM +0200, Rafael J. Wysocki wrote:
> > On Thu, May 28, 2026 at 12:32=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.=
org> wrote:
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index e1b550664bab..4f92905f3edf 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -527,6 +527,20 @@ module_param(dpm_watchdog_all_cpu_backtrace, boo=
l, 0644);
> > >  MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> > >                  "Backtrace all CPUs on DPM watchdog timeout");
> > >
> > > +#ifdef CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED
> > > +static unsigned int __read_mostly dpm_watchdog_enabled =3D 1;
> > > +#else
> > > +static unsigned int __read_mostly dpm_watchdog_enabled;
> > > +#endif
> > > +
> > > +static int __init dpm_watchdog_setup(char *str)
> > > +{
> > > +       if (kstrtouint(str, 0, &dpm_watchdog_enabled) =3D=3D 0)
> > > +               return 1;
> > > +       return 0;
> > > +}
> > > +__setup("dpm_watchdog_enabled=3D", dpm_watchdog_setup);
> >
> > You might as well use a module parameter to allow this to be set or
> > clear at run time.  Is there a particular reason why you only want it
> > to be enabled or disabled via the kernel command line?
>
> Thanks for the suggestion.  Mainly because in our use cases, we only need
> to set it once at boot time.
>
> Also, I was wondering if we need to consider potential races if the flag
> can be set at runtime.  E.g.:
> 1) The flag is set.
> 2) dpm_watchdog_set() is called and the timer is started.
> 3) The flag is then unset.
> 4) The subsequent dpm_watchdog_clear() isn't stop the timer.
>
> Given this, would you still suggest providing the module parameter for
> completeness?

Would that lead to anything bad, though? If I'm remembering correctly,
would that mean that any already ongoing PM operations would still be
subject to the timer, but not any new ones.

My suggestion would also be to actually make the timeout and warning
timeout configurable at runtime.

Best,
Tomasz

>
> >
> > > +
> > >  /**
> > >   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
> > >   * @t: The timer that PM watchdog depends on.
> > > @@ -570,6 +584,9 @@ static void dpm_watchdog_set(struct dpm_watchdog =
*wd, struct device *dev)
> > >  {
> > >         struct timer_list *timer =3D &wd->timer;
> > >
> > > +       if (!dpm_watchdog_enabled)
> > > +               return;
> > > +
> > >         wd->dev =3D dev;
> > >         wd->tsk =3D current;
> > >         wd->fatal =3D CONFIG_DPM_WATCHDOG_TIMEOUT =3D=3D CONFIG_DPM_W=
ATCHDOG_WARNING_TIMEOUT;
> > > @@ -588,6 +605,9 @@ static void dpm_watchdog_clear(struct dpm_watchdo=
g *wd)
> > >  {
> > >         struct timer_list *timer =3D &wd->timer;
> > >
> > > +       if (!dpm_watchdog_enabled)
> > > +               return;
> > > +
> > >         timer_delete_sync(timer);
> > >         timer_destroy_on_stack(timer);
> > >  }
