Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9527A3BB9FC
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033011; cv=none; b=p7diydlO5dZX4wyAWcLxT56U2od9c51TJJ8HPb1ZjVxJi4RnqXYkLn3bPV2T8rCS/Ks/0U3ENvWKUsyzm1dHK+ANB0o67WZ9KiHN2BtuR76/yMPujaw1/R/6Rer0MUNz2c1ZaFgGzvqY0aRR0HjWriRmRzH9DPRZX1Kwgqbajjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033011; c=relaxed/simple;
	bh=6x8AaL0soP/QvCrhUlcKrRT+37cNHuikR53lCEKEpMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+qqXZlCfvb2eOKLzSwFor/ZG7H/p8yXiHGQ3JKastbjajyShutLB7tdz3gpKRFLGz3pxFOuIIN8S18VjjMFCAfyQQ2lCLryJyHtrnj4vrUO/Wc9RwLl50LhGTE+iGZa+FvAfOfdbnasPBY1v9wjcTPoymdSScPlJ/DnjH2pZak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9382e59c0eso273378266b.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 05:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777033008; x=1777637808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlPOzsbSlIKF8HuNfduxYXPi56LqB7rH+tGNemLx+GY=;
        b=FGyYp+n5mUYFfO/0gXDHJWS/QgRe3g1LBHa3f7UjvMBvxYQqntOSncU9bnftq6yCoB
         eb3/3baX/neeW3Mrd3nPwXdq81ig1sX3ogJQS/hs69ToG5JPXL3rEfTXgLEq6dkjY7TU
         LgyVCIKdJT8cut+WhMc4kF+FpWSLOgH8FehPMLk2/x1UWLghpg5rD3aNrZxRZq5FpaD9
         FP7QrKpXgxQaM3KnpgL9a0NGq35BLmoDNzteraXcLH1IdMA1ymPcFOWs/Hq5/rU0nNDt
         T7OBq8w18kWukKQyM3VmHf+Qx0OAL+dhONp3Nm2cXSdacz+oQ9BWd2Ua1UGxKIhMddsn
         jEFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+4MI+rRtfOS8+FsFtocgi2orPAB8MBLWdn5mX2nVryMNnkbssPjD66FvgeeYwcNqU7GS16bmQ5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTwMAN3PTT6G5etASJmfq+4rl8ftf7AV1Wt+VAPtDxD/DclTm
	0Io9M/fVI9TpjbugbBcxQFQJ6c/4vU9yP7UQlc3nC73T0bfHbQ25IbBE34Cr7GNnPDM=
X-Gm-Gg: AeBDieuUmqqlR3l2A6tQszXD0SjSm/zZFvm4tY+uktjasfnh7ONa4ZP6DWHqfo7CsnH
	+Lgrv0UdmznR/97g98sVuA71zAYzuPC6lsu3wBvnduqeql8LNEq4x5ZoyREfC6cbycUNn89A5dW
	Hg86uiaVrotHBLMWqTSGg5aWwsglj51OKrYFBr3hhh6fGKAUnaON1w4upQzEmhd5JSgkBwUUj31
	2assUsJc1UXOjXE+KXpkVRI8Uo3ASDw5lRXLWFif2ncIROQS19xDP9RU1UridGQMQEjsw7cVjFe
	+E0ru3BTRzW+nbLpq9fGS8CWPXpqa30kbX9k0x50llPRy8KCSOE8z8NGMEGIf61R5vS5l9ZGXiC
	EgRgAu0KukjSqpGaRn5WnTAolPiqYTMYj/OB1OWml3AyikJ+9HG/rJzh69ebqLuWuoqTB0TEszU
	qg5HmhlYg8QRmW2uZbH66cLeydvugw3erLDNgk7EmmriDVY3bldDaZXxCrlU1F+2Zf99QK9KI=
X-Received: by 2002:a17:906:ef07:b0:ba7:e3ee:47a1 with SMTP id a640c23a62f3a-ba7e3fd9970mr1193568466b.4.1777033007771;
        Fri, 24 Apr 2026 05:16:47 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1b694sm784633166b.29.2026.04.24.05.16.46
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 05:16:46 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so12900029a12.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 05:16:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ck6i5HcrrIDboCEPlEcpWG2DZlDPzgJGc8eE5fxwzhHg4WF36GWTy6ZsRwyRcEIuIqdgigscATA==@vger.kernel.org
X-Received: by 2002:a17:907:3da4:b0:bac:1263:2562 with SMTP id
 a640c23a62f3a-bac12632637mr434030666b.24.1777032550820; Fri, 24 Apr 2026
 05:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776793163.git.geert+renesas@glider.be> <72e2a0e7a5abda02fe36b3f5851842f7a77b2593.1776793163.git.geert+renesas@glider.be>
 <aekXUvIPb8nkhdKu@pluto>
In-Reply-To: <aekXUvIPb8nkhdKu@pluto>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2026 14:08:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWJvMH+a1RqozbaCxxH_8M569JcruTFa8PW+87FysnjHw@mail.gmail.com>
X-Gm-Features: AQROBzCeAVXP6DoeEYDD8I1FaXSTP-ZpY0v2OnIf6zjZFA9mNfY85ZLl0E87BuA
Message-ID: <CAMuHMdWJvMH+a1RqozbaCxxH_8M569JcruTFa8PW+87FysnjHw@mail.gmail.com>
Subject: Re: [PATCH/RFC 05/14] firmware: arm_scmi: Add scmi_get_base_info()
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Saravana Kannan <saravanak@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cristian,

On Wed, 22 Apr 2026 at 20:45, Cristian Marussi <cristian.marussi@arm.com> wrote:
> On Tue, Apr 21, 2026 at 08:11:38PM +0200, Geert Uytterhoeven wrote:
> > Currently non-SCMI drivers cannot find out what the specific versions of
> > each SCMI provider implementation on the running system are.
>
> Thanks for your patches....this is not a proper full review of the series,
> BUT this patch catched my eye..
>
> Indeed, yes, it is deliberate that the SCMI version information is NOT
> exposed out of the SCMI world, since being the SCMI an attempt to
> standardize a common FW interface (as in [1] of course), you should not
> know what runs inside the black-box, it should be irrelevant...
>
> ...indeed the versioning is used inside the SCMI stack to deal properly
> with different protocol versions implemented by the server OR to apply
> proper quirks when needed, but all the rest should be standard....
>
> ...you should NOT really behave differently based on the underneath
> protocol or firmare implementation version...it is the SCMI stack that
> should behave properly, transparently...

Oh well...

> Having said that...I understand that at least it could be useful to be able
> to query the SCMI stack to know, even from non-SCMI drivers, WHICH quirks
> have been applied/activated at run time...but anything more than that it

I see no need for that, but we can discover which quirks have been
applied from the kernel log ;-)

> seems to me dangerous and prone to a number of abuses of the SCMI stack
> itself...
>
> (Also...exposing the versions itself means also tracking that bit of info
> in more than one place: the quirk framework and your drivers.)

I'll see if I can get everything handled as quirks instead...

> > However, different versions may use different ABIs (e.g. different clock
> > IDs), or behave different, requiring remapping or workarounds in other
> > drivers.
>
> ...abuse like this indeed :P ... the SCMI server is supposed to be that
> one entity remapping the IDs in the background if the same IDs happen to
> be representing different physical resources across a number of distinct
> platforms all supported by the same firmware blob...so as to present
> a consistent set of contiguos IDs...

In our case it is just a single platform, with different ID number
spaces for different firmware versions.

> Also because this should be one of the selling point of the SCMI stack
> in a virtualized environment: you can ship the same kernel drivers with
> the same DT and you know that ID=<N> will always identify the specific
> resource that is needed by your driver without worrying about the fact
> that in reality in the backstage the effectively managed physical resource
> could be different across different platforms, because that does not matter

This sounds strange to me, do I understand it correctly?
So the ID should (1) be tied to the use-case, and not to the underlying
hardware, and (2) be the same for different platforms?

For (1): Then we must not put these IDs in DT at all, as DT is supposed
    to describe the hardware (and firmware IDs in DT were IMHO already
    a stretch before).
For (2): How can there be a contiguous list of IDs, as not all platforms
    may have the same underlying hardware?

> if the SCMI platform server had properly remapped (at build time/run-time ?)
> the resources to your expected ID...alternatively of course you can ship
> with different DTs to describe different hardware...BUT remmapping stuff

That is a different issue: as SCMI covers the full platform, not just
the SoC, the IDs can be board-specific, and thus should be specified
in the board .dts, not in the SoC .dtsi?
Then the SoC .dtsi should describe the hardware, and we end up with
things like arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts?

> in the drivers themselves guessing on the vendor/subvendor/impl_vers
> seems a dangerous abuse...

There is no guessing.

> I watched a bit of the LPC discussions around this (from Marek I think)
> but sincerely most of those problems had one (not necessarily simple)
> solution: fix your firmwares AND/OR apply quirks in the meantime...

Unfortunately (at this point) we have to work with the firmware that exists.

From that LPC discussion, we learned that we are actually the lucky
guys: some other vendors tend to change the IDs and/or behavior without
bumping the version, so Linux cannot even act upon that...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
