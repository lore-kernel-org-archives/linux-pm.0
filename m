Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237333B71BD
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535781; cv=none; b=m0UAypnYYDnJwjjD2bR4ub0fZGhI3k8YL3fpG6hrh5Adrm1eCXeVFMaAzsRbHtqIgfOX2LiriEktP76XyT6zpeZwByJsPF8ijNQ5Xf0r+6LfMZhmL0Ps9HrK6BN09vNXCOmVFg5e+HIukcMzv/GqG2LHX0XwgNwW/cryhXvsbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535781; c=relaxed/simple;
	bh=xuRqAUdvHsG4BxcDdfuXSf+SI6WrEN2MF8ZgZw7jyWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ge87ALcdunpGmKp8TKAJ1LMhpyzVvnpCL5Jju5d9Huk1F1Xzrn5H8DJlS+kHl/NVivGxd85Y2TX3uoE0TuHYLz9n4hLslB7C2Y1YsedE/bz59uAVkgokvxBbKrhBfo6hyjpdi1EH5SHUaPY/RId0Ptb2LuyoQlOsgdiB7ojZC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bfc54558d5so1584908e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535778; x=1789140578;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qKx60bz5SuKi9YOnfZ7Xh4JH5NN7Tn78TsaIHZikv3k=;
        b=DAgcWzAj6ET0WX3aOrae6+bHQTMh1XYmtbh5p/t2fwc0rufv3J7/sI849YNNDyS/zE
         L8dUsa6SoQgoDb5Sb7uWq2HU4MIecJCE93d0QqJRoPuqOyAmwwuTqw+d8ZotIzZ2sY5L
         7elVV6S5JWc20FMazNfWOEvjriRZPUSyoGdeyDpbreuWsyNyiPhaNDhjRLkykmhGbUpv
         6QNkiutosjuHIGy3WUT4u/Rtl5+0f5LCqZnZQMxc09y734honVWbhrFqN988+KKs9Lh/
         nYpPBKRJTiqwyCuhveYewHZJsM5XR8Rr6y9gFej2GRqxJUUicMPrW/Ld3ouFlt0FhdfJ
         +wnQ==
X-Forwarded-Encrypted: i=1; AKwUvByJtmgGOyw9e2q5zGNHGmpcKFjz2yol7auLqg6KFlIdDvAF4kZ8dGZOYpVNUX5SDa2OTjV/4vn8eA==@vger.kernel.org
X-Gm-Message-State: AFuF++nOhWT2cu9ucC2AvcIBqqoc1EGV3zp2O4Ii6QkAJpsVDKyxDrUD
	O7BTG3QkI6ou2eXHukvgJZ9dDUwJz7lmLe3A1U3NQ1W6sZ42ZgvI/941FojOivqM
X-Gm-Gg: AYBFou0e1z2I7o/WG4nhc+KMLZEUmMqbc7GtWZKozb5Ax0AOLScwITPwzqSIcSgQKbP
	iJNvrf12FMB9kO0TmOCqFWdbsvfHsCP3uAHAMpRYl6eyOEZsvdqW6pdVxSXYJ/R5eWr888UrQ2e
	DCMe8OF0pB8sC5m1s34Kkc6WGoKqfKQQspE9EMgHNnyqIJ24uPQZmhMnfvnvYJBl0SbSKZSYMNB
	YB3NsU87WdlQChkDx2rDp1v/MJv8vUkktC+NleGEkiKO0j3MUdBjXS+8hZw/gs1aIYVW5JRvWSz
	YWuNn/VZ2RfPyu0RAJ9pZoVc25W1tZvr1vZgZ97aJLF7WAj6HzHYPU7SxigoIgxJ1Oo4vSqiCzn
	+1p10LY4uGwZ4KyA8uNZVa6qJXoX16ErYK7toT3CBdYMWxRlI1li0s+Ru/Yk3j49OSz23372zjo
	wlIjffV7rVWpis1B1GOd3pqwnynstU/zTLUHBlbWllf6UFeg30G7/3JnHOQVbCm3KKgviOv/XtA
	v1D4dvFsfI3oBQADV2ZRJe5CECQ+lywVjMi
X-Received: by 2002:ac5:c004:0:10b0:5c7:ea14:4fe7 with SMTP id 71dfb90a1353d-5c7ea1450cfmr1753877e0c.9.1788535777572;
        Fri, 04 Sep 2026 08:29:37 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec3b36cbsm2342737e0c.17.2026.09.04.08.29.35
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:29:36 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-78a338fe106so1714673137.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:29:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwAVTrEbCKCD50truGfk02TC8zrVYFSwDnLi6GKEw/rXF2nkJrF88phQMswP3ueQq0ct2iSshDhEA==@vger.kernel.org
X-Received: by 2002:a67:f906:0:b0:744:d517:b0b0 with SMTP id
 ada2fe7eead31-78a2ef8049fmr2629622137.10.1788535775319; Fri, 04 Sep 2026
 08:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com> <20260821150408.73829-9-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260821150408.73829-9-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 17:29:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWn3BaY3EHeThFo34Z=69OaZb0FQ7Z7Ui9MczDGS4nBGg@mail.gmail.com>
X-Gm-Features: AcwNN1ViLT-nOz1SKiDYeBMSJtbLrC_K6YnJyCHi1MudTORPs1tGe-hfANcJPSI
Message-ID: <CAMuHMdWn3BaY3EHeThFo34Z=69OaZb0FQ7Z7Ui9MczDGS4nBGg@mail.gmail.com>
Subject: Re: [PATCH 08/10] arm64: dts: renesas: Add initial SoC DTSI for
 RZ/G2M v3.0
To: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Aug 2026 at 17:06, Ayman Chaudhry
<ayman.chaudhry.kc@renesas.com> wrote:
> Add initial Device Tree Source Include (DTSI) file for the Renesas
> RZ/G2M v3.0 (a.k.a. R8A774A3) SoC with basic support.
>
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a774a3.dtsi
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0

Any change we can get "GPL-2.0-only OR BSD-2-Clause"?

> +       soc {
> +               compatible = "simple-bus";
> +               bootph-all;
> +
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               cpg: clock-controller@e6150000 {
> +                       compatible = "renesas,r8a774a3-cpg-mssr";
> +                       reg = <0 0xe6150000 0 0x0bb0>;

No need for odd sizes: 0x1000.

> +                       clocks = <&extal_clk>, <&extalr_clk>;
> +                       clock-names = "extal", "extalr";
> +                       #clock-cells = <2>;
> +                       #power-domain-cells = <0>;
> +                       #reset-cells = <1>;
> +                       bootph-all;
> +               };
> +
> +               rst: reset-controller@e6160000 {
> +                       compatible = "renesas,r8a774a3-rst";
> +                       reg = <0 0xe6160000 0 0x018c>;

0x200

> +                       bootph-all;
> +               };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
