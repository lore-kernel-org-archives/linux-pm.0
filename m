Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F643C6A57
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006728; cv=none; b=ie6xBiqdBjNVQs284tE5TFrr75l4RkErq4xdbff5dJUBAMIcpPCNZGFzDh2SLTUsi0TctcZ1YvgIaHQIFY+2qvUQpr6G5omVokViJNNgv7yf4mAIiMxs4seWGKA5IPp+OjdRaSEU8A2CTOOxSFnLzxveSpsp3jOdm6Gysd1RUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006728; c=relaxed/simple;
	bh=Wp5Awetz8x1lkJd7iV42zxvDh1yQD5wNbmheE5eZ5No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/aE/zK08j4LAhW998hKvE6voRMrUadUv8KXK65gXZ7GHd1a243RcBCx66UFJQHaFTJ8lZbdaNjGtARFDpOUVLVkMWrgFsiKG0s3N13OiBhtZAi7OpFoUmPET9YuCQp+OoLaRwcdhk5sSvf53wNZS4z+dZfyS3kWhQOa0cC8tso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bf94664327so794524e0c.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 01:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786006725; x=1786611525;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y/Tg3lEpqdaiPRfyjPgi2cmAvw9BxKYOOcBoKp4sZn8=;
        b=aeW9J7FcbkxBk95OdHm3txbBpwn+M/VdttqRZBFL68uYUT0sr/njZv5G8XeM/A2GSY
         r6TdwWoIxYdhB6vt2hI6aUaV9BcyK1VVMpFGXtvueGD3FQKnNEv1jEJd4ztzHkontkIY
         i0A1tvfkltEvZdxR+mXtljIkUKmyMEzO6sZx+EAfKPm4MbTg+cY876fycu6xJGcbXzCb
         +ACTFfasenfgiX7V54JGohIvs6vMhrFijzqmE1MmmfRq9STvK0f1DdRQm59orPeY8rft
         7Cst1DDGIc+xfP4mbj/X+f2iMRpCm0Z6o43Hxlq60owsx2jLbZgQS5x0z8piAmmhkF02
         4X8Q==
X-Forwarded-Encrypted: i=1; AHgh+Roqaja3RfZfTTjXI3S+O7BxV45aD7QT2dx68AheowOp/wjzQXZhj/eh3hFR44o+Dl9vqqAcQ3f5GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpIx3SRvczmZPSfwpLcq0hSQwI5rhNkYl2Q7AM0WBLYW62n4g
	1Sem/yFSQI2ysjunCtDp4HtG69+7PVFg9/yKqLQAihwazVyZFbVs/7lbV47k53Iw
X-Gm-Gg: AR+sD13KkHXPBxfCoOy3aiNFF4AjGLfDpgYy7hOp05lEjer4FZfMjthG7lgmoGmaew2
	J8xl0IVgHziFVNe8j2IpGlAwEZBzU0BgLbqhP1cj0so9ovMW1TcOpH+tMUa36eYDDQ0UkHTxQTj
	S1HLQ3cMBsscUlmWQD/HrVpECO8FdDmBOZacRxo0xzo97X4rPU0dtWHvauib1AsTHN4SH7qXypO
	3y1+IsJ8npVjJmsqwd47FmC3fVVBmA/IrvjqogKfyLkpKTy4TdJlo+bajlNlqOx4PIq32eQTS89
	S82pJAJh2zwnV0IiljmbZ6XfYWdpdQNcOika4Xfo5pf5vBz2KHATcLyadwpRrdSOznFkW5jcwbp
	DIIk5aL+nQS89fbNXYNn6atPJPgXTyJC5V1F60Q0LIfjmeIR7D2Q/zuEEwQu6kwQYqSthu/5N7L
	rhcMPbv9RWwzDw4VNxbn7ViG8+x0iSEmDtGAWzu3DTi5eoSZlypw8KtbICUfkboKG16UfTGZ3Z2
	bloRqeZUjXqwF++DRE9W2thTVU33NwDj9wRfjxA
X-Received: by 2002:a05:6102:5045:b0:740:2717:a2d5 with SMTP id ada2fe7eead31-760e7df2d1bmr3106844137.6.1786006725323;
        Thu, 06 Aug 2026 01:58:45 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d050c87esm2798643e0c.3.2026.08.06.01.58.44
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 01:58:45 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c2dbaf828eso671854e0c.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 01:58:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpJGj9X1wk/VcbvZOn4wRzTjP0GB7W+G3GUwF8IFBYxgYRdVednQ8w+3lCPZWpne8sr2T33snKONQ==@vger.kernel.org
X-Received: by 2002:a05:6102:374e:b0:739:626d:4473 with SMTP id
 ada2fe7eead31-760e3698c49mr3173857137.0.1786006724650; Thu, 06 Aug 2026
 01:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785941595.git.geert+renesas@glider.be> <89e6a71b35703f10e12f520af1f389b5f40f4b35.1785941595.git.geert+renesas@glider.be>
 <7c30baacac8c75037f32c0ac3099a6107cbec38b.camel@pengutronix.de>
In-Reply-To: <7c30baacac8c75037f32c0ac3099a6107cbec38b.camel@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Aug 2026 10:58:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX3mUVq5HAOcoLxf8_=ALKe_j-0uSTTORA_KyiOq1Bgiw@mail.gmail.com>
X-Gm-Features: AUfX_mwUZKZac7nMaa-VOsxeMPj2DizVJUU-sXiHc_DXR1wX8yJ0IgF-oPKqM3c
Message-ID: <CAMuHMdX3mUVq5HAOcoLxf8_=ALKe_j-0uSTTORA_KyiOq1Bgiw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] pmdomain: renesas: Add R-Car X5H MDLC driver
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Philipp,

On Thu, 6 Aug 2026 at 10:13, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Mi, 2026-08-05 at 17:20 +0200, Geert Uytterhoeven wrote:
> > Add a minimal Module Controller driver for the R-Car X5H (R8A78000) SoC.
> > For now this just supports the always-on power domains, and dummy module
> > clocks and resets for the serial console (which is enabled by the boot
> > loader).
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v3:
> >   - Replace <linux/mod_devicetable.h> by more specific
> >     <linux/device-id/of.h> in v7.2-rc2,
> >   - Add a comment to document only always-on domains are supported,
> >   - Consistently use /* sentinel */ for zero sentinels,
> >   - Drop trailing commas from sentinels,
> >
> > v2:
> >   - Spin off from "pmdomain: renesas: Add R-Car X5H MDLC SCMI remapping
> >     driver",
> >   - Add default support not using SCMI,
> >   - Drop all SCMI remapping support,
> >   - Document use of -1 as a sentinel,
> >   - Rename struct r8a78000_mdlc_info to mdlc_info,
> >   - Print HW IDs in hexadecimal,
> >   - Reduce log level for unsupported MDLC instances from warn to dbg,
> > ---
> >  drivers/pmdomain/renesas/Kconfig         |   4 +
> >  drivers/pmdomain/renesas/Makefile        |   1 +
> >  drivers/pmdomain/renesas/r8a78000-mdlc.c | 330 +++++++++++++++++++++++
> >  drivers/soc/renesas/Kconfig              |   1 +
> >  4 files changed, 336 insertions(+)
> >  create mode 100644 drivers/pmdomain/renesas/r8a78000-mdlc.c
> >
> > diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> > new file mode 100644
> > index 0000000000000000..5c8acead7cff9bdd
> > --- /dev/null
> > +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> > @@ -0,0 +1,330 @@
> [...]
> > +#define DEFINE_MDLC_RESET_WRAPPER(op)                                            \
> > +     static int r8a78000_mdlc_ ## op(struct reset_controller_dev *rcdev, \
> > +                                     unsigned long id)                   \
> > +     {                                                                   \
> > +             struct r8a78000_mdlc_priv *priv = rcdev_to_priv(rcdev);     \
> > +                                                                         \
> > +             dev_dbg(priv->dev, "%s: Ignoring\n", __func__);             \
> > +             return 0;                                                   \
> > +     }
> > +
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
>
> Are .reset and .status needed by any consumers?
> I'd leave them -ENOTSUPP otherwise.

.reset is used by a variety of R-Car drivers.
.status is used by the R-Car I2C and PCIe drivers.

So both will be used later.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
