Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AC502579
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898241; cv=none; b=o6xLh94IZinIkXQOtUcG2+EWQqdBMrgWFBSj5Kj+GuwKWuAPNyN1H1vRRY/TGXfiwjyZjAkOsq095a/+7gp9dTXr10yea9JsOLVZig2L3ddcCeq/28wpGjkJ/wsbsSsZkshFU3D6R/gt+31oWfkon9vUrbWH8/AAqWyaEVld9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898241; c=relaxed/simple;
	bh=PlBzu5bIxgzsVNd8YW2W4F6Ph0gpnLGqokew09Q7to4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNrR9R3qnslDQZyWwud8qMqpFN+Gp/KEO02aMCP0M0CN5KU9Tlxc8xXTd9IKsjOwW4KycbkHuS6pDSArNg5JJQyXD8BTA+8GaQHuXzmQFCWyYg/0IubhnZn5zPtkFm3N1NhEw/6G4zFPnWdQyAAk60nUC4l2Wv9X3RMIlcW/QfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4Tl8BK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4Tl8BK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07F61F00898
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898239;
	bh=pJ/UBJWX6KYy+UT9hMNUkHk4sC9Ccb877JQPrw3bZqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i4Tl8BK15K3bB4clI0W9VXyzfxDmZaXgxPJPItWs6oDl7KRI2PpAdJUFdKQH4QEbc
	 c5wCPclDiSp3EHwOJWqcUHE1F/gFOYrhInGUJgWtNH849WBoVIZHMCVIRHdVoi+pfy
	 IFixf8eISMAf8EiYaut33R8BV44EoupLWZ5WuXM0iGeXwU5IqMjdo5BYaK31Kerta5
	 ccg5IuTWLT6M6mxUBgygkrYFh8/Bcv3Tbhydvj0s0lgi/hG3Wqs2qjuOfNGAvC7YNi
	 Ufpta+/e/AFVT543CgwMQ/hltHQgIqYnWJG4ZirA98RxJ7H5XBUJPeVkLJ45IPWP0F
	 dHwmg7Tn1kziw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba3fba0080so1950600e87.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 06:30:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBylZPTkoPj6aSkUnC4OTruySFr6v6wjq1pCTjm9QpTdWquPPVCtld825yZY1kYHLIa/sQpnJryI9Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJnL8227RlLSBQNwIkti87A1DqZeoVi07SQ94BUrWXtbJva0mRa
	kR5YxG2fJ81uxGLKpFCZdCGkQUanpJMqgC/ampJEJCtxs2y/V5TsKFw3NA5fe+V2C7dWPOfpKfi
	Q9nniE3CtEbY5p0jQFCz9QpSnZ+8ind8=
X-Received: by 2002:a05:6512:110a:b0:5b8:f780:5ebc with SMTP id
 2adb3069b0e04-5bcde35ba0cmr4342256e87.9.1791898237244; Tue, 13 Oct 2026
 06:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012041733.798932-1-yangyongxin@kylinos.cn>
 <20261013023411.1364546-1-yangyongxin@kylinos.cn> <CAJZ5v0ig+XkpPwM53WpQoewWg8D0UXeLNaKs18YvSM792RsHNQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ig+XkpPwM53WpQoewWg8D0UXeLNaKs18YvSM792RsHNQ@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 13 Oct 2026 15:28:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gzCS1C-U2bD=skZFRxcQwkH78a3_Hcfv72Zx=DqHsXWg@mail.gmail.com>
X-Gm-Features: AclHuK9Hz54pIQ5efDHMWUh6X0cwPMgFmmXSuxk60Xs84C83agA6yEOUozkLKuw
Message-ID: <CAJZ5v0gzCS1C-U2bD=skZFRxcQwkH78a3_Hcfv72Zx=DqHsXWg@mail.gmail.com>
Subject: Re: [PATCH v3] PM: hibernate: Log the hibernation mode on entry
To: Yongxin Yang <yangyongxin@kylinos.cn>
Cc: pavel@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 3:22=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Oct 13, 2026 at 4:34=E2=80=AFAM Yongxin Yang <yangyongxin@kylinos=
.cn> wrote:
> >
> > The hibernation flow is the only place where the kernel decides what
> > to do after a successful image write: hand over to the platform
> > firmware (ACPI S4), power the system off, reboot it, or resume from
> > the image right away. That decision leaves no trace in the log. If the
> > resume path later fails or hangs, the tester cannot tell which outcome
> > was requested, so a report of "the system rebooted instead of powering
> > off" cannot be attributed to configuration or to platform behavior.
> >
> > The mode is selected through /sys/power/disk and stored in
> > hibernation_mode. Append its name to the existing "hibernation entry"
> > message, so that the line reads "hibernation entry (platform)",
> > "hibernation entry (shutdown)", "hibernation entry (reboot)",
> > "hibernation entry (suspend)" or "hibernation entry (test_resume)"
> > instead of a bare "hibernation entry".
> >
> > The names come from hibernation_modes[], the same table that
> > /sys/power/disk uses, through a new hibernation_mode_name() helper, so
> > that the mapping from mode to name lives in one place.
> >
> > No functional change.
> >
> > Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
> > ---
> >  kernel/power/hibernate.c | 32 ++++++++++++++++++++------------
> >  1 file changed, 20 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index e365e440cd52..6f88b42b1af8 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -72,6 +72,24 @@ enum {
> >  #define HIBERNATION_MAX (__HIBERNATION_AFTER_LAST-1)
> >  #define HIBERNATION_FIRST (HIBERNATION_INVALID + 1)
> >
> > +static const char * const hibernation_modes[] =3D {
> > +       [HIBERNATION_PLATFORM]  =3D "platform",
> > +       [HIBERNATION_SHUTDOWN]  =3D "shutdown",
> > +       [HIBERNATION_REBOOT]    =3D "reboot",
> > +#ifdef CONFIG_SUSPEND
> > +       [HIBERNATION_SUSPEND]   =3D "suspend",
> > +#endif
> > +       [HIBERNATION_TEST_RESUME]       =3D "test_resume",
> > +};
> > +
> > +static const char *hibernation_mode_name(int mode)
> > +{
> > +       if (mode < HIBERNATION_FIRST || mode > HIBERNATION_MAX)
> > +               return "unknown";
> > +
> > +       return hibernation_modes[mode];
> > +}
>
> Thanks for the update, but I really meant this:
>
> static const char *hibernation_mode_name(int mode)
> {
>         switch (mode) {
>         case HIBERNATION_PLATFORM:
>                 return "platform";
>         case HIBERNATION_SHUTDOWN:
>                 return "shutdown";
>         case HIBERNATION_REBOOT:
>                 return "reboot";
>         case HIBERNATION_TEST_RESUME:
>                 return "test_resume";
> #ifdef CONFIG_SUSPEND
>         case HIBERNATION_SUSPEND:
>                 return "suspend";
> #endif
>         }
>         return "unknown";
> }

OK, scratch this.

The table is already there, so it can be used below.

> > +
> >  static int hibernation_mode =3D HIBERNATION_SHUTDOWN;
> >
> >  bool freezer_test_done;
> > @@ -794,7 +812,8 @@ int hibernate(void)
> >                 goto Unlock;
> >         }
> >
> > -       pr_info("hibernation entry\n");
> > +       pr_info("hibernation entry (%s)\n",
> > +               hibernation_mode_name(hibernation_mode));

But is the wrapper function really needed here?

> >         pm_prepare_console();
> >         error =3D pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE,=
 PM_POST_HIBERNATION);
> >         if (error)
> > @@ -1130,17 +1149,6 @@ static int __init software_resume_initcall(void)
> >  }
> >  late_initcall_sync(software_resume_initcall);
> >
> > -
> > -static const char * const hibernation_modes[] =3D {
> > -       [HIBERNATION_PLATFORM]  =3D "platform",
> > -       [HIBERNATION_SHUTDOWN]  =3D "shutdown",
> > -       [HIBERNATION_REBOOT]    =3D "reboot",
> > -#ifdef CONFIG_SUSPEND
> > -       [HIBERNATION_SUSPEND]   =3D "suspend",
> > -#endif
> > -       [HIBERNATION_TEST_RESUME]       =3D "test_resume",
> > -};
> > -
> >  /*
> >   * /sys/power/disk - Control hibernation mode.
> >   *
> > --
