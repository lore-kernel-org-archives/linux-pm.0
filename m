Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24B364EAB
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235994; cv=none; b=HqJzZu6FpvgQ+GtiBI7hVnWClSdDRq3cup9xmn7f94RLj7sQ3lFt3aP7eN3T5YOMOMzLW/bF8kgB74paitJygr7YSk0BByin5XP4RppdZPIjx5ZUOc+5WBl/Q/UvsKTcBr+j6vBA804q/LLN0KtCl5VQVqqJ5oipa7wreCaMa1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235994; c=relaxed/simple;
	bh=36lBpAkEr0H2Wsx1O/r0B32FSIwBe2F6o8wScyIxU0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVUCfedEOkYkImZP0X5rxudqJ/z31EqoNxN9grMEXMtIADiI/Dlz3lpqQZ8va3AS2TDiZJufAgwVv+yYYgNkJCxXdeZwB96xF1HHVci6a6fX0UhrswtnTMHqUeFoudCrbo+6sVJAsxWTgC4mPUq/Jj1Amyylus0luKeGv1W8RqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-57516bb40b9so1087109e0c.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 03:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778235992; x=1778840792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZIqmD8zZ0qFeOi8hR6tlVmjP85Y0OQ26EIUPvE1H2I=;
        b=AgfSbLbZ9NECoB7SCm0n+tfa2Bzb+hWI/n9v18CSih9ngu3UtK0DfnU5I5qh75LQ0m
         kDkFGdiP9LQStsVKIexZ4vZF4a2I83yP9d+II2RNC5S4kAUvtxxD2WZbgiAVTaC4tWC0
         iRi4v+S18Crs830SWQYie69VVS5hEGAz7txt6KeuEAjYajZt5NClVDjJeGQug4wOUveI
         sFufXvyRInhXBmzKrlqE2hHLVDdtSuPaetEx/d1JGul37kGr7WoUAhlNJH4hs7ij+o5f
         8aIwCWZd+abeiePyEMeO2O5t9F92ovd+4DqYullWdODRODSQ40u/IZGUf+Guv8pa8hN4
         IRRw==
X-Forwarded-Encrypted: i=1; AFNElJ9GpbIH7yEoARH28bpzz/lCmvjVyM5/tzb4OKSVDn9Q9wjYY3qDAneg+TJC1zGXjuAVKpSSP8WRNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Y/Y8KJRyGvZcqzPZZZr8QU1t3BPc/FhmWhjC8TJ16xbxv2Jg
	x+/5z4ZR4q6zYfpyssKgz+JMpN+jKs0TscPosBI9I174L3ISsM0sHkZFosq3oasygWY=
X-Gm-Gg: Acq92OENUXBzvZJD5ZrzzonT8cKedXIAi3V95GorAIlK0W5scLNenEkaaY4L25jU5ww
	xzVaQ9tK3WCnCiuldQ7nVCaFzEtlE0uVEzVINV484044ARJ4f1PiSWp5RC6zn5J1/t5iKHHzHXV
	xOG+ACSMCOuubGADG5cUsJtuZfpg3QO9vKd96tidF2lV5noLE7yVTmAqaKFUyAPm/0H+WV4RxEF
	8QtaB8+8TDS7jWpX4xYFGrFRiunVO+fyZ4fTHbp+t/ZqQfy92ZCF70UqQV1cxmIaH0a4wmRCmA8
	/kzYkVcnpzvTsqAm0T3gzwzOJuCbe5Yi7y7vFw1mspFRkDALJF0SM5v44dSBsoE2VA8Z5J0HLUD
	TePHVrwNuf4C4PettQ9jytcI6BGC982JeHSEKlS2O2fAlZI43PATZp4C6xVMsFvWUsnKh2UGQr5
	+EdwbiUhDB61/EFDiFayPqmtzF48L6TnWdmlwjCNvwZI85J2O12xlv4+FFfZIf
X-Received: by 2002:a05:6102:6a92:b0:618:3503:5659 with SMTP id ada2fe7eead31-630f9000a98mr6608796137.14.1778235992377;
        Fri, 08 May 2026 03:26:32 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6313ffe8ab3sm609576137.2.2026.05.08.03.26.30
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 03:26:31 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-94b07fddecbso1098672241.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 03:26:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/FVFpNd//DKHlebH6jQvFZ/Ldtf2BidacpgG6Y+R1xo5xAbOnAsQQWAIqBuIAdZr6oOIs4WUbzXg==@vger.kernel.org
X-Received: by 2002:a05:6102:3048:b0:614:bef5:637c with SMTP id
 ada2fe7eead31-630f8c2bb7dmr6450388137.0.1778235990622; Fri, 08 May 2026
 03:26:30 -0700 (PDT)
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
Date: Fri, 8 May 2026 12:26:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWK3Noh5ZQVWT9C0EKyXZePMaJ97C0A_syK+xCb_=abeQ@mail.gmail.com>
X-Gm-Features: AVHnY4J3TVnOKvIG81cskhXstanCgVV2EYjhdTAUgyNfFJiiKyj4H0BCwyLVTfY
Message-ID: <CAMuHMdWK3Noh5ZQVWT9C0EKyXZePMaJ97C0A_syK+xCb_=abeQ@mail.gmail.com>
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
>
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

Exposing only the clocks/reset/power domains the agent can use,
in a contiguous list of IDS, means that the number space changes,
depending on which resources are exposed.

Suppose you have a system where you want to assign a specific hardware
block in the SoC to the realtime CPU core instead of the application
CPU core running Linux.
That means all resources used by that block must no longer be exposed
to the Linux agent, and the corresponding IDs must be removed from
the ID space exposed to Linux.  As the ID space must be sequential
and contiguous, the IDs must be renumbered, impacting resources that
are exposed to Linux.  As these IDs are used in the SoC .dtsi, they
must be changed there, too, However, these IDs have become part of
the stable DT ABI, and thus cannot be changed.

This patch series fixes that issue, too, by describing the actual
hardware in DT, and doing the mapping to exposed SCMI features in the
kernel, based on which firmware version is running on the SCP.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
