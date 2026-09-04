Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674D50EC03
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536589; cv=none; b=Gdp+sXdCh0KtDogYX6kcjKAmm73+Ic10+lqiuezl/VU/bgA54mI7S+SWDqag0oR4+SCtE7ktPHdhmXLBkNsAWthxbHbddgGK2CPhA6Av71IeIGN/YLARm8vOXzhrbZL0p/kD0XPYL9cZYqfHkwDNN8rLHg2A1ilM4KHRV+VjPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536589; c=relaxed/simple;
	bh=4bEAll6bJapZukrKkjXZtk1Cgl7yrbg5PsFtTRWvy8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsbc47GEja6RACVMgtz9kDXVX0qLtdaEnVfy+vnn7tWQpbbrSEQIlWn0fqwzxawKGK9I3gHQ6VVKaYNbEDKKcQVJ0ENyWPRL9Q0+fx2eUfrWtuuYehszw29k0Q/ERYQo+ISH4AVkxyxFWkAVJkSpKKpspJDtgTgmfA6HEc9uTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-46ad7304688so2134324fac.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536585; x=1789141385;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hzE9a7y7ZZDe66bPxoXer0uMhuOeucoXHc9TRbP+CZA=;
        b=QyZ8wqCgugo2Q09XadrDmiOaJFsoncIki3qrTY9k/mg5jkoL47+uRbhFNb5ctdbbmA
         +lwToCWJGe5R1zyime4q8hKA5ZWHHuMRuvpKF2eoFwLAZt8FAijwkGxZV5JyuhoROnlc
         uLPIEjlGdaz2bE6VDaRk+AnAKkxGlGTFcBNqyE/cgEKC4Qjj6gYd+3+ryqwnFBpqWH1Q
         oANMjcVyX3hE7B4+pRU79kfBLsJSrolkmVh7LG8aITHmwQFem4XxqjIuj40X7FvYPYw8
         aG/wjJcDzMf/L4JBzpiAx8eP282PYcZ5/3O+Na6DXCrU6iRI6tYTvdoCTluV5M6Tcj14
         YzPA==
X-Forwarded-Encrypted: i=1; AKwUvBwTBT3kODIIt8+vULuXNnXxsYm9xZJSjp+5FkVJ0pgV+TPAdaHpygp/WlvSkFxzwXPIM60X0SH1Ww==@vger.kernel.org
X-Gm-Message-State: AFuF++kbnurK54ETubbmkEO9US69Vrg4eKz3j3AZqJ+fd8RWhV3/jTbi
	pT4Umh5/ci/Lm/4InOqthbaYbMEiEqKLczGsZlH6lGvAoWCCW3TDH5Fk9PofYZ1d
X-Gm-Gg: AYBFou1bX7oIToHuXgAwg3vROVFpjRCB1b3tOmwxAWBR9uMNE6ulQodsfSP/7EAnuyU
	soqavg6hASTEWfjD+1067ZB0G9zh+jVckXvDsTr60oKwCp4EpciqCFKF6Pz+zJdLDyzERZvBAWv
	VWm3WZqf5xuJBVxUy890/B+gP75rGU1ymAMJ5n6sTUDFZ+7OEZ7WTCgqMZZz5/dCUazqPOEfjV5
	Cd3aIaiKgUt4N0kn8iUa7jE4AzLvATUe4B+Fbw2XsA6urHfzozP5c/y3WGtV2to8PCGjEBduU+x
	O5QOsYaKFHDtzjgAxlmkP98qKMusHBErJAiMVp76bYBaO/CK4wR8MJ/SvH/ARFYx4fEdayUwRvi
	mgdvsQ/lS4Em9odcbaJM/WWFLJDlUeuhn0m0DpRQeBdEt43eTPYbbMeyMJ2cR5a+D9n0HfE+dJ3
	X9VIcX+2hDcSfFTg6cSZnKlvGltSdcXPRcX9agKNtIr3FoPM8LLrNEhBksuU19urT97EHB7DPX+
	R3YWipIQ4WoGt08sNc5EJ8nBw==
X-Received: by 2002:a05:6870:5e48:b0:470:e96b:43e5 with SMTP id 586e51a60fabf-4757d59548fmr2358080fac.17.1788536585062;
        Fri, 04 Sep 2026 08:43:05 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com. [209.85.160.50])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47554d7d787sm2298822fac.17.2026.09.04.08.43.03
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:43:03 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-46556b9e02cso895509fac.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:43:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxkycmGdHB/Y1amKWFgzPl0UTc9zzSoniO9P64IJnipgKF5KE7eegF4I4n7J2dLsabstMy0yviT7A==@vger.kernel.org
X-Received: by 2002:a05:6102:1676:b0:785:6719:abb1 with SMTP id
 ada2fe7eead31-78a2ef7b044mr2760248137.11.1788536188830; Fri, 04 Sep 2026
 08:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com> <20260821150408.73829-11-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260821150408.73829-11-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 17:36:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV3uLdyr+VOW-_eN3QMFpq9KV-O3HQsKY6GPpixeQhcKA@mail.gmail.com>
X-Gm-Features: AcwNN1Um6XH5hlFEECJFpWec4doGqp3W45Z0eEeDzho30JjiEWI3GGf_1U5A2yE
Message-ID: <CAMuHMdV3uLdyr+VOW-_eN3QMFpq9KV-O3HQsKY6GPpixeQhcKA@mail.gmail.com>
Subject: Re: [PATCH 10/10] arm64: dts: renesas: Add HiHope RZ/G2M v3.0 SoC sub
 board support
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

On Fri, 21 Aug 2026 at 17:06, Ayman Chaudhry
<ayman.chaudhry.kc@renesas.com> wrote:
> The HiHope RZ/G2M sub board sits below the HiHope RZ/G2M v3.0
> (a.k.a. R8A774A3) SoC main board.
>
> The RZ/G2M v3.0 SoC sub board is similar to the RZ/G2M v1.3 SoC sub
> board, so there are already DTSI files available in the kernel. These
> DTSI files will be included once additional support (e.g. CAN, PCIe
> and ethernet) is added for the RZ/G2M v3.0 SoC.
>
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a774a3-hihope-rzg2m-ex.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0

GPL-2.0-only OR BSD-2-Clause?

> +/*
> + * Device Tree Source for the HiHope RZ/G2M v3.0 SoC sub board
> + *
> + * Copyright (C) 2026 Renesas Electronics Corp.
> + */
> +
> +#include "r8a774a3-hihope-rzg2m.dts"
> +
> +/ {
> +       model = "HopeRun HiHope RZ/G2M v3.0 with sub board";
> +       compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2m",
> +                    "renesas,r8a774a3";

Please replace each group of 8 spaces by a TAB.

> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
