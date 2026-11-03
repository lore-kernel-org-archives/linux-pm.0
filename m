Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696285;
	b=ehrrwm2xcwynuRR5G0o+opPfWfp89Gqm2e2zfCn1J65+cPMDUdOuEdgWCmG7RkRG/Mvr
	 bOyR9Ilr4tMvPo5bkzaDQLUwGAVjHu6KQn47euHkUZSjOyPwLIy2vAHsFo1fWrWyzbOJ8
	 NQGxzCL6Edxu2TTuYddZRYSnbUFZvnY9LrbMbFFRPrdtb4um0sn/csQ6xqWF0Wz611Eh5
	 99t4cqQubMDb3D5eqS/Q1DN5xoD+1QKGkZNvQrVToUvoKHwCj3NdPIZ8+4Cnoa0kxrPta
	 0n3LQ/OcD8Owm1ZAdxAp6MQuPwW/14y1dxZn0XEsyvvWzZAUm5N+Z0YgkBPUerQEGZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696285;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AUgj7ybzOrbdmhNXXkJnAoh6ZouzAZL90keqraEO3nw=;
	b=fUeWAfCtMdijXJJSpGz8mHAoV/TSSWtF1gMevu/QsYVWt926lY60+brpgMl+w3BMA32r
	 2rFzyu8MW0na4OU6/GIRgNvzvgenpndN1Pl3xC2geWSHgtyNnobLlmz0VhQE3Gjn4oquV
	 GNMG2di3rUBxiq2DL9F8tUTIJAnVcRM6LPi3CX7jRIDAI6JIH0xEcvT8PAL8YFTyft/f1
	 sZQLVjtSn3Pqah/K+o34Z6fvdnyh/f3rX2dWZvDVfzWwjtUxFIyamv3DLgNn5xloqFn7T
	 RxFvgM8jpxMYAdPu7R0YKfL9gsL2vBpBET95hIvYc45zHGpvEy6CMPFRep9UKo1huRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKH6l+Xc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8B606D803
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKH6l+Xc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40381F01577
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 08:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696284;
	bh=AUgj7ybzOrbdmhNXXkJnAoh6ZouzAZL90keqraEO3nw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JKH6l+Xc19miNOkvdh6fwXKmZ/peo1JLSx8CpwB7AijrPFwQ5nMrSkiCTWGvwxYnV
	 hmZms6pQ7UWI+F4lN0IqndsfmhgVlMBSc8TdwaDl8EmL3ndRDomC00sTJnD5ZPU3Fx
	 CpI7jvnpjWuPFi1lqaZ3xY/95vrPjNcicxGk5InxLjv0XvTn3x1DPFYlEN/tpT9bVy
	 HHXOI1+z4niVB+11bzLb/GPbjtm5Z8gExi689a+FQqGsFDyszprbcR9DXFG4T0eEPa
	 aFQEmKpZSbWRCkVwkQgHv6wy6f2XGzk3YWJBctaYRCMrImJ+A9CCR+rH8d1FwSvjVp
	 8qwcOpfV6jG/Q==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso4411405e87.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 00:58:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByu2jan+rTU1AF8sjA6ZYJd0AAWCmbqZE0iZH9th+TVnIVaEnQT0DTsXEsz5QtvSLYJbV18+M5v0g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8cEw+8kvyDI44ZLvPXK2dk8XY4fpNQTCAg2rsJY4IcG67KjgsX
	0lK8Ss8cusDzWDE9PTPj0xx9Zdu46aDt63OV9J2xsbmzDvjgPiPVvPiMbayO+CL4LrU6RZk7fgQ
	pIqFNvkZk+MjT1Audoa/S4dgpgJDCtug=
X-Received: by 2002:a05:6512:b84:b0:5bf:dc30:93a5 with SMTP id
 2adb3069b0e04-5bfdc3094a3mr4560521e87.4.1793696282130; Tue, 03 Nov 2026
 00:58:02 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Nov 2026 09:57:48 +0100
X-Gmail-Original-Message-ID: <CAD++jL=DvHOGWpYYudhG-EhxTk3iUhtfz7OBS0mFgurvnCmb3g@mail.gmail.com>
X-Gm-Features: AclHuK-LEcFutZHI-ID3nCMC-9st3AveCqqRSTzeXkI5ke3GTM3j4j9Kq1OFBKw
Message-ID: <CAD++jL=DvHOGWpYYudhG-EhxTk3iUhtfz7OBS0mFgurvnCmb3g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ivan Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	Shawn Guo <shawnguo@kernel.org>, Chanh Nguyen <chanh@os.amperecomputing.com>, 
	Alistair Francis <alistair@alistair23.me>, Julius Werner <jwerner@chromium.org>, 
	Paul Cercueil <paul@crapouillou.net>, Dmitry Osipenko <digetx@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sound@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-tegra@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:53=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:

> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
