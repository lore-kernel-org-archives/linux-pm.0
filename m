Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAE2D73BE
	for <linux-pm@vger.kernel.org>; Sat,  4 Apr 2026 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775329267; cv=none; b=OzSgRO/Z5rgTa1U9rKDs7NPMLMdl6PJrW7Eswg7zl84zBX4GrqJ1dRfEP9HBCrCXjJWQlaENKgknSkVI+KIZ017ztqXY1Zb27XNnq3lvl+a6iGcCgY9wvan6GGK77BhuCN/2kBGpvWzM5jrMA+HZrDYYo1JcDVTecasi7aWIFfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775329267; c=relaxed/simple;
	bh=WRG3RurDZbBFkUHmUcm1xzZ83rRZxr3wS0Berv4Rfj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7sTW1rNJn19IZQAOFD4tgLpTegSNIFygmS1JD98vH+F56aa367ENzLwGnVrh8kMDv0h5mcZDJ990GXlySbkWtX/yxN+fBZ/Uka+JMq1x9NSmGTKVoBrh2TUKpkM07ZAtaWPNqBLdBVUAieXe8oTv/0or1OaZS0s7Q3UkgKyrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWFmHb3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWFmHb3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4A6C2BCB1
	for <linux-pm@vger.kernel.org>; Sat,  4 Apr 2026 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775329267;
	bh=WRG3RurDZbBFkUHmUcm1xzZ83rRZxr3wS0Berv4Rfj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AWFmHb3lSNnzHS/kEUafd7aPQv2M+A2Fhoj8GCtp0ZsCNhmlhBI6EP68UdhG4A7GS
	 a7aAPlVFd5RP8TsL1oXeP/actMaKV0d/278fwM+iBueDqbcf/jpydJeuqeDFGqoMDQ
	 ncbKMnFYsAoCaKYINQG1QvPIyqCIv1dm/adh/gH7sjnI9ZqqKHLbaOKkvwku3oEegM
	 3ovcmXMSr+SrwSJcv6Qxppt20nZ40VyD247GOmtgWjDU7V9c1h8tmThkXUC7dc/oVU
	 ATC/4hKGO1mC98CGRnFEKyrPYZgrCfeCRrFIu1My24tTFmb9AZ7QevKBXaeVp4f9za
	 JIr/dldcrdYYw==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-46a9ae3f860so1012384b6e.1
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2026 12:01:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXab90LB3pAXw4S03QtTRZVZisD0aRmQI3yArikQwR6OVJFGDarGn4wPybRuCsrp7m/odqfNCQ8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDn+6mbNHM9seBfJm+3DNjUtTNuXhvfvWLxk9XUWtjxD8Q20ef
	ropGxAUxNeSXf8Uu9a/nyarWmdZExi77AlgsaT5gWsYE7sG7WffUJ6fGS5J6Z69rwP6luONi+uj
	qJXWLq8sULIcbbxkwCcNsO8CtWZ9OzTo=
X-Received: by 2002:a05:6870:d189:b0:404:31c3:9b8e with SMTP id
 586e51a60fabf-4230fdbdea2mr3728753fac.16.1775329266185; Sat, 04 Apr 2026
 12:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <346b33f9-5ca5-4735-a89b-f7cf813419ef@gmail.com>
In-Reply-To: <346b33f9-5ca5-4735-a89b-f7cf813419ef@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 4 Apr 2026 21:00:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i=_yikMrNgs94nn6aamZvq8XdsdL5442jxtp3KybrGcg@mail.gmail.com>
X-Gm-Features: AQROBzCxLkL5IPMFmoGDheyoXRZ92kPFWfBAy8Ofj01927-5t8eGeXQ3FIAjQFc
Message-ID: <CAJZ5v0i=_yikMrNgs94nn6aamZvq8XdsdL5442jxtp3KybrGcg@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 7.1
To: Choi Chanwoo <cwchoi00@gmail.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, 
	chanwoo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chanwoo,

On Fri, Apr 3, 2026 at 8:31=E2=80=AFPM Choi Chanwoo <cwchoi00@gmail.com> wr=
ote:
>
> Dear Rafael,
>
> This is devfreq-next pull request. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c0=
7d:
>
>   Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/de=
vfreq-next-for-7.1
>
> for you to fetch changes up to cd905830ea6184d6678386ce2d652bec324034d1:
>
>   PM / devfreq: tegra30-devfreq: add support for Tegra114 (2026-04-04 03:=
15:39 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v7.1
>
> Detailed description for this pull request:
> - Remove unneeded casting for HZ_PER_KHZ on devfreq.c
>
> - Use _visible attribute to replace create/remove_sysfs_files() to fix sy=
sfs
>   attribute race conditions on devfreq.c
>
> - Add support for Tegra114 activity monitor device on tegra30-devfreq.c
>
> ----------------------------------------------------------------
>
> Andy Shevchenko (1):
>       PM / devfreq: Remove unneeded casting for HZ_PER_KHZ
>
> Pengjie Zhang (1):
>       PM / devfreq: use _visible attribute to replace create/remove_sysfs=
_files()
>
> Svyatoslav Ryhel (1):
>       PM / devfreq: tegra30-devfreq: add support for Tegra114
>
>  drivers/devfreq/devfreq.c         | 108 ++++++++++++++++++++++----------=
------
>  drivers/devfreq/tegra30-devfreq.c |  17 ++++--
>  2 files changed, 74 insertions(+), 51 deletions(-)

Pulled, thanks!
