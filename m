Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD649F123
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717988; cv=none; b=lbeE6dxoRTeMAJkz0tjL7z2KOOXmQZBLovjYzTfp31fcVRXtXK1XBEhpsduosjtrPcoGHln2Ndp5BCuVdILpe6FhICK0F923qdeXHYHwtnyD0P7//c/2bKIuy5EBZp6VdcPYQrVsY+YpyN1AHPE1clwfGYZwZmBTLLh8jC9jQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717988; c=relaxed/simple;
	bh=wTlung53wgG0U6uz6ynHrcjwVaYOb0YK4Nvyasm8+go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llea2qSwtktgROgf8vN95VpY29HjgiZ0z4HD/TqKvirNrh1t/1bEstQKem7cDzcwRZlU3+zaB86myGHFSmW3dlBBUSTQHapUBWny8h2OaGXg+gLjzYHDKlmeNT/JaGUSC+I5t506S+vRU1u1dVBZ1DNOphjfFQRaQG0Pq1pIv0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-7fcb425fc2bso226639a34.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 00:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789717986; x=1790322786;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y+tYCkkvzZJmFoYOhTQyYw6fM+qA/usgZs/lU8fn+ao=;
        b=teWj4zF0s+y49ph9wA8CjYnAolSMM3n6T78KM/brr9naTEnk5EUUREsEBMIFaMiRUw
         8KVEhvacYQu66D25AnK3N6eI/njZ3EpHvJpCLpXMZYXRCadDPLsrrtLWFQIlUSc+niGv
         w41hF7+poczufETa06wciroMy18CGpH7H1Rnk7ydXxybn4GUhY+pTnZBmrXcfA2Cvamp
         h4RgT8rZivqYdMN3C7TrJMiXjAyeewe5w6iUdyJ//Y1JEhuTnNAm8CuRIp4AaAKCpanv
         XBJ+Rg9j8egiaiUOXGhOWXq76QostPxkogKqD3hvF39VgreDwtUESEwDpEvHP4VIi09r
         1Siw==
X-Forwarded-Encrypted: i=1; AKwUvBwFMIJ1y4q/8qQ1yT5jhuGyIm1jmjxSh51Fs0rg6GKC36zzupNTY26YGP1+/0QRsKfZQxGzJkeT8g==@vger.kernel.org
X-Gm-Message-State: AFuF++lXmu2Aa3CzWd90vRslMUVycT/2RLpcNMRTRml9+36UiX6q28JM
	p0PwCQwm0hr3X7pn+SUGWRkMPJsuTImb+Rj3YyPoA4WJ5qcLGNE5jiMr0EJLQhBU
X-Gm-Gg: AYBFou2haQ/GtWAJvWyg8rdT+k+blk9vNbVg5QNL05abfPS4P5DqV1JSBdlEfqJDLnw
	NYvgzI+ju/5H0hJGkgsKojdiZixPSiNvfX1PxB6951Gi2NJJ0vAr4CNEN20cq/BUHRMl3cXjGUp
	pKCku9x+KAraAiFHIVU4wlGiZSgXKFxqpPP6HMA3klOS/sLj7NnFyaXNvHmMOb8103xNQyLt80F
	t2yjyI2nRPtbqEj5q+4NQf1cP9JihL0V37r+R0IoB/NbCiiE76cchrQGy/I5ChrcRn2MrYZH3a0
	ZQVXPxr1enzrENejA92ubju9f7HHcIkk+wmMUrs36yBPklqIOnzsZOaj5XeNDfb0OHV7nduGpgG
	wewUOz/PfOnsbf7rYbG11RvXaoFbjoqHCB8axDLOpkDQhjqCsNqL5lj58HY937lsKJpzueLCep2
	BMD1kyMcHTomWtbW2PDGL53WAlbixRi2+xF0foArpyZAEoGOVVye8REfuh4o9ZNO+pKnNdDDqGP
	9Oio+MvEBjgDDsm/Xkt5IZBdWoXTd4Wkc+V
X-Received: by 2002:a05:6830:34a7:b0:7fa:5c49:5253 with SMTP id 46e09a7af769-80de3ae7362mr1924355a34.26.1789717986125;
        Fri, 18 Sep 2026 00:53:06 -0700 (PDT)
Received: from mail-oa2-f17.google.com (mail-oa2-f17.google.com. [74.125.231.81])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80e52854f16sm805345a34.27.2026.09.18.00.53.05
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 00:53:05 -0700 (PDT)
Received: by mail-oa2-f17.google.com with SMTP id 586e51a60fabf-466cc88a0d7so390015fac.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 00:53:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw3AMYptdp0upSzIiy7W59A++ut5xNfScw2HMC0popleJsltxIyQlnayR2AgsqYceysEXZZ4woSIA==@vger.kernel.org
X-Received: by 2002:a05:6102:358d:b0:79f:e8ce:27f2 with SMTP id
 ada2fe7eead31-7a55af2df71mr547985137.4.1789717606396; Fri, 18 Sep 2026
 00:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788338320.git.geert+renesas@glider.be> <1d5c56c80291e447208ac8777aaf90ad6f0a4f4d.1788338320.git.geert+renesas@glider.be>
 <20260917221647.GA4038349-robh@kernel.org>
In-Reply-To: <20260917221647.GA4038349-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 18 Sep 2026 09:46:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCFY7-SEGLjhaO1uCDwsvogc0ocdqSz=1C_gsWX6T_tA@mail.gmail.com>
X-Gm-Features: AcwNN1XFZho-l6FTtqXfFYSmbjO5DpuymjytNtvp4sOSdCdr5EidSrnlACqjwyk
Message-ID: <CAMuHMdXCFY7-SEGLjhaO1uCDwsvogc0ocdqSz=1C_gsWX6T_tA@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] of: property: fw_devlink: Add support for renesas,scmi-firmware
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Saravana Kannan <saravanak@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
	devicetree@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Fri, 18 Sept 2026 at 00:16, Rob Herring <robh@kernel.org> wrote:
> On Wed, Sep 02, 2026 at 01:29:20PM +0200, Geert Uytterhoeven wrote:
> > Let fw_devlink create device links between consumers and suppliers of
> > SCMI firmware on Renesas platforms, and enforce these dependencies.
> >
> > This prevents probing of drivers before the firmware they depend on
> > becomes available, thus avoiding unneeded probe deferrals.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v3:
> >   - s/firmware/renesas,scmi-firmware/,

> > +++ b/drivers/of/property.c
> > @@ -1417,6 +1417,7 @@ DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
> >  DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
> >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> > +DEFINE_SIMPLE_PROP(renesas_scmi_firmware, "renesas,scmi-firmware", NULL)
> >
> >  static struct device_node *parse_pinctrl_n(struct device_node *np,
> >                                          const char *prop_name, int index)
> > @@ -1574,6 +1575,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
> >       { .parse_prop = parse_regulators, },
> >       { .parse_prop = parse_gpio, },
> >       { .parse_prop = parse_gpios, },
> > +     { .parse_prop = parse_renesas_scmi_firmware, },
>
> This is going to be a catch-22, we can't have vendor specific properties
> here. If we need this, we need to come up with a distributed way to
> declare them. Linker section tricks is one way. Maybe something in the
> driver struct would work?

Quoting myself:
"I still think the vendor prefix should be dropped, or replaced by "arm".

> Can you just avoid a property altogether? Why can't you check for the
> presence of SCMI at runtime?

A system can have multiple SCMI providers, so
of_find_compatible_node(..., "arm,scmi") is not sufficient to find
the right one.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
