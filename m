Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B4934D4DE
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716950; cv=none; b=n4a3SVpqyCrp0W8HWzccbVmwAadcjYMzfupzDzvaM52Z4BrEsUSh7wO3zaIoKsdkjYzHg7SqRZ2seHjgsuFA6qilSdxN7UeAcFG3U4KIwqgXKaydcNiDRLGXa9nATR7XiKQ7mGxmtx5W33jAuEJxJ2b7CcdKG25aB2nKB/fd9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716950; c=relaxed/simple;
	bh=cHVPOWKKfhZVIB7cWuXyuW2OrGOIzBYJeXQE3IvAcLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihsoAZUdSbwL8bwknPEKHljgwjIwcuG0JRTDtqqJeSooDR1MHgRzmLR9jPcrVD2euNb3guXMRPSY9omUZd6aDf205fRsyf2E4C80AZ5+0wFjCbNoxrvACuk3xD/lXsXajDPDvWHi/F2qR5wVIF6WJRyqLP1uNWgbxnr5ivhd5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e4d9197so258297e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 00:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789716935; x=1790321735;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0WtucTJYH5u+SsiRL/3DRg9hQeKGo+JDwDdtR43iO30=;
        b=wUrUceFw3PoUEHj+w5cqO8fq67p0lNqkVbliKT1Fa3VgdgGQRUf328IcQaPx1I0QTV
         ixSgpKebyHDBrCvz2fmBwGkoLH14gsanbw+qi8YzGpu+vBfwbqhiDfNItApyWeU03Dva
         mY7k31T+eUfDlyRYoXVZdA0Chn/6i0gd3hcZIoymtq9zCnfn1PXX4ViNLu9yGJMClEtj
         PM7/E5+hFCb7LXqcZpNUDm+9qVJqKHQMDrUUlqt7swCH14F2ifBfLD4sSwAQc+cDqtXd
         +LZdJnm6G7mGXn2qNq73POeSjyEBttRxjFKBtfQYUdJiqZ+NagQF4GNGsQd4Z//aO4PL
         ghMw==
X-Forwarded-Encrypted: i=1; AKwUvBxM3W9FjwCswQmbs1ZReMkkydDg6mqOhFAnaF5UhJt2HEpJHZ4q1Nh1S3rbomMdBw9AqIfqVuATwA==@vger.kernel.org
X-Gm-Message-State: AFuF++lLX65a9Bye6auyaZucQFnlkpmrfAQGKOvqUiJLF6QgjGnSGMTh
	hwBwu5PCf9kOSf7LSGvZZksDN33DugY5JDNAolQAQWjjLHy9D6ThQEtUNum84z8J
X-Gm-Gg: AYBFou2NDT91iH0jCtfq9T3X67t4AyE+/abdUuef8j658P67hq3ytXE2i4vkesVQPVv
	P+t+lVyLZETNat/B6+HXwCphla5A2O++kjEdQ+LopJGYbYkmcBZU6IDPglLc+sZCTu8usbYXKN3
	BzfSJTv3x2O/8tQygTq7vNpwf/BXpRZP5FzdjILAhReR0N7VuLn0VlVabPO9/5eWGuaoZGH6z5f
	09uU/Yu7C1SL6viz/L1LPQbEXGbb9VNmLs/ese5TxXDXEhGccRWFf87/JK4NHnRa5d/YV0VIKPD
	AnbwyNj87evcRmYO2hOMGh1vn6rX+qZQD8slJ96mJaca7t2we9SzY6Yy9raQXQkJn9m5pBS098M
	sQ0cYUjYzsqPXSp826q+qkgkne6Z2QlqfkgP2ckG31qv+Lrs8mVD5Bf7rbZMfS+y0bm52tnXap8
	+iFcw09/ifnXCmglrwELbI4uB/xPruQpvEAp1qIkCDLTweadp8evzhWOyjNfbpVvd5JCOjwbt3C
	vqLx7jp1THHjlmnY1l7aCQTRkLRwBlR0YR1yw==
X-Received: by 2002:a05:6122:8f8b:b0:5c9:a60c:2732 with SMTP id 71dfb90a1353d-5c9b58e9e3dmr535664e0c.10.1789716935582;
        Fri, 18 Sep 2026 00:35:35 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9b82ff09bsm824843e0c.6.2026.09.18.00.35.32
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 00:35:33 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e97e2c7d4so208199241.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 00:35:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxSaWCAOoXhXHYnUAH0erPbYm/wHmpY86A0PEJHhON0vbWtoQpB5kbOQJKaON+GrjvOyyX526hFfw==@vger.kernel.org
X-Received: by 2002:a05:6102:91c:b0:7a3:2e52:1163 with SMTP id
 ada2fe7eead31-7a55da9b0damr516237137.26.1789716931735; Fri, 18 Sep 2026
 00:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-2-4c72d4e086dd@ideasonboard.com> <20260918011156.GB145152@killaraus.ideasonboard.com>
In-Reply-To: <20260918011156.GB145152@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 18 Sep 2026 09:35:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUWwCLiQASDhr3yY6XFY1704W3tAWEPgYw77evrK9ECRg@mail.gmail.com>
X-Gm-Features: AcwNN1Uhv0ZzlOO0pTf4pD3p_OGSBmogWfpHa_8PkhuJrVnrMv3c15ALo4pMZkM
Message-ID: <CAMuHMdUWwCLiQASDhr3yY6XFY1704W3tAWEPgYw77evrK9ECRg@mail.gmail.com>
Subject: Re: [PATCH 02/10] clk: renesas: r8a78000: Add clock for FCPV and VSP
 for SCP FW SDKv4.36
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Paul Elder <paul.elder+renesas@ideasonboard.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

On Fri, 18 Sept 2026 at 03:12, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thu, Sep 17, 2026 at 09:04:41PM +0900, Paul Elder wrote:
> > Add clocks for the FCPV{B,I,D} and VSP{B,I}. They each have one clock
> > from an option of two: a 1066MHz and a quarter-divided 266MHz. As we
> > already have support for the 266MHz one, add just those for now.
> >
> > Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> > ---
> >  drivers/clk/renesas/r8a78000-cpg.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
> > index b820d09e1a195068debe8a6eea7a01c534a97b23..17792ff6ab8ae2f7eb5c8f7e3d581b43177e195d 100644
> > --- a/drivers/clk/renesas/r8a78000-cpg.c
> > +++ b/drivers/clk/renesas/r8a78000-cpg.c
> > @@ -326,6 +326,8 @@ static const struct clk_map_in r8a78000_cpg_fw_4_31_0[] = {
> >       { R8A78000_CPG_SGASYNCD16_PERW_BUS,     FIXED_CLK(66M) },
> >       { R8A78000_CPG_S0D4_PERE_MAIN,          FIXED_CLK(200M) },
> >       { R8A78000_CPG_MSOCK_PERW_BUS,          1667 },
> > +     { R8A78000_CPG_SGD4_VIO_DP_TX,          FIXED_CLK(266M)},
> > +     { R8A78000_CPG_SGD4_VIO_DP_OTHER,       FIXED_CLK(266M)},
>
> Same comment as for 01/10. I think the two patches can be squashed
> together actually (unless Geert disagrees).

DT binding definitions are shared by driver and DT sources.
Please keep them separate, so I can apply them to the shared
renesas-r8a78000-dt-binding-defs branch.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
