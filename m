Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD7386C20
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076085; cv=none; b=pvNJgkeWUCp1JAFJuhvzLUvZ6I47qIpOVgdt4diXztm17OqSwam8gmJG8daZmZqRnuU6Oej7tyHWdrZIMFhOWLtyVVbcDonPmuJYhSs0SSkUP/2kbLycwJ0xfLqsbTj7vnJiZXApoD1GzLBBmg+2SOnv64rlyWzffByJK4VEnPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076085; c=relaxed/simple;
	bh=yFQEjf1OrYnLzPc/A6Tf6rhy0yAKag8495q1ohVt6B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3kP2dA1g2bH7Ti8h+7DFoUN/MMQjDOdsMNzuljaHHgqZZPV9VyglBzHyPzLoB4zaUOgBNeU1JrSNW6Rp7pDIGNM9ImiYSgINva8cQoW7+368JV0XGXlV26x14lMwXk9lxg8pOJqih7ZDaN51C7jp6W5gmIRq2JAu0FMgLS4xpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeBWELJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeBWELJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8AE1F00A10
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780076083;
	bh=ogUR1hw2mWuyYrjJA9/13S+E++g4Iv0OaXgSlr+68Fo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aeBWELJTFiYdvmrsEq5It8NlVvFcKPqZlRynJyfVkrdbn8lkP3LfAiYfwa9AUR4gN
	 4v7X0UqpkvibjI5NrqFZWeJuj2uuLgkr84bn8iudGJ0t3t/LZquwo7brNwR+5c32qV
	 tBdlELy5BqGWRHGWkc9j+1e97HBtPh0KjlaDywQLMGhbhbh23SHeE2H4rDvYEfaN1q
	 g+thIYZFjFMPbTOTd9cL89zCOKx6xDi6fOyfrqjrL8h/0EaKg7J44NV6vZ82AKH4R3
	 3wtMULM9wmfnciPyvhsrtl8tDRRtub2yR1B+oEu63cKi6k9X1ltzSrbmj9YB0VHP1p
	 T0WxrwU2e/vdQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so9750043e87.1
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:34:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ91mEVL0x8NrKHj4u1Yn8vecu2r81h3FnFDjSqwf1qAqCS6PbnhA5FPNz0jWLNKZcYGMz4ZW0uP5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgaq3BDC8T1e56NbukTYZ/JfhVwfL9f5lTo/XByOoSWALpyYqW
	WsCaRgqsTWQljnUvQHQ4j/rMoPExpSi3vSOLmJ+agxCBStOExJ5fb/61PiFvRRbJYS6wfLJqaTD
	YkbdlDTO2luMZqg/n5lLg0tzsbBzKbDo=
X-Received: by 2002:a05:6512:3caa:b0:5a4:1add:c56e with SMTP id
 2adb3069b0e04-5aa607cd2e5mr243766e87.11.1780076081350; Fri, 29 May 2026
 10:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
 <a943706d-d413-4ed8-a0fd-a3234c66cd8d@oss.qualcomm.com> <CAJZ5v0hG4aNrTR1j1DX+xv7cBNwsN4Y+qa3eFfXtLrrDBZ6kCA@mail.gmail.com>
 <41eec804-5678-475d-b0b2-a5c0b3b005d4@oss.qualcomm.com> <c66d527a-17d3-4419-a0c4-676dc92bbe43@arm.com>
 <305d2570-4ffc-4d48-b831-e1f695d3dba7@oss.qualcomm.com>
In-Reply-To: <305d2570-4ffc-4d48-b831-e1f695d3dba7@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 May 2026 19:34:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gbGAM5+JjjKDqOpYXgxAMGKHrF=3-GR1GbZydPt9ddXw@mail.gmail.com>
X-Gm-Features: AVHnY4J7_r31ksIByvp0kdtXDzJ5Ml4Ck2f22EROA2m96cEI4ZYfXtDjSYBSgUc
Message-ID: <CAJZ5v0gbGAM5+JjjKDqOpYXgxAMGKHrF=3-GR1GbZydPt9ddXw@mail.gmail.com>
Subject: Re: [PATCH vs/3/4/ 00/11] Support cooling device with ID in the OF
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 5:31=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 5/29/26 17:29, Lukasz Luba wrote:
> > Hi Rafael and Daniel,
> >
> > On 5/29/26 13:41, Daniel Lezcano wrote:
> >> On 5/29/26 14:35, Rafael J. Wysocki wrote:
> >>> Hi Daniel,
> >>>
> >>> On Fri, May 29, 2026 at 10:35=E2=80=AFAM Daniel Lezcano
> >>> <daniel.lezcano@oss.qualcomm.com> wrote:
> >>>>
> >>>>
> >>>> Hi Rafael,
> >>>>
> >>>> On 5/26/26 16:08, Daniel Lezcano wrote:
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>> ---
> >>>>> Changelog:
> >>>>>    - V4
> >>>>>      - Reworked splitted functions to register a cooling device and
> >>>>>        merged separately
> >>>>
> >>>> Are you fine with the thermal core changes in this series ?
> >>>
> >>> Generally, yes, I am, but let me have one more look at it.
> >>>
> >>>> Is it ok if I pick the series in my branch (and may be send a early
> >>>> PR) ?
> >>>
> >>> I have no comments, I'll respond with an Acked-by to it later today.
> >>>
> >>> Thanks!
> >>
> >> Thanks
> >
> > I have re-ordered the patch 4 <-> 5 and the compilation issue goes away=
.
> > If you decide to do that feel free to add my tag to the current patch
> > 04/10:
> >
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>
> Thanks Lukasz !

So with the change mentioned above by Lukasz, please feel free to add

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

to the series and take it into your branch.

And yes, an early PR would be welcome.
