Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4D43CE72
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582849; cv=none; b=R6gDZ8xvm1w8CWcDtUF5jI7zx3/9s1+nxcONTWN32mU1iAXiCnCeTTzlWre0S255zP0uMOamTeIkispFtYl7JWgn9B0jlJSBqVlrIAwUO9hrJ2xTp1gelOYgOkV0mgb2xEqV3k6t59TseRcc4osDMawVqIxCGP2sTdyZ35t3Dp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582849; c=relaxed/simple;
	bh=lzVDByOMJRdqe9R5u+FUOskx17lzI8QGDBa2Yx0eM/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPP3auctecYWP+nlPABVgWr0k7RBvDfhVt0vU9VxuJixlA9t3wSySRHfM5WplfHdQ8c9bDryVnLfuFNvUgS1bVN68Cqec+3e+5rMiuAP7kWc6FiVS1nRzBmfa/Vce8WVzCH022LQA9Gev+kTWEAalyH6yea1zP9hmGo1TtX1Rf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bf94664327so1957006e0c.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582847; x=1788187647;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zpblJv2SEkmZc5HujuLgy2e4sDhnCcMQ0T+RP/YPytc=;
        b=rDN52TlrguMIfojuqH1i/NmekIF1rr0MN8mnmZ46/DBffp759tuBeenOEZ1paW5bNh
         hLz2XgOkNTf5GLKyqhvlvkZCQbeTVPZChI2+jsEeseat8D+8tkjyZ7IKuHbNhQaDBWXy
         xu5hSDzhcfTNBsFCltNddfiGyepwdI/JiPCel7b8iDoJVKe2+2/s+TGglwfy6ghyKFDD
         vtNmL+z/Ovbpch1rfpS2T2Zgcf3faQkCzNWEYIkRfNii+S504L4D9IKIRn7AEGCoJBp3
         o4TnlFeGpYGhGWFdZVimcTOe5nTLNdrfjLbxjvLBkjOmH6CVYi97/ccl6DlsGLefLIOf
         mPtA==
X-Forwarded-Encrypted: i=1; AHgh+RqLdlP8f9dHvtFBGziYcFokcDxncDsh7W1CBkL34JeZabt77smO0wk2VzvgNlVtrO22bbUOOYYukg==@vger.kernel.org
X-Gm-Message-State: AFuF++nVqBJe1UiXMEXsAy4aGlMhtQp/4mMaKWGsdod/1OeciCUqD0Ks
	FSUxE1tyKOF+vYEBgmnFoa4l+NNkzKJwzbMLwQ9culALFqS1I2MMC1KVXopGZIvXwG0=
X-Gm-Gg: AR+sD126elRgWQdg3fPcLWHTcjAmOBI2r6heSUIJsKCb6FFr1VqgTdLN05zHGafvPg7
	qhNfDipQT6az4sKBdMzvk+ekCDq/OP4j8dWkuCsbSl7woj9V+Tn65rgPcJOr61R/ZDP4gq6Rdh+
	0Cgo+lyvj1hKrh34o57kpEX17ltznwVlkVcCc3LrnK8yVpHaOrgaZfpT3wlHSoF77HmyyNasl0f
	0tqhQCV3lxdEsUU3UNYxOgK/iXdntJuiPPy+u85Z7K8BTGYowOdA8LE0r9mz7NpAGXoH/ZCW0ny
	poBv1PxLLMmL+216NsWszCpIl/AZIj4K9uZUTBrzHHsg1MfEuvCM524dvb6DOzdUdQHM8nUc0L3
	veD8xxXjl8anrsNffbkR/6LNdClPiZU6Rkj6tO2LeSaAHu57RAdMMO0a7dxvi9jB8wVxCrTJ+YF
	7VTnVMNdu75Dhi9cs8buueNCL6i0wuhSFJxwO+si3mD56vDTc35G2JlfNTPS+1izqa420zXU0wg
	tRqKssnzQoCmVsS+52+dI+WEdCAyRHSQaWI
X-Received: by 2002:a05:6122:4895:b0:5c2:ac92:eb18 with SMTP id 71dfb90a1353d-5c60dea05efmr7367445e0c.7.1787582847283;
        Mon, 24 Aug 2026 07:47:27 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c623cf4026sm3699347e0c.3.2026.08.24.07.47.26
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:47:26 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-96723c7151eso1620705241.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:47:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro2hUvL0XudevQCdVF2+hI8dfASAO6KF9iFpXy1YbP0ThdzAs3KjSMqcyyKB5z1ylyAJOU5JFlfyA==@vger.kernel.org
X-Received: by 2002:a05:6102:8092:b0:77f:2f7a:f07e with SMTP id
 ada2fe7eead31-77f2f7b3870mr1243665137.9.1787582846228; Mon, 24 Aug 2026
 07:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819191325.217809-1-biju.das.jz@bp.renesas.com> <20260819191325.217809-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260819191325.217809-4-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2026 16:47:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCjiTOw0XqQvcUd1So9v0+8PO6KAqpqWTX5xk6r26GnQ@mail.gmail.com>
X-Gm-Features: AcwNN1Vgxu0CvNeSEcZZhx_3TGW5jkUU2Jthh2_M3mMM3rK8o598dAhJnDmMzNQ
Message-ID: <CAMuHMdXCjiTOw0XqQvcUd1So9v0+8PO6KAqpqWTX5xk6r26GnQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Biju <biju.das.au@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 19 Aug 2026 at 21:13, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add a power sequencing driver for the Renesas RZ/G3L PWRRDY module,
> which signals power readiness for various IPs (USB, DSI, CSI etc.) on the
> SoC. The driver binds as an auxiliary device to the parent SYSC driver,
> using its regmap to toggle the SYS_PWRRDY_N register bits, and exposes
> {usb,dsi,csi}-pwrrdy pwrseq targets.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Replace the large of_device_id structures by C strings, and
>    using of_device_is_compatible() will reduce kernel size.
>  * Replaced of_device.h -> of.h
>  * Dropped local variable pwrseq from pwrseq_rzg3l_pwrrdy_probe().

Thanks for the update!

> --- /dev/null
> +++ b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c

> +static int pwrseq_rzg3l_pwrrdy_match(struct pwrseq_device *pwrseq,
> +                                    struct device *dev)
> +{
> +       if (of_device_is_compatible(dev->of_node, "renesas,r9a08g046-usbphy-ctrl") ||
> +           of_device_is_compatible(dev->of_node, "renesas,r9a08g046-mipi-dsi"))
> +               return PWRSEQ_MATCH_OK;

Nit: of_device_compatible_match() handled multiple entries.

Sorry, my fault, I accidentally copied and paste the wrong function
name in my review of v3.

> +
> +       return PWRSEQ_NO_MATCH;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
