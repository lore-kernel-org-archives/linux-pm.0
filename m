Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C594C652E
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577656; cv=none; b=BhUDOzdZZDCCAtZ42yx7o+ZZLe6UPgcapW2nV19EgIXl23qpYlYhkgL2n4wlHgZo/e8AErAU3hgCgd97zdrmK2jczEkJ/f3MggWq8XXVWEKlrrP7gDovoxIqEjfViZUvjE6nnSrxr36EqqSyTXKwLc8MjKRo6qMIUqyD6cZG82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577656; c=relaxed/simple;
	bh=+Cs3VDVugIjX3MNVr9btCbWNjreSEbxnWC6UpAzcikY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4sKZmFRFtpy0Skx/Tzmbys3lFtI1Ct22Mr35DRTJE1855s60NhKKKGdK6geY7MLeNKUtHXpEHOaq3bNSzknNz6AVOCjW+dI0I2q4DSgHwLQxA0xcREC+XE11MW6ADrm0xxu041Mk+04XlVuCyPqHeePV9LDhbRDUK+p2vKxBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjbO+wUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjbO+wUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D9C1F008BC
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577648;
	bh=+Cs3VDVugIjX3MNVr9btCbWNjreSEbxnWC6UpAzcikY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GjbO+wUK8PFGJDHTykoLXmuHDqj5Q7HLnMpLEGqYG36NblxMPUNwQLqNuP7FzEtT4
	 JtNiFzZ/1GJdhAx3cf2d/F6lgfSLCGCB6qOb6ixqEY8owR8DlGvYXsSTeAdY2dHNf4
	 um0RvShJEozxLwpw/Um8fJ9MSJePrMWS+n9P+W2MJEQKKTtNV/ybCuERrp5NU/6B95
	 lZj0/o+SBlzX8Ebb7rn+q5ig4whFnumLJBwY77N7myjOW9XvPxgXpgFzYNCbq1Hw4n
	 xV3s0FQA2HKc/MFPuqF6apfb/pYnlhD4tXsFKK4J8z0/eokzzdgWXGC3jEzMW515N9
	 BQQxBTOl+bhjQ==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1744fso1788746e87.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 09:54:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwOlTkPVIhw2B1xs22i9U4IzwK/wAfOgRNLjaD89MxVUY5Cv2yFTuDnYF74bbMB9SQol3Q4oV9wlA==@vger.kernel.org
X-Gm-Message-State: AFuF++l/cEKJhe/nEN/VHtcn9cx2ZE8OfHE4kRANdq+x/BR9e9Xk3Vk9
	cTvpOTZQcbhIyY1+RvHVzSVSoE0yt5nH4NOVJepOrITMOEmYDLlwDFU7nPOjmbNVZzWLDi/cMZ7
	h5FuEAg9CSlMDJ/ZNxRuDoui2MBML+q0=
X-Received: by 2002:a05:6512:b83:b0:5b6:183c:5ca3 with SMTP id
 2adb3069b0e04-5b8b665fbb5mr1072085e87.65.1789577646856; Wed, 16 Sep 2026
 09:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-5-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-5-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:53:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLk6wQ=GOzRODdd+D2GQg1=GoP5UN7ZJpPPBQJxZcMQy+w@mail.gmail.com>
X-Gm-Features: AcwNN1VTSOwI-aMkaQ5X6FNcYlrB3vHQ8mD-kiafJFD8muXAXYKzzuAMRSbPmhw
Message-ID: <CAD++jLk6wQ=GOzRODdd+D2GQg1=GoP5UN7ZJpPPBQJxZcMQy+w@mail.gmail.com>
Subject: Re: [PATCH 04/14] mfd: remove unused wm8400 driver
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
> This driver requires a platform_data definition, which does not exist
> in the kernel.
>
> According to Mark Brown, the hardware supported by this driver was never
> shipped in production.
>
> Since this is clearly unused, remove it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
