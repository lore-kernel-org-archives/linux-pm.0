Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA01829D269
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770926777; cv=none; b=LUw0RbPXJE8UQSwyrTSYCX1FWiRyh0iEMyrXRX1DqOaBgxpUpaNqdgNsmdBmulXbpKkIjVX/BoOe4vCe1dY0/qaLnNlpxbhAxhc0iGuzEjaC9WcBOOeM+7K9xaL3ZhA6uwNlliqvjAyHiDmEa7WXsBXqhNeMXw5nRHUxuwjYFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770926777; c=relaxed/simple;
	bh=ydx6gVx6CLI/8rjjMaH4en1WRJjXMu1aXKvOuM+3YzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afwLiepISJpQh9zdv9et1B86+zW1i1UWJs6EEFsJtRKRk0ckTpiney5KGIMdOPA/3ThjxaodT+T7WCgiGHHXzBhwEoQB8AbQBFuOzcndyznc5cMxTsX6tdcHZiUk6E1fYk5+aVr/L9mR9TU2yo7f5j6p60kHXzudBH3ylWcME0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stXI6JBK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stXI6JBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557CEC2BCAF
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 20:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770926777;
	bh=ydx6gVx6CLI/8rjjMaH4en1WRJjXMu1aXKvOuM+3YzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=stXI6JBKTlCmUZ4mpHAXtp0CSpKirmFhDzLj8C0xwMKCNrG2f84jx0N4r5cbtg6CD
	 NDP0UJ6hIu6XDv9g7RK9dWZ92fiDhG92DTDgv+EoSVFoxD2FcuUqHa62vsL1qJZBQL
	 RAG+JdJUOfjjLJFbVjXp/zCpcj6WGyT8SXFzKvyQz+6SnABj5XcpHCTmDxU1MrzVNc
	 3wBfhjylWR1XyUzyJKQEpGxFgvU0DWu/R/xXhnB+C00OUeF/JzeTHh8ieOGQjOxIsr
	 l8BlBsbVLx33AxpTNCelo0eHqxiiwdKAl0+M16K/5VpEr6W/vSrkCravbgMilc9PL/
	 6E8g4z3AcjF6g==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65baa72399fso214996a12.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 12:06:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7jX2x7ZfquT6jEeqjOQ+VZP1bSxjYg/hiMHtbwTLxwzNIpNTPPeRJHlTOTqMB/iIWX4XGKsYFtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3KISLzUVlpBwCY2Cve3o2YnwEk0k4xPMwsbDzvkswekFyLb33
	wFbHFfvy9DYWXMJBskwxrMRKNnuBi/WY18wxl3nkLUpTUArOgzwomCF5k8h5WcidvPiLDHfby+W
	rAaptrRoRmBt3rAgRpAtmJldSifFQyQ==
X-Received: by 2002:a17:907:78b:b0:b87:7938:7b77 with SMTP id
 a640c23a62f3a-b8facde13demr12825666b.30.1770926775798; Thu, 12 Feb 2026
 12:06:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
 <20260205-gs101-pd-v5-4-ede49cdb57a6@linaro.org> <20260211211229.GA3882182-robh@kernel.org>
 <b5078af810a681333043f64d71b7d6ea55ff44bb.camel@linaro.org>
In-Reply-To: <b5078af810a681333043f64d71b7d6ea55ff44bb.camel@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 12 Feb 2026 14:06:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKKig8ePmmMZH=QagSyw0d=FKrORTxKzj7HOZqd0jLZFg@mail.gmail.com>
X-Gm-Features: AZwV_QgH12zvtmgpHtYhs-H6vgHDqmWIaZbmOcDQ86b9Aj9PuKrMvtIh1vd2c0s
Message-ID: <CAL_JsqKKig8ePmmMZH=QagSyw0d=FKrORTxKzj7HOZqd0jLZFg@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] dt-bindings: soc: google: gs101-pmu: allow power
 domains as children
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 6:03=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> Hi Rob,
>
> On Wed, 2026-02-11 at 15:12 -0600, Rob Herring wrote:
> > On Thu, Feb 05, 2026 at 09:42:32PM +0000, Andr=C3=A9 Draszik wrote:
> > > The power domains are a property of / implemented in the PMU. As such=
,
> > > they should be modelled as child nodes of the PMU.
> > >
> > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > > ---
> > > v4:
> > > - consistent quoting using " (Krzysztof)
> > > - add samsung,dtzpc to example
> > >
> > > Note: Ideally, the newly added properties (ranges, etc.) should only =
be
> > > 'required' if "^power-domain@[0-9a-f]+$" exists as a patternProperty,
> > > as they're needed only in that case. As-is, this patch now causes
> > > warnings for existing DTs as they don't specify the new properties (a=
nd
> > > they shouldn't need to).
> >
> > We can't have warnings added if they aren't valid.
> >
> > > Only if DTs are updated to include
> > > power-domains, such an update should also add the new properties.
> > >
> > > I've not been able to come up with the correct schema syntax to achie=
ve
> > > that. dependencies, dependentRequired, and dependentSchemas don't see=
m
> > > to support patterns. Similarly,
> > >   - if:
> > >       required:
> > >         - ...
> > >     then:
> > >       required:
> > >         - ...
> > >
> > > doesn't allow patterns in the 'if' block (or I didn't get the syntax
> > > right).
> > >
> > > Rob said in
> > > https://lore.kernel.org/all/20251010141357.GA219719-robh@kernel.org/
> > > that this is a known limitation in json-schema.
> >
> > For a given compatible, you should either have child nodes or you don't=
.
> > The h/w is not variable. So something like this should work:
> >
> > if:
> >   properties:
> >     compatible:
> >       contains:
> >         const: foo,bar
> >
> > then:
> >   required:
> >     - ranges
> >     - '#address-cells'
> >     - '#size-cells'
> >
>
> Thanks Rob, yes, that works in general, but unfortunately in this case ex=
isting
> DTs don't specify ranges etc for the google,gs101-pmu compatible. (This b=
inding
> is specifically for google,gs101-pmu only anyway).
>
> The above suggestion will cause the same validation warnings for existing=
 DTs
> which is no different to just adding those properties to the top-level re=
quired:
> as my patch is doing. Unless I misunderstood your suggestion.

"google,gs101-pmu" represents some specific h/w. That h/w either has
power domains or it doesn't. So which is it?


> The compatible doesn't change with these patches. So I'm not sure how to =
make
> your suggestion work without causing warnings for existing DTs. We can ei=
ther
> have an old incomplete DT+binding:

If this is considered incomplete, then you are going to complete it
and add the child nodes? If so, then the warnings are appropriate.

If you were going to maintain both bindings forever, then you would
probably want a new compatible. Or just drop the properties from
required. Note that if you have child nodes with 'reg' and parent
missing #address-cells or #size-cells, then dtc will warn about that.
So it's not too important if the schema doesn't.

>
>         pmu_system_controller: system-controller@17460000 {
>                 compatible =3D "google,gs101-pmu";
>                 reg =3D <0x17460000 0x10000>;
>         };
