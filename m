Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87708406287
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592675; cv=none; b=h+2IiSEeh9lC8uX4m25VSfzg8C++RyjNusXYgm3/2YKvWXK/12tu2kE+HJH2HOuTmjLLtGFNeY8AmHog80DmkZWlTFxFrdlq/qexBTbx6E41TfArHjcO69bDZHfE5Kqw8HjHbKZa5BmgD06ceA0Y7LYRpkM1LnRL1NaOsxCVi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592675; c=relaxed/simple;
	bh=FxUfzWpCleIQzfr8y72a6t+Wi81Fv5S94Ccqz6vyAuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQIAlnVcHsvu4ChUcdp61bq1qxo6xqNod7UngwV/T18fL4TEofOA6BrvDBvQyKNJ+g7da69dyg8nwYLbcaly78r/v3K1S+7il35YfjqJW7Cmwfjy7LHuJS0PvSYSOLWqjlRAgk6Q+aDJt6KEfoAVFzVTP7QHtgrGY2ylyYRgctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7391d5504b5so841053137.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 03:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783592673; x=1784197473;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s6cZ9HNvj5euq2IsKqnGtW9n38TCf44UpefkQ/0EfN8=;
        b=l8pJAJhGiyg7vPGsoPybprInaD4KkdCLX/nfw09oSm9fUIIQt+nHJpFdmlbvxi8xYm
         GJS7i8cB/GHYkZOAdGe3nU+CfMBdWnV/TwXVkItQKs+pje+oLkFxABOs7sfyGaVnp6WQ
         8GTTMyV6qYdRSCOtGMZ8ajNBPQSRv5+G51Fu7UDkw0aoYSxLMPvCkXFZDj0gAsly3DSZ
         4RUA67fzM2FIcaDk8dTk1uJP/arFsPVf/jAGKKc/r/tVnERZN8uhZJ50pJJOL5xQY6dG
         30SAm71cdCdqJ2fL15K3WkW7JpxgiLQOetPpZ+jd2yYPeSBuyZfGo8nsAxhA3+ZsSZ9C
         kcuw==
X-Forwarded-Encrypted: i=1; AHgh+RryBHW6h1ABumeyg8JCV9LjbclD8bJyo5wZ/OwQapBJykH3Sfx5k9wUbfs0n26FkczlfElEwMIAiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZb+CDz9nGAtbaEDYpUkbJI1m37ZIdKLizGzk98YLGkiW3cM5
	ltN7yFiOs4Ife2K5dEzv21O7HiTR5aoG5j6GM/DlK60XBmEIXXEv7oH0np76NI86wLw=
X-Gm-Gg: AfdE7ckJo5l1uikTsf59tFKWepHpp8FuNAqMsiyIenN9Etu+5uR13Eb3c01VxeO9XJG
	eMkyRVo6UQj/EsPF9oq4cK56snAFkVvOt8nHiQ8eK4oAlYFwYeXrUBXQhZSnHuI1m1nZuKBkhiH
	JMJdJDrXmBcfKGwwU7kKnS7IM3FE1ioajasgC6wJzGum34bJyd9PTDyaxMx9JCCNSm0GviEeXKh
	sJ9APWMjBVTz0IwLYxMAV2SL7VZbwvSBqaTQDo13yQ9gPfuMh1t9tYBe9K+6gRKrxj82/REzOTW
	AQZhavNtKnAmpltmWICQfOXFOB2KrrVqk9SvmA17K8pDecg08s20oaCxLAtdyPWvklqScAy7yz2
	ZcWImhZnydD0MobAGP1quj5OQpcf4/Qgvw2uDVIQ33vP4PlOD3DigzA5+nF0WL/BESbQUeimYrR
	ZBqghzAbZ+UPXxUrXkZKswJlq0fG1eZQOGrSSaJhjAiEaSKcwatg==
X-Received: by 2002:a05:6102:94f:b0:738:531e:a43e with SMTP id ada2fe7eead31-744e00634cbmr4111720137.7.1783592673463;
        Thu, 09 Jul 2026 03:24:33 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed3868749sm2801313241.7.2026.07.09.03.24.30
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 03:24:31 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-96387efc30aso821419241.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 03:24:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqtG0MfDThFBng2SXm1wzfolCGgg27tZww5QsyzdzDoeQH+EzNM1PFSxyZKo3gi6H9OchWfaZhelg==@vger.kernel.org
X-Received: by 2002:a05:6102:94f:b0:738:531e:a43e with SMTP id
 ada2fe7eead31-744e00634cbmr4111626137.7.1783592670751; Thu, 09 Jul 2026
 03:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505142.git.geert+renesas@glider.be> <dca2c4940ba38b897f04b6fb67591de9835900e1.1783505142.git.geert+renesas@glider.be>
 <59725f93-5269-4b0e-8633-48821219877f@mailbox.org>
In-Reply-To: <59725f93-5269-4b0e-8633-48821219877f@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 12:24:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCooODm3YuE1JjZJAc2BeQuD==kWbA+ZzpXRA3fqa0Vg@mail.gmail.com>
X-Gm-Features: AUfX_mzHlNNTYZ42llQz3ksPLOjU-3fWPe_bQZCByAo9mLJpSl17fS0OhOffgPc
Message-ID: <CAMuHMdXCooODm3YuE1JjZJAc2BeQuD==kWbA+ZzpXRA3fqa0Vg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: renesas: r8a78000: Add MDLC nodes
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

On Wed, 8 Jul 2026 at 23:56, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 7/8/26 12:15 PM, Geert Uytterhoeven wrote:
> > Add device nodes for the Module Control (MDLC) blocks on the R-Car X5H
> > (R8A78000) SoC.
> >
> > Complete hardware desciption of all (H)SCIF serial ports, by linking
> > them to an MDLC for power domains and resets.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> [...]
>
> > +             mdlc_ddr7: system-controller@e8380000 {
> > +                     compatible = "renesas,r8a78000-mdlc";
> > +                     reg = <0 0xe8380000 0 0x1000>;
> > +                     #power-domain-cells = <2>;
> > +                     #reset-cells = <1>;
> > +                     bootph-all;
> > +             };
> > +
> > +             mdlc_hscn: system-controller@c9c90000 {
> > +                     compatible = "renesas,r8a78000-mdlc";
> > +                     reg = <0 0xc9c90000 0 0x1000>;
> > +                     #power-domain-cells = <2>;
> > +                     #reset-cells = <1>;
> > +                     bootph-all;
> > +             };
> > +
> > +             mdlc_rt: system-controller@19440000 {
>
> Please keep the list sorted (0x19440000 should be before 0xc9c90000).

These are sorted by instance (Module Number), as per Table 18.1
("Target Module hierarchy of Module Power Gating and Module Standby")
in the documentation.  This order is indeed a bit odd, as it differs
from both alphabetical label order (unlike e.g. hscifN), and numerical
unit address order...

Any guidance?

> > +                     compatible = "renesas,r8a78000-mdlc";
> > +                     reg = <0 0x19440000 0 0x1000>;
> > +                     #power-domain-cells = <2>;
> > +                     #reset-cells = <1>;
> > +                     bootph-all;
> > +             };
> With that fixed:
>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks! ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
