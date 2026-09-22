Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC0382381
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087648; cv=none; b=sMUcoUpvMxzwYYs7R+yOG3qVTNCojfBmAcgjEJJ8LZT9EZZD4qaSav2TX7lbLcJ0/8ejbpDROlnT5hI6u3aQPOcwjijZ/3ZvDeM3kAs7gA7Q9ymT4BCc6F6x6oi05mdu3Xql4W5dv048vEwGFcR65YBOhkF99EuiZG6dktBUm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087648; c=relaxed/simple;
	bh=zHlsfWC8sX3pz0/XSFoxgX7FqDI7whEHdUXnwOXIQoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMBVvAMVR6q/qpT1IMgaOW4fikNobSrysv+PEWU2NK49uMOa0SAtvIbq/hHDO7UFDiUYCLbxtWhZb6Fp2Ws5wR/YmjX4vmoNHEEBYrCp3rVzr3qmrkuBuAlDOdvPVheBCtagFNKHSpSYYKTli6tI4xZziHVxDZJ2CnDdEnN9df4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5059f9so2432282e0c.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 07:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087645; x=1790692445;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ifr1hHZZAJWVubWKqPeVb9esvq1iy0mCWPvBSTHrG+w=;
        b=n/yjDL64sz+b8zx4sFJ1NTLtdGPal7JTgwB2PNXiL6eZGILvH/zo2hoA5FJnMTpZ/D
         4MjgdvLoeosR08jjo4ZAqKOc4lXer06CyD80z55gNCmdm5GRT+0G+gO8XAc7rV0+szr8
         PxVIaESJ8kbdIkNQlaCkg9Iz7t9fT3PsBtvHBItEhiTQBeFmLADKq+1BlWI6Y//zovgY
         ruvC/kEroLLNz+wqCe4/xSvtDnve8CM9Vxmr6DcR30mLPG/Fa+LMpzSY9Pa9J9mINx+h
         qGEK650IAXHxoK7Kh2+7yY3wIDjw17FwRslzIDIhrJFV7VfMVpxEvX1MbJiwVXYhtLRq
         TGdQ==
X-Forwarded-Encrypted: i=1; AKwUvByqf5Z5SzT4DZxluM1C8nWTJ6aAbLXOxCMletFaoKGr2Nx/pPvvFwOBI+qalDa7wXKisn9xPAPvCA==@vger.kernel.org
X-Gm-Message-State: AFuF++kbtWj0t2NC+mMrsvX3g1rs/nojY2t3FsMZD332xOkgkieLGH/F
	+1LVZR6i8STC83n8xEM5Hfc9EoyYVOS/Cph0HBAoOepgyfmXWYnC/wloqTtpaGcW
X-Gm-Gg: AYBFou1kF/sWD5rTmm58HzJEB85hKXQo1zIIKMRrZyzDBGRf6f9s6Elh1XLUlWvNxOd
	hO1upsPmo6GDhs6wOmeburhQDJ03ILSVMGBZHbn8jPW7Q0h+fZ4sk14nHMKfyaRoBkeqymJzOMU
	vWLitE1a7rQtCwriqW5Upra9JTKDRUviHnXmhCcXIxgHRTzlb/3go4XdmAF9HN2+4RJCx6+y+tH
	PoAwHFN43nK8bcNHpBKe2ft8or8uCHVn9p3kV76bt/sftlqq76d5Nhny8rKQfdR22NN2LwKjxPT
	SyV6HSzOWmruURZmYGalu4wHZ5audcd0vrOgDwGDtlwrQW1zFP+P1eckATH5oQ/SuqNC5oMGUNa
	H6zEw5uwVhUftlf4KoZ+mDc6RFPAQJjzzXwXc7oRNbQ152irb5DY8jGZGZeLLgGqS/6FRswOEwT
	cnkPJane4OK+KkpZ4pRz8+xXrAbUoBDiKAz/0uxWDLGprerF0n7j68MT8hX00AHZZfSMMeY0XJH
	nWQ2uME3BK9EzWjB0ajTDQ+guYaodvA+sDR
X-Received: by 2002:a05:6122:3106:b0:5c9:c60e:3a41 with SMTP id 71dfb90a1353d-5c9c60e3d74mr6805193e0c.19.1790087644914;
        Tue, 22 Sep 2026 07:34:04 -0700 (PDT)
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com. [74.125.227.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9e7be86f3sm1793684e0c.2.2026.09.22.07.34.03
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 07:34:03 -0700 (PDT)
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c67e5059f9so2432213e0c.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 07:34:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxywqX+SrwbzMOvqgUv9RCZTrZyLSS1F1BkAs7GaVlDPhJbYhiiHqHB9ehM3F5Ej0HL64Y5YUhEcw==@vger.kernel.org
X-Received: by 2002:a05:6122:390a:b0:5c9:a617:580e with SMTP id
 71dfb90a1353d-5c9b8b29cf6mr8586451e0c.11.1790087642750; Tue, 22 Sep 2026
 07:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com> <20260922042707.116378-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260922042707.116378-7-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2026 16:33:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVbyktVBAwBh=LoARWHHmb_FrF+omeDvNdR76uxus3mPA@mail.gmail.com>
X-Gm-Features: AclHuK8QDsFUbN6MlA77zfZcOMVCYGTCDIMnum6Wgku5P-WW7MUQq9pjTBb7a98
Message-ID: <CAMuHMdVbyktVBAwBh=LoARWHHmb_FrF+omeDvNdR76uxus3mPA@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] iio: adc: rzg2l_adc: Rename num_channels to max_channels
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

Thanks for your patch!

On Tue, 22 Sept 2026 at 06:28, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Rename the num_channels member of struct rzg2l_adc_hw_params to
> max_channels, as it represents the maximum channel supported by

... maximum number of channels...

"the maximum channel" (aka singular "max_channel") would be equal to
the maximum number of channels minus one.

> the ADC hardware rather than a count of channels currently in use.
>
> No functional change intended.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -62,7 +62,7 @@
>   * @adsmp_mask: ADC sampling period mask (see ADM3 register)
>   * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
>   * @default_adcmp: default ADC cmp (see ADM3 register)
> - * @num_channels: number of supported channels
> + * @max_channels: the maximum channel for the ADC

"maximum number of channels", to avoid confusion.

>   * @adivc: specifies if ADVIC register is available
>   */
>  struct rzg2l_adc_hw_params {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
