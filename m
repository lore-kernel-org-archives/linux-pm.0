Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693986;
	b=oPL5F6OFBYqEttumiNUgJo+m2t1uRZ58vxIX5CrB2vtFF0sBYIhJZHgl3vSoRwNmHKhJ
	 RvFSyA23Po5o10khBeGO/6hPpDBcZKtQ4pFYdIhzBe43pbDIr1Gpha1KqhM/h3Q3eAjRL
	 wXP7+ytCL1gNollQzYJ08BnsXSE//s2boAHr2R31SxFSiAQj1U3441rNGZrFXASI1iyIN
	 NvpVteqMc8q6wn/CVBxY5Kc+k5K63kI4fq4MJ25yBpyabDyvKuIH0RO5D0yuGG3vjAw69
	 67p2xeb+IQW0TRFmIaThQ6wI/G/RXB2xFSfOgTwvCF7OYtIIFgoaeyusFjvtpAjzB4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=H9aEGpaBgrUqyjrZLFv+rrixVdKutJ5TaTpfNSMOxho=;
	b=oQ/BUcStkwQ5HYLQkysEuCv+YY9XRtzhbUSfK8xFwkWgVVNfzNxljHHbI6jI+rl0GMfa
	 lKCTUBEWYJbbYPWqmm6BwH2veNhhtaHsTeeQ14Pm+tlJR1aNhGjzYBqXOsl4SDrLKLD+A
	 QL4FVNZ75TIhDboBB4vBADx/2FZiBXq9WO3oi3MnvB6V79KhrTpO/s5QAdBFSOI/hyJmL
	 X6rYm6vVBqVnqRWRX+1qYcofPT6AKJ9QkvSRpURSlhSiEzdiYh37A0GSElxXbrRR2P51z
	 cKFBtWO1uSaaFKIHgRh5xCcSH02H/H0CT4Nt+ca+sLCY0RRWZ/J/IgsDZrIRJmJTVDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S0aeFzXs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D641606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D641606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S0aeFzXs
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso6155698f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 03:53:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795693984; cv=none;
        d=google.com; s=arc-20260327;
        b=P8QlLOnXfbm3S+ZuDRuEfkrShan92garpD7sfBgXwxxDmWECr8b2yxkUj34pjBsvMV
         /nvmrV7duXbfcJDtLgdFE1Nh/SGe4/qkYcDScBdTs2DueW3Bo0FE2Hy7yZlaY+uoqkb8
         LQE9qfbOwMFOFrnCfAwjKd3tj55I3JVj7zK6uC5OPsazGccpP1xg3a8RYR+ivLps6sCg
         83hDES4wrbVCmSTpVvWFVpmxTNoZCh2Bb+5FYv2DkYFxeTYrxdYaocMxA1v2bQUToqN+
         zhF/AHc2whN5OUbbWQUePk8okGRseBQF6qASzrqIqLvVTQWEft/J5ZJdS4epnOktsaqr
         oibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H9aEGpaBgrUqyjrZLFv+rrixVdKutJ5TaTpfNSMOxho=;
        fh=mkaTd61SDUlhNBnyT+iSGAoiKUq/+y+HPN3vY4umDBs=;
        b=IfilT55gtCO0ttK9uUm+T/yc+mMtqBE9bJm1LNV/FyNd6t9TpWWX3zVsqIXi6HD9OS
         2hrwn18PPLWg6yorirXJml6xI1tAsCCEkc9xOPT7uDJKBmwZLXe/9WOGT+3+960s9jSQ
         65xJEYliF264nStVLTvW3yvVqhLpRPAv8XdntgiwoYvqfKM1xyry5EL9si6uDsGjt1Se
         2Ho/lUYAStSDP/PUaUxttE+0gOx+SW/LY240IoXaU6WFIl+Ae1zhFBrdQZSQlHIYuqRJ
         IV0/5Xcg2YxuI5z1SuLMxPvifQGNG1gePBxfPnbk0zwzPtcNK6vTuqgPSpeq8JOL09vf
         BtBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795693984; x=1796298784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H9aEGpaBgrUqyjrZLFv+rrixVdKutJ5TaTpfNSMOxho=;
        b=S0aeFzXs8Ydxkd9skMwIIs7vYu438WzLCdSH1AhQRK2t/3eQ/tH2INCrLxs8Ige2ym
         dTV3cW9r6JBOKuLokz/ZTzKF4wvh4/KHKWyioIo/roQe4ctBB8SLklKMOecXePLfDIbs
         ApUHSe49kqHosp9KeFS1skNO4y1Z1DUe1SvAgCMaJna0mJR43cBrFhUk2JzU2tNxGYoX
         TSyQ6m3GFNMU5Fh8vHr3ok+H1I/EzZoiZHBKeiIkYS+iTMnJ6hrBOULC6e1xzngCo+us
         Xo20s1nzuZcB5h0jY1X3ptrNvDZqzTYKZ7qh84y+6IfidobrggRjMpMFb2OPpOQkr2N+
         yWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795693984; x=1796298784;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9aEGpaBgrUqyjrZLFv+rrixVdKutJ5TaTpfNSMOxho=;
        b=DZvV9OZfDGjMVsXCPtTM5zYAbkQH2CkG0HjtG4z7VCnjAMFsCZwFgdfj02QraAX3+v
         gqfX1/fKkS3nHRsASzxHRqh8hsSIUErfbW8B+zUQSNGlkZpocH/0Gf9BRUYsXWMrdG9i
         pJ4IK9wq1ndmXwsI3A7b1xtl7agA+/8PjZFj/wh4cEoagidzbCi0ongS5TxTp60X5xNH
         m/i50L4bYMFqdwj6OXA4Ihj3/PoDLSKUASSPSjIBJy5otZs+P1Kg8QCmUvNNxu1wz70w
         zYlQRuMXHKRoKN08q/Huls8ssZRgjH+AA1iUxc+hinFiSXEaqX3kFbozhRKDYdMxAjdo
         wbxA==
X-Forwarded-Encrypted: i=1; AL+hErF9g6ivCvlP/kSTLqIEqIFlichgfLIarEYsq6W6lZyma7c7uh8YEqRucSyfhviwLovLv6yhpkEvtA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+GF7sCXwvAdkhNa3GfzZCKsogYZNqm6GbUSjMK7/msQ18G8P+W
	ZQbma3Wo89EPcV6l1/WiFZH32E195AAtYK7GK5XAsMhKKn9B3K0JLa9hr4BUzv1GRgiN3yYB9Cj
	Yx+KreYUAmlgZuK5Lu7S5YKlJUT+7+OQ=
X-Gm-Gg: AZFdTZfndZW/kvdYdHMuo2DvtAK47TTfE0EuZWXeAxOyk9WgX9gDukZa+/9DUFQi9DS
	XoNVKWH2G2deqSvIuqrb9Xr+c1eIIgp39RK5amI+V7/f8oj3qztfZJNyJIrH5riURdsWxS2u1Qm
	LT1Arv/Cc2UD2mWrExva+YWVMaXWYe+t3nLNujbgmUxZ6brXdwIbZ8mfqLtm1Po4Wku6BHjbbMY
	zmVSeeyxaEuEhcJr60WC83v06yKA7VK9wzbxRb4ANTXxL1vHOVprbbsUvNTTiaw0xZmoBmj/0fs
	/k4H2kIH5t8pqt9IGU2FIMHXhh9Z3YMFtrBgzVcSBWgFVB0tn6laUiVUC6i7G+RjrOSiSttFpiT
	5B2eCVX/TPJvp0/qTNMMoZRjQnotDfgCBUa/4EeOTILwSuNy8lkrfDksZEK+wQ2xrhpVV2ZvO3i
	NRLRl2hMmedt1MtK7NyQs6v0W3Kt0UUummg/a3E8C3iJCXiWVc+X0PXvP7YDw=
X-Received: by 2002:a05:6000:299c:10b0:4a7:9630:7b5a with SMTP id
 ffacd0b85a97d-4abb47b2043mr29738022f8f.47.1795693983751; Thu, 26 Nov 2026
 03:53:03 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126081155.501493-1-wenst@chromium.org> <20261126081155.501493-3-wenst@chromium.org>
In-Reply-To: <20261126081155.501493-3-wenst@chromium.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 26 Nov 2026 11:52:36 +0000
X-Gm-Features: Aa3M54q70A5WmDyjKjXpU3fpfqljo9KNpnEhQvgxjBv6crELfdOj0n7b-mbXhxE
Message-ID: <CA+V-a8vgFBmQ-ih35f6GrXg-JBekovdF4jOuXcvteGkBwDEGUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: rzt2h: depend on POWER_SEQUENCING
 instead of selecting it
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 8:12=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Commit bdfc454e8567 ("iio: adc: rzt2h: Add support for RZ/V2H(P) SoC")
> recently added usage of the power sequencing API to the rzt2h_adc
> driver, and directly selects POWER_SEQUENCING.
>
> This new Kconfig select causes a recursive dependency when combined with
> the in-flight power sequencing integration into the USB core:
>
>         error: recursive dependency detected!
>                 symbol USB depends on POWER_SEQUENCING
>                 symbol POWER_SEQUENCING is selected by RZT2H_ADC
>                 symbol RZT2H_ADC depends on IIO
>                 symbol IIO is implied by HID_MCP2221
>                 symbol HID_MCP2221 depends on USB_HID
>                 symbol USB_HID depends on USB
>
> Power sequencing is not needed for RZ/T2H and RZ/N2H, whereas RZ/V2H(P)
> and RZ/V2N do need it. But it is not a strict build time requirement
> for the driver. Change it to an optional depends on.
>
> This also requires a change to the pwrseq stub functions so that the
> pwrseq_{enable,disable}() calls in the driver still work without a
> power sequencing descriptor with POWER_SEQUENCING=3Dn.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1d6ed49041ab..7874d0e78e9e 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1631,7 +1631,7 @@ config RZT2H_ADC
>         select IIO_ADC_HELPER
>         select IIO_BUFFER
>         select IIO_KFIFO_BUF
> -       select POWER_SEQUENCING
> +       depends on POWER_SEQUENCING if POWER_SEQUENCING
>         help
>           Say yes here to build support for the ADC found in Renesas SoCs=
:
>           - RZ/N2H
> --
> 2.56.1.839.g22a8290db9-goog
>
>
