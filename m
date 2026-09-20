Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18C3F12DE
	for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898585; cv=none; b=AeDem7v2FgRiD0NqdEJf1a1vSaUMVakBUhL9KM6E+b1vx+5kiSLi6/4ZntHqqpMGIdM/NsVclWIqvHqE4GbO+qVn7DOR8fiASkfAIwjt8LyLl/pssyV0SuQ1RJVXQjZc19iUMkN0URaOkH0Iqrvv8oWG1xnoN7rjUwASFsIUKXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898585; c=relaxed/simple;
	bh=6Z2B9efW6oQ12wEhyEUlN9Sfd4HI65DR1Bu8uFgI2HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTZhaNqftTmZPOg43t6jKLoqhr8D7QWZPUzKtWOV5NuOw+KpykLjxMFuVJetpTXFOF08LAaICiaNHn38kHu+B3KWUYolPlLFEUMjc8Z7dB7VBMSOgeh7/2PCOI28jFA0ra8E7gOnVbC5N4lID/6I/77nkn8zEnllWbly2rCpQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tco057qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tco057qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3533E1F008A2
	for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 10:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789898581;
	bh=A5oO+cMTbQ47NycpUxUJcMEhXz8+yRynclZhYTmvhis=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=Tco057qgWvgMuPuc4/91xhT2/7OKkAszD83wQzIYe3mDkMMJxIBWH4LbtRvfobKUQ
	 yAhKphrUMBpepjuzK5gt+voyHNIhtbk1Qa4gtqAR5NrZ52Fukpcpc9QKE1Si744HIW
	 3M1wAMKAnSNIb8pbkJcltguiMRTchvMg/2OUShSix9qONcds0jja/ROfDQVtNqEEAX
	 XP51rAlP9Kf1UOGcpl/6AeG7aWjQYJH6oAilT6SEEfZN5JeF5ACfrxtXmLdhK3aF3D
	 creBqK1Tsbt9p3vxcj1K0VKo88iBq2tpSkIeFO4SN7/qwr62XWYK4tdL1P8ffIY7dd
	 sjugVvnfX9l7w==
Received: by mail-lr2-f13.google.com with SMTP id 38308e7fff4ca-3a302c06eceso15405421fa.0
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 03:03:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzV/ofkU9BIQlnkhdNiIs0Dpxo7AhBt0yzsxTD6xXq1U5Yw1jOSaWb16cuThCb3auK53mPfwZOz5g==@vger.kernel.org
X-Gm-Message-State: AFuF++la8GUefJysYJsVNlqxqxNkWZNQPDuNoQbw0mVNFiaUYpfy6heA
	yEidFFZeS8cwFWbUPThWvkb8mVnlM9uqWe/F/BDocmJFE5QQo9Qi3/clK7zn+ammdWrLM6ZH6+E
	n0S3r/Nu2YVnul5a+A1asM/DV15z3kjw=
X-Received: by 2002:a05:651c:31c5:b0:3a3:7681:6d60 with SMTP id
 38308e7fff4ca-3a5fc0aa3afmr16089621fa.24.1789898579440; Sun, 20 Sep 2026
 03:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913145527.18148-1-iuncuim@gmail.com> <20260913145527.18148-5-iuncuim@gmail.com>
In-Reply-To: <20260913145527.18148-5-iuncuim@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 20 Sep 2026 18:02:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v64SfV4wdXwn2Si8w87r6E+PidAAKJJfUJDWqz3kHn9chg@mail.gmail.com>
X-Gm-Features: AcwNN1WNiiqZx-dirR42ASsi4bsV2jdbUXD9xI8djW0wkB4hBsUX1s8oMylt76o
Message-ID: <CAGb2v64SfV4wdXwn2Si8w87r6E+PidAAKJJfUJDWqz3kHn9chg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	=?UTF-8?Q?Juan_Manuel_L=C3=B3pez_Carrillo?= <juanmanuellopezcarrillo@gmail.com>, 
	Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 10:56=E2=80=AFPM Mikhail Kalashnikov <iuncuim@gmail=
.com> wrote:
>
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>
> The A523 processor has two temperature controllers, THS0 and THS1.
> THS0 has only one temperature sensor, which is located in the DRAM
> controller. THS1 does have 4 sensors:
> ths1_0 - "big" cores
> ths1_1 - "little" cores
> ths1_2 - gpu
> ths1_3 - npu
>
> The user manual for the T527 processor describes 4 sensors, whereas
> the one for the A523 describes only 3. As additional information, the BSP
> driver was used, in which the value SUN55IW3_CAL_COM(5000) is used as
> the calibration value in the formula; in the mainline driver it is
> treated as the ft_deviation value. Also, in the BSP driver the NPU sensor
> is used for both the GPU and the NPU =E2=80=94 its actual purpose is uncl=
ear;
> both sensors are functional and show temperature changes depending on
> load.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

I think we can ignore Sashiko's concerns for this patch.

1. calibration likely happens at room temperature
2. it is not the drivers responsibility to guard against incorrect
   device trees
