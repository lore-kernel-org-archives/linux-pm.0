Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822B3370E4
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976416; cv=none; b=pnCAFtzivPSs+gxhFdQuYA0mZ2kl/jqWv8n0sqp3UQAPDbyyMW26pE3QzSA3UcpNg/nAnl9eQ9DAftgLLhICFr125FP0z0jLcvRuMUmOFKpcHaMxBoMHN1E4pSiNuS4cjMU5BGgIjSq8BfkX+lgLMdTpy02XivfOriAePP3m7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976416; c=relaxed/simple;
	bh=iW80MMizgfc3HtndFzRauxTguYsoscb1vmxoIjZiJK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4YlmqqvJ2yRMwLymC5nnXz8h/FIweVGOwpY/PKf+qSU0q7JJ9gIQxZFIPoHidAkWFWDRtjIuEQAGNA0hmjLTvFxLs27UuTXJDzmssjk2QCmi4xQyWgnTkae9VRx9ZgCareOZuBgPHtSVVrHf9rIoB37R1AOHQQ7Jt1ksnbIULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwzBxPoJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwzBxPoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9F2C2BCFD
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 10:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777976415;
	bh=iW80MMizgfc3HtndFzRauxTguYsoscb1vmxoIjZiJK8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RwzBxPoJ/qhPJZXFOFluZBT+l1SFiuKlVh3v4YUTVoxeYqA+C32zHOXZ5olVaM0jn
	 1II46G7PsXmNJxmW8p8UGN34iS6DGdpsWr2Q0sF4Io6KCcDDGTO/BF7ILvTAB42yyn
	 khweEtYdXIFyEBT1qhDSxsCoef6jQIOfJJ/qjp/bytgLAIMDsujcLvLMg1nw3I0u6/
	 lrwnnGnNU7FksCi1zTBGhnxAxxm5FEvQJLXmJKaEDjrrPvb71CppwxsltaNqHs8cRx
	 DCKzBNXKBeHiaCc0/3k4HU25ySJgGu77UKwgDomtZ38Lh5VQIa1oE/Xj3hPsLLEkvT
	 s+10D0JfQhY0g==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8738c178dso1382347e87.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 03:20:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+mH5NX6bqKRLmi4IOBYq79Le4Zz9wvwk/MslDm6UMh7i8HfikkKGsZYM38mZ6MGtMIxnQGs0NuNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSWSzoJ7bP5xBCoIr1k+hP2YdI7QGGjDuIYry1zDM3f3/8eRo
	Cmpvo/PUeuuEXeOley9NVaSGtMwLeMAbtUeRp1H8WrNFslYE9JYAbbxjn0A3Io78Uap+yAgukt7
	V0b/yDLSm/J3nDL5cF+fp01p2UoBwRkk=
X-Received: by 2002:a05:6512:1452:20b0:5a8:7f49:9ca with SMTP id
 2adb3069b0e04-5a87f490a13mr719970e87.22.1777976413843; Tue, 05 May 2026
 03:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
 <20260429161430.3802970-4-daniel.lezcano@oss.qualcomm.com>
 <CAJZ5v0jTbOkR8Odok2Cq6iWHGRzkF56spHr2xp_M8Zayg6ZAfA@mail.gmail.com>
 <CAJZ5v0ikmPwRq6ykwCH=Qi7Z477sTktm5dRU721Ye6+qQKs2Dw@mail.gmail.com> <731f3161-a202-40e0-ac22-aa16ea58e832@oss.qualcomm.com>
In-Reply-To: <731f3161-a202-40e0-ac22-aa16ea58e832@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 May 2026 12:20:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0huQ3B4buieAUnbqnbV_fpFBPG3+UgULs0qcK9j44NwSw@mail.gmail.com>
X-Gm-Features: AVHnY4LccoFs5fRagvUcUgMvLdZTqx8uyXDq5Rd_uADopfh9IqKkwLegesOOYj4
Message-ID: <CAJZ5v0huQ3B4buieAUnbqnbV_fpFBPG3+UgULs0qcK9j44NwSw@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] thermal/of: Move the node pointer assignation in
 the OF code file
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@kernel.org, 
	gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
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

On Tue, May 5, 2026 at 12:07=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 5/1/26 14:50, Rafael J. Wysocki wrote:
> > On Thu, Apr 30, 2026 at 10:12=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> >>
> >> On Wed, Apr 29, 2026 at 6:14=E2=80=AFPM Daniel Lezcano
> >> <daniel.lezcano@oss.qualcomm.com> wrote:
> >>>
> >>> The node pointer being assigned to the cooling device structure is an
> >>> action done by the thermal OF only and does not belong to the core
> >>> framework code. Move the node pointer assignation in the thermal OF
> >>> code. Consequently, the devm_thermal_of_cooling_device_register() can
> >>> call its non-devm version resulting in a more intuitive design of the
> >>> API.
> >>
> >> I wouldn't make this change.
> >>
> >> It adds overhead to the OF case that's not really necessary and
> >> complicates the code just to avoid using struct device_node pointers
> >> in the core and I'm not really convinced that passing a function
> >> pointer to __thermal_cooling_device_register() is so much better.
> >
> > I would start with splitting __thermal_cooling_device_register() so
> > that it becomes (sorry for the white space breakage induced by GMail)
> >
> > static struct thermal_cooling_device *
> > __thermal_cooling_device_register(struct device_node *np,
> >                    const char *type, void *devdata,
> >                    const struct thermal_cooling_device_ops *ops)
> > {
> >      struct thermal_cooling_device *cdev;
> >
> >      cdev =3D thermal_cooling_device_alloc(ops);
> >      if (IS_ERR(cdev))
> >          return cdev;
> >
> >      cdev->np =3D np;
> >
> >      return thermal_cooling_device_add(cdev, type, devdata, ops);
> > }
> >
> > where thermal_cooling_device_alloc() does all of the ops and other
> > checks and the cdev struct allocation, and
> > thermal_cooling_device_add() does everything else previously done by
> > __thermal_cooling_device_register() itself.
> >
> > Then, it could be renamed to __thermal_of_cooling_device_register()
> > and the non-of variant would simply skip the np assignment (and it
> > would not take np as an argument).
> >
> > You can deal with the devm_ variants of the above analogously.
>
> So we will end up with:
>
> static struct thermal_cooling_device *
> __thermal_of_cooling_device_register(struct device_node *np,
>                 const char *type, void *devdata,
>                 const struct thermal_cooling_device_ops *ops)
> {
>         struct thermal_cooling_device *cdev;
>
>         cdev =3D thermal_cooling_device_alloc(ops);
>         if (IS_ERR(cdev))
>                 return cdev;
>
>         cdev->np =3D np;
>
>         return thermal_cooling_device_add(cdev, type, devdata, ops);
> }
>
> and
>
> static struct thermal_cooling_device *
> __thermal_cooling_device_register(const char *type, void *devdata,
>                 const struct thermal_cooling_device_ops *ops)
> {
>         struct thermal_cooling_device *cdev;
>
>         cdev =3D thermal_cooling_device_alloc(ops);
>         if (IS_ERR(cdev))
>                 return cdev;
>
>         return thermal_cooling_device_add(cdev, type, devdata, ops);
> }
>
> Right ?
>
> That is what I did more or less initially [1]. It resulted into
> exporting thermal_cooling_device_init_complete(). Here it is similar,
> with other functions.

They don't need to be exported outside the thermal subsystem though
and they don't need to be exported to modules.

> The reason why I added an init callback in the
> thermal_cooling_device_register() function is to centralize the cooling
> device register logic into the core code only.

That still would be done by the core code.

> By exporting the thermal_cooling_device_add() and
> thermal_cooling_device_alloc() we duplicate the logic and IMO it is not
> desirable.

Well, you want the logic to be duplicate, kind of, if you want both
the OF and non-OF variants to be there.

> By introducing a init callback, the core code gives the opportunity to
> any extra layers to initialize some private data in the cooling device
> before the init completion
>
> [1]
> https://lore.kernel.org/all/20260422174305.2899095-4-daniel.lezcano@oss.q=
ualcomm.com/

I don't think that adding the init callback is a good idea, sorry.
