Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846394;
	b=hBOv30Rwl2kkaaxjM3AyH1opG0+mPewYhsSaQ+WCaGQ1Hb20BmBDIGiwmoEQyC8H78JP
	 m0tToDIK6yb4NnoseuC38oJI5tAlkkVs8Fa51jCiUU3iy1kgBgw8hj5Ja9FPSdtl/cDoR
	 2Cg7tjGGi6gASjqPgoJvXva1PUpVE3Wv6L5On1h/DTLjV8Tq56slbokttvGpNXDL6lrgv
	 8Y+F3bAasbDqoqGr49FKLdvO6AcnvwY8HVwFIX/ln1yPpBKKDgRMn0/Nn0eJQtiTpOoU1
	 BkbQ7ntGce0QywCGO7Cy5OJoeaR+bE9BWfLAFXD7EjI/ix/qPjofXSuTqtK79tpuM2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846394;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=8nHg2KK9YdUFsDyCN5OyhUk3RMp8EQBW/fDZ8x8OirA=;
	b=SdIkZJywtbQObwbRSvTyL6eMuAgAkJtYuQssuU5Ej8XrKgZdVtIAfTo0UculF6xp1uHe
	 Z5pgro7XTiNThHwjxZLULMpawsRDSu99vtvNkxX6+QoSztuTs0ltmBLMR1NdQEpCjCOrd
	 fx3BTiUtAexKnvbMoeSmAhoVB9/aPYAwhMrGpWohGhA/cWtUEWh0jL92G8DQdRTmY7gdS
	 NW7bfkdB0AzYPdsjADLsj4Gl1NawqiBixepacGv3cQ1NEXuvikXPJyVJ5HTsq8FExyaOF
	 RYbCuDTQ1VV9Zuawe7AMaei9SOpheKHT/l/gxuNRLENyq09zgwLLF0+ek5//8pbRIPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=KM6jG51j;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DFD606A32E
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 02:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0DFD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=KM6jG51j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793846388;
	bh=8nHg2KK9YdUFsDyCN5OyhUk3RMp8EQBW/fDZ8x8OirA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=KM6jG51jfXUoSCb57V4cpBGaTQ+dTrgtvDKc7ult3QhPfcC4XqYOot3xI8+s56T5F
	 4p78QdFKgK1wTJxD2na7iIGYuuw6fGfVhGkO0ZdIlBOgi/OtzDf3u8aEo1FEXJiFys
	 Y9/rnd3Z+0HSwmDAR1GMB01LNKfhtvmSxzyyVA4M=
X-QQ-mid: esmtpsz16t1793846385t065ceaee
X-QQ-Originating-IP: 1qJ0Z0u4efqxxHNQ5zYtrNxVL5oaBlKpVLnn3sRJKbU=
Received: from mail-pj1-f44.google.com ( [209.85.216.44])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 10:39:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9340389161725991926
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso697633a91.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 18:39:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBykodDt6ApRKrMiJJIwK/fy+PhjkMdjqp9BIHqa4tkucuLW4E/0I7E6ihYL2xB1a+zKJh42d6Vgjw==@vger.kernel.org
X-Gm-Message-State: APuU4Z++HqtP4sSknuKu0wL+j6oWp7/0YWhj2RR4rBBaqEKi3UxHNwpZ
	Yp06luhQ0XLVLKtDmLQh8GjeQtcAkhxp+k0GZoFx3pnq+rcLcpXAHVsEdUuByHNhbqhN2VIBahQ
	53t4tev6d5JwX9BaoAeuqKhN/Mhrif6E=
X-Received: by 2002:a17:90b:562d:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3ae8982c1ffmr16206466a91.45.1793846382617; Wed, 04 Nov 2026
 18:39:42 -0800 (PST)
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
From: Chunyan Zhang <chunyan.zhang@linux.spacemit.com>
Date: Thu, 5 Nov 2026 10:39:06 +0800
X-Gmail-Original-Message-ID: <872B2B4EAE847E62+CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
X-Gm-Features: AclHuK-lEE7dv-iC1Lsio6aPGOufL5hgelB1hFojisk2-zoMsjC0hhsp9HraOXA
Message-ID: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ivan Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
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
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, 
	Chanh Nguyen <chanh@os.amperecomputing.com>, Alistair Francis <alistair@alistair23.me>, 
	Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>, 
	Dmitry Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OFTxDW6HahUO6h1dvtGMmdSPtexTzEAMspOOVnh3j51Kl07gyON3cTVx
	3JNfADcVb9YovkiKPDwNO6+oBio7yKBV8SHyA6SydMaC07aGqor3yaRWE3D4svqtdFd0eRj
	6L1HXcNu5a7AUFq+uLH5AB9RbnY6HCpttljkl4yuBOISdF+zK0wlftb176/gM5G1Cv3eYXT
	4HZVtzYFqxN3W6oOYVxrmXA7wfTBr5tU5aR4v/4vHfEy+hdwmvdV/xoebCBGDLCKOlrhplb
	8OU5qZ5yB8h0qU2DxnqQPIFMuFYIBCm9gFctgSAplg+QRHpAz/ExpNg7Bs7VTT31wkqBIVd
	mhSJKkjSMz0VIyyIAhhQqkE5TmybVOyCs/9yghbEl02/BskDTe7+xMA24cOjPsloCk+pmQz
	hsHWTDEcCPPatBbfMCG3XPydCTxrrb9EdyLvotsC7qTvric7xYhg1pUlHICScWE17XUsnkn
	PgkHAT6VAc6seyI0AfwPEZrexJZxezOzHKfQvyJe1s3d5iNAyPIDEYITDBrwCjMfi8nuJzo
	Bv1PFXlXH9xeV7vjlXfps7b46S1r8zcwBr3cWJzrFs+VgpgTbAKtn0mVmglLxZF8s0qfMeC
	A1W2sDiXfuUvBAf05VwBz2Y3iAyXl7bJaKWjsLmckiC/KiGVyxcQ8IRqupn4OlQiGvR33vW
	wNz3/BsJKFpokfNpuqz0H5ndnSqdS6ViGxEFlINlW6TfdF4oMwNbitVDgExuZMyUmX664em
	py026IDMTxmW6A2ack3oXtoEBPvjnwptp+8NE/gh7rQS+cr0sKBXnOkXi3jjrAP4Ly5Spw9
	ejcuEXSznIqIn0TMDK2Ufq5iNjVzq4XQkOL29qtK+qA5qxcULEkxw1WJ095ai3cDzyHUIqL
	tbDB/tLZbpTWRMfehV8anEXjFiWPenPEfVVeQx2VNnVVjZI4d8UbB8bqekAoO5kwEugdRRJ
	nOAareoGjmlSphtnJnDD3P5Ey+YOe9pE4zg7Z5Qd/4D5NNcmPq4VVG84r+9tL5NB5VzgLAC
	v2UdBT9Rl0zp+oHfYb7kYlydi+mhVvLdctmufiVQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

[snip]

> diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> index afa551f6185f..222d70baef1e 100644
> --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> @@ -47,7 +47,7 @@ properties:
>      const: 0
>
>  patternProperties:
> -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan
