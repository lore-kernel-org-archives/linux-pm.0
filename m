Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831244D7976
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577776; cv=none; b=cNf9YlDHhgAy51JLybvVd72g1TfAlTRyy1uQ8qO+wWYiRphi7kJsomrN9XIM82C1pNvY/4X7lU9Ir9QCWjES9WbwyWrlKwheSfEEYe9Cr9+C94Mhbl2k+SnKsS/QTqRUrmtU+Tav+8hRkJUrUl1g8VJZoX7ksROj6TN5JJKgChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577776; c=relaxed/simple;
	bh=FsAF5t94/E+0eDbBJV3FrxLYtGfzl97iFt4l9Z2gsvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDXug2pxW7hg/pjI+Y70Xv4Uxp6r16x7s8w/93pSw7S9uhb6ov7HVPwfkVxb51h+rXWqfhvvY5g0gexqJIrCQNFPBaCSMlhsI10/Zuhzow0H3OjI8gomWGIdu6oit0FN97JV4COs8oxOGAF9snXridZ/tbnUc+Ht1Zq6by80Fbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7+gfNmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7+gfNmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CF11F0089B
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577762;
	bh=FsAF5t94/E+0eDbBJV3FrxLYtGfzl97iFt4l9Z2gsvc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=K7+gfNmDOPpIoKxCMKTMh/JgNBNkuQ/A4EezTw8pu9Q7ieNsQFkcIj8gELDjvz+u7
	 G/DON3bdCDZ62f9zI0NGfWcHBs+xoNCjvia+WQ0X5Qr6g+RPKH2nvXvTIY4HdMMGul
	 D/44Wv+Z9y4jlEkuXD9A99zVkynPi5060sCu9OwV5vZm/yxxS/r/mjs1PhAruYDw+N
	 bfvrCv5RqLlNtd/INVIwPdW5h9DUZl0QaUfrED6fBiXx8JXYzIrj1MWpSGnbWC8gLx
	 6XOubQVNghPf83YvgfkM9qMYD+f7fWXTEKmRPAMgRhJgHU47TZQJHC4eqSCL9Q6oVV
	 5fo2W6vDFkd6w==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b88dc3bc02so1254688e87.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 09:56:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByvLYosEeJsFnKDVDs2CJXJos7/6F4MH2SvCpXuH4yCNMFom9OcUd/XLQgDtJs/uCvhwxHVqjtHJw==@vger.kernel.org
X-Gm-Message-State: AFuF++ko5ESc4VfgwWgsPdoFb/GzYnd69ZCyHZLej2kB0JNtqEdtHoFt
	vEgOAVtPPsPnaK/LGgi2oaGiavimuOw+f9cn34xbrAtJfFnQE9e1Y6+ex3xb81lQeca9LhFe8yy
	VnMVWmRG6/zDXsbbqRie9gEoZm8BKMqM=
X-Received: by 2002:a05:6512:3e1b:b0:5b6:1a7c:fd7f with SMTP id
 2adb3069b0e04-5b8b6652b42mr975442e87.37.1789577761635; Wed, 16 Sep 2026
 09:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-8-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-8-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:55:49 +0200
X-Gmail-Original-Message-ID: <CAD++jLmJ4tbJuwuQtAx6UCxWU4XghXwp=saMqy5SRsASqe-=Hg@mail.gmail.com>
X-Gm-Features: AcwNN1X4XEEO3B_3JMl6a8g-CgUfyegbwNLsrb9Ef6iUWMuuaWJ5SqyyXzqaDA0
Message-ID: <CAD++jLmJ4tbJuwuQtAx6UCxWU4XghXwp=saMqy5SRsASqe-=Hg@mail.gmail.com>
Subject: Re: [PATCH 07/14] mfd: remove unused lp8788 driver
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
> This driver was apparently never used upstream, and without devicetree
> support cannot be used by external board support.
>
> The MAINTAINER entry was already removed in 2021 as the email address
> bounced.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
