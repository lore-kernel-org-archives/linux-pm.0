Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17683E0730
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405083; cv=none; b=qybzYpgYZAvAfIGDF/p5d+LRuA1sMDvA045W740PttMljo2VuyaDhaTbcKcyJR2ekSOCNHVEQXO7yFHNbB2Xre6rSWpV1KixCGqlgN1ogoSgUh/b8VyxWEIPoHiV1c1gTnCVO33o7SkoRDmxrWMh2KGaaAS0QDxQFRxH+U3Tjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405083; c=relaxed/simple;
	bh=g3EsPEeclboffoN4RYwwMYX1oGuyBaS6O6dpSTTXey0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7NQPYJ5ZH1jCXW0YpacgCGHi8g528KxEvaqbwP7SBTs+L6tYqp7BJtJOJo5tK74871u5hTPYITga6jprzrvJcVYi+aNCvINeJWg4lgaOrZVi0745FTWJRCxBuezXXhenAMuB34ru3jWA7o9Sz8ampG8dXQxQXHFIXXjEuk7kn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K6vF9FIa; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K6vF9FIa"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-516d0db9372so100266251cf.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780405081; x=1781009881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dnOAmoRyxNthicf1c6w62nXUJx2BXxcSG3avUHO1yI=;
        b=K6vF9FIat2W/fFhtLU3DeKxenaeszxbMdyZWUdzlDMcHix6YFR9q9hdsiz4Lrc9Ynv
         C88QPDBOuWLz6/WK8oqngL7vI4zN1hRCAounmjtIFedrZay394kZKkudxezKGgXz65R7
         TXrNkUC/VFutT8aS2KdUlQV+FEnSITHuVj3/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405081; x=1781009881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dnOAmoRyxNthicf1c6w62nXUJx2BXxcSG3avUHO1yI=;
        b=b/YKLOBmi8dhoURNhehjok1vruM9/vpkVJr8Frfgwck4GnoG4Ca80sesAmolGT4FWo
         8PRUQEunpdUpnT948W8hFZNiwknjQu6jR+I60Lo078awFUyzqQsjhCbBlBPWrDehg4yC
         VXFaRt0iI+jBjrLzp+f7Q9Zb0M9q6PQBK4QIpIRM8Wq/+6GGbdU4mwdKiqmY11KQsGO/
         9idfcTZgJKwcS0JT6Yw4k4hrs4VlriaNXr+bBXQNdyAGNvlIAO82WyRBBJLhNLiqzv4A
         mcIuRHmFA6aGlyhljwR36ZhEijqd7/2rnTbgJyz/GqnlPBys2yUVVQqp6p3FTAa9ZI3G
         fbYA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZYDDG9WhLgjlPFJVoBwAye+QiWf++sUVj5/F78+jlqpBbOsoavUr2WZhF0MGGSEbuVImfsXYdHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt3c9Agk8I6E2CaMbc1RRdii7NfbcJjOyLPJiWWcwR0CdnoP4a
	aYNX06N7dskOUz4/63ZgGgmFtHkI11ZWgOuj//jV6Lzq9dKLVAsSDdx5mCxxlqmBJsctjfvF4al
	IJm/ZMA==
X-Gm-Gg: Acq92OGGmFBx+TgRnOFF+BISWh6NydXN+yZ2PABgvlGX8GHqknEFHz05PNhPwYQ457n
	DXIAsvA6Vw+ZoYj2pS5EjJ8JcxpTXTxkpiXoQf2qafQtsCdnCvRueC54othP4zjSAUbMKykOWKn
	FOjMaoaQDC3Ug58BsF/hjaDkQbnCKMeVODOTDiug07wGFktRboG8BPDpuqQz87FDMImxOD0j0YP
	SE4yWW15BRFPjO/rmMEed3Fbunyty6Oywh6EhFZDtZ4Y7RKWjAhZ3l28lr1c1dhpKXzzxGWB96j
	PYp+7tgAoFhZbzlcKDYT1UjpkCrXHdZwAfdvuXLs9sAhE4jCXT/Kshqpado+MqFiTzkYT7JoUaE
	gV6LMeKBuH8gbNFr60iDrtYRiWssCbAViSxH++xVfwwBR+Tqn3vBF863YQALh0/QhZg1Lw5JecI
	1rYO5CwH3Kxf9HzZ3ngMjqh3PVq/6RUgA+aS4XWTBHqyeGIFpamRWiEUDB0au1A88eH8+J1EGS
X-Received: by 2002:a05:622a:8353:b0:516:f4f7:3318 with SMTP id d75a77b69052e-5173a84aa33mr189254991cf.48.1780405080884;
        Tue, 02 Jun 2026 05:58:00 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51771a45e9dsm5833301cf.9.2026.06.02.05.57.58
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 05:57:59 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e61648f10so12911cf.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 05:57:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+YzR4mHvV/JG/q/185TeRq1zNxkk754u02h6tEsg/TC0K4b4OUekGd0wVUZb+cD4/e1RF5YYQbew==@vger.kernel.org
X-Received: by 2002:a05:622a:568d:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-5176aa0bfc0mr7185061cf.5.1780405077197; Tue, 02 Jun 2026
 05:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528103215.505795-1-tzungbi@kernel.org> <CAJZ5v0gc7AtOjWd+cg6tFgzPBovu=wmYmavjaRRjTdNNd8q-0g@mail.gmail.com>
 <ah47N8Ng9zfcASmk@google.com> <CAAFQd5Drvq0iPAb2Ly=K7WLOmbRAcLY4TzZxHmhzarK4cvx1xA@mail.gmail.com>
 <ah607VQjZeVKqOP0@google.com>
In-Reply-To: <ah607VQjZeVKqOP0@google.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 2 Jun 2026 21:57:40 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A-b0_de2RenHER-U8jHB+oX1HCjdwOe97KXrnAvZDaaQ@mail.gmail.com>
X-Gm-Features: AVHnY4Jg3-atKcicTbx0VLmhOWxiVCwzSMZnJZPxPioqRbNAthQJ4WJBPWSyNbI
Message-ID: <CAAFQd5A-b0_de2RenHER-U8jHB+oX1HCjdwOe97KXrnAvZDaaQ@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Allow disabling DPM watchdog by default
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 7:48=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> On Tue, Jun 02, 2026 at 05:37:13PM +0900, Tomasz Figa wrote:
> > On Tue, Jun 2, 2026 at 11:09=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.o=
rg> wrote:
> > >
> > > On Mon, Jun 01, 2026 at 08:39:42PM +0200, Rafael J. Wysocki wrote:
> > > > On Thu, May 28, 2026 at 12:32=E2=80=AFPM Tzung-Bi Shih <tzungbi@ker=
nel.org> wrote:
> > > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.=
c
> > > > > index e1b550664bab..4f92905f3edf 100644
> > > > > --- a/drivers/base/power/main.c
> > > > > +++ b/drivers/base/power/main.c
> > > > > @@ -527,6 +527,20 @@ module_param(dpm_watchdog_all_cpu_backtrace,=
 bool, 0644);
> > > > >  MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> > > > >                  "Backtrace all CPUs on DPM watchdog timeout");
> > > > >
> > > > > +#ifdef CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED
> > > > > +static unsigned int __read_mostly dpm_watchdog_enabled =3D 1;
> > > > > +#else
> > > > > +static unsigned int __read_mostly dpm_watchdog_enabled;
> > > > > +#endif
> > > > > +
> > > > > +static int __init dpm_watchdog_setup(char *str)
> > > > > +{
> > > > > +       if (kstrtouint(str, 0, &dpm_watchdog_enabled) =3D=3D 0)
> > > > > +               return 1;
> > > > > +       return 0;
> > > > > +}
> > > > > +__setup("dpm_watchdog_enabled=3D", dpm_watchdog_setup);
> > > >
> > > > You might as well use a module parameter to allow this to be set or
> > > > clear at run time.  Is there a particular reason why you only want =
it
> > > > to be enabled or disabled via the kernel command line?
> > >
> > > Thanks for the suggestion.  Mainly because in our use cases, we only =
need
> > > to set it once at boot time.
> > >
> > > Also, I was wondering if we need to consider potential races if the f=
lag
> > > can be set at runtime.  E.g.:
> > > 1) The flag is set.
> > > 2) dpm_watchdog_set() is called and the timer is started.
> > > 3) The flag is then unset.
> > > 4) The subsequent dpm_watchdog_clear() isn't stop the timer.
> > >
> > > Given this, would you still suggest providing the module parameter fo=
r
> > > completeness?
> >
> > Would that lead to anything bad, though? If I'm remembering correctly,
> > would that mean that any already ongoing PM operations would still be
> > subject to the timer, but not any new ones.
>
> I was overthinking the race.  All userspace programs should be frozen whe=
n
> the DPM watchdog is active.  The race I was concerned about isn't possibl=
e.

Right. Somehow I was convinced that the DPM watchdog is also used for
runtime PM, but after checking the code it doesn't look like so.

>
> Would you still suggest providing the module parameter for completeness?

I'd also vote for a module parameter. Being able to toggle this at
runtime would be useful for troubleshooting problems without needing
to change the command line arguments (which isn't trivial on some
systems).

>
> >
> > My suggestion would also be to actually make the timeout and warning
> > timeout configurable at runtime.
>
> I'm working on that and I think that should be in a separate patch.

Great, thanks. I'll leave the splitting and other logistics to the maintain=
ers.

Best,
Tomasz
