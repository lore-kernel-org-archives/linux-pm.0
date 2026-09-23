Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D5486E70
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159642; cv=none; b=ncXLhPzju2Gc56qLTbnuuIgQUfRODXocV9vNy1YqT1axYvTFxTAURCj2TK57GlRVCVyDp9i7e1jOmScfCEHrvgezsWukb7ZA44caEeP2Gf+7OvYQZhtF5W5C9GfBkwDi8lE5yvpoecgG+VJ9NPpoI/6HNdS4Tq0LRuUO27/ISaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159642; c=relaxed/simple;
	bh=6QiT+5Eti1IhGEvRyNE2dwG7QghpDhUduh0GYW+kW4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/oAvYUbTSUCLQKEpw2DXPSsQytgUOno+2wzbHM2911Bj6X5r0hJedicy1i/k2CgEu2bFGdwbpiWow9CS9pLuQyhixJse8Rfy0y4Gy65nXFU7NvoeJHHlhFs3Dgm6DhgpwuWFJXJFXjJYK1q8kqenUblSMdO9D+/5tO/4eZk6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c7b4ed2so457224241.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 03:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790159629; x=1790764429;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YiOls8D0cbeW0kl5ScyFGGWv5xl1CQ8uKTuoQSqtSKM=;
        b=QDesZZntka4RchGlqTCOAeJRNlfY5Od0fXo6utGulL193JGCgV5KkLoNQhm5PFJLqy
         Ae8CY5bsZjGi2Mup1HaG281Npib4FAfeUCKsS4y9PH54Vsc2qXZfXUesrGxNqUYPtFrx
         AFmmt5ROp/ROWh6Xnmeb5EW/MnuG8YGcLjf0OWa4wtxDKUAO8pHlmQ+zLRIlmyh07Kpa
         EL1sfohcY/jbuAwBt5U+dHikJsrRCMEgFz6VShfqW6gIKc0zSHsF/Jg2UjERbYRu8ATD
         tBFM4W4s14rJYm/37j+KNO+G1avJtBpvwDJMGCVQhTZKpNXhqS1J6wNLrkNBqCqNeQh7
         F14A==
X-Forwarded-Encrypted: i=1; AKwUvBzI+aj/1m2G0H+YFCu13ahVLNyHfgK6lrH9VzZKG1GlLrE3W+mmnZKjL3xo6B0TOMUzf76xzTlj7w==@vger.kernel.org
X-Gm-Message-State: AFuF++nSawuvswiKGxEa2vnkz7p7okk2Uj6gJ/9wmt5Y9wQ5/qb9k5UM
	TtMEwUDg1AUs/m7/NFi38XH5t9bPPnwmCAoH4GxeR6Bv0I8Sr69cff/oafz96v3fZVo=
X-Gm-Gg: AYBFou1ItEXxP+HaCfeEAXjPM7g/82Nm/V6v5nUOjMqJOK5FRIWOlTEV0h/uTGH5vEa
	fv9XyeX0uR+22yRCzzRVFePkyiiSIkJfzkrLdhwO4SWHNoNCFBZXOf9rgLrEG0f3JYz9k2FXAfn
	wwqWUhrZfeHOq5n5GQSqkSr+Z9jDKm4jE+QNzt0yYFkbFmXxVZOSE758+MQadx+VLsIHfuMs0YC
	BsT4VF8Php1dP04yOepCmjejg/jrSQBy+h2Ix8iZcOACmrbUD0LfeY4v1T/Rgj8OaTi69B6FzI3
	NYvYFuq/B5onyevResRtA5mpNMcKiv84e0fkB9BeyDoa57ku/Yh8CXLIzWUWvlww7QRbPyaihKg
	RbeiwqCu2y1vaEix0VgEE+CRzH0rgj+mYxgjlRAo4giA1jQrEVvBceUg+iiOWHkBptW4SVuqXfm
	fvoDg9SfzsaAe9xq/xSaHLVRSDxhljO2N5I1to0sNpOdvKm2B+0ODe1cWP/wovmLtF3mYO6meF0
	Vt7UkdS6xlPnNdqAFrLazLMSM1tYUFk71un0npzU/237EYTD67YC1QArw==
X-Received: by 2002:a05:6102:292c:b0:7a2:2068:6e37 with SMTP id ada2fe7eead31-7ac1bb2edaamr2010257137.15.1790159629052;
        Wed, 23 Sep 2026 03:33:49 -0700 (PDT)
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com. [74.125.227.12])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf566d033sm2950256137.5.2026.09.23.03.33.47
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 03:33:48 -0700 (PDT)
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-7856441f7dcso329530137.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 03:33:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz+V/WJsGIRVGoVfKv1gNPUPdOPRjJh16zU1EfV8Aq6UlQHtKTEFd2V10SrSvn81lFcNjMz5JAcsg==@vger.kernel.org
X-Received: by 2002:a05:6102:3712:b0:7a1:f7e2:aae1 with SMTP id
 ada2fe7eead31-7ac1d0ca801mr2003132137.19.1790159627332; Wed, 23 Sep 2026
 03:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921134432.50338-1-ayman.chaudhry.kc@renesas.com> <20260921134432.50338-4-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260921134432.50338-4-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Sep 2026 12:33:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVkh_qpJKqD7N=njG+35gS+rE7cFfWQ-kS3aRoTByxH_Q@mail.gmail.com>
X-Gm-Features: AclHuK_hGN_yWlJ6BENm_qv3b3xlhGSBd5j_07ozn_vS55vMXA_7UHHfcE0Hj3o
Message-ID: <CAMuHMdVkh_qpJKqD7N=njG+35gS+rE7cFfWQ-kS3aRoTByxH_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] pmdomain: renesas: rcar-sys: Add r8a774a3 support
To: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sept 2026 at 15:45, Ayman Chaudhry
<ayman.chaudhry.kc@renesas.com> wrote:
> Add support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC power areas
> to the R-Car SYSC driver. The RZ/G2M v3.0 SYSC is similar to the RZ/G2M
> v1.3 SYSC, however it lacks the A2VC0 power area.
>
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v1->v2:
> - Added space before closing brace for `ca57-cpu1` area
> - Updated include path to SYSC dt-bindings
> - Added Reviewed-by tag

As this has a hard dependency on "[PATCH v2 2/9] dt-bindings: power:
Add r8a774a3 SYSC power domain definitions", I will provide a shared
branch with the dependency to Ulf.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
