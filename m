Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89ED373BE0
	for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774218269; cv=none; b=V0xcmZ+9JCAQdzsfNUflE26N5efVbPu4lw+GES1x7j46mMmNkatXMkkDP1zNVILPHIpozz+BG1/lUxfPjXoUiC1d/D6wQ4SLh6G74J2nqnaKoDJ9UNUD8b871vy/NddOss9kYvrNPcFS0e5xVoWLEtydclIZfb4NJbfJGy6Pc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774218269; c=relaxed/simple;
	bh=YMkX6r2NEeeGAVKAmeo/RTP8S5oRupKhDNo1SE7wpzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRdB02g4EXaxvsbZrR3cHPIv5bhywROe/YRRE9PLoJtDZs3ROunE/RRXroIJ6I+SErWfHRA0OPHdkbqGqpgjnpelM3cNtIFAmQcqtKXxqkq/iBzDhHjPUQH6HTwU9S7EKOY7T92cDuX1BqM8TEpGh1piv9LPDR8o8PA8hD4x+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaXQ7Ftn; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaXQ7Ftn"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c0ecaae7dfso6138577eec.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774218267; x=1774823067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHlux91S1pcszks5LnQqDKbd7Lhdihe1iwVw4ZIiPgU=;
        b=aaXQ7Ftnbu7tCcuKXH+FgmtDYIuzIUZvoyrMg2S9hF68XsNFaBQQ1GMW6c0CsCPmCw
         5/+VPIQ1zYJLhJPghk/oQGNtyzZ3a2ez5G+S430E2EPwI8leNcpVXB6cDM0e7zKf3MOm
         40kV/gIaCNZ5Vm5NfejbsyBk++oMfCkr6Og4l9mMKjsHsegJO/ms7qpamno4WzKr9XM0
         6/KKCdb1dMTh1P1VuvJitv7JZQlQF7GH2DGGEj1CI5AhQGPBSemx1fLz4kxy0aHKqJSe
         F5EnHxlRcPkLZZyB5hDyzhObwU0mqV6ndQNnLmD4yDBIxG7AOJz+2cpiIS483wwACNPY
         SzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774218267; x=1774823067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHlux91S1pcszks5LnQqDKbd7Lhdihe1iwVw4ZIiPgU=;
        b=Kc5noETk3LNgUjVN/HmrzQY9VoXe/Ve4rXQsomt5lS8/Ij+2MO4Ux61NmGOHrCq1fo
         QjCwLRLViiK7WR4VK1531NIkQydIqI0GVVqvUfLIUjbUq7OOHQT7sejYWp9iguuwBRWz
         EwSvpFAkw6NqIZRWANMSsmDNpT8ZavZd9blzsITXvh0XfgCtYyaVYiO33gF+feADfgCq
         +xn5fWWM+BcoOa9/Vsbtqy838/6KsOOVPvjBO0Cz4ZQDGiQs8lxogaUxQ9hGAV7dgDSt
         NuGnwgghOOF9UzxH4hPfgxg0sIfdc8XarP07sIXGxv5xrZMHvN82P8AcoZqePE7hjo9m
         3kDw==
X-Forwarded-Encrypted: i=1; AJvYcCUeqYjyuqhLignWxt1g/wiOJxqJy+d7qZMafhhdmS37cpf8LhUMu+Lmg8OEWPaHWjLZuW20jCieoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOjTUJjYsvgiXKiUMQV4MDCWgfx4n8jmGTK8yyh8UWpc5yL5IC
	0OzwMAgctRFFHsdeEYHC33effm43dVVTkQ96v3UY35yff3Iib4w1DRwy
X-Gm-Gg: ATEYQzwl4ARmtcWjnl7JqP/grsxHaqLK6mhb5X5XVykel1VYHVsRabVXJiNUzYd3kAv
	TSaO7ufiOuKfJ5ufhXaKX55DS4zUBwNhIE0kNB880bv7CGzybaBnd9WkAcxBAjwSi5FTDRdQNLo
	npCKkroIlFdn5qzEUnw+rFbjhoyvxkj+XzPD0JBFyCzcNaT8Xrjx0Qi+ByxDYkpsv645NQBjaKU
	FRtvqqs2LrcPPD5O8TWrXAa1infwoKUX3FPnnK3X8D58LaHkjMY/0nV5l0ocopudbyGAUtN9iZu
	2fiyxd7eseIKFxiCje6dot8YVQpMkJ1NFQrBexNE82RWkrI5Nuvru6OcBZ/MfHAp+6DaLcqGgbp
	xvRIjB4OZKX5IqjPxakjn6JL/VAFvFoQDV5X7PavVrSg5r6PyXRP9nz5Sv5Zp5NCv6tR8wvueQV
	lCFxT+ErFPgb7MW3Tq+71j/GnEwEe8kETbY5SjVmgV2Tyf1NdNijuen/kJy0kbELMSdhc+gtxDP
	2Q=
X-Received: by 2002:a05:7300:134a:b0:2c1:7ca:ceb1 with SMTP id 5a478bee46e88-2c109567522mr4864099eec.6.1774218266887;
        Sun, 22 Mar 2026 15:24:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b1a88e5sm13452469eec.13.2026.03.22.15.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 15:24:26 -0700 (PDT)
Date: Sun, 22 Mar 2026 15:24:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Guenter Roeck <linux@roeck-us.net>, 
	Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, 
	Kevin Tsai <ktsai@capellamicro.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Hans de Goede <hansg@kernel.org>, Support Opensource <support.opensource@diasemi.com>, 
	Paul Cercueil <paul@crapouillou.net>, Iskren Chernev <me@iskren.info>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Matheus Castello <matheus@castello.eng.br>, Saravanan Sekar <sravanhome@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Casey Connolly <casey.connolly@linaro.org>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 2/2] iio: inkern: Use namespaced exports
Message-ID: <acBr-W2ILu9tnMyd@google.com>
References: <20251209-iio-inkern-use-namespaced-exports-v2-0-9799a33c4b7f@bootlin.com>
 <20251209-iio-inkern-use-namespaced-exports-v2-2-9799a33c4b7f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209-iio-inkern-use-namespaced-exports-v2-2-9799a33c4b7f@bootlin.com>

On Tue, Dec 09, 2025 at 09:25:56AM +0100, Romain Gantois wrote:
> Use namespaced exports for IIO consumer API functions.
> 
> This will make it easier to manage the IIO export surface. Consumer drivers
> will only be provided access to a specific set of functions, thereby
> restricting usage of internal IIO functions by other parts of the kernel.
> 
> This change cannot be split into several parts without breaking
> bisectability, thus all of the affected drivers are modified at once.
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com> # for power-supply
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

For input:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
