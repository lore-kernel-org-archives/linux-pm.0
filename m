Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4364F30F4
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534801; cv=none; b=JMTaoKq55xupOksSdJqQLwtNMLDbNqFQ9+rHoQFlo2zW5aLH8Hob+kNz5YknhY99yF0g9szbKYFIhWneHdPNZ/Ep6fFEKvpP0bha7w1S4G4iwZ4kEoGbwu65HzW1/OcoGhJy6mbOeXVXfFYaobVqbveJo//MdIb+3cZ271LtWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534801; c=relaxed/simple;
	bh=JKMK2CnzL8ftNzdqEBL6ZbY15a40r3hgTJf4pBsjvSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9c6q/oYgfs2sIHTxxk1JigfRVnJiFuqlAd1vwWHU5jbUrVQkK9S6jxCuV08syW9PHwNF8HLalkgm4DOqZOBdkfw/iUrXCmxGbXtk+1IYdUd6A7oUMPSE0/DTuE3uyzwtMQR7+49nUFflNfWPpKF0iSlXxI3AtiPiUeNY/6mJ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-75e2905c09aso267350137.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534798; x=1789139598;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EH26aGan0gGqVYE0IjLU+OD6hNNld1CIjczwNKp7Quo=;
        b=Dc3wHIc2Wc235r56/W92m3FOgWvkV/zSeLBr4TA2TMcxC1TbZTF6iPu3LZjGqaVJTx
         4jKhXbPy646KcmNMiFEGoAma/jwBYcyRZYj/UdO2wCb1F8P2pE9xu2EW3UfgyICsCEnd
         ZH/F7NriTdtCaK9QJnB5QErwnartJRZaDzay6lZvbxApxcuNXzv+8luZxpXP8koNCFhp
         QxCB/vPgbLRrObq2M69T3AWPZ/Vj1SOYONSWw7zF1aEOeIqqpAhY1sSEo/rfrZVuo5x8
         iqYCheRDjF+C6qc2/P0osm2jz6EOvwtifLgGCw3ymzW0GCNiyco9l3yE4tUQaJrvVmXL
         0Lww==
X-Forwarded-Encrypted: i=1; AKwUvByV8FOUEBrw+u11B2ayIrOOQ/HCSnnMn+wePESILQAhEBt+3kdJ5B7U/DFDukhTUQYlK0lza3XfwA==@vger.kernel.org
X-Gm-Message-State: AFuF++ktx8PICq08VzCVImJ7TqcVcyYtlDlh4psS3ClHozEtVUH1eZQK
	6h+DG7z1OdlohH3/ct3QBI0o73Ssg6+TUCnp9Q8F/kruZXLUnmc38JqufPwINPwM
X-Gm-Gg: AYBFou36gvIgtKqa7g8FwsogtAIGefF3x4FQQwQgKLpLADw7+7mk+zbiRBz7tmpcD9J
	LgOrEVOQc73lb4fC2b0VYwgJdA1YRqEIJsjxDPEG6aVDhKu8i2Xg6OKV8I7DYekoXll39xgivgG
	qeu31gmjUG7ECoCg5D7TKIV3q4WsD9Lc/SvpDLA0Il9wjtEuGeYX34i9rFh2EFFovPtU63tOLyF
	gn0c/jvYQ4h35nZAvCfw2z17VZAyG8mZoCe84+d0WwF0E7ukszgvNBYTHJJsx/92KB71GYK1CFA
	Yw2lDfo/a8PVUwZ1l78Kibcnxc26x2LiBNzAvLGxmXiH6HMeCWZpsm05CXNew+l0jDLszZxlEr8
	Qz60Uea3JFADiqIzM6DUk/bty2LQfB/a3u9iRV3ADcsPDUzVPCbnO/vmwcIy5SCpxQdzSWXJDM2
	Lmlio5eGWrXacTPgyYBDkg0MSFayf16zRe9M+/rrXY/wtepHrwweirXAo6gPiKTdtutK+pIFDeO
	75soOq9JtSJKebuqxzYP60+sXMGyg==
X-Received: by 2002:a05:6102:508a:b0:779:dc0d:2b2d with SMTP id ada2fe7eead31-78a4a917628mr1862404137.8.1788534798530;
        Fri, 04 Sep 2026 08:13:18 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ed1f14asm1772607241.3.2026.09.04.08.13.16
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:13:17 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5c7afda4515so695192e0c.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:13:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxIT/7kcUAMFa4qMyRJa1jncZbfEqCXvAQTlRs6UOu18vS4o76QW+Zlp8FXET9uLGtO//vmcO9RDw==@vger.kernel.org
X-Received: by 2002:a05:6102:2b9c:b0:784:b9ec:913f with SMTP id
 ada2fe7eead31-78a4a6c8e9cmr2072720137.5.1788534796061; Fri, 04 Sep 2026
 08:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com> <20260821150408.73829-7-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260821150408.73829-7-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 17:13:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOLRH5CWwUBkb6odaX=4t6eDnd4onrkgGfvwgPc37i_w@mail.gmail.com>
X-Gm-Features: AcwNN1VLaUGS5m2MWtdAilN8Kk2snIGRLTUTYNqUMsLJBTkMdKQbkgJo-6rNerQ
Message-ID: <CAMuHMdWOLRH5CWwUBkb6odaX=4t6eDnd4onrkgGfvwgPc37i_w@mail.gmail.com>
Subject: Re: [PATCH 06/10] dt-bindings: clock: Add r8a774a3 CPG Core Clock definitions
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

Hi Ayman,

On Fri, 21 Aug 2026 at 17:05, Ayman Chaudhry
<ayman.chaudhry.kc@renesas.com> wrote:
> Add all the Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC Clock Pulse
> Generator Core Clock Outputs, as listed in Table 11.3 ("List of Clocks
> [RZ/G2M V1.3, RZ/G2M V3.0]") of the RZ/G2 Hardware User's Manual.
>
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/include/dt-bindings/clock/r8a774a3-cpg-mssr.h

Missing "renesas," vendor prefix.

> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2026 Renesas Electronics Corp.
> + */
> +#ifndef __DT_BINDINGS_CLOCK_R8A774A3_CPG_MSSR_H__
> +#define __DT_BINDINGS_CLOCK_R8A774A3_CPG_MSSR_H__

Missing "RENESAS_" vendor prefix.

For the contents:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
