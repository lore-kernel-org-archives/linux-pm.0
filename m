Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC13DB633
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002614; cv=none; b=V4Rfisu2ZMP5eiqSNsA2q3yn2ERIRxG0wBlxlST3ncONH/Zozg+7q5BEZLQFCpLIY1EWPOnT1a1vejQnooTdsDKKBsT+eK8dVMmQq6m7nJTEZZ/Z7GcDBipe8g3s2sr2H0sOE5LNQvMGlPt8Ys4BF6qvCAD4CcqHb/6FVWMttmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002614; c=relaxed/simple;
	bh=BRzW2/OT2/0yKrT1p+N+QYbs30oY2P+WH549plD4BDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWeBlYDXB9Kxsd7GlG2QcQ/0IVwE4cYhaka29VRk/BTUvGhXaF+g9JhiKuUYQElIC2JdCtYDJz07ECgZXg+B1mQylnz5cP822p84fh1Ec+BflkG+1axP40bHWhZE7FGO60rM1esD2h3nEdgvOThbeMD+X1nJaSCRlcyob8YGMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bf9466412fso1466082e0c.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 00:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786002611; x=1786607411;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bw0q5d56LIKtFiT6Te7rkJ4Ur/ITs2O5UDLJ3AFpiL0=;
        b=oxw40BAOpgQi7xssvOnuf0dbC40gncYnnYvLczAcvjOo8N6szAeu60sEm4Lvm8+0qy
         RNIu2XcgvlA3hgzfSiFNtDPdBS6AuSTkYdjh1EJvW6ZHI63fQLyV9FJ5cM7oZgl0N/IP
         gEtFaEVh5LW6JsRWOJoMR8Jn5Z/cYS9ga+zAGAaFSGAe9u+mOv6PDK6LNHGQdYEopFb7
         kY6nGRlsEdAUJrFpqcK8RedpMLles45N+0W0GxcDtUbet7Zh/gF/yelVw4Sv3TY7qB1X
         epfYjwoE90Wbk+Z1vuQMHpD9j06PHYuQTa2p7g2a3c8wNGuhO+6iEt7dM9cFoobNvmE7
         qdfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqiw4S3bcJFnkX3Lp+Q1gINKZCmr0rzC+Ey0njpMkN25A8HXapx79gsTOj9CueRylqTXF45/Twglw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl1zztICSgdCZNLTbSfoUc0z6OFFrjDLR11Fh4lfuToIH93at/
	Y27UtyUggVuOx7zJz9Y+4TQlXS7b0oYIk1NrEchbGMNrSJhjJfV9c2Jgd+ewvvR1
X-Gm-Gg: AR+sD12Pq3kf1KAkjKrakZQyJAu/bOi9CUC4A9nglVLQ51db3pR0oJbrFW6zrRpEu4h
	gN7YqO/hMJ16fCaj7MM2HQxZXt8StuwaKDgd0B4g/OnEdhxSjhGfnWcMLN30VM2aTPbLMrSySnY
	62ZTVtNVvPZR5NWVoAJ2eSxTdNtxmOmwfSnTcEyfQUq+ivHjNP3YymFnNk9EJP1Li+EtvzMIyR6
	eQ3brcZyi2TJvLgWNEEd/Yck+oGzAgnkM3BH0guenpTzg6HGSXN5N1lVfpNJVUV6qz8z9BtCQa9
	PuHvnmTJNxdR2AZGfOD1GwVnUff2auVAGHz1W/zE/tRAivN+G+qvbQftUJfU0MgvugmsSJYgDDu
	6ql/bzH4qT2/TTYR++cbZQQJmIlyxZIP0esT/v1ebJyfvacgy+pBE6Ve/kMndFtw30ReZvYJEA9
	SLei/42Xm/+EbUoEA9WPnyVAALbURxK2c9kkC92pswkGUlayU8PxMNKGOlGAUKG3cBfUkxqMEht
	LQMC9s00jCfGPuTgT4PsbCb4w==
X-Received: by 2002:a05:6122:1310:b0:5c2:cffc:2c55 with SMTP id 71dfb90a1353d-5c3d8d4f5b8mr2118646e0c.0.1786002611034;
        Thu, 06 Aug 2026 00:50:11 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d050bd1csm2905711e0c.4.2026.08.06.00.50.10
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 00:50:10 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-966d70b9e1cso1123243241.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 00:50:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrWtGICCrpz+8kI9EyFn+pNVerxF9tzCpWa6rqTksqseZ1wrQcJ8xlL0mF0ToK0bw3gJ8I8aElZPg==@vger.kernel.org
X-Received: by 2002:a05:6102:5788:b0:74c:7fd8:73f5 with SMTP id
 ada2fe7eead31-760e7bec35amr3810486137.6.1786002610083; Thu, 06 Aug 2026
 00:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785941595.git.geert+renesas@glider.be> <89e6a71b35703f10e12f520af1f389b5f40f4b35.1785941595.git.geert+renesas@glider.be>
 <0124d3a3-81dc-44ce-88a2-9426c65ac46c@mailbox.org>
In-Reply-To: <0124d3a3-81dc-44ce-88a2-9426c65ac46c@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Aug 2026 09:49:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXHPjzCidCkfyF0c9fndAmAte1DuhxGZt=WY=_jxpwU+Q@mail.gmail.com>
X-Gm-Features: AUfX_mxDCMXWQzEKQw-oHDEPLKfBz2gF2hlxdZi1vAhDPfXSN6ZVQ5LCO1qQ5aA
Message-ID: <CAMuHMdXHPjzCidCkfyF0c9fndAmAte1DuhxGZt=WY=_jxpwU+Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] pmdomain: renesas: Add R-Car X5H MDLC driver
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

Thanks for your comments!

On Thu, 6 Aug 2026 at 00:38, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 8/5/26 5:20 PM, Geert Uytterhoeven wrote:
> > +DEFINE_MDLC_RESET_WRAPPER(reset)
> > +DEFINE_MDLC_RESET_WRAPPER(assert)
> > +DEFINE_MDLC_RESET_WRAPPER(deassert)
> > +DEFINE_MDLC_RESET_WRAPPER(status)
> > +
> > +static const struct reset_control_ops r8a78000_mdlc_reset_ops = {
> > +     .reset = r8a78000_mdlc_reset,
> > +     .assert = r8a78000_mdlc_assert,
> > +     .deassert = r8a78000_mdlc_deassert,
> > +     .status = r8a78000_mdlc_status,
> > +};
>
> Please keep the list sorted alphabetically.

This matches the order in which the members of struct reset_control_ops
are defined.

> > +static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
> > +                                 struct device *dev)
> > +{
> > +     struct device_node *np = dev->of_node;
> > +     struct r8a78000_mdlc_priv *priv;
> > +     struct of_phandle_args pd_spec;
> > +     const struct mod_map *map;
> > +     unsigned int id;
> > +     int ret;
> > +
> > +     ret = of_parse_phandle_with_args(np, "power-domains",
> > +                                      "#power-domain-cells", 0, &pd_spec);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (pd_spec.args_count != 2) {
> > +             of_node_put(pd_spec.np);
>
> Maybe some "goto error" fail path which does of_node_put() wouldn't hurt
> here, since the of_node_put() is duplicated in here multiple times.

I'd rather keep it like this, as of_node_put() must not be called in all
error paths.  Moreover, SCMI remapping will add more error paths,
and multiple fail* labels.

>
> > +             return -EINVAL;
> > +     }
> > +
> > +     scoped_guard(mutex, &r8a78000_mdlc_lock) {
> > +             hlist_for_each_entry(priv, &r8a78000_mdlc_list, link) {
> > +                     if (priv->np == pd_spec.np)
> > +                             break;
> > +             }
> > +     }
> > +
> > +     if (!priv) {
> > +             dev_err(dev, "%s: MDLC %pOF not found\n", __func__, pd_spec.np);
> > +             of_node_put(pd_spec.np);
> > +             return -ENODEV;
> > +     }
> > +
> > +     id = pd_spec.args[1];
> > +     of_node_put(pd_spec.np);
> > +
> > +     map = mod_map_find(priv->mod_map, id);
> > +     if (!map) {
> > +             dev_err(dev, "Unknown module 0x%x\n", id);
> > +             return -ENOENT;
> > +     }
> > +
> > +     dev_dbg(dev, "Ignoring HW module 0x%x\n", id);
> > +     return 0;
> > +}
>
> [...]
>
> > +static int r8a78000_mdlc_probe(struct platform_device *pdev)
> > +{

> > +     if (!info->base) {
> > +             dev_dbg(dev, "Unsupported MDLC instance 0x%pa\n", &res->start);
>
> return dev_err_probe() might be more appropriate here, even if that
> would be more chatty until the support for various MDLC nodes lands.

Indeed, it would be very chatty, and may confuse users, that's why
I used dev_dbg().  We can revisit that later.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
