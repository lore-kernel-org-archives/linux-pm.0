Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA573F39F2
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681807; cv=none; b=bKVxphJRLbSvfhVfA4kFDGy+o0uT69Vt43Y3kH6NPO4z3zAXNNRg6oPdunb/Lcu1a28uFIyxCmHr3yK97sUj7WyW/7y1E0/nlu1xo4axse43PvZqc0urYz3unhkrcsV1A88RLnc3p238v6ZFGeAx0P3DCQlEDNh3c1ilGJbmIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681807; c=relaxed/simple;
	bh=TAoC8AtqfvyrcOiH125Z48ckCbhqCjSDAUjYBMGFx+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAx0u7+fAx37aVmEvqgz2Ih6msBjFLNorCoCrtfGwEjfVvDu07/ASI05aiI/zlfv/3Kyna96VymuB+njDfRAeScUxuwi9/+pNtzM+lf5XR4PGe/hB6f/OyNFSgAGysJkKSxDfZMQXHAYVgg8tpft1EqIjswhLKlMva7v9f4Cz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81e7826cbd2so8901687b3.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 04:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783681805; x=1784286605;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MuUmGqSSA58rP0nRidv37IIoymAVqS6FDOb1XQHbyds=;
        b=GlxvWsgjK4k9mGMZrTgznUk9vKVb7isBOdvqEiWD/f2SNb4hqOUZndWMM94I1rcZKq
         ZWjvaMb8Yrm5EV1QtFOWWpeWEG4FtAHHxiRh4tY9Cy+oZqiD+hHzNu694ERak7vNnBLS
         GDz/1MT5Lti2ebk1Z6VvAzfINoubE2Htbr+wV/2KHEDJ1HC1Rcdmvhg5kYZ2715HvVab
         +IAACRtxKLXqbkhxjegLK8olAKIR5P7Obalf8vxaze5J+fL0MTogR+aUxxvXd3mIherH
         yBwHTzSRybFxCiPRhjkBGw/9UgS3k/xkj0xG2kwdUy8vXxlgebfmVEKeATd07Y3FElGP
         0PNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnuJPWJwAMzp8sBQ2MalXEO+DU/s9wi9ZRP1TYfEWGNTDP5dX86YQBotIfcBxbQzNA9lKXl17ZTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqzjsVYyRG2vGhdSi3sSrplYVR5B1RKo/ULy6zs/3A0SGg1iol
	+uleFvW1GHhLaKsm+9yI6kSxWxa1qQ/wSuE9urVC4gBuZZTYdhozUe9UQgQSSxB5YVM=
X-Gm-Gg: AfdE7clJxNB5rP1R9M/FStpj/XvQuhnqjbJ4E1YIWca/iaIrotA77ydUb2zfU8HHuRu
	OkwbIfTK5ZwbKxMtlXFfP1YtDJNQ5+iLVp2ITin2XJk0/Vr+WTZr38V+30LwRElG1YJsuRYZfKJ
	vtCa9BAyJ0CGP1owWJD4SLjPoXECrJmC5oP/1m6VqqhuU+nXChtx3Ga8jxPQ3C8QY7zDi8TVaW0
	E3nH+oxdM5YLi9ZC3JH6FxiYDus7i/hVxZUyhiYSPCSMFrJxwP36PBiMUSpLc4kHO3S+YMxWJPn
	rmkGXfofi9z97XpNnmtqOlw2I05O/9diAEhAVodPLbG5ug2toFRXH4HF1a6W1LC1/YGIFAlnu/i
	rH5iTR7m4F4aqCL37XGqteuRNYfLo7fS+88CUI4R5Ru0X9wNOIzBGHQc6/DlXrTtlAOnGGMW2zp
	CKrf42SsirLrDyGe4amOTAs2Wd1WJWekxg+jT4LcPhyFsVh6MElxNPt89bIR77crqd
X-Received: by 2002:a05:690c:7288:b0:81d:6af3:b9b5 with SMTP id 00721157ae682-81dbe553926mr84380147b3.9.1783681804646;
        Fri, 10 Jul 2026 04:10:04 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c201dc7sm41751767b3.41.2026.07.10.04.10.04
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 04:10:04 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81e7826cbd2so8901597b3.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 04:10:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqvZpqNir5AVbvUoJn38Nv0TVOvDolX17t8O0Od/WvROE/PuW/9vciucL/Jz4G3NEnWC6kCe4uzIQ==@vger.kernel.org
X-Received: by 2002:a05:6102:5789:b0:73e:9fae:5844 with SMTP id
 ada2fe7eead31-744e0426fd6mr5821388137.27.1783681371174; Fri, 10 Jul 2026
 04:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505329.git.geert+renesas@glider.be> <49726acff0fee1c3606e83c4f242ef6aad25b4b8.1783505329.git.geert+renesas@glider.be>
 <20260710-adventurous-burgundy-chimera-b2fff9@quoll>
In-Reply-To: <20260710-adventurous-burgundy-chimera-b2fff9@quoll>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Jul 2026 13:02:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=ckONBbTYELPJU8YWoNzdu3PJ95VR8cz+f_7dUeiPUw@mail.gmail.com>
X-Gm-Features: AUfX_mypDnJ4qFpPLK-a5R1Mbwkbc6yQr178xDsRkCp5yARGuoX_7FuK_KFx-r8
Message-ID: <CAMuHMdV=ckONBbTYELPJU8YWoNzdu3PJ95VR8cz+f_7dUeiPUw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: clock: renesas,r8a78000-cpg: Add
 firmware property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Fri, 10 Jul 2026 at 12:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, Jul 08, 2026 at 12:16:23PM +0200, Geert Uytterhoeven wrote:
> > Add a firmware property, for systems where SCMI must be used instead of
> > direct hardware access.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v2:
> >   - Spin off from "dt-bindings: clock: Document Renesas R-Car X5H Clock
> >     Pulse Generator".
> > ---
> >  .../devicetree/bindings/clock/renesas,r8a78000-cpg.yaml    | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > index 4e23bba334382346..fc499e7cf52e4f0c 100644
> > --- a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > +++ b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > @@ -35,6 +35,12 @@ properties:
> >        <dt-bindings/clock/renesas,r8a78000-cpg.h>.
> >      const: 1
> >
> > +  firmware:
>
> RPi is doing similar, but I have doubts. It looks way too close to
> generic "syscon" which is disallowed.
>
> I think this should be vendor+purpose specific, e.g.:
> "renesas,scmi-transport" or "renesas,scmi-firmware"

The disadvantage of a vendor-specific property is that there are more
cases to handle for fw_devlink, cfr. "[PATCH v2 02/10] of: property:
fw_devlink: Add support for firmware"[1].

> Also we have "firmware" nodes, so this might cause conflicts in dtschema
> validation.  Anyway, the phandle itself is fine for me, just the naming.
>
> I'll ping also Rob to chime in.

Thanks!

[1] https://lore.kernel.org/de34ac0c52695d92c67cf950b3d8e9b30095d305.1783505329.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
