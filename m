Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427585;
	b=l4mSU0mXPGxyIiuDHpFjUuLGukdaEuMJiVd1gpCrxvCQYuTG50I8xxcfBLi/tr2RkFK4
	 M3LafU2SkLZebR08IYjrW1z60G+zfygwksI6xiFby4h30oKr17O2HqZibjvsm6nkLa7KK
	 B4wYO0RdMrG/AVAl1DgJE+CI/XU4MiPayW2wByk88lQSPPdoErC/4JcNUxP7uGbf9HNao
	 hTiEsfBQ9o5y1hA1w0Lm3VxGxBWSh5NSvSg5vrln1OGZRZ90zrn2+kNtZf0/h4ZVsu8y8
	 NZhUwzx8PdL27flQOvr1oIVz6LQC4nZ1VuszhWJzCGD6svQe6FrsZ2c4yX6ApnBCSiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427585;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Q8KL6LGvq0FwHTPovYus9FfkhDMRIi4bd+XQz8TiIQM=;
	b=dOig1JYqhemDsU61XMVirbnma9tSvN3mllIB306POIFqswV6Cgx66dJTBMhDf7bUuPp/
	 6PPUB8ToGEw+AsdIM5YgYwQlQTMnyqdvdtWwIG282VWLuDls6o78kQKJ/sOLVKSJDeAD9
	 O8oNdHXf0pKo4wcNafF16P8qTGNyrok80mgvuPy852ChbAbrq2c44ovupUll4UAU9Pgp3
	 qlpOFSGxyggcDOoG7bKz+2I+ff98TIQlg/tV3n6Uzri9w+sbUnsSjEcZnfYXYFr3y1N/L
	 V+n+y9jJqzM9c3DrHmnr/CSEHYdCMGpbF+CODHPSPiHn2PegzxD2nSeiJwS8mEZ5FBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F03606A31A
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90F03606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c411e139259so218836766b.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792427583; x=1793032383;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q8KL6LGvq0FwHTPovYus9FfkhDMRIi4bd+XQz8TiIQM=;
        b=nw6GE5HtSWavjwLN8Yn6z2kQ++gjK56ZnFU2ZBu0TFe29SkkTI0LsZxOlvjfhqID4Y
         EI16LuXk3ieaflY6GTRVDd7qI7XQUT4cYwfjdXefu3i+XB25RJXPUTxJxrZa/xuo9Hnj
         nFRpF+TTTIU/5oFfnA26qfd/CPh13DvkchdXFXrhb/uHw2KC75aY8X07uo6pNjVcLebk
         C3Q0H+LgXO3F5tbt6FF8iSsAmTcgn7arcbSRDK1u42ciKzklW81OOLuEuWM0fsXZQ0Iu
         tOeH8NqBWwkKW6f2Ab6WIeD8RRvfBgC7URSFWayyhRCtfpOd3klwHg231X+haHuU4sov
         2pmg==
X-Forwarded-Encrypted: i=1; AKwUvBxqMDlF+JW5nLvKQ+x03u31jbHr+QssU1baxkdj10u9fr1AOVe1SjublRdv62n+597fUdesqr0Vyg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIKLP9481ftmTwNkPFpPgPkmO3x+MC2L0cwFSVp82q77rCv4MXD
	VjyJDtOgUzqLu1AsE0myc3TWWbCi4mjDaZrW+ei01uZuPJ//QF7LuKRe6fKD6UnxbVc=
X-Gm-Gg: AYBFou1GDhkS0FBtUapeHjBOXnvMDKfTIL0+JzDc2ZaArNMcw22xLD4+W7rVf80AYIv
	rCoGeiUAuRLiUI51lT5SJJ7CG51wSfYNfolP/km9cgRuEmv17iTwPEPfYR1iOnd3/YnjvNIBr3E
	8KNYRYAJTKbQPo//dBTBq0bV3Z2y2Rq8GuT2+B5UWhodAvf133KOs2r4XNWB4CENFBuVvYXXQ5O
	7sBDMWG7A0vS0VTXNITMDRFckWLdz2zotyVqR0ZQZcnFsRsdnYU25fjazRGwfOQHRBNrnhyVTHy
	irs+uBlXV2wNHLbmxtKgI8gTXPFx3O+i3Q4eJ6ml9JFHZ0Mi2vfGvgwDCxW0p5zFA8AO01TZXZN
	45Ii+O4Myboj7CsLDole2fg48NcVCjhUnd/VbeN/i8tHa/OnNFKGNnoezM2D76duLEg2H/9ULa9
	9yaaujzHmVVkOGFDyvEXA62eMf4afdFnSE4/u+jzV3xHYTJ/yOhnvfjsk8Kjnk6EMsXMRz7P2UE
	WrPI6YjIOheBdiNZNTxYN3CsuoLI6umQbSg7lCUB/5G4nE=
X-Received: by 2002:a17:907:6ea8:b0:c3f:a2f0:6cb with SMTP id a640c23a62f3a-c419e03a22cmr578682866b.18.1792427582820;
        Mon, 19 Oct 2026 09:33:02 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4256c790adsm245978266b.31.2026.10.19.09.33.02
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 09:33:02 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c263415982eso277746966b.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:33:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwQhA9Xei2Zheo2vBAvE8pxpOa0Nl8/V+ft4oD1si5ZmHu8fb1fMJLn09Cixo2ru/zbZwVVYVWGSQ==@vger.kernel.org
X-Received: by 2002:a17:907:944c:b0:c40:6ed9:b961 with SMTP id
 a640c23a62f3a-c419a05c502mr618122766b.5.1792427582507; Mon, 19 Oct 2026
 09:33:02 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792163045.git.geert+renesas@glider.be> <4524363679c1f2163aca3b3dda2bfbde170d095a.1792163045.git.geert+renesas@glider.be>
 <20261019160545.GC3705@killaraus.ideasonboard.com>
In-Reply-To: <20261019160545.GC3705@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Oct 2026 18:32:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTz3BR48_Y8_UR9PEjLuavHtN-4uaEKURtqRXFBO0uUA@mail.gmail.com>
X-Gm-Features: AclHuK84fhnixZiNIMOwb9AdAvJEMnIe-A6l4ZZgkoIEEk378oR8Z0wb7zPZzKY
Message-ID: <CAMuHMdUTz3BR48_Y8_UR9PEjLuavHtN-4uaEKURtqRXFBO0uUA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] pmdomain: Make genpd_get_from_provider() return -EPROBE_DEFER
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

On Mon, 19 Oct 2026 at 18:05, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Oct 16, 2026 at 05:55:44PM +0200, Geert Uytterhoeven wrote:
> > Unlike provider-based look-up functions in other subsystems[1],
> > genpd_get_from_provider() returns -ENOENT instead of -EPROBE_DEFER when
> > the provider is not found, thus not supporting probe deferral.
> > Currently this is worked around in of_genpd_add_subdomain() by remapping
> > -ENOENT[2].
>
> But not in the other functions calling genpd_get_from_provider() and
> propagating the error up. Have you validated that no existing call
> stacks will break ?
>
> > Fix this for all current and future callers by returning -EPROBE_DEFER
> > instead, and drop the no longer needed remapping code.
> >
> > [1] of_clk_get_hw_from_clkspec(), __fwnode_reset_control_get()),
> > [2] Commit 18027d6f392ee8d8 ("PM: domains: Make of_genpd_add_subdomain()
> >     return -EPROBE_DEFER").
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v4:
> >   - New.
> > ---
> >  drivers/pmdomain/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 964e44c2f78f1d55..88c886814a5b9da3 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -3021,7 +3021,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
> >  static struct generic_pm_domain *genpd_get_from_provider(
> >                                       const struct of_phandle_args *genpdspec)
> >  {
> > -     struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
> > +     struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
> >       struct of_genpd_provider *provider;
> >
> >       if (!genpdspec)
>
> Expanding the context:
>
> >               return ERR_PTR(-EINVAL);
> >
> >       mutex_lock(&of_genpd_mutex);
> >
> >       /* Check if we have such a provider in our array */
> >       list_for_each_entry(provider, &of_genpd_providers, link) {
> >               if (provider->node == genpdspec->np)
> >                       genpd = provider->xlate(genpdspec, provider->data);
> >               if (!IS_ERR(genpd))
> >                       break;
> >       }
> >
> >       mutex_unlock(&of_genpd_mutex);
> >
> >       return genpd;
>
> The for loop seems to imply that we can have multiple providers for the
> same node. In case a provider fails, the function overrides the error
> code from -EPROBE_DEFER to whatever the first xlate() returns. That may
> cause issues for your use case.

The code has been like that since its introduction.  Technically one
can register multiple providers for the same device node, but one
can never safely remove one of them, as of_genpd_del_provider() just
considers the device node, and removes the first matching provider.
So I think someone just didn't like nesting curly braces, and tried
to be smart ;-)

> If the of_genpd_providers list doesn't expect multiple providers per
> device node, I would change the above into
>
>         list_for_each_entry(provider, &of_genpd_providers, link) {
>                 if (provider->node == genpdspec->np) {
>                         genpd = provider->xlate(genpdspec, provider->data);
>                         break;
>                 }
>         }
>
> to make it explicit.

Will do.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
