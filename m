Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1E38AC89
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940769; cv=none; b=Gae6a5EKmzHzwG7OmtkzGDcy8ivw6nLQlmgsFj2JvPJ+tiX0jvaJxXJRS9xiXals+NXUZQnf5XlpaD1qtRxZdiPZ516pVuYo/Km2dreGKAWKqZQVENiF+G9J11EoL+4JA8AZMxh/Novch8uocr6wXqyhNvsOqZDwcUY/fDDrmfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940769; c=relaxed/simple;
	bh=qRmimtUgu8R/VWBfHxicdR4COyi8h1pw6EXhs61Gshk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVvWok0oRzV4s89J+41IFLmKL2PUG024emIOScZpRW2GseBkHO9fJgq8YLIUiPV6lMDtlGUW8jv88lKEt/u4m6lWkE+/oCcj0zsKmP+RxTFdOFJkNcjdUiKlsorNTueMNb2J8/vRueWmf83BWto9Zwh8kgSzW5OQGKf3TUmKQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNNgvEVD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNNgvEVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8463FC2BCB1
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773940768;
	bh=qRmimtUgu8R/VWBfHxicdR4COyi8h1pw6EXhs61Gshk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lNNgvEVDXKbef3eLOfoU2iBJuZm8RZCDJxkGM4r6STQYoF9WTZ64aWNa4DCnE4VrC
	 m5gYQh/qw2bOQjBGFDgqGZ79cEFAwNIWaAaHcILPiND6FGab3uoQCJjnJ5k7W5Je3k
	 7jBiYWiybxg5eD+fHv1ZhKQdNUBOFRNgoBvGb140h+G24SNd5GfZj7XivWM/Bojjyj
	 zC7F1djLspFmns8GBCOIhBr7jXNvKLf2AM0JtJaMP6kyaKDPkDjj0n7yOAPCJFnUfR
	 og/bMQsjnb3N/3S0Exat8IEwCvvRtU6pGeCw/b5JHEIWXuw2pDkvMQfn0y+ez6A4It
	 m7bkYouwsYEkg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-668abc98923so730785a12.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 10:19:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOMXTRMPgm/4/3AUkqXrbkYzlqkasneBuF3pO090PzsJ3VSdhsI4XsWdvExbQU/S0iw6MonMd3WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZyt1rpFLYAt1OijaWCI+sSGV0Es752c+STZ7sgfXIsD/+JNz
	0k5AixvZbPGo8ELw+/SjKW3nWtGT6DsK+nUwvVOJjmH2T+jDkAw6S5MQ+ruS5XZutWiHDFwhjOR
	avX9L0ZNieCHKfU3M6mHoOVeOwQJEKZ0=
X-Received: by 2002:a05:6402:3593:b0:661:3f3c:400d with SMTP id
 4fb4d7f45d1cf-668c9c52289mr147080a12.26.1773940767380; Thu, 19 Mar 2026
 10:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132305.438657-1-ulf.hansson@linaro.org> <CAPDyKFr25L0Omm_uCjZp03_ptnrKR_P2p3e3qxDeUoFFKJg3bQ@mail.gmail.com>
In-Reply-To: <CAPDyKFr25L0Omm_uCjZp03_ptnrKR_P2p3e3qxDeUoFFKJg3bQ@mail.gmail.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Thu, 19 Mar 2026 10:19:15 -0700
X-Gmail-Original-Message-ID: <CACRMN=c82Npk8m=80ZwshZny9zEO7UU6cR2zB=VUAKXUFC=QaQ@mail.gmail.com>
X-Gm-Features: AaiRm52M6HBVMpHbwsDK3waTZA9ElGzNCB8yzoba-xU0I5Q5Yb41uy2aowwGHJs
Message-ID: <CACRMN=c82Npk8m=80ZwshZny9zEO7UU6cR2zB=VUAKXUFC=QaQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] driver core / pmdomain: Add support for fined grained sync_state
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 9:59=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Tue, 3 Mar 2026 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Since the introduction [1] of the common sync_state support for pmdomai=
ns
> > (genpd), we have encountered a lot of various interesting problems. In =
most
> > cases the new behaviour of genpd triggered some weird platform specific=
 bugs.
> >
> > That said, in LPC in Tokyo me and Saravana hosted a session to walk thr=
ough the
> > remaining limitations that we have found for genpd's sync state support=
. In
> > particular, we discussed the problems we have for the so-called onecell=
 power
> > domain providers, where a single provider typically provides multiple
> > independent power domains, all with their own set of consumers.
> >
> > In these cases, the generic sync_state mechanism with fw_devlink isn't =
fine
> > grained enough, as we end up waiting for all consumers for all power do=
mains
> > before the ->sync_callback gets called for the supplier/provider. In ot=
her
> > words, we may end up keeping unused power domains powered-on, for no go=
od
> > reasons.
> >
> > The series intends to fix this problem. Please have a look at the commi=
t
> > messages for more details.
> >
> > Please help review and test!
>
> Saravana, Rafael, Greg - any concerns you see with this approach?

Not specifically related to this thread, but a general update so
people know I haven't vanished. I've been reading this and all the
other fw_devlink related patches (Doug's making flags set/clear/check
safe, overlay series, the PCIe patch series, etc) being sent since I
last replied. I somehow missed this one. I'll definitely take a look
at this series.

Email replies to LKML are a pain right now but it's
expected to get much easier in a week or two. I'm holding off on
responding to most emails until then.

Thanks,
Saravana

>
> Especially I need your confirmation for patch 1 and patch2.
>
> Kind regards
> Uffe
>
>
> >
> > Kind regards
> > Ulf Hansson
> >
> > [1]
> > https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.=
org/
> >
> >
> > Ulf Hansson (9):
> >   driver core: Enable suppliers to implement fine grained sync_state
> >     support
> >   driver core: Add dev_set_drv_queue_sync_state()
> >   pmdomain: core: Move genpd_get_from_provider()
> >   pmdomain: core: Add initial fine grained sync_state support
> >   pmdomain: core: Extend fine grained sync_state to more onecell
> >     providers
> >   pmdomain: core: Export a common function for ->queue_sync_state()
> >   pmdomain: renesas: rcar-gen4-sysc: Drop GENPD_FLAG_NO_STAY_ON
> >   pmdomain: renesas: rcar-sysc: Drop GENPD_FLAG_NO_STAY_ON
> >   pmdomain: renesas: rmobile-sysc: Drop GENPD_FLAG_NO_STAY_ON
> >
> >  drivers/base/core.c                       |   7 +-
> >  drivers/pmdomain/core.c                   | 208 ++++++++++++++++++----
> >  drivers/pmdomain/renesas/rcar-gen4-sysc.c |   1 -
> >  drivers/pmdomain/renesas/rcar-sysc.c      |   1 -
> >  drivers/pmdomain/renesas/rmobile-sysc.c   |   3 +-
> >  include/linux/device.h                    |  12 ++
> >  include/linux/device/driver.h             |   7 +
> >  include/linux/pm_domain.h                 |   3 +
> >  8 files changed, 200 insertions(+), 42 deletions(-)
> >
> > --
> > 2.43.0
> >
