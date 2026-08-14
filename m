Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D50352005
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716723; cv=none; b=ogJz4c5UF+EOKsdi4WnrKSZYg6rkrxZEqsC6jW8yyEwDde26DvkHGUrT3gA8R7XcC6OGnC01gvQTmttcLgkt0RLtkiSyX1MwEB851JhSuwA9n5gNDmZSylyGNJ7R97IQRKDflw/mhbWqUfC/+RolaAcwf9E+BBrZrXiIIRf7PX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716723; c=relaxed/simple;
	bh=JsIUcnldQ1u3QtCScnnx1TV/XRtH7R6vMqus1di2IQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flQ1NOXzFGX0U7GIAEEB9mEb7PNtV4xBKs0tAzr0DA5o6v6NHm5YysYkT7NNykB15WABBYB3DefvvRCvY1SGemGSB9AH/PMfVLwX6QCwNzLjYXsLESGDch4wsUYTyDplYAlMx4gaMtzLBeIMAenxVI50V3q0pSZfdHfB4IRJZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-97bf8f94cb3so219534241.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786716713; x=1787321513;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bgWXOyN3bHTLW1HwfNjCBRVaO5dCtEdU8VDYMKoBjsk=;
        b=jDDc4uElEy2+U8g6sU5wancQElUXW1gOIHW6IpOxbBC4yKayPaHU2XC8aSPATlmuur
         T/GSz047M4LWFDXHIDnHf325t9b9T+u68yjbqLZLSrvmxEh3SlYIPGi+ZvpEJJoDuIIY
         wy7jyFINvkAJr6sEViHSJUXaRMfPmzJrXfMZILPbJOzcgWAjah84cmOR6qGtOLKet9vX
         zv3zvwWE5vPD4bZqHNOQ0rLFf+p3wQjKmYA36gwZmjHvtBQLiThiDc5eorf3cW9YX2Ki
         e6jGwhqAT6oO4fWE39dbTPmLvvk4JO3VuC7UHS43QL3V5uHmJ/8bDRGeYvhLzD86QhDb
         EX2w==
X-Forwarded-Encrypted: i=1; AHgh+Rpm60Zcfi4v/3YLxNYy0Ir8eeP4TB33BKvOsMnKTimVsMAtRY1WUVUg73qVQE+LzObrIgQ7MSSquw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxR8wmwY30Wo5zU0iPuI0GhSRL6p0ESixqs11MR+dWigsSxL6
	9Puc1CYUS5krUU8LromS2j7W5RkYQsrOrEvtds/sIR+mdifsBuZ+0kIcLjlV/3II0No=
X-Gm-Gg: AR+sD133N1CGvgaYpDlHUb5wfbArpPXkc1b0vm8XS7/tBTPMk/fXLdfvdJrwPUcATTk
	KwDnwHv+07uq3x/doDBuY9byYhxPqp1Qwzd4y0XH7AZvbNGTuQWsxwGNb6qmkDCG7Fr9c0L6JKH
	gPVmq6mY8uaYPb/DIJ6EJUdcxWmbpEPAUwnVVh2eFIcAj1gQ+BdEATEMpSvM2KMK7iK5d86rNPT
	B94SLbqwTrh2tKcavXCoSpYDpPPMmVBucQzM8tppAYr0rV0xkIgVQhlzPzfUFfvthNhhWDllt2M
	m/8IfZdDkUsS0zzLNANNG4MfKflNxI45e++zYnBa8ZIjhLkpzNUYz5dHcGF0XAPr5/XCMeS67XD
	GVDFjajTU+oe5WNk4NQDgO7k2p+cAmirgETB3lcRGuFVDhVOIV54pAZ7mm+5cGfuWbg4PuSsS8G
	5M5fS8ck4IrE/31IE1W6kKn82mJek5EYAEak/nvVaMbt2+Q1UcTAdzCLyR4uAbtWlJf4QRt0BiX
	Lr9jxZlraRfqOsSokAuGzG6Bzf28g==
X-Received: by 2002:a05:6102:548c:b0:73e:9fae:5848 with SMTP id ada2fe7eead31-76f2cc475f3mr917000137.12.1786716712884;
        Fri, 14 Aug 2026 07:11:52 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97bfa5a111esm1067779241.4.2026.08.14.07.11.51
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 07:11:51 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c2dbaf828eso354769e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:11:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RotteNoKQz6jvvc2qnhThr3I1HSlEOQnrgFfAJYeR+9kjL/ftgwfy9dPfqp01jtqz5QcKUGj3Lf+g==@vger.kernel.org
X-Received: by 2002:a05:6122:1d10:b0:59c:b1f7:4df3 with SMTP id
 71dfb90a1353d-5c591f5e797mr1003893e0c.12.1786716711327; Fri, 14 Aug 2026
 07:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812115010.108322-1-biju.das.jz@bp.renesas.com> <20260812115010.108322-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260812115010.108322-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Aug 2026 16:11:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+asd-YNYx_supbAvYWcEJYQrFKqBVv-emeN0Jy8ME8g@mail.gmail.com>
X-Gm-Features: AcwNN1UShNX_oTiWicJgMTaw8xcuLUMGl3dXuc-syfChFLEr-XWrgdZtyk_0koA
Message-ID: <CAMuHMdU+asd-YNYx_supbAvYWcEJYQrFKqBVv-emeN0Jy8ME8g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Biju <biju.das.au@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 12 Aug 2026 at 13:50, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add a power sequencing driver for the Renesas RZ/G3L PWRRDY module,
> which signals power readiness for various IPs (USB, DSI, CSI etc.) on the
> SoC. The driver binds as an auxiliary device to the parent SYSC driver,
> using its regmap to toggle the SYS_PWRRDY_N register bits, and exposes
> {usb,dsi,csi}-pwrrdy pwrseq targets.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -27,6 +27,15 @@ config POWER_SEQUENCING_QCOM_WCN
>           this driver is needed for correct power control or else we'd risk not
>           respecting the required delays between enabling Bluetooth and WLAN.
>
> +config POWER_SEQUENCING_RENESAS_PWRRDY
> +       tristate "Renesas Power Ready sequencing driver"
> +       depends on SYSC_RZ || COMPILE_TEST
> +       select AUXILIARY_BUS

Could this cause circular dependency problems with ...

> +       help
> +         Say Y here to enable the power sequencing driver for the Renesas
> +         Power Ready signals. This driver handles the power ready signals
> +         required to power on the various IP's on RZ/G3L platform.
> +
>  config POWER_SEQUENCING_TH1520_GPU
>         tristate "T-HEAD TH1520 GPU power sequencing driver"
>         depends on (ARCH_THEAD && AUXILIARY_BUS) || COMPILE_TEST

... e.g. this, due to a mix of (a lot of) selects and (only three)
depends?

> --- /dev/null
> +++ b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c

> +static int pwrseq_rzg3l_pwrrdy_match(struct pwrseq_device *pwrseq,
> +                                    struct device *dev)
> +{
> +       static const struct of_device_id pwrseq_rzg3l_consumer_match[] = {
> +               { .compatible = "renesas,r9a08g046-mipi-dsi" },
> +               { .compatible = "renesas,r9a08g046-usbphy-ctrl" },
> +               { /* sentinel */ }
> +       };
> +       const struct of_device_id *match;
> +
> +       match = of_match_device(pwrseq_rzg3l_consumer_match, dev);

As you don't use the actual match entries, replacing the rather large
of_device_id structures by C strings, and using of_device_is_compatible()
would reduce kernel size.

However, you might need the match entries (actually their match data)
when adding support for future SoCs that might use different registers
and bits?

> +       if (!match)
> +               return PWRSEQ_NO_MATCH;
> +
> +       return PWRSEQ_MATCH_OK;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
