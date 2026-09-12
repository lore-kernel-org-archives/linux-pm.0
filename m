Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D23A9636
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240073; cv=pass; b=K3XvVTBxTwpm2kry98g4trP4teNZmUvijiUrnJrDJd01K/FU7A/dl7AWzdLHFFTLUwUJ8EYENEPCWHph1GM030wM/pBUOeJk2Ijeamv7YMAvJJ/pcbPSggDj6KXtOSm1KP4u2r6CfD+6tzVKozWghTC/b2+xc4Fx0S7+6Hk4TBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240073; c=relaxed/simple;
	bh=vBGRoQcJXlxAMtSg/Ev+xruoEjdajUUrjRvI4ba6Pgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWD205Y5aCrimH/5v1Uk8V6WBEUZ/2DHT7fHzXDg7ExbFKiL4AvwzQwtRPqtQLbvDMeM8ZJVT2sjzqJV3XotN40ItPZECKvUbPIDe/AzWwUGWLEUVCAztzY6ntwa9j4JnIBkYN/Aw4s78p1Jv2OEoIE0+wlOhzLecAcfvFOQgb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkapOxgQ; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkapOxgQ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836c4474028so17697597b3.0
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 12:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789240070; cv=none;
        d=google.com; s=arc-20260327;
        b=eSSpn879gVhCPEMRXq37/d+eBuBETntm9VRFRGV9br5Jo5H+YUo5p3MlDlUGT01haT
         J9J/EWUHFj4GGfi3iYAxOq1+VuBNA54r1pPND5nE+K++PCCGYn8WIqayhu4mxk/al1sZ
         L+7Ykufk+46t7qBMy/SQtxuiLUbo1kwXSR+VQI6dYB24UmKF5MKfAkENl4jwiLDdOHiR
         82QRFwKF4inOKukEEXLJL6CEHGv90g/nDdS9D2QQNMEqGU00dYOjrCKARonCkLF4tux7
         DnBE0nEVFOCxSgj2Tj/9V2BAJCSHmpqGMUPWuOFMuK+LwDSLfKz8lFsIVW84kcGl+aLj
         0MqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=frZxPsvBVeqqB8BxzOhZbWb1UNk2/xKGtRE4rwWtWZ0=;
        fh=j9LNyOiSFg92noCvmlflrVOxzbfy0x3ZnygEXavNBUY=;
        b=PKHtczEJMPPJzYdM/QIR/U0Io28LGa9KoUnVQTxPqsR3R9B/HMYv+vQ1tYWz/3+T64
         TX/+3+ZY42JCqiBSQyh3WzcKM6syqBX+8scVPeFUFw4FrDCjtvVEUjycudUYgsfeFns2
         RuWGXlbVXuH+y9Y8yisN48Ci6nwp5Tr5f/TE/XnQqj0+lGmS/C/oXn4B7L3XR3aM2AFI
         A/egp0Dxhr6SlvORpCN1TIWBi6AzloCHCwv2Hl/rljE6M1WUF2FeOsdVsZUdgramIXCJ
         c4rEwNroMSuQXyt4cp2dBbP8wrxvrkGad5WoJ8I6xs8yUzbLpiBz+A6RtkYoHvROlsK0
         rhNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789240070; x=1789844870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=frZxPsvBVeqqB8BxzOhZbWb1UNk2/xKGtRE4rwWtWZ0=;
        b=JkapOxgQXv5ET8Qb94XeyLO5pdOFXllOR0Q2jHzDfQFmE5TApts78X36dzgsP4lV2F
         AJpPEUcDjvOL9fMptDgklbypBepaL7YvWJbxaU730rnc/MoZzNy6Mhu2h+zxGE+CJc5M
         k2hgcKXkNs6qxCDziHeQObBXqeI0kQpb+nlsaaUMYz0ugBeDOBKsSZK1/hu3sLnnrDSq
         hf6LcnHprhEv4+71lL8LrKSogYSjPi/n9si1jW/+mhYjriYOk1P037UAE/S8G2X5R7av
         pmPULYCr5onjsvJKFLbXL0cmoqgxlAq4gzR6aQ/7jJhtlhxPZVHM9fSYbghe748bl4rL
         qYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789240070; x=1789844870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=frZxPsvBVeqqB8BxzOhZbWb1UNk2/xKGtRE4rwWtWZ0=;
        b=ZvankRpGaypMBoy7kLbfh5bT3hLc26d/DKoEGjbBJvWCuaPX2N1q4IxTIzY5noDOuS
         EZEYY0Nt14zqP0kqJEWmJWlkf3mP6NK0zJq8bq8+ZbTGhVYga56hQXUNWiglGngeUlp6
         NA0MWzcDch+BC7aYszOnhaYY/s1FgkfFFuInvJZ5KYCICgk/yGeDCT63XdGQcA+7y/co
         dz8JJXqfq3EYkXbmqqq/hQtMte7ewjt/HbgRZ9cCmAD/Eo+C33KDkWLCvtyBOL622L1e
         pliilIJE/iW2zFsIyaOg+k32+cmpUxnVQr4RR4NuLVsx2SaK2YYbm+06Jmh+UsX1cITG
         FkrA==
X-Forwarded-Encrypted: i=1; AKwUvBwK6pQtYoJqxfA88KPpoxkhETet77fbaKTxFRVMJWd8mPlzuE+ZcWEIwmpHonBocdlnP80n2KPxag==@vger.kernel.org
X-Gm-Message-State: AFuF++mlxT6un6Z2hGnpfuYy0X+oKhNDijh2ENtiWvplHGSUHAubkSKX
	4Fyg6jQP3s2mrriWqVY5YSnr5kPODS9BVuUHL+p/jOx/8BuIGrhjiuJIyB407sgdwBEH6btGj+b
	UMaY7FEzSqQ1ClkknHQEhB9Gvp1mw3HA=
X-Gm-Gg: AYBFou128CMRYmwDSDlz7L9flgwZpl43109mPq7fjNmPoLy5Za3vG1UO7UVrUxyhkaD
	+xFIhMP4SzY5gq8X4zBrOgArWcqwIbTql6TWIn+pBuQbJhCv2xfUPL1HGwnHpvvvU4bUoJqO4Oe
	kPzbFEeuLxhj28F75Z+lVSN+xR1XUsPNKfY++jPYGRpCq3BCalA7tr0mFKoyyGd3AgXt4MZXqXS
	DKDwFXjAtwd1F28oIbLT+4Vg0/yg11awAWneTdajvgNMnrQS2C9X7wq2Dh4FUnrUMgYP4GcllKN
	VujJXMZ6XZgfgqALxtTo5Aj9jlUlTOrDww/vCeRJemhtq1Zt1ZCd
X-Received: by 2002:a05:690c:a790:b0:873:5bb2:6c0a with SMTP id
 00721157ae682-884b6f29b6bmr21177167b3.52.1789240070580; Sat, 12 Sep 2026
 12:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906061755.5103-1-sumeet4linux@gmail.com> <20260906061755.5103-5-sumeet4linux@gmail.com>
 <98a0dbf7-9724-4ccc-8810-645dfe715656@kernel.org>
In-Reply-To: <98a0dbf7-9724-4ccc-8810-645dfe715656@kernel.org>
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
Date: Sun, 13 Sep 2026 00:37:38 +0530
X-Gm-Features: AcwNN1XqTP8GoNHaMkR4dokovXZ0UiUGTDkYaF2EyUFt2qLbm2siHwKKSL9BVhQ
Message-ID: <CAJ9orWStxJLN-0Dk2LqmyxEagC_nH-veS7wWrN_kXvb6WEUWiw@mail.gmail.com>
Subject: Re: [PATCH 4/5] devfreq: Use %pe to print error pointers symbolically
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
> >               ret =3D -EPROBE_DEFER;
> > -             dev_err(dev, "failed to add devfreq device: %ld\n",
> > -                     PTR_ERR(drv->devfreq));
> > +             dev_err(dev, "failed to add devfreq device: %pe\n",
> > +                     drv->devfreq);
>
> Instead you should use dev_err_probe and drop the last argument.
>
Sure. I'll do this suggested usage of dev_err_probe in different patch
series for *_probe() functions update.

Planning to post V2 for this original series to use %pe to print the
error pointers symbolically, reverting the change for dev_err under
*_porbe() function.

Thanks,
Sumeet.

>
> Best regards,
> Krzysztof
