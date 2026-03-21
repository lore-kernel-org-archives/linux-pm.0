Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9711032860F
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774077054; cv=none; b=rx/OrAMZkICdDyKdnQwbhCkxZEqzXXMd9puBJJ8fwW0//3nPX+FVVVojVEv1am5u0bRef/J7EFLgCQJ40uDcoGX1mA/UuPfuudqreKKri76Fy9Neh7EL2oJKmBScQZI7G25kFlYS9Hn19Pz99/EAoEoXbDVWnMlzMIJJmxS4uQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774077054; c=relaxed/simple;
	bh=VLEJtZ8y+Cfj36ZhZc/0uHi8isnrxUstNAtXT4ZWuGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtnXAdw1a+oJ+f4h/infeImeFQsjeq4fbobu+tTwTJfYagtLooGOT5a3VXK4HSUxuXOgr4bre3A56mBeuddJ+7010w+gpfz1vYUFBHH3bHb+TdcjnmjbR/VB78JGv9e84Sdd+fM7t+1Kawap2BcnD1HoHsaWH23gRzRkntZXdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJl4CAX7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJl4CAX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415AEC2BC87
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 07:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774077054;
	bh=VLEJtZ8y+Cfj36ZhZc/0uHi8isnrxUstNAtXT4ZWuGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hJl4CAX7eqHpDEP0GEGO3b1xlV13u0xNsBY8ImEPfwlYdmr5RsQya/njCxYD8v7dZ
	 AFManZ870lQHy320HwxajcumlB2s6bTHTuJxqRWpfZHP8gk7wg1vNcuWat+DI46gXp
	 gPHCZaWKkC4dF70yOEx4oOyQ4zdSPhjk+yFFiLjh1ls8jA/jszHLwjZJ2M6SvQhEq6
	 NjUnWW5D5zyQAf3DOGvryHoOV9fM0c/nHFj5oahHNrbGyIbUt1rLuuFC51Zzh4h4AR
	 NbhR+mAs1/DWT1Jl70b/7cXoKaAFEPus8aKf8KQvROrftIYWpHPRMF9CCJp3m3vVFc
	 axNANYrG03MYA==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d7f09aa39fso1337278a34.0
        for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1w79hrXpeG1rznRh0wuzAHBC0ANd8OztomErmfhmln1RScdaI56ThlEVBdqcO08GGhf8w3GKgfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyER4Av1DSkELU2nPWDB3I1yCA9OYGzJ8NRssrimh7oihiT5YGf
	Jfl7/xNYWPSfIcfaCPagB1kK1mcsNRB67Ua41WGN4M7ROKXvwO7FqHdEX4qk4I3SYHRerlDPD7p
	li/pQyJbNkhxlNQ778AzitAeEtmaIfwA=
X-Received: by 2002:a05:6870:2490:b0:3eb:7a44:744c with SMTP id
 586e51a60fabf-41c10fdac36mr3665173fac.21.1774077053488; Sat, 21 Mar 2026
 00:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126185423.77786-1-clamor95@gmail.com> <20260126185423.77786-2-clamor95@gmail.com>
 <4b98421a-9e64-48cb-9726-ff34a5b9cc76@gmail.com> <CAJ0PZbS6JhPOMNP3fB4biiu3b32jF-A6AMQ6M7usOEG0B88JJw@mail.gmail.com>
In-Reply-To: <CAJ0PZbS6JhPOMNP3fB4biiu3b32jF-A6AMQ6M7usOEG0B88JJw@mail.gmail.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sat, 21 Mar 2026 16:10:16 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3X9ffx1qMDw+POqWDJFG+mL=eNQh5-gfyPAKQscduEUA@mail.gmail.com>
X-Gm-Features: AaiRm52Ol0OKLRbXVbXvPTn5wdvpUVGdkRzWnXIv0kuse-shw1ZE4kHrX4cAt-Q
Message-ID: <CAGTfZH3X9ffx1qMDw+POqWDJFG+mL=eNQh5-gfyPAKQscduEUA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] devfreq: tegra30-devfreq: add support for Tegra114
To: myungjoo.ham@gmail.com
Cc: Dmitry Osipenko <digetx@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm sorry for late reply.

Applied it. Thanks.

On Sun, Mar 8, 2026 at 5:02=E2=80=AFPM MyungJoo Ham <myungjoo.ham@samsung.c=
om> wrote:
>
> 2026=EB=85=84 3=EC=9B=94 3=EC=9D=BC (=ED=99=94) AM 8:24, Dmitry Osipenko =
<digetx@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > 26.01.2026 21:54, Svyatoslav Ryhel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > Lets add Tegra114 support to activity monitor device as a preparation=
 to
> > > upcoming EMC controller support.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > ---
> > >  drivers/devfreq/tegra30-devfreq.c | 17 ++++++++++++-----
> > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegr=
a30-devfreq.c
> > > index 8ea5b482bfb3..fa83480a923f 100644
> > > --- a/drivers/devfreq/tegra30-devfreq.c
> > > +++ b/drivers/devfreq/tegra30-devfreq.c
> > > @@ -963,16 +963,22 @@ static int tegra_devfreq_probe(struct platform_=
device *pdev)
> > >       return 0;
> > >  }
> > >
> > > +/*
> > > + * The activity counter is incremented every 256 memory transactions=
. However,
> > > + * the number of clock cycles required for each transaction varies a=
cross
> > > + * different SoC generations. For instance, a single transaction tak=
es 2 EMC
> > > + * clocks on Tegra30, 1 EMC clock on Tegra114, and 4 EMC clocks on T=
egra124.
> > > + */
> > >  static const struct tegra_devfreq_soc_data tegra124_soc =3D {
> > >       .configs =3D tegra124_device_configs,
> > > -
> > > -     /*
> > > -      * Activity counter is incremented every 256 memory transaction=
s,
> > > -      * and each transaction takes 4 EMC clocks.
> > > -      */
> > >       .count_weight =3D 4 * 256,
> > >  };
> > >
> > > +static const struct tegra_devfreq_soc_data tegra114_soc =3D {
> > > +     .configs =3D tegra124_device_configs,
> > > +     .count_weight =3D 256,
> > > +};
> > > +
> > >  static const struct tegra_devfreq_soc_data tegra30_soc =3D {
> > >       .configs =3D tegra30_device_configs,
> > >       .count_weight =3D 2 * 256,
> > > @@ -980,6 +986,7 @@ static const struct tegra_devfreq_soc_data tegra3=
0_soc =3D {
> > >
> > >  static const struct of_device_id tegra_devfreq_of_match[] =3D {
> > >       { .compatible =3D "nvidia,tegra30-actmon",  .data =3D &tegra30_=
soc, },
> > > +     { .compatible =3D "nvidia,tegra114-actmon", .data =3D &tegra114=
_soc, },
> > >       { .compatible =3D "nvidia,tegra124-actmon", .data =3D &tegra124=
_soc, },
> > >       { },
> > >  };
> >
> > Acked-by: Dmitry Osipenko <digetx@gmail.com>
>
> Acked-by: MyungJoo Ham <myungjoo.ham@gmail.com>
>
> --
> MyungJoo Ham, Ph.D.
> Samsung Electronics
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics
