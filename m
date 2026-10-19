Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421804;
	b=Cnl1l/7LNTk4CrZOKznAjHCie/+ONRLywEMU99HHzwpkEpf30Dbp48mxBcAYnmrr9sCx
	 6Go09pONPqFldDjlaf9MzNcCXpplbczObiQdjbdMWPQHxqSHeVXudBg94pYr1iFzDVElm
	 Li+L5chc4lafh5sCca3xSQ9iGVt07DbY8/PWOOVCLj0k/MaUGyGEEVFJyYvJ/zltfEnyv
	 EN9m/hwFIJF27M3vIGMuJlStFMDvw3Fv/7//Y7TzF5iF4N/cLf+VtYW8HfNv3cwcaa3Pl
	 zRa1kxU5EGOgP7h2cm12Mzv6RAwb42u/ej1b4G/jr2W12aDKV31maN9ZldTS5YceP/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421804;
	h=Received:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Yo6/2OGJfxhXILo4QGIB9gHfvFskGfKjbh+hNyiFvf8=;
	b=jyvNsD7lE+tMoI6mNuktoV6WROAdQSayYijErpsRaOmy1+Bvpcp5UlQNpd5+sd5LDGyq
	 PqPEIzha8kfFJIeCWk2OqE2Zc6ddfEfKhTRFtkkNE8ioAJN7nYhsr41ZDn6E5jepZ0WAx
	 lgXp6OkZckWWQT22To1k3rwlXhBVdoj/TCMpLBp1G9nXCmHxqmnLHpWFrcAvuxfdaznEz
	 kMfqqeBM25g5r5mgdo7R4Q0HUn8PMMsmp6QIY2kC0i2a/AFMXCU+5JOlpKwOj05Gvf6fL
	 XxLQs50jSSvKSvugrshnZc5M8Km/Zj5VxEZCmhY9htTKJPuhiRlCReBvFYcn3Up93/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF9A60724B1
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 14:56:44 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9A3BB9EB
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421804; cv=none; b=Zm90duUybiiW8sB34WzELeOYRGJirWkG+E8jvyDM8A/8SZqEWUwtz2IbULnDr4YdmcItSqknck+81focdhe7ANtetMBOPrkiDo/JCGhTPKQ1RgK4W3hh9iwlRDa462xu8bqPBZlsSXyiExoDoBfCVXUnPzNIUGvv3QpWXfsRz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421804; c=relaxed/simple;
	bh=+5tzO8aCL83c5Kk9ARXsVnhNDY1XZ/tMHseqvaZ/klI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILysFYL+lkkFWtJ2TN8jeSHmH1x3YwNhD6YRnXh2YdfjCVlzs11jfy5vFGI7haYbQWdtRUTRgVhtQTFR3eWYPvVcHlto4yAgpNnaUceDq+KAm5aaQFSryqzYk5Ef4TeP9KkCugx34/TjNYFL6vpeczTXxgNnQEm+olR3Z8I+gM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-988c7371716so598263241.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421801; x=1793026601;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Yo6/2OGJfxhXILo4QGIB9gHfvFskGfKjbh+hNyiFvf8=;
        b=08EmWmwyTPkYUBUY8hHig5WeEFfx3v+UkGuW1G3Lld62HCsGm+UqH4q46ScJ6oLGLY
         El/ymEmlPmGEuNCCkaIdruJgtokruIQc9agRlmHgVdtPVYvG+8kZY2MuWpPjhvELsN42
         J3VbaxPcwHKt9+pceDaafSFIefr3NHI4zNLlV2s4PPwtERlxJQWd/nCrbdQ+fkYry6oa
         9Xpu9PACEC69wDSqLWvjvUdVGhWp6NNu9VNimkxvYE5ll2/TIyraXwq0Zu7U1tbHlGlD
         MvfA3npVXFLPE6BNgmg4z0xH9ZA47LeM1DlnolVzneOIP2HhcI0BFMthtlfIq/G/fgDz
         kcXw==
X-Forwarded-Encrypted: i=1; AKwUvByaUSTyWj08mWCpHqhuvJFIFFCtG4FwXSWEksVVF/6t7llOOl1lbm1JunFRe9zlTkyI5d16md9KtA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIZbSQX7Z4LwPOIXg6z/BFBsQQQg9UQmhDe5R7RKh3M9aSN7org
	PUp8Qb2DoaoNf5OqQQAcBogy9614HhrPyz+WnuWxaA3jU0A5NL6NCkatpQIu5esTz+4=
X-Gm-Gg: AYBFou1O4mjT5rrqhT2h5b//Px+z26/FHMDRdrDr/hpbIM4e4T+5OgOJuwiHXwLoCLV
	wTEZn6eEEExk/a6JwnvW7j/tkkR5rV+LcMJEvYWGRfrkm3cQOvm9Lr3xSIWsc2oyGL1r0+4mLdp
	x20VRwgV25fzX67oEzfDM573/QDwF/d2BWDd1Fcj6vnXDx0IbVtxRG/F2Tr/LHn06AjUMc3Nv/2
	0Evvyf2wr+zjAdx1shJil7aLHC6YIBC4GrOn8vUUF0geMdc3vjS0KqhVD9wA/wM4fnCrNStSOhe
	3F4n7LZVVQ3nC/WijtWncJX0D7l1TvuabBen+1uhva5Am2QwYlYZNrcv04tm0oq8bGP5jyFwDey
	CWbT9G5wdQlTGHitmibTSTth9mdchaotsn0qc1T6GHCmRbH2fuI95t4RxQxYBDk29BwaPTm4uJY
	rWPoTsxgwHPrvZLj5QqnyKeMivCtmjqyPc4HLmF0eRy7yR9BzOyAeRhMbrR5iJ7utwpijgYuRL3
	2hbjBmcPeN23Y0c50Ge+1JVSm1QCOcKe8vz
X-Received: by 2002:a05:6102:358d:b0:7cc:32da:56e with SMTP id ada2fe7eead31-7cc369a49bemr1710858137.19.1792421801524;
        Mon, 19 Oct 2026 07:56:41 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc7722e6fasm335355137.7.2026.10.19.07.56.39
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 07:56:40 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7cb6dc850c7so489574137.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:56:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxLqvbLT3X8/aCcUPoBdkEwC3xh7rd/ASaQTlTLXnJk7MLuNYKiBcNHJd26vIDUw7oI/msk+CO+8Q==@vger.kernel.org
X-Received: by 2002:a05:6102:f86:b0:7cb:288a:b66d with SMTP id
 ada2fe7eead31-7cc369ac7b5mr1684195137.20.1792421799154; Mon, 19 Oct 2026
 07:56:39 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792163045.git.geert+renesas@glider.be> <1d7da50cfb58232c6dd4c4afefb938fd7e62fdcd.1792163045.git.geert+renesas@glider.be>
 <20261019144256.GC763679@killaraus.ideasonboard.com>
In-Reply-To: <20261019144256.GC763679@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Oct 2026 16:56:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWkAvkxHkzRVviF_NkZHP7UeCBjebxciE6jFN_8ViM=aQ@mail.gmail.com>
X-Gm-Features: AclHuK9UZUEUyPMO3TO_vFhUiV57c9SStFUdXlV8TRdwkOQjKO9ySUhEkuMfo5c
Message-ID: <CAMuHMdWkAvkxHkzRVviF_NkZHP7UeCBjebxciE6jFN_8ViM=aQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] clk: renesas: r8a78000: Add clk_hw to clk_map
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

On Mon, 19 Oct 2026 at 16:42, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Oct 16, 2026 at 05:55:40PM +0200, Geert Uytterhoeven wrote:
> > Prepare for mapping to other than fixed-rate clocks by adding a clk_hw
> > pointer to the clk_map structure, and populating it up-front.
> >
> > Move r8a78000_cpg_priv.fixed_hws into fill_clk_map(), as it is no longer
> > needed afterwards, and drop NUM_FIXED_CLKS.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/clk/renesas/r8a78000-cpg.c
> > +++ b/drivers/clk/renesas/r8a78000-cpg.c
> > @@ -16,19 +16,24 @@
> >
> >  #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
> >
> > +struct clk_map_in {
>
> The "_in" suffix isn't very explicit.

I can add a comment...

> > +     int dt_id;              /* DT binding clock ID or -1 sentinel */
> > +     u32 fw_id;              /* FIXED_CLK() ID */
> > +};
> > +
> >  struct clk_map {
> >       int dt_id;              /* DT binding clock ID or -1 sentinel */
> >       u32 fw_id;              /* FIXED_CLK() ID */

BTW, do you think it would be worthwhile to reuse clk_map_in here?

> > +     struct clk_hw *hw;
> >  };

> > @@ -92,35 +94,69 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec,
> >       return hw;
> >  }
> >
> > -static int register_fixed_clks(struct r8a78000_cpg_priv *priv)
> > +static struct clk_hw **register_fixed_clks(struct device *dev)
> >  {
> > -     struct device *dev = priv->dev;
> > +     unsigned int n = ARRAY_SIZE(fixed_clk_rates);
> > +     struct clk_hw **hws, *hw;
> >       unsigned long rate;
> > -     struct clk_hw *hw;
> >       const char *name;
> >
> > -     for (unsigned int i = 0; i < ARRAY_SIZE(fixed_clk_rates); i++) {
> > +     hws = devm_kcalloc(dev, n, sizeof(*hws), GFP_KERNEL);
> > +     if (!hws)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     for (unsigned int i = 0; i < n; i++) {
> >               rate = fixed_clk_rates[i];
> >               name = devm_kasprintf(dev, GFP_KERNEL, "cpg-%lu", rate);
> >               if (!name)
> > -                     return -ENOMEM;
> > +                     return ERR_PTR(-ENOMEM);
> >
> >               hw = devm_clk_hw_register_fixed_rate(dev, name, NULL, 0, rate);
> >               if (IS_ERR(hw))
> > -                     return PTR_ERR(hw);
> > +                     return ERR_CAST(hw);
> >
> > -             priv->fixed_hws[i] = hw;
> > +             hws[i] = hw;
> >       }
> >
> > -     return 0;
> > +     return hws;
> > +}
> > +
> > +static const struct clk_map *fill_clk_map(struct r8a78000_cpg_priv *priv,
> > +                                       const struct clk_map_in *map_in)
> > +{
> > +     struct device *dev = priv->dev;
> > +     struct clk_hw **fixed_hws;
> > +     struct clk_map *map;
> > +     unsigned int i;
> > +
> > +     fixed_hws = register_fixed_clks(dev);
> > +     if (IS_ERR(fixed_hws))
> > +             return ERR_CAST(fixed_hws);
> > +
> > +     for (i = 0; map_in[i].dt_id >= 0; i++) { }
>
> This is avoidable by passing { map, ARRAY_SIZE(map) } as match data
> instead of just the map.

True, and I did consider this.
The same mechanism is used in the MDLC driver, where using ARRAY_SIZE()
would quickly became a bigger burden due to the presence of many
more maps.  So for consistency, I kept it the same in both drivers.
An initialization macro might make it more manageable, though.

> > +
> > +     map = devm_kcalloc(dev, i + 1, sizeof(*map), GFP_KERNEL);
> > +     if (!map)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     for (i = 0; ; i++) {
> > +             map[i].dt_id = map_in[i].dt_id;
> > +             if (map[i].dt_id < 0)
> > +                     break;
> > +
> > +             map[i].fw_id = map_in[i].fw_id;
> > +             map[i].hw = fixed_hws[map[i].fw_id];
> > +     }
> > +
> > +     devm_kfree(dev, fixed_hws);
>
> Why not plain kcalloc/kfree ?

To avoid having to free it manually at multiple (three) locations,
both in the error paths and the success path?

>
> > +     return map;
> >  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
