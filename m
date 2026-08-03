Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E4331ECF
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758496; cv=none; b=lW4R0kqtphYWaSrzpzeh1rIUE4LAAM8y+S8N2TYXfPnEHp/2j7/mEtCbYE4/ntmL4w/GBEGKQVWYlb4kHiXv1smIu9XWWQ0t43jr39iP8Ltyt1O8S5H99ITCD86A33hhKiixdDZsPHG5139Gv3vyssjBVnlrqXVPtI0jPGAMH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758496; c=relaxed/simple;
	bh=okWIOwpaAfBMcyH50oSVfKzplqlhnVTdVosRYGHHdGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7FuvAemnyEEAn9lHWcQCmR0t7AOTNyuNcCkhApt592eYKVlaFb1LP/kQKZPxEnqHW6JcCAkxaK7qjlRDgSqtN6e2mz655CN9m25FLxf2l758PUDyHZrHMOvBG0j7snI0T+pMqMHYK5OBJmaIMnK/5E4IUsNsmS5IwEsaiKbQsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-74ab6c88052so1032272137.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 05:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785758492; x=1786363292;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/3F2htAaSgkkxvZ/5MPPccMC2gln25kjMNeYIdiRBb0=;
        b=Hug45E4Gbe/dlTOzkp4WRfcCYzSrlkJ4r779ggPI/mYBasLmw8dFgmgWzG9SalOHja
         GvJlhqpDyy3O1MICEJDk9nj52bQW2tlC9vLV+YlskPNtlnyQxvnVefy30PlKz5kucSAQ
         FGL5xUA8iB4GBOnaZ3y6FRqXL7ysLuVxwAfh19QkjHIkZ/J1WRvgksxS+R9GYzsgE+TM
         qtm8vXjnrJXwF5FrQlQNcSES06T7QmZ+MdI5/TZVBSa3mMRCFPUe0gJFTRoAxQ+XDrz/
         EDEoH6c13meila2APZcVkPkgsgQoXyW/i7rbBI3HU+t6bm8BVmdNUqex/0khhA3AygXs
         X2Yg==
X-Forwarded-Encrypted: i=1; AHgh+RpMhu919/WBTj5QjTpxH3l0LSI/5tE7zR7m90op0OcLijeOuGZJkX0OmaMEbmjHx14fkYCoFzLMAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytBmTHAHdJhIZngcqmxh7EVoCCmvc4sXx/6DgOa4d40SVnDe9O
	AE0w4s7W0pwFL8B2CjI/svzWoKkOn9hZjn8ED0tu/BpJh7UYCPOi0wi6is3twwhi
X-Gm-Gg: AR+sD12shocBt+kdyHyaFtBaWY/K3YQficvgkT5X+3j4qya/F1Ef+v8OB/YSg70oi+e
	UkTGw8ERjisGk12SqJm41VV1iSLtmrtqLOw7e3pEPeSvqH7J/agu/JVJAsaBek7JFqIdD7U4xkf
	ii3hCjRSc5c6I8BtprM2x7gOFBgBTXWFoBt9LQYyMRn7Vr+Xll/xgdaxQwuS2IuVbvIExT+F2vU
	zBzjDzCMPmeolO4K920SKkMZoGB8kq5F5kCGotsfrYW4HLkBHVhd3K+AgU4crVkfKTRJbZ34ZBf
	W+d7NK0uSom1P8j8AkUQDWhNhLT7SchQsUGHCuY3c0aYTWJJxPTXSgx1CT3rbFCLAIi9NPOzTAd
	IScM3eTVo8/e9JPua+qChaLciLhePGtncjy5etuCIkof78ZOlYA/QI6wAOy2HunAan5AgMcL8bs
	eWK/2y9RqXJX2zkWgkazHVxdQEB4e5tOULfDDC6s/2EDPZkvc9zL6pdyJW6PvVyKkdF/9XDNYrA
	SZLjav8SUUD7hJ/mz1pd7lLqjq6LQ==
X-Received: by 2002:a05:6102:f8c:b0:74d:ce65:4739 with SMTP id ada2fe7eead31-75b22162230mr6203871137.8.1785758491654;
        Mon, 03 Aug 2026 05:01:31 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-759c905316csm5943315137.8.2026.08.03.05.01.30
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 05:01:30 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c2c96286f0so1595917e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 05:01:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpRGX4Gf72ZDtLsvDx+J4jVrhV5gRqPrQQD/RPwVTlZhHBucm5/P6nBqfEKu/81pgUXP9lMIwKLfA==@vger.kernel.org
X-Received: by 2002:a05:6122:c94:b0:5a0:370:f12c with SMTP id
 71dfb90a1353d-5c3877ee9a2mr2551587e0c.11.1785758489767; Mon, 03 Aug 2026
 05:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505329.git.geert+renesas@glider.be> <49726acff0fee1c3606e83c4f242ef6aad25b4b8.1783505329.git.geert+renesas@glider.be>
 <20260710-adventurous-burgundy-chimera-b2fff9@quoll> <CAMuHMdV=ckONBbTYELPJU8YWoNzdu3PJ95VR8cz+f_7dUeiPUw@mail.gmail.com>
 <20260716214924.GA1477674-robh@kernel.org>
In-Reply-To: <20260716214924.GA1477674-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Aug 2026 14:01:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0ss6wUEdjC+OYa3iQS439aJ8b_d9M2ws7Ayn4_kOyMQ@mail.gmail.com>
X-Gm-Features: AUfX_mxcGqdlDliYxmfdCYiKuiCZlBR4i5y6ZczTyLGv0wHHqfKRM8R7C8jMMeU
Message-ID: <CAMuHMdU0ss6wUEdjC+OYa3iQS439aJ8b_d9M2ws7Ayn4_kOyMQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: clock: renesas,r8a78000-cpg: Add
 firmware property
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
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

Hi Rob,

On Thu, 16 Jul 2026 at 23:49, Rob Herring <robh@kernel.org> wrote:
> On Fri, Jul 10, 2026 at 01:02:39PM +0200, Geert Uytterhoeven wrote:
> > On Fri, 10 Jul 2026 at 12:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > On Wed, Jul 08, 2026 at 12:16:23PM +0200, Geert Uytterhoeven wrote:
> > > > Add a firmware property, for systems where SCMI must be used instead of
> > > > direct hardware access.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > v2:
> > > >   - Spin off from "dt-bindings: clock: Document Renesas R-Car X5H Clock
> > > >     Pulse Generator".
> > > > ---
> > > >  .../devicetree/bindings/clock/renesas,r8a78000-cpg.yaml    | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > > > index 4e23bba334382346..fc499e7cf52e4f0c 100644
> > > > --- a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > > > +++ b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > > > @@ -35,6 +35,12 @@ properties:
> > > >        <dt-bindings/clock/renesas,r8a78000-cpg.h>.
> > > >      const: 1
> > > >
> > > > +  firmware:
> > >
> > > RPi is doing similar, but I have doubts. It looks way too close to
> > > generic "syscon" which is disallowed.
> > >
> > > I think this should be vendor+purpose specific, e.g.:
> > > "renesas,scmi-transport" or "renesas,scmi-firmware"
>
> If you can tell me the resource that a 'firmware' provider provides then
> it is fine, but you can't.

It provides a firmware API, which is not available until the firmware
provider is initialized.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
