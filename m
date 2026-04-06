Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B345B21A
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488677; cv=none; b=oAtxE5U67QwgdRxgkydz0ROyw/Da4Z9OeUxLkoYk82UfhQ5E2adtN+GoIojUTX/FzRPvs15BRvEl640vOnRe8tTYwDsdMhp6/x9dF9e17HNqph88UP/JUpY2umG9OrfHILHLufhysH9NGzDkg9/vZg0c/XShDfVmnoVJXliEpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488677; c=relaxed/simple;
	bh=NvMf8l90Z+H8jCJnZ+9K336laPUp8x3c+pdVChXjXsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brVroSXhkjyULQ/K0gWQrSM5MyS4d+VJp89q0CfgRlhADttQwTGCowzD5r1nQ++HcGv8nNxpq2GYMQJwyDeUpgWtkea7ejcRMcQcFsdg7RwEif2NG+ZN/K6eKbRGBHteA2ITPcJkCsGkEpSCwN2dNzQiykWm5fN+h3OZYXAa6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYqMCBn5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYqMCBn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6243DC2BCB0
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775488677;
	bh=NvMf8l90Z+H8jCJnZ+9K336laPUp8x3c+pdVChXjXsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YYqMCBn5Ga+tGvEXDxsS4bVj7kvaOnbSwzpq+CFBiFqv6x2JdWN4rFsopuPkStDUR
	 aMePAJwahwEkjm4p5L31wAFBbd04iXS5HdS4Gn/noy7Zd+k15aZDvzLT0TunADA7bg
	 Wo+7i7se6Z86HcU558Xa4RkzaoJQaYLldKbWg+uXyBIWsVaFi/k+Kwk9ffk7Y8Onqo
	 8llh4KcvzdOkHnrGK8XZM/k06Np8c5/Px3iAE+n7XW/L2pEAe0U0rJEMxU7ivVONik
	 whr1sXk3dUH/Zf7Wu0apvhlbNHVv15rEN1PkwNK0HAvWWLz7j/4oKAoCBUOlBkJqSi
	 sDyQqkg/FZo8w==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so2769618fac.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 08:17:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcjRleG3Ivnt/kEpnKLgooKQl7w2RnlGnfjOK8wQAynk5ds4Bh4eu5lZhP2EQn9R/qC1rsTBp56A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqRjtUGt6KFj7K2/RLo/EuZpMTxxDUXVDyjlukb15BRIvmZ70J
	EJIFMXRNEXNaowdA2mSCQUy4UMfveu61e+DcraBHSizfncZTeJ1/8etYxdDNogvqJSMkIEScZsf
	IUVQ1iE027rger05DMjyu4ASG+Y/Ke9w=
X-Received: by 2002:a05:6870:16d5:b0:422:bdd3:95f2 with SMTP id
 586e51a60fabf-423100f91fdmr8073367fac.43.1775488676566; Mon, 06 Apr 2026
 08:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac269a91-0ba0-4798-acc6-ec294926bbb0@gmail.com> <2026040354-kitchen-unwoven-c0ce@gregkh>
In-Reply-To: <2026040354-kitchen-unwoven-c0ce@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Apr 2026 17:17:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gSLnyW3vdpdHjR5Z8h_EiQE=q4yJRrQ7_jaNGkst6CbQ@mail.gmail.com>
X-Gm-Features: AQROBzBgvYTQj8zVRdrP65cB0PWTV2YEnD65a6WuvqblHaN6TD58j4xso1S6nk0
Message-ID: <CAJZ5v0gSLnyW3vdpdHjR5Z8h_EiQE=q4yJRrQ7_jaNGkst6CbQ@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: Register class wakeup in pure_initcall phase
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 7:24=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 03, 2026 at 06:09:59PM +0200, Heiner Kallweit wrote:
> > Wakeup sources (e.g. autosleep) can be created as early as core_initcal=
l.
> > Class wakeup is registered in postcore_initcall only, what results in
> > autosleep wakeup source not being shown in sysfs. To fix this,
> > register class wakeup in pure_initcall phase already.
> >
> > The current behavior doesn't cause any known issue, therefore treat
> > the change as an improvement.
> >
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >  drivers/base/power/wakeup_stats.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wak=
eup_stats.c
> > index 308f8bde9..30f0d3d61 100644
> > --- a/drivers/base/power/wakeup_stats.c
> > +++ b/drivers/base/power/wakeup_stats.c
> > @@ -216,4 +216,4 @@ static int __init wakeup_sources_sysfs_init(void)
> >
> >       return PTR_ERR_OR_ZERO(wakeup_class);
> >  }
> > -postcore_initcall(wakeup_sources_sysfs_init);
> > +pure_initcall(wakeup_sources_sysfs_init);
> > --
> > 2.53.0
> >
>
> Wait, if this doesn't need to be change, we shouldn't change it.  Unless
> you have a bug that is being fixed here, don't touch init call levels.
> They are tricky and will come to bite you if you don't watch out.

Well, if this is objectionable, a quite straightforward alternative is
to call wakeup_sources_sysfs_init() directly from pm_init() before
invoking pm_autosleep_init().

That would also indicate an ordering dependency between the two calls.
