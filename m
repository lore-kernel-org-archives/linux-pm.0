Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794210021;
	b=bx9c27BZWhmv3iZJmcKaQ5ms3zLTnEtAKc90BqDSOQewUat+8WkzAZUI3EABQT0mcefR
	 +7IGu8I4cKek6eZn11j/V0EW6Q2uXI3gw9sRFaGHUBvYHPGsjoRSwajy3gZx43n8n/L4S
	 7Ge65IDBIi61VTUMTW8ANSVT1iUNT1VzwDNaUKwYv4wYiIaeEhCgbvEWgIlfv6JIZWqxn
	 ot5NSMgWllAEskbxqsCo+olDIs2kK0fMmNJD18uBsZhEUGGEylIjfgU4/NdWCRJ8LNqO6
	 3/vdeEGK8KTzS6fogVZuNMvDIFNeh2d1Ast6EbAl3lMXVskc7a+PwXDHUJUdIcl48hA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
	b=uMT7PPaZf/qi/vcqW6bpsf1W/2E9ithPJGL0SNt0uL/TU1ymFy60YVwbXezQ9rVDdgnR
	 FpSOlCcWIdC6aVA6HMPIuhPnWdjtAGndlDrA1q7DYnxldY+mVbD0H8bWGji9nDYpAH4fH
	 0tUmHYiLAFASFjbaLLf6l1sKUul0T5soDcBWC2DGtzrZlqNqaI8F4TeKYU68Xdi6UEBBR
	 IQg33Ff7ecsLNbAUTZThnm8QjS25Js5ZS/u6bT/DoPisYq4nvnw2RvG6K98ht/W/e1ngG
	 1IHmu4CUx6pcQjL34GA7R1KLwln5n3TpPl4EoOpSnRIrhHDtu/Wngh79MlEK8q+Fs0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw1HJ3eB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D64606A333
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 07:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D64606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw1HJ3eB
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so228663a12.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 23:40:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794210020; cv=none;
        d=google.com; s=arc-20260327;
        b=fXjK850oj/HaBVwZuLpN5mKsTKGID5szXyqXanPK6SZzUHUPdLdz3j8gFh7/OeMjRo
         pAqNlgJu6QIb8TTjwBRGHrLREHdp0mQ/46HxgoZ/PZ+8wBvP/dVP5Di+Fu3IqOjvRMiP
         wL57BWECzHqmPUnrxOO5GLjhrwLB6ZVdhlMel2ZYmYmliCSIKuWalUeJqs+LZTJkdJAx
         pMODdFG8tHLEHaN1bkEOiK/QnnkzbPU2YJ56jzQIj96OlxBYJo69F2HhCFLrG08vykk0
         SVtJzZOjjrA/uHJgmvsARdGR5XQwaJ8GaU/czvuve7c5eWlTKzBI2mI0akRwZqe1DFZH
         i1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        fh=verEXaT7CN+Ph3p7F3v905Usv9123Kf2ElCuuVozL74=;
        b=AdUJadskP0Un4tibQzObkgqdMS0JfMAREHfNQKObajc3cMVTsJNcBWo2yiuU9fbhey
         GfT1K2GtsDze9OPxRAukd3XZoZf484+uMC+Pv+bMJYUrPNs03gle/p20aLSlu8IznjwP
         FlTme2FaOJ5ZX3+l9jaJ9eiJQIDrDhPeGrVRhMFo/tKUaLdNV1iRMHNfkCCPhaqRTBfq
         75bAoq5rwMVt3NOdtxfpPUQt1LA2GBvNGjD1dQ7ULCj5OwUTHIsi0//hysfT41zRenV6
         l8jLjY2wX5k6G1koLKXufOfEbenXIuOBOfmhSOgF60lR4WaF8u+xzYJC5jRQf4MFYXZP
         7yYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794210020; x=1794814820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        b=Fw1HJ3eBrEG+YcG2OfXIKNyXLbtxL6pFyShNR64xnTBicLVJTLcqI70PP7XlmXPNx6
         VWmQ662eksYGc8vJo+lcMpjTIaYcJB9aokKPIxavS8OWhjpOs8W89bix1ozwYvKeb3b4
         M7C1Y4n+R7cdsAeFDh3I3fT0WNvzf0CnRZWDlQZYC+5M2rSyX8wMQx9uS+vQs8QSo0d/
         2FLip2Uo0zLuYIubK7TNTBZ4sl8ZrZ+JeHk7SDm/ZlHHFtWu1M3YyNEi+YttPBGWC2RM
         X/hXAhXzRlZNf20NwByFmIPl+GnzmQCqAB4nehLzmm3jWxLA5k3xC+msTg/JbR6XvUqv
         ep4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794210020; x=1794814820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        b=Co8Bx8zoRmBICa8KJED3q1s2oWbSAeAJ9pQMEM5SjQ2EQLBEyA5IhzV0HxuhcZWfqJ
         A4eOvOEv/kSOXV/zsfIjyxCZDr9nQhls1xAiPc7AO19KrEc2jr2024MGcaBRmV0/W65S
         nWHE0AnKdf5MrQTIsExeq6zpvAhV3L/lzzDlSV3fv6mSpMCuYqBU1o6gNH23yFl5WwBQ
         a2tZM36FEjiiZ3zgiTGSHk5WWjAsa4cSucjZAt7QotXSDx2e4QNk8Tj9yxudPJLYK6t/
         KttygkoaBGtQXSzCXHi+o7jCFpEzBrdsWqmks5xdh6mkWBtL8TL1dMNEy/Hrth6CYUME
         B1Ag==
X-Forwarded-Encrypted: i=1; AL+hErFbzOD7orsKiMAX8m3Sp+A03GnC82mkuzddbCyPKBz1P/POMCRrVdnGhN3V6/H2hDZgnz5HQytorQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CCZ8wLn3KRNbYd7rFXu7ly9fw2ctrMjJxPzRRT8Z81UqfH7Q0
	mSaIR4ytoLw9L+5HLk3u7upn4yyPmnoUQoVY2ptFWlNbGuJ4VBGiPmTcsJIg+PEKSxtHmH1xWMi
	zY6zu98y8CxBGKwk7QDTZAf2BnTpBUHw=
X-Gm-Gg: AYBFou2OoLyM3i9aRDJX82dt+uclM+yp5sZGfNRPLlPQDjxAuaYudmqVUskf2a6xwTJ
	PgoW/Pg5AWVSWzUQKM4TKztuqqX25uMJ7Tcir2t/5MpIl+pLh9KJlChUsZQtWqigBp0IvelVxjd
	fOISTz8i6AV/kxyIFrMCZv99YT3sWEp98T3cnKMOXmd4iZI/0lxtCdOYbPmF/1H6RIY5HRnirfp
	WzyBdhUrKhsjG5vN7b1t4tnPhH8NB2Ax3lYXiXoHeZrznR0b30yg3lE3Yl/1xReICsQCWRZ4Pbu
	tV6snZmmwNOTM18TPnVPsMzoLUYXC6c8v0Q6xICd3Kmy2auLpJzPqlFoDa5d4q8PfoSmbPSaKK7
	doTKU9Qw8pVXg1T0K2cLPJbv+sGKsTh5/PjU=
X-Received: by 2002:a17:90b:384c:b0:3ad:a270:a623 with SMTP id
 98e67ed59e1d1-3b12d107e44mr3364118a91.4.1794210019701; Sun, 08 Nov 2026
 23:40:19 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org> <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
In-Reply-To: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 9 Nov 2026 15:39:42 +0800
X-Gm-Features: AclHuK_dnPMk52UN3-2_wspDGRy5a6s-cwmnh8paY6ZY-G54Qz5KZ0bygsAWCVc
Message-ID: <CAAfSe-shr1+0YpxEvf+4k+DyGe3==PUiD72CwjE+RC4gX-ShiQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2026 at 10:39, Chunyan Zhang
<chunyan.zhang@linux.spacemit.com> wrote:
>
> On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > Unit-addresses by default (and most commonly) are hexadecimal. There's =
a
> > number of cases using decimal patterns. Fix all of them, limiting the
> > pattern to match the 'reg' limits if there are any.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
>
> [snip]
>
> > diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yam=
l b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > index afa551f6185f..222d70baef1e 100644
> > --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > @@ -47,7 +47,7 @@ properties:
> >      const: 0
> >
> >  patternProperties:
> > -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> > +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":
>
> Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Following up on Andy's note about this:

Please disregard my Reviewed-by. Even though I did look at some of
the other hunks, given that I'm not familiar with the other hardware,
I don't feel comfortable giving a whole-patch Reviewed-by out of
caution. And since I'm no longer the SPRD maintainer, an Acked-by
wouldn't be appropriate either. So withdrawing is the best option =E2=80=94
sorry for the inconvenience.

Thanks,
Chunyan
