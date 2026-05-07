Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0831F98C
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141750; cv=none; b=Z47PfGSMELHBeZDhooYHLXpG8swxINf7YSI7mCO8a2b1v5+MY3vTLNpkJBRzBjTcytts5vU1Ey0Quleti9rpTgqs2X5oZktyXDoQz3pBujBb8X4e3RVVCgVVg8XlgxJaWF0bUwsUzWuJLsJqBK9L+LlM/74T5MLZEzGbJ4PD6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141750; c=relaxed/simple;
	bh=BtfahhhAzKwhxGXbFBG/UrJl92zYnGC9mAaLmhhe9pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTgB7pP08388oNLWczlNgv3DCjiq9DRlOnq3gFDngAxMom+9AmFzwMHR7qfqs1s1xf+dGSR+ReMNTUOdYugHxpyYDBZtu0016+3HdDkUa9DThz7FMN7iMbV5geEDY0/gR7hsi88NQ3ipdh9396o5OeUXywOxxD/u3+hYSzv3zQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c801b30188dso204989a12.3
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 01:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778141748; x=1778746548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlujo7B4GXnOEwb19kGu4mpvesYmekRBqIKCAW22YrQ=;
        b=sYsx3didk+qtYmRVqzalqRo3s4GQ4AMDRH+Ec7rwfveVnsPfH/XC1nb38AbgyRAC3U
         kdkeGf74NhHZyA/ltvgNFXm4eJZP6akbm6yjhVKeTNkNf9ReP3+5WFrgRhbCeiWEkxTo
         HCHkQpRNuJMhzZNMbQV1pwEm/J+IzUgp0KbQzR7j7rRD1k40PqAYPABi3CDmb4+QLHxM
         lI+yCUhErc2FVcFSbtwnycjLXick/RUF+v0swhEQkEDKfpqe+lDzYk0ckUZF3ed2yUUm
         P+lTBoQc3q7x73bYEhUvD9FF8ok6igtWN4FQXWGa4RduQQziIFW/2gN5B0MBgQwy9v6o
         +mZg==
X-Forwarded-Encrypted: i=1; AFNElJ+0/y1GoPE6f8NjvnBJ/b3xEyK8ST0SuOL6pJIGl9F5wFv6V/xAXSX7vGq1G2KSncEoMktCGxT4gw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7US16BB1VQN75CeXjyhrRgCslGJxXlwIlWhB3tsMBckgkR+GP
	1Jed2jm60lVZG1FnaiOgMqsS8lwlP83nrx7tBKOD22YGSlUdN6lUrVRBrVGqUmHBMzc=
X-Gm-Gg: AeBDies0W12J+xCPIZTcHTgJfZvu31QCzEvLq5GY8CtDalEBN/+J3Z2ZPs9RJNAwWlZ
	e22EYIyEoM2Uw0YLmNY9aYkEiGvoIQz+GGoeaLhAfGIdl1zwU0sihotT88kK78UsnOoKFXzcZqG
	g8Q2Z2IPb+q7MgeWqgPy8TMETaT6SH3cIh0kxV1RySjgMsUZXZi/6c4jTPCTYOReQy1S641yXD6
	SSiZ0Pelx8O6mnLQMc/j4pFDyuICoqbIGDQwSGRUhygSqh4EkaQbEP4/D9u4kyUBNxQzr5roFUb
	/5ov8/Xst18aPt+4vMlvRI0VNuN+Z/Oswylp+EYtY79pWR2k569WD5VeswpE1M6JVOfn4/vWgvw
	WJFwfyKCZqswPYdwafaZi/X0KLD17GiNbcI9czwkvFLhFD/PTQcdyDDXgqEEHyTXs59EqaRpEAt
	gVmYlOG3/3S+/SXkVemElAY8YjQl+UPfbTEy/SFbyDssL902bxdbPid7QhhafwwBMycKFITH4QX
	w==
X-Received: by 2002:a05:6a20:e210:b0:3a2:d316:de53 with SMTP id adf61e73a8af0-3aa5a199cbemr7586191637.0.1778141748034;
        Thu, 07 May 2026 01:15:48 -0700 (PDT)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com. [74.125.82.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8629sm7976890b3a.36.2026.05.07.01.15.47
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 01:15:47 -0700 (PDT)
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ee990e8597so961332eec.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 01:15:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+xuqbT5CzaFgaL+6MRs/PbInR2Dk48FemiqqLc1YGyaE56ROGLIiJbcGS1HalkF5QxMeYfEFn4BA==@vger.kernel.org
X-Received: by 2002:a05:6102:304e:b0:62e:79ee:4cda with SMTP id
 ada2fe7eead31-630f8e6ad78mr3364577137.3.1778141327428; Thu, 07 May 2026
 01:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776793163.git.geert+renesas@glider.be> <72e2a0e7a5abda02fe36b3f5851842f7a77b2593.1776793163.git.geert+renesas@glider.be>
 <aekXUvIPb8nkhdKu@pluto> <CAMuHMdWJvMH+a1RqozbaCxxH_8M569JcruTFa8PW+87FysnjHw@mail.gmail.com>
 <ae6Zp54NhKlVes8J@pluto>
In-Reply-To: <ae6Zp54NhKlVes8J@pluto>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 May 2026 10:08:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVunEehM01pLa3t5a6o0NmMOCQRwh7n5J+OkDk2YR9kUA@mail.gmail.com>
X-Gm-Features: AVHnY4JbGLo8_iAmQ_D9O0588NyvaqL5CIqCjBD959GBuikmvjn-HVAEApsHrL4
Message-ID: <CAMuHMdVunEehM01pLa3t5a6o0NmMOCQRwh7n5J+OkDk2YR9kUA@mail.gmail.com>
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

On Mon, 27 Apr 2026 at 01:03, Cristian Marussi <cristian.marussi@arm.com> wrote:
> On Fri, Apr 24, 2026 at 02:08:55PM +0200, Geert Uytterhoeven wrote:
> > On Wed, 22 Apr 2026 at 20:45, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > > On Tue, Apr 21, 2026 at 08:11:38PM +0200, Geert Uytterhoeven wrote:
> > > > Currently non-SCMI drivers cannot find out what the specific versions of
> > > > each SCMI provider implementation on the running system are.
> > >
> > > Thanks for your patches....this is not a proper full review of the series,
> > > BUT this patch catched my eye..
> > >
> > > Indeed, yes, it is deliberate that the SCMI version information is NOT
> > > exposed out of the SCMI world, since being the SCMI an attempt to
> > > standardize a common FW interface (as in [1] of course), you should not
> > > know what runs inside the black-box, it should be irrelevant...
> > >
> > > ...indeed the versioning is used inside the SCMI stack to deal properly
> > > with different protocol versions implemented by the server OR to apply
> > > proper quirks when needed, but all the rest should be standard....
> > >
> > > ...you should NOT really behave differently based on the underneath
> > > protocol or firmare implementation version...it is the SCMI stack that
> > > should behave properly, transparently...
> >
> > Oh well...
> >
> > > Having said that...I understand that at least it could be useful to be able
> > > to query the SCMI stack to know, even from non-SCMI drivers, WHICH quirks
> > > have been applied/activated at run time...but anything more than that it
> >
> > I see no need for that, but we can discover which quirks have been
> > applied from the kernel log ;-)
>
> Ok so I may have misunderstood...it seemed to me, glancing through the
> series that you wanted sort of reconfigure other non-SCMI drivers based
> on the SCMI FW version assuming that some quirks were applied BUT also
> that some sort of corrective workaround was needed additionally...so
> what I was saying was that: is not more straightforward to be possibly
> able to check if a quirk has been applied instead of querying the
> version from outside ?

I am not sure I can implement everything as quirks...
Also, as quirks.h lives under drivers/firmware/arm_scmi/, accessing
quirks.h elsewhere requires a relative include path.

> > > Also because this should be one of the selling point of the SCMI stack
> > > in a virtualized environment: you can ship the same kernel drivers with
> > > the same DT and you know that ID=<N> will always identify the specific
> > > resource that is needed by your driver without worrying about the fact
> > > that in reality in the backstage the effectively managed physical resource
> > > could be different across different platforms, because that does not matter
> >
> > This sounds strange to me, do I understand it correctly?
> > So the ID should (1) be tied to the use-case, and not to the underlying
> > hardware, and (2) be the same for different platforms?
> >
> > For (1): Then we must not put these IDs in DT at all, as DT is supposed
> >     to describe the hardware (and firmware IDs in DT were IMHO already
> >     a stretch before).
> > For (2): How can there be a contiguous list of IDs, as not all platforms
> >     may have the same underlying hardware?
>
> I would NOT say that an SCMI FW must behave like this regarding IDs, but it
> is a possible SCMI deployed setup that can be useful in virtualized setups
>
> I mean, the DT describes the hardware of course BUT when you refer to
> some of this hardware DT bits from some other subsystem by referencing a
> phandle, even in the non-SCMI world, you are in fact selecting a specific
> resource that fit you use case, right ? Can we say this ?
> I mean you needed that specific clock or regulator that you described
> previously so as to be able to enable some other piece of HW...

OK.

> Now, the SCMI provides an abstraction on top of this, since you really
> discover domain IDs of a specific class (clocks/regulators etc) you are
> in fact describing an HW abstraction that you then refer with the usual
> phandle...also because there is NOT so much SCMI hardware to describe,
> given that the HW is handled transparently (opaquely really :P) by the
> driver on the FW side...
>
> ...you basically obtain such domain ID, usable as phandles through dynamic
> SCMI enumeration so that you can use it all over your DT to make use of such
> resources...
>
> ...on top of this, consider that the SCMI server CAN provide to its agents
> a per-agent-view of the world, IOW it can (and should) expose to a specific
> agent ONLY the resources needed by that agent, i.e. it can expose the set
> of resources 1-N to two distinct agents and that does NOT mean that the
> underlying physical resource mapped by ID=3 in both agents has to be
> effectively the same piece of hardware: it could be the case, and this
> would be useful to exposed and managed properly a shared resource, or
> it could also be that the same ID=3 could refer to completely distinct
> pieces of the same class of hardware...(same protocol same class of
> resource...)
>
> In fact the SCMI server provides an abstraction, sometime a mere illusion
> to the agents...
>
> So in a virtualized ennvironment you could expose the same ID to a pair
> of distinct agents on distinct VMs, so that you can use the same driver
> and same DT despite the fact that maybe the underlying resources are
> distinct pieces of hardware ...

I am not sure how this can actually work.  Many clock, reset, and
power domain resources cannot just be remapped to different hardware,
as they are related to other hardware resources described in DT,
which are not handled by SCMI.

Take for example a serial port:

    serial@c0714000 {
            compatible = "vendor,serial"'
            reg = <0 0xc0714000 0 0x60>;
            interrupts = <GIC_ESPI 15 IRQ_TYPE_LEVEL_HIGH>;
            clocks = <&scmi_clk 42>, <&scmi_clk 43>, <&scif_clk>;
            clock-names = "fck", "brg_int", "scif_clk";
            dmas = <&dmac1 0x33>, <&dmac1 0x32>;
            dma-names = "tx", "rx";
            power-domains = <&scmi_pd 44>;
            resets = <&scmi_reset 45>;
            status = "disabled";
    };

The clock, power-domain, and reset cannot be remapped to a different
serial port instance, as they are tied intimately to this specific
instance at MMIO address 0xc0714000, which is wired to a specific ESPI
interrupt and to specific DMA controller channels.

> ...OR on the other side you could decide to share the same resource with
> different agents (say a clock) and take care, as a server, of armonizing
> conflicting requests from different agents (e.g. by refcounting enable/disable
> across all agents), WITHOUT necessarily need to expose that same resource
> with the same ID to both agents...

E.g. preventing the inadvertent disabling of shared resources like
shared parent clocks I can agree with.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
