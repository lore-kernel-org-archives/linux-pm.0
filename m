Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B551C34F
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577451; cv=none; b=fLvYLuqPUuO+xYYUJQFJf2Yo7OBh8WqQk+HrXzsnKrSfbn4T6gRMiI2SCGNYMv9WrQuejGHPOp9lNkZNWRIE4J8u3TmeF7M3v5PjAO8kSzwrieqhR05GyeQmawplKOUb3exe5hGX7BmU6Ueo1zD00bBrsRCb+rXMj+bLQN3Qy6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577451; c=relaxed/simple;
	bh=YbF9Hq6ip8NH9UOOHu4vU+eokzBGAvhZ+dvcT2bOj6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAUG9nTF2DFTt1gprDWUiQcOD4gl09i3eG5S0FggAiwM+0YQX8kA7/FkQBQPUOdcRCqeEvGaSyBWGV8fAnRCZT6z6iM2xlzKgCX+f4fZiqY3t9ZgndL6CNghw32ZZXifKyeC2jM+wxlgLI6Y8aeSQY8g9PyszMn5oziFUmIwiFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzyqTTzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzyqTTzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFE01F00921
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577435;
	bh=YbF9Hq6ip8NH9UOOHu4vU+eokzBGAvhZ+dvcT2bOj6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HzyqTTzdTWLsGmoCJP7+EXA26N7h4dqjzbXM5JPEPRmAvBShC5ylp3QJV/IjFmw2j
	 mjYxuiIBuHovU5P+xcx8DR4hs3yIUF84rFvt80tKQbbcmWfaC3EJjON9izC9FxzvdM
	 oFVfWzvRvSrFfZUjJLWso1ndlCj0t1vaf66uaca+2kSipx62tXWjn+XumW5OQJgL4j
	 T4S5S1y7EEAGt7l3v09zRQP7DTAhU8QxP8B2Vg2Tp9QhJZlqEaP1j07YpuHi9gJLJK
	 RTsbMzdFpidBi3Q6p012fOaANPqli9LviU2nv30Gm+quxkMLGJbSfeU5/2BANPeULK
	 z/AWiwO1xhFsg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b88dc3bc02so1248788e87.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 09:50:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw+F/WyiBQzaL0z8uU+xqEf9LCZRYNU4aoIMxQPpXq9w13dYjEmUNMjdZE4NYaoSYbvxwThkKrEWg==@vger.kernel.org
X-Gm-Message-State: AFuF++lPEXxiwng2iA7oUb493Hxs9+W+huXKw1l9won6+A1sHFgBmLm/
	As9F+QjY0faRbycDdEPVebbGVabG4YTJAfKFwpwF3EYJvDu4sZWi9kdO/iGfYBShsG+ACSBzUoo
	hrf7Vr6U4eXbp694Bdjbr4yAxhbup5j8=
X-Received: by 2002:a05:6512:12cb:b0:5b5:e263:dcc7 with SMTP id
 2adb3069b0e04-5b8b660c1ebmr1008093e87.5.1789577434048; Wed, 16 Sep 2026
 09:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-6-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-6-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:50:21 +0200
X-Gmail-Original-Message-ID: <CAD++jL=8g4U-BkKH2zVuxQD1BqHNP-EseUsKzTJNpJFaR+Q6AQ@mail.gmail.com>
X-Gm-Features: AcwNN1W58wTtgVz2clQ_wz9Mlu89xpFs3b5LWAbQ7ez6ueMaGMU5iIjS17A22CM
Message-ID: <CAD++jL=8g4U-BkKH2zVuxQD1BqHNP-EseUsKzTJNpJFaR+Q6AQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] mfd: remove unused adp5520 driver
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

On Wed, Sep 9, 2026 at 3:23=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver requires the use of platform_data definitions rather than
> devicetree, but that was last used on the blackfin architecture in
> 2018 and nothing could have used it upstream since.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
