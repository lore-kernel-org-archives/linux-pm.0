Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4003002A0
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058157; cv=none; b=f+0MwHBCQg3G0heFbhZZxQSd+2NjF6lYeAk3sGyiLH9DB1Cm1SrASXlcHjtOUU1bOIFgXRWx6L9s/+HaSUs8fF7T4187C4G0jZHCYNEUVHClvJClQvNh3j6rUIgBh09d66uQHqp3BRJPRiWskbJ6LoRZGXORbfF2rgeIRb5nCqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058157; c=relaxed/simple;
	bh=l++kw2Umx4n5N3laCPqoc0NPgx60DZVdOxmnYoGfK7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1vD2Hc9E3f7sB1lWa43+yBz3sXrlV5ESRHkgEg3UFP3If5YgS+kdJ8GhASCBTZrGD0QzSSRAfiv3oLs5EODKisGCCY3D3eCsugXYLBqIQqxX7DzA5ohhzr2l3ke0Z1BuzLFUapWqyMH6Qr1dksOhbOVO6njKSGYChpxCUpjpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pzcx0WVE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pzcx0WVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF9F1F00898
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780058156;
	bh=8HHSUQYeEpATP6eQrlMUUpo6PYMGpfYyKOesnFMOdk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Pzcx0WVEN8yhTAZzKKYNiTJJiD7DizHbrXGKFCNZfkt5gu7vtCScvCA7br2LWg/rs
	 OXHAKU4wYzV5RKYkmrQvqv2CQj/nXF0qhv6URN89FP7o8A9+xU8v9Vw97vCuZhBY+y
	 J35YwViER8+uwwTDSS4XXkg8CEjn53SXrHmOptOJlIUOrpjDOTvKTLcrXE6dQh15un
	 3fcNc/4tjnfCamWuVLUeyX+nppOmVFfsTSu1GKxG5KvYR8ZW7w/0bPpdNiFUjPOSP5
	 Kj5o/SrSNkIGz5iJQ3kn6sgE+ZSNRO/fDlghQriBn3TOi68O8EFAD5q7wc12Sb/RK2
	 otdNv8+l7MJ1g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8891febd2so18237515e87.1
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 05:35:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8rl1smL6b5SS6a/xPCJZIyQ1H3rAdBLjkFgE0FbftAEgIRMSAeMWkFxDqmDtufnWKM3CpShtQizA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBXGYYZ9/A0bglC34S74vnGBG9ATFI5vbzO2Z2TiaOoI28Q0IO
	grvIML94uE/iI9y+8z9JrTWubJ0fZdxD+UlS5Cbx3dEnwey3va0l0c8gg1e2m47DLwgzd+M2JGn
	MnFw48zix3Cm5AMfznQtS40zCyBRsxlc=
X-Received: by 2002:a05:6512:3981:b0:5a8:87eb:b118 with SMTP id
 2adb3069b0e04-5aa594b88fdmr867278e87.22.1780058154325; Fri, 29 May 2026
 05:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com> <a943706d-d413-4ed8-a0fd-a3234c66cd8d@oss.qualcomm.com>
In-Reply-To: <a943706d-d413-4ed8-a0fd-a3234c66cd8d@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 May 2026 14:35:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hG4aNrTR1j1DX+xv7cBNwsN4Y+qa3eFfXtLrrDBZ6kCA@mail.gmail.com>
X-Gm-Features: AVHnY4LaeZiayztaDJATXujww2-z5ZrdMRh2TOtbmnvu0Re6m99BauFVLXS9Ypk
Message-ID: <CAJZ5v0hG4aNrTR1j1DX+xv7cBNwsN4Y+qa3eFfXtLrrDBZ6kCA@mail.gmail.com>
Subject: Re: [PATCH vs/3/4/ 00/11] Support cooling device with ID in the OF
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
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

Hi Daniel,

On Fri, May 29, 2026 at 10:35=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Hi Rafael,
>
> On 5/26/26 16:08, Daniel Lezcano wrote:
>
> [ ... ]
>
> > ---
> > Changelog:
> >   - V4
> >     - Reworked splitted functions to register a cooling device and
> >       merged separately
>
> Are you fine with the thermal core changes in this series ?

Generally, yes, I am, but let me have one more look at it.

> Is it ok if I pick the series in my branch (and may be send a early PR) ?

I have no comments, I'll respond with an Acked-by to it later today.

Thanks!
