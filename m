Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67D3E9F96
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590601; cv=none; b=J6Z3uca8cMQD41kDoPSUyFbmxgAn5smm5i+IMCJVr1v9iLM5rjkICyMV52zcrNkJ3yNF5AtqApD+CQRBqPr+BEdhRi4lu6YBk1XEnr4/EDpMJKWNXhBCy0C/tvf1iR8Hh4Lm56LL8Dtl3Fej9lj4d+O7maZXIKMNRz2FU0NrFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590601; c=relaxed/simple;
	bh=XyB0QJBI/ArxNnxn06+fFpma6hNeLNHAjblX5FcA1C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bc7ZkyarQ0pCkSN/4Tfxl4+D36EFYW5bIAOkk+8NbrI7nnWQvDq8Bo16mKGYwmk+1Zg5ICK1/PwPSg/AGUCqPhpCfHyiwoYpFLRGXkGiaFbzRVxyQHDo3VdNBSgpr4JXiWt5t4aea0n67KzDNQysg3ZgczlQIcO6CfbOoqRd+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-96944741eaeso556080241.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 02:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590594; x=1784195394;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JBx1Lwl28bs84XHLARf2PZgvr/qdRO+0Qc3qcd6uTMQ=;
        b=OiI0I9hfLm1aHAh1t4OvGKT0SkUBhDzh4iziiXWR0fmMxh2Tx0LLvnU/7u/Nffodqj
         l478fcGmJHkKv8nykZbxgB8gJjqSzT8eNpBe2eIv/PFG4KAZYZoE3QSTXnjyptP260Sh
         ZAdSBpqBx1MW5KxBXIyu9bhu8BWJoMPQn24dt9JW8uWihC5Tyv4oQ81S1yC9oIVGgb89
         0pjfDrB97drgWufH2/CB7T3TYUpLWpQW3ebXqJGMY3RMnCX45DC7/far0Q90hKzaql2Z
         NrSVDKbt9t7PRuqsT/s9i7yyCabebqlbdMuCFIhHDsPIfnZbeJcIq8toPYU2WSiaIeKp
         xchw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4s/HoGmHJB3bCSLMrRHh7RG0fx9EfJIrHAnbxTbRz5JM/J+pIjs4uyhyPAVr6lQqv192eOkZeWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqaN2LK96xC/x8UGahJO0O4fJzt42QyuezoeK1v+/QsHdfDrak
	Z8G3nNJfMX9tA/T0GMLdiTrVHT0jNf3XeL4hqkobHUq5NMnCRxz4QpyN8NFVFLy8ICI=
X-Gm-Gg: AfdE7cla9Lezp3HEknAkDWRRD9skL1STvjt0CgwlXHomR+vFWTtvh4ye7HTRtZ+GStd
	dUut3iIxOYsLuEvRuRBRuhQFY3LIHKbjOmprh9CXITz4nhgxjMl7TT/rJRnpvrpKRzB6pxHaaGi
	zUijL+FGYF37JojmDp+A3i+jonqb80Mh7YVYPzByKOO9qd5MQZo3d4r4uklcoW6fIjIQm7jgSxB
	V3vJD6CCI5jqQul6T5x6kGcMEj8OJp+Jnb4WLIZ8ev73zDz5ZrVvH6AJ3Lo+JG5rpaX5eqYyHXI
	p4orUg7SlNAr0/UY/p0QGID3/IZOW+2cAgCS5FFPIIuYtwgFYLYPZNl9Mo6xw6z4dBziYpISOGY
	2M/ZTrOLKHTd+hEF+NJ/PbFhlYBfIZx13bcc+bipl0TsA2R3r+B3/weyp2iZd/V1dUX+xXquk+l
	l+8lyeDx6WM2UEiuntSCcDVUHEywa/aAyM5oauPnCjISL7ICwtXehPAxHl8Gvu
X-Received: by 2002:a05:6102:644e:b0:608:9a34:c8ea with SMTP id ada2fe7eead31-744dff405bdmr3423923137.10.1783590594453;
        Thu, 09 Jul 2026 02:49:54 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed2c94ba7sm2821742241.4.2026.07.09.02.49.52
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:49:53 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-738f3419eedso448695137.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 02:49:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RofEXe9rB6/gfS/4PuIVTIewE/HD+MnNveDo2Aav6G19bbAVTQuf+w4UxGlv9PidqT3SPQ0GXiwbg==@vger.kernel.org
X-Received: by 2002:a05:6102:c54:b0:740:22ba:8a4e with SMTP id
 ada2fe7eead31-744dfed12b0mr3967593137.6.1783590592726; Thu, 09 Jul 2026
 02:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505142.git.geert+renesas@glider.be> <50f5804f00c55cd60604d00da1bf1f1dc912ba8d.1783505142.git.geert+renesas@glider.be>
 <80a31a21-9876-48a7-a9ed-baac4f87bc11@mailbox.org>
In-Reply-To: <80a31a21-9876-48a7-a9ed-baac4f87bc11@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 11:49:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+nHe9kWbBv1k=b-6iixBBJbqeNY-Vq+qbT+wD2g6jUQ@mail.gmail.com>
X-Gm-Features: AUfX_mz8czD0BjSvqmftRZ_pTGys7GO-j5nSESdQS6eSA4Z7r12bLxvVFtqIaAw
Message-ID: <CAMuHMdV+nHe9kWbBv1k=b-6iixBBJbqeNY-Vq+qbT+wD2g6jUQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] clk: renesas: Add R-Car X5H CPG driver
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Wed, 8 Jul 2026 at 23:55, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 7/8/26 12:15 PM, Geert Uytterhoeven wrote:
> > +static int register_fixed_clks(struct r8a78000_cpg_priv *priv)
> > +{
> > +     struct device *dev = priv->dev;
> > +     unsigned long rate;
> > +     struct clk_hw *hw;
> > +     const char *name;
> > +
> > +     for (unsigned int i = 0; i < ARRAY_SIZE(fixed_clk_rates); i++) {
> > +             rate = fixed_clk_rates[i];
> > +             name = devm_kasprintf(dev, GFP_KERNEL, "cpg-%lu", rate);
> > +             if (!name)
> > +                     return -ENOMEM;
> > +
> > +             hw = clk_hw_register_fixed_rate(dev, name, NULL, 0, rate);
>
> Would it be viable to use devm_clk_hw_register_fixed_rate() here ?

Yes, I think so; thanks!

> > +             if (IS_ERR(hw)) {
> > +                     while (i-- > 0)
> > +                             clk_hw_unregister_fixed_rate(priv->fixed_hws[i]);
> > +                     return PTR_ERR(hw);
> > +             }
> > +
> > +             priv->fixed_hws[i] = hw;
> > +     }
> > +
> > +     return devm_add_action_or_reset(dev, unregister_fixed_clks, priv);

And then this, and unregister_fixed_clks() can go, and
r8a78000_cpg_priv.fixed_hws[] is no longer needed after probe.

> > +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
