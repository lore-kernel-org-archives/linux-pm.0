Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7833AAF7B
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240237; cv=pass; b=WuBSy5/QqWDClh7bwhK4CL6Yt8O2umpq0PkNIzU9fOIrbT4YXsqD+NkIE1tWpzWcnIejgz/a1wJgt9vcqg2y3543SBCftL3pe3D8f+FYTuOGa0wjyHxJC7kPa3Mk2kOwiupx3/SCt9KSMDkYBL9ZNSH0gxxnwKFran63KUxXBxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240237; c=relaxed/simple;
	bh=nC1HlSANXwPCu0TdcZsZ/ITYqsAJked312qQsvhydMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfjotLhVrZ8McjGo8FlDE4qbKarpaWCg0Jqzl+CPQDAwoR+J1wfye3n2VO55XgNy2mxTft8pywtWK54iNg+hCEFR9OYCOVbE1E7AQQc99FaF0sOSvqFs8QJWAQd/w099EnQF1c8VA0TvenS7izNez+sX9RQ2bWWyYHw8PRepWDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM3eExt7; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM3eExt7"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43da99ddso8283127b3.2
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 12:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789240234; cv=none;
        d=google.com; s=arc-20260327;
        b=ck7wYbDwn8xqfRX51vOAkV7Wf6+gV+nN5i0/7IEbUzoJOsOHS7uzqhiTsmLWbFHJoU
         zzpW+aSQPLa8a/smVBJKTCMyO5J55mGqTadeWSJb6N9yqfvVaid7epTpIXcVMILnDpfM
         9Ggzk0he4Wyqgp/LatPTePZTrVSLdiBA4WtisxIvxyMUdaQSZ/wv9qUhGLNyJsnKOLxn
         ECdkNXG4u4tur0c/7NJR44yVN86yIacCThyXWOlTfFktKBZ+J0EsvjjnQUUmcPqORbTF
         od271h2AjNDajBQogah/+LNQ9LMM1oGntmd6wo2sgLlgr07I1jxzxrCCljCjlQGOBpXi
         Llkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=daj75kJ6ldxZJz9wLYTKbQQmIUWSVox4tdaNBDn6j84=;
        fh=1tIQ0V4UeovZ9yYyQbRev580Se7rk8hIktKSRE5a6yA=;
        b=Sor2JajL25oVtmsDVvVnJBn/0GqTddwOIEXJJQ1ySn4q/1Qio0DtDEIllh1wQaucWj
         V8bdS6bbY6l79RhytsmRnBZY7v6pt7yByzaNNlOZZoWkxV919UZ7WJtbTh2QHWqPyCcb
         ZQVGgUCEMuj/sE4/BTb4qVj8Tero1cC6wj3qZMItePD/uM1w2YAvpb2n1vhwDQ3VGaOX
         6dB1PTtZOnNgxMyG+T+fJxc8O4hjZQ1KGoCd16Ql8JixusEr6ad6wN5YInYoT8YyWL1n
         feD/Vdh/0mKCOiFSORdTIWoYV5khOHYElPs8rqP1ETqSWfaTZ8J1c/Zag/BBjqe5SPBt
         dUsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789240234; x=1789845034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=daj75kJ6ldxZJz9wLYTKbQQmIUWSVox4tdaNBDn6j84=;
        b=UM3eExt7dIEMPJGPVysCGiZoJvVhl544RBXMSKbBfawBd4i4ZIIrytcZCFRMvLVM3d
         5eiLXNBDNhGUMAKnG6+WP65Yk3S5t/+rAwzH/7NjWzps65qzaYK5evMfM2Ot0BwfJKKV
         Ur9kMpPKFdo6S1W2rH2aAcvBKX0zTWg5fXJq+vpV0d9RLgrOa+S+PC9HyUoFTSQCjtFd
         JD4zSgPlW2NuoroUQpoOJwihbV7zD0Cg/GWE0WN2p7DYdnNKSzI3g+aNV8qr42Zoe0Gk
         JFif1loFi4gJt8pMKaQWUrcfxAo0tHc55cAf0+3XSSY9XfGaK7lJQrhx3Hx1KnuPFD73
         RZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789240234; x=1789845034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=daj75kJ6ldxZJz9wLYTKbQQmIUWSVox4tdaNBDn6j84=;
        b=WCXFA9/1+s8/eryzgz4qEN3nJf6qQIml//0Pi7XaikG7gQRlthHQgpb0p8q3HAO0nU
         2Qx/H1dIwSQS8ciTxCFdyhyLhF+EgxHUXSuwrjpq9ThIBsHvMMKhZGWFf7ysdeOzEI/g
         4imTg2qZXXSqOUuBTF0/gVxksdPYyaRL3/lcHDPyycdfa+fd8GHa+vMiP5mYXVfnw8pv
         Oq/Ae2aBtTKRyaveoeGmgdEmWwz0QuHFb5VEWcEHwX+zU1xCjDwyKXKJ3mMZUo2p1XSr
         EkLs3q5SCis2QBRy6Pz7Fo0iGZoLcj62zxIqA6qyCKMuv7pnIY8Fqden4XL58/rXzn8D
         SwjA==
X-Forwarded-Encrypted: i=1; AKwUvBzGBpYC8Ubmxhhu1fha1PZbhoi5SHZ/xWLfcHIaFZfaUYimZg7bhh0mlTB2tl6XoGuS2fUq7+TDdQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nLtiFvJrpSqV+iVr3xFXRtDRIUjTSFp+2eBBsbhK9REcDU9HAP
	vwkCM8/wS/Nh3xgFYqhZjzqdmOU85yjraeKOUOUn73o0JRLmZgUEi0HSae0dqGBBb/gwL/opwdu
	tmxe1FvxII//Go/fY3I3ZUwqJY+a59CE=
X-Gm-Gg: AYBFou3DEPy3zHdEgxNlJQYA33XC7VG0fgJ07u5e3QrjU9gElMVSH5vTVb4jviXgNJt
	PjbL94aIcblwWntlRlJh5MUe8rAw7ou/d36ETIMLLroKpFKZ3qBf9Y1BCmkccDsYziDQiAdFEg7
	1p+zXGInnocZgxfJdNhXb1bKWlbIa0HsPUVzAGQ5bC1m+FHTTkLHiL2i6y0IOptKyhS7vlPQoJY
	/TUs7wkixA/IUHOVpPrZxpwMeGMUvfcVMJQOhCJGPiG/WwTCbHf1/HYar4w8V6uMLG3nLNsOUcV
	0G0D94JJO1m5cAc/fdxLR3rhoSzn5uBkaM3jXmLG9+oMK71LkqE7
X-Received: by 2002:a05:690c:9a91:b0:873:5bd1:98b5 with SMTP id
 00721157ae682-884b200e9d9mr29464677b3.39.1789240234520; Sat, 12 Sep 2026
 12:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906061755.5103-1-sumeet4linux@gmail.com> <20260906061755.5103-6-sumeet4linux@gmail.com>
 <1a5fb9bb-d057-4579-8b2c-b81aa16a61cb@kernel.org>
In-Reply-To: <1a5fb9bb-d057-4579-8b2c-b81aa16a61cb@kernel.org>
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
Date: Sun, 13 Sep 2026 00:40:23 +0530
X-Gm-Features: AcwNN1WFgZ6qmRCXqz0Ywv_tzPCCXsJ0jqSiA_xFTFPzs4rsV6HyVJPe6GfuozM
Message-ID: <CAJ9orWRgatqn5gLx5+eDu7-T4s2PWcoVQPvuyMBgEp-KwDwkfQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] power: Use %pe to print error pointers symbolically
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: rafael@kernel.org, amit.kachhap@gmail.com, daniel.lezcano@kernel.org, 
	thara.gopinath@gmail.com, talel@amazon.com, hayashi.kunihiko@socionext.com, 
	mhiramat@kernel.org, mmayer@broadcom.com, viresh.kumar@linaro.org, 
	sumitg@nvidia.com, peter.griffin@linaro.org, myungjoo.ham@samsung.com, 
	kyungmin.park@samsung.com, cw00.choi@samsung.com, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, sven@kernel.org, j@jannau.net, 
	marcan@marcan.st, casey.connolly@linaro.org, sre@kernel.org, wens@kernel.org, 
	t.schramm@manjaro.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 12:00=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 06/09/2026 08:17, Sumeet Pawnikar wrote:
> >       }
> > diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supp=
ly/cw2015_battery.c
> > index 1bcb60cf763d..48643f7bf503 100644
> > --- a/drivers/power/supply/cw2015_battery.c
> > +++ b/drivers/power/supply/cw2015_battery.c
> > @@ -658,8 +658,8 @@ static int cw_bat_probe(struct i2c_client *client)
> >
> >       cw_bat->regmap =3D devm_regmap_init_i2c(client, &cw2015_regmap_co=
nfig);
> >       if (IS_ERR(cw_bat->regmap)) {
> > -             dev_err(cw_bat->dev, "Failed to allocate regmap: %ld\n",
> > -                     PTR_ERR(cw_bat->regmap));
> > +             dev_err(cw_bat->dev, "Failed to allocate regmap: %pe\n",
> > +                     cw_bat->regmap);
> >               return PTR_ERR(cw_bat->regmap);
>
> return dev_err_probe
>
> Instead you should use dev_err_probe and drop the last argument.
>
Sure. I'll do this suggested usage of dev_err_probe in different patch
series for *_probe() functions update.

As of now reverting the change for dev_err under *_porbe() function
and planning to post V2 for this original series to use %pe for review.

Thanks,
Sumeet.

> Best regards,
> Krzysztof
