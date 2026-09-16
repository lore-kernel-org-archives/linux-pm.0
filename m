Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE8521203
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577405; cv=none; b=Vo4AnGELtvqt3zvOYHSZaof4//Xxxpgm4fQ0HRe1mPRMphnV6hCjkFzRO2NiUEQOgoSl8os05S56DpU82t43RVnxFpzY1PwOOr4vucsDz94LmBRmDAb9dawh9q0prh+jX5zBzFNMApUGs9IzZ/sbmtPBsaj/pcqjIj+fdZBoa00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577405; c=relaxed/simple;
	bh=Ggb+PcHRJDo/Cz5nvBOFJMC2dQF5gLYbmIeM6Iqn8Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keMyLtD3ZhjKUuDUn9QwnAKtM+ZBkrNezO8bK3ssdCLCIqyq7XP0j3HXINJ1CKHBsOy2LL4QPPHkUZ8jwKWEQAqMH+Iislru1fmP/g0OQIud/1gQCSlnKlv8/c7L39T3kdw+8oGvFSCqczDvi15134lnw9jSltc7zS1jjMFq6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHEKiZSq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHEKiZSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B847A1F0089A
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577391;
	bh=Ggb+PcHRJDo/Cz5nvBOFJMC2dQF5gLYbmIeM6Iqn8Mw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HHEKiZSqg7+GyH1kW7u2Hjh6n954PQBWjugWOQSucOvoJpAfVng+ngPvsQ9NcH4mi
	 xtk7OuOd/JleKPjNisP2KjwOjHIlYAmHsKORnWbSLqnopk/P8kruswK9aha5jKrh2h
	 T5+u99gibJ/LLILgQgGSpKR/8Olwo6hpZbKotqNrJYNTrMVnF8YOJ9y+Y6i4ALwW4H
	 C6w1r6Db2dXNgKyLToIc40EzB8gYnT8NftrmIEs6OAPDomnrsefuQKe0nCSYGQfS55
	 ndgO1nZRsZEjKDvPuli5DD2CV2kvHzdB3pu0VtMl2TRvS1qfTm7mjpI/uYPSwFuoyo
	 g+RkIzLA2y8Fg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8b402f4e3so1099484e87.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 09:49:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByXXMTLs5H+XQq8bROWcGB35as4LF9xHNgR4AB60s0YbNypGMCZ9Yer3Pu4QR/n5ZupoL1+A8zaBg==@vger.kernel.org
X-Gm-Message-State: AFuF++kvdPVVHAa/TgUA6VTBgZKMqLqPQbQCtFkfY/tUM5vd0kwjs51K
	kaoysRbk75Y24HKz8C+hmEJZW9vxNLxqY8+zgGBUy3dNQTcsQLDyUgBmjku+cW26MAOK+5wDTL/
	xB0FM0jcwdsH2s47Gg0r6zkRIzLPxXos=
X-Received: by 2002:a05:6512:1595:b0:5b6:422:a61c with SMTP id
 2adb3069b0e04-5b8b666eb43mr1907989e87.28.1789577390371; Wed, 16 Sep 2026
 09:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-3-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-3-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:49:37 +0200
X-Gmail-Original-Message-ID: <CAD++jLnHa+1e0N8V0znwzeTZSX1Y5YDAa=cVKSYjeFpZM0o_OQ@mail.gmail.com>
X-Gm-Features: AcwNN1Whb6PQ06lQN_GxsWNtotsS8LqxjoSrqgaYpOWlLWlGsW2D5EFYiCtujyY
Message-ID: <CAD++jLnHa+1e0N8V0znwzeTZSX1Y5YDAa=cVKSYjeFpZM0o_OQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] mfd: remove unused rdc321x southbridge support
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:22=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The rdc321x was a 486-class SoC developed by RDC. While RDC's later
> products closely resemble the DM&P Vortex86 product line and are still
> sold under both names, I checked the datasheets for those and found that
> the GPIO and WDT blocks on them are incompatible with the rtc321x.
>
> Remove this driver, as there is no way to run Linux any more on the
> older chips after i486 support has been removed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
