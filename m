Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4059397958
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121846; cv=none; b=AZsKjFCvF6UyD1HT3OZCXsypXDy75g3/rnvncf9hIp37o1Oe+OvtDaIA6S2yYOG+E983r4t4yuFf+JWyiT8mxSAbgFXffyAShgdwLH0TmpMtLLq7KWn5ZE9llqki2ianu5oDM0OofpvoQPWIcQFrgAyxyB+KYiKeknxEy2MyHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121846; c=relaxed/simple;
	bh=vPc6vf6UpiLlXJoEYCa/uwMx3ESspZKnGUeVSaDznCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2RpDVq3icqdjTA+wa0lrHJFbvhfO5Gzp4ptRHktlJQomFuF/ZfKDc/q1vY8DbULpX4Iz6qhtyMCjXcixD00zGIl0n6NQv61XcEQmS1PfsXQ+AqxMsH+atHY5vCx9BD5lgUegrTY58QS/z2HbGnXw6XqWeWRPbipYu75rnKCoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so410989366b.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 09:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121840; x=1786726640;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zddzVVYS9F5PpJp+klwF/9jEg03r8YZTMRZfUZl45Bg=;
        b=lE9KSS46timQXU5quLq9T2J2uXMLUm93rjxEo6GHrlfjnYj3WRdh8A0/ByUu+kesEH
         xlC/9ktQVxpZpBFbFxl6dkVaFbtM1mQv9Nk4jrG265Pyt8AHvoZa6AYCG/aX3uCHZz4w
         JAd4H7x8lW3vEhQq3Am0ll4wkT/fg9B1u5+F+5DhHhjrSaSiPUfR/BUVasEPhqLopvX9
         7zKEFP9lcVK9KyXhtZQDmiattcmiilVxioaXm9TbU3/QhIiLdvQDB5MWjYLgHFtD7KSG
         VHKDg5kStbXqYoyWN2+2mM18+6qgZ10qroZTWyXU5Wmmrhrdl+e+8MVZ8WemDiWSSke+
         IgwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7nOTzDt2Ynhe5ozC6OhU1UpgKakxZ+1XyCdLVUBtJqN6grNCVHdsUpW8HyyP6tsSAd9y6N2eGOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDCh0dPK/aW8/IAKERITy4mBfL8L2rMfmPGYvXNPCx+sYRjC3f
	Q3+4ffHtbcsoRpQv9wvUmH9YRERO9ot+ozpMDy7zHlXz+yfq4qucIoEKelJ436fWFqc=
X-Gm-Gg: AR+sD12rq/659cQ3W6ccba0OEymRp5a8Tk9ne5F0A9iUrfvsqNt/Q1LgMNaGwBQKlsb
	6VbeHm+KkO/3Zrqvv4uzb9HLhRDJapEHeok1B/bk0OccUh+AYTlt3qMstzcLhahxp8yqFconcxy
	C3G8Am90RzEDKjDyDpKv8teXtTFjqfPV14Yd8QHluC3oXFGY0i2/YFz4gZlS/9uF330VYYocMjy
	nMTLZotIUt/KIJqIVb4Q5KOng0cgqXC9Mii1dWT/5HOWw3PDRxh6oqoxI1YyYpO3KzOI5Pxh/D/
	3SNJ//DCkRrGUmsIVGOgP9x+7lK3uKkBefhCzjrOCC+GaMzjmMSUWsPKc6El406KVRRbnKjKqei
	xoeqKlsAPvJLYgh2JEEgx8QG9jg19PHPZcPiMcJ7rJ0Wwt1H7N0/TMr2l/Gob2lcf2z9vBifIs6
	RvoWLuen/2XY/Y4q1vJD5bHGdwGbri2PfQUK8CTUbWbviMhKZxSEjJinEnm1h/34kam9xfjFlge
	I9zGuCIJC99NyYj+D/8tgbe/PzskqbAnlGv
X-Received: by 2002:a17:907:3c93:b0:c16:769b:9838 with SMTP id a640c23a62f3a-c20731a9d01mr527481666b.5.1786121840334;
        Fri, 07 Aug 2026 09:57:20 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080cc34easm74740366b.43.2026.08.07.09.57.19
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 09:57:19 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69fc9f25118so3826335a12.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 09:57:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RozEuZAjwMyhHU1pxeJaQacl0dQZLgnh+3Dgqt4tmXOfuY1b2gxqMXFcB0bgY8g6tNjbOba8TTc3g==@vger.kernel.org
X-Received: by 2002:a05:6402:444a:b0:6a0:a4ce:1b8e with SMTP id
 4fb4d7f45d1cf-6a1b49ea41emr5538936a12.0.1786121839381; Fri, 07 Aug 2026
 09:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505329.git.geert+renesas@glider.be> <20260715-greedy-ocelot-of-feminism-5be3bf@sudeepholla>
In-Reply-To: <20260715-greedy-ocelot-of-feminism-5be3bf@sudeepholla>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Aug 2026 18:57:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXD5eMuLBJWqLAt93M=8pSooBOFQ-H9jBM98N8HUwbRTA@mail.gmail.com>
X-Gm-Features: AUfX_mwo4EKqALTJkUcOqfKJfKUYp7ByWT2RwJWKEGja2YdKTdPuto8-gpxkDXo
Message-ID: <CAMuHMdXD5eMuLBJWqLAt93M=8pSooBOFQ-H9jBM98N8HUwbRTA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] R-Car X5H Ironhide CPG/MDLC SCMI remapping support
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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

Hi Sudeep,

On Fri, 17 Jul 2026 at 10:05, Sudeep Holla <sudeep.holla@kernel.org> wrote:
> On Wed, Jul 08, 2026 at 12:16:18PM +0200, Geert Uytterhoeven wrote:
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
> >   4. System power.
> > The latter is not relevant for this discussion.
> >
> > Using SCMI also has an impact on the board DTS: besides the addition of
> > a firmware/scmi node with protocol-specific subnodes, devices using
> > SCMI-abstracted system resources now have to refer to these resources
> > using resource specifiers containing phandles to the SCMI protocol
> > subnodes, and firmware-specific object IDs[1].
> >
> > Unfortunately we encountered several issues with this:
> >   - The clock, reset, and power domain IDs are not stable by design,
> >     causing DT incompatibilities.
> >     SCMI requires that the ID space exposed to an agent (i.e. Linux)
> >     starts at zero and is contiguous.  Hence any change in system
> >     partitioning (Application CPU core vs. Realtime CPU core,
> >     virtualization, ...) may mean a renumbering of all SCMI IDs,
> >     implying a massive change to the DT.
>
> Yes it is well known fact. But where this is a feature or limitation
> is debatable. Why would SCP firmware churn and re-number or re-assign
> a differ domain ID everytime it is updated is questionable to me.

For an actual product, I tend to agree. But even then there might be
a need to reconsider partitioning during the long (e.g. automotive ;-)
lifetime, e.g. to counter a new attack vector.

For a development platform, the situation is different: the same board
will be used for various use cases, with different partitioning of
responsibilities, and will run various firmware versions.

> >   - There may be different SCP firmware lineages, e.g. proprietary and
> >     certified variants, and FLOSS variants,
>
> No sure if I understand the issue here.

Safety-critical products may require certified firmware, which may
be completely different from what is generally available.

> >   - SCMI features may differ across firmware versions,
>
> Again, features must be discoverable that is the advantage of DT vs this
> firmware interface, so not sure what is the issue in this matter.
>
> >   - SCMI may abstract the hardware in a different way, requiring changes
> >     in (possibly existing) DT bindings and drivers to support the same
> >     hardware with and without SCMI:
> >       - E.g. the number of SCMI clocks inputs to a hardware block may
> >       differ from the actual hardware,
> >       - E.g. hardware clock inputs may be abstracted as SCMI power
> >       domains (or vice versa), like on Qualcomm SA8255P[2].
>
> True, the moment SCMI like interface is used in OSPM, the firmware
> description hides real h/w details and provide what firmware thinks
> OSPM must view hardware as(how VMMs virtualise things for VMs, firmware
> can have similar effect with such interfaces).

So you end up with multiple compatible values for the same hardware
blocks, depending on direct hardware access or SCMI, and on the
actual firmware.
What is the policy for naming such compatible values?  How many
different DT bindings are we willing to support for the same hardware?
What about driver changes? Maintenance of all these drivers?

> >     Experience has taught that not describing the hardware in DT may
> >     lead to major issues later.

E.g. one may miss one internal clock input when describing a device in
DT, where control of the clock turns out to be critical for a specific
hardware feature?

> OK, that's interesting. But the whole point with these interfaces is to
> hide those, so just don't use such abstraction interface if you want the
> hardware to be described as is to the OSPM.

How do you fix it when everything is hidden, e.g. behind a single
virtual clock?

> >   - SCMI does not support the concept of a clock domain, so existing
> >     drivers can no longer rely on Runtime PM, but need to be changed to
> >     manage functional clocks explicitly,
>
> Not sure what that means, you mean clock protocol is not good enough to
> model the h/w clock domains on your platform ? If so, you are welcome to
> improve the specification.

It is common on embedded SoCs (e.g. TI, Rockchip, Renesas) to not only
have power domains that can be powered down, but also a clock domain:
a clock controller provides a common way to put a hardware module into
standby mode by gating its clock inputs.

In Linux PM Domains, the following callbacks are used:
  - generic_pm_domain.power_{on,off}(), to power a power domain on/off,
  - generic_pm_domain.dev_ops.{start,stop}(), to start/stop a device
    inside a power domain.
Both are handled automatically through Runtime PM
(pm_runtime_{resume_and_get,put}(dev)), so drivers don't need to care
about the intricate details.

However, for this to work, the PM Domain needs to know which clocks are
meant for module standby.  Without this knowledge, individual drivers
must control these module clocks explicitly.  During the last two
decades, lots of drivers have been converted from explicit module clock
control to Runtime PM, and reversing this would IMHO be a step backward.

I already posted patches before [1] to add support for clock domains
using a quirk.  Without a quirk, the SCMI clock protocol should be
extended to advertize whether a clock is intended for power-management
of a hardware module.  One way to handle this, the SCMI CLOCK_ATTRIBUTES
could be extended with a new flag in the returned attributes as I
pointed out in the cover letter of that series.

> >   - U-Boot IPL (Initial Program Loader) needs a proper hardware
> >     description in DT, not using SCMI.
>
> I am going to ignore that.

And of course we like the DT used by U-Boot (IPL or not) to be as close
as possible to the DT used by Linux.

Thanks, and have a nice weekend!

[1] Series "[PATCH/RFC 0/9] R-Car X5H Ironhide pure SCMI proof-of-concept"
  - "[PATCH/RFC 4/9] firmware: arm_scmi: Add a flag for power-management clocks"
  - "[PATCH/RFC 5/9] clk: scmi: Add scmi_clk_is_pm_clk()"
  - "[PATCH/RFC 6/9] dt-bindings: firmware: arm,scmi: Document arm,clock-domain"
  - "[PATCH/RFC 7/9] pmdomain: arm: scmi: Add clock domain support"
  - "[PATCH/RFC 8/9] firmware: arm_scmi: quirk: Handle power
management clocks on R-Car X5H"
https://lore.kernel.org/all/cover.1781171705.git.geert+renesas@glider.be/


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
