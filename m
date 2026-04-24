Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38983AB272
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030569; cv=none; b=X5MNZ2cNiLWLWKKrFZ5VeTx0l14Ed7EzbJKKa6/WmXrEiBXk6ct0vlCNNvJIP5H+FecEn7ZcXh2socbBC4gA+XsDLqAgVlHUwGcvn+LeGkFE5PPVyCi4mFqYXdm7t4j6LINGe8+hwc06F+pT1c9pDSRXJ6sir1SLFPlLV6EsVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030569; c=relaxed/simple;
	bh=NrNB0Z4JheJ9/gWbOMPohCnZWZtAqhLPKDbrHylRWo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzakUrsf9GYWTnxXgIzrsGzhRxCVBmDwPHfrkPOi9o4nDcH7OxxPtS+ZfYYy8cOGi0dkXyx3RhLW1BjyStuq9XEjskTeB5xlcEWnisYy4CVpocaU4KK+bcCyX1eAMzXUYeLGHEjrbCJ3Zx4GehdB7ihv5REvKKXqB6C5R1CvF+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso7387232e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 04:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777030567; x=1777635367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTjTO3Vp0zB9Wc0GJptJYSFqlnWOG96HJNT3Sm1YIxY=;
        b=kkVg9Nf8BF5RQqZ0FT1jx9bA1p8x6JL4HER+R3WNfAX8k8Gx40bEABdi7nX5o3pK/U
         /Uid6HpaW8Zs1DeBtKbXtEPBhSEGKjSqVTSo7KaV2CloQW0ao56POhoDhlz7FgQoCAy+
         tgaOEK+XTOKVNLXrnUyD+F7Rtmc07T79RNb/YV0b02oOe8z6zgmHHGPcO7gNPm80JWZB
         51aVD87+eWHsuPlEjEko8q5g4EoIdG/2bQZylpkZaY1wIud3cSjJcKSnY9joFFGOCoXl
         RulghAcNoNBeo1oYvsX67AWnB189Z/gmg1IxXSZsac3TbJ4tYPYZAbYRbBpy56Bn+xEg
         QV5g==
X-Forwarded-Encrypted: i=1; AFNElJ8Ki83EeJluw1XvyD4T/ALK1OGYaCrLhAgRl7asFiQ5Ue28/943eINeecPwDVn+Jy2FVgQo2wILFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK0bv3HHOGb9pVB14B8NSu/IPKFj1Vv8vDlsI/NARMf00Lf9hx
	wbq6DYMpJRyjiTbpDdYnN4XuSRQk4X7CiTznao0i/yop35eFQ6UaNIKcHFtExkUsTbU=
X-Gm-Gg: AeBDietcaxcyf23H00XakVnmHeTccaczoF7mfFzOWUrws0X05WikaiGzvkXzGA0+kcP
	bKr/8QVO27kiO9rhLnWJBLP77K1qoT78P9tC7G+arxOo4MB/onwcT4t+AlpcRleQ4QPFTYydjxP
	3bIJ2R8y23lKQaKCVceGwhwqTBKwDBaY/EJ+zUyZl6+eQo454GwDIXIxD1JWTce92fGFxVofYfK
	UDctkjOJAMG6JlFnl0E0tUV+Dl7gbdOGgP5niExtLWFF6AFDXRS93kXV/Dzhe16psrJNihIhUSf
	zZPNHLN6GjqxtPASYZXSu7N+oOXdjI2mh9VB/3KnkUrChgj4xsiwvGoxzzaCyHAEhwmjWkyHe2N
	OIH9kYMiKgELqUruQmkBMwO7SmawQDxojjreEYFHy9GtFTShB7AEHNt5un/VxWRjtGezAPBTUNC
	eGczQaFNWls/MTjula7t2YIBu6O2yAWFpcafQJ3O9ABRn9na6hIMQPqPZK+riY2FKiLhwrpTc=
X-Received: by 2002:a05:6122:4d08:b0:56a:f34d:f225 with SMTP id 71dfb90a1353d-56fa59d6e92mr17619472e0c.11.1777030567454;
        Fri, 24 Apr 2026 04:36:07 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa933a54dsm13139465e0c.16.2026.04.24.04.36.06
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 04:36:06 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-60904a76e63so4463250137.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 04:36:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9jzyi2LJlrbkQGOfT3zjklPSWune4mLWb+7arGpEFg+h3KRkrGVbZnBRTGdzvWB8m6xOon4Hydkw==@vger.kernel.org
X-Received: by 2002:a05:6102:292a:b0:60a:cd0e:5cee with SMTP id
 ada2fe7eead31-616f4f84fdamr16386481137.12.1777030099174; Fri, 24 Apr 2026
 04:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776793163.git.geert+renesas@glider.be> <7hcxzqr4qi.fsf@baylibre.com>
In-Reply-To: <7hcxzqr4qi.fsf@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2026 13:28:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU=3AN8wHbnO2Cx4WsLuYWhv_fRfTA50fmrqyREO3nrbQ@mail.gmail.com>
X-Gm-Features: AQROBzBE70P7irgYnQUYx63AIUadZqGfMGlPrac0wi4EECHihh00jV8ht_DYoMI
Message-ID: <CAMuHMdU=3AN8wHbnO2Cx4WsLuYWhv_fRfTA50fmrqyREO3nrbQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 00/14] R-Car X5H Ironhide SCMI CPG/MDLC remapping
To: Kevin Hilman <khilman@baylibre.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Saravana Kannan <saravanak@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kevin,

On Thu, 23 Apr 2026 at 00:48, Kevin Hilman <khilman@baylibre.com> wrote:
> Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > TL;DR:
> >
> >     Describe hardware in DT, and perform the mapping to SCMI in Linux.
> >
> > The Renesas R-Car X5H-based Ironhide board is the first Renesas
> > SoC/board combination that implements the ARM System Control and
> > Management Interface (SCMI).
> >
> > This means Linux can no longer perform various system operations (e.g.
> > clock, power domain, and reset control) by accessing the hardware
> > directly.  Instead, these operations are abstracted according to various
> > SCMI sub-protocols, and Linux has to send messages to an SCMI-compliant
> > firmware running on a System Control Processor (SCP).
> > More specifically, the R-Car X5H SCP FW SCMI controls access to:
> >   1. Core clocks and module clocks,
> >   2. Module resets,
> >   3. Power domains,
>
> I'm very curious how power domain hierarchy is described on this SoC,
> because one more issue to add to your list is that hierarchy cannot be
> described for power domains in SCMI.

So far I had no need for such a description. AFAIK, this is handled
inside the SCMI firmware, which does know the hierarchy.  Hence the
firmware can power up a domain when any of its children is powered up,
and power it down when the last of its children is powered down?

I think the clue lies in having a PSCI top-level domain, cfr. what
you wrote in [1]:

   "But... how do I describe the relationship of this hierarchy? In
    particular, when the SCMI-controlled PDs are actually subdomains of a
    top-level, non-SCMI PD."

Or am I missing something?

So far I have used only a few devices on R-Car X5H, and e.g. the
serial ports are in the always-on domain.  I did experiment with
a dummy UFS driver, as UFS is inside a real power domain, and that
seemed to work fine.

[1] https://lore.kernel.org/arm-scmi/7hecy3h7ky.fsf@baylibre.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
