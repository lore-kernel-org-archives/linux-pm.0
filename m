Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF72DA756
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350460; cv=none; b=kd97XaH7uDR3cjKzz1CI3ZOWog5RT24JxAy8gzDtg6Du8cQruXvRmh/zoV/p49NAE/DQL157IzZNQVDysvssk05tu4/8iWg8zP8p+0v+nvvl7AsFLqAjrC90LlAsD+CRXv7Vv48PFDc549koFhbmEc7H2TLSQnPGXyGfcpTfTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350460; c=relaxed/simple;
	bh=+RDLim/geriyK6BHkVN+y+fbAsLHqr+xXa+qxaKtufQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKa2FPY47d/Szz82pdEvSoW6jcQ4KLb5XlVZvPT8XFmYk59vyI0z5qhxlV0qM5H1RU+VKi0wsX8+O21XLm5WHQbTFNKKg7oFfxE4jHq/d58lfdHgrGE3J09Tma5PNhBhD/RxUol1VNCIRoRy4fJEIZe4Ppe+TVF+R3WGHq362Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56f75445470so4513797e0c.2
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 01:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350457; x=1779955257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kh5ilGfgBOd7IY4hv5kPF1I4gBzJqYiKUxJVuEQxYWY=;
        b=ecU3eWB+DsR5TpEfuDzd3Fe05+uqlh+aBKWXE9Qc0iYhx34FnRGIeEsjZbmaA/b/Qm
         hyvu4Y9vcTNUXoyEkHojIDgXErNG0vGWE0mSlHCglk5Zm2dTl4hkNeWgjVJdpJbfddcT
         V0wNysobE0kjc7Iy/4rbGOOKqPssm6peXflSVOlmVmIEIkWuu9z8jINNi5GGiNcBYDUh
         XUR+wZ2F7rDUdQfE/l+6qVZPAB0P+vVIB/8bMZSy38F1IQyUhVLJ9dCT1QGBBnGN5vbZ
         RVDvVSl8NfYME8g6NKeaoGpOZo7nxIJ7Oo2v5K5u3H04muIjaaPv1lfFO//Kcmbr24vh
         yF1g==
X-Forwarded-Encrypted: i=1; AFNElJ887BDTOTWw6ecRuYNSR1f4mPW7/C556i2HtzEOT3BuXediD13Eayhs4kJIAydh5a7Nt3OCD5qFUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fZZghpx9y3n0Aap+KuvovGmxrcJQTBy3mXA9wKzAs4XjNaYl
	u/h7WaySo0iJN70KDKTlU7aJg8jDX1uiQ3gt1Pg/k7r4n9/M52becfF6nt3jJa0fa7M=
X-Gm-Gg: Acq92OHXZtf9RQti86oBLnpbNDZgfDDI5Cz1MY09yan4JvGqFoIBl/OB9FqB4pG8QQk
	we3OSXf6Lv6jKczcoT82ykHK8Vq/W4nOrV1guMWvujHO8T0hgXOqIaidXlfVZ1LqlplIovmtlCI
	YxzbDmlewXTjbyEm8eS6HvnStXAoGV2uLeSrnSUyVtgqqTttP8EBY24xH5XRbDb2bWSrGKWst4v
	Aq8/jBRt7zme/AQHKa2Md60Dpnl9MbEc/jo2wKzLuUuB58fLOXSrs8vnSr3DxN2Y357UIkdVPgn
	+u6cjvD5NHLY7w4kmXwQh4h9dkT1s5JMrQqURtQFXYMZ0isuo+V7b+IA5LJqzkk25oX1t/DoF63
	FmomDV4vVc5NB+srRXgaLLacewsVNy2YIQ20HSJIsNPGu0WmCXXBSiEyILjXK3D2VxHN2DcCjQc
	PzDOFAcJe/0LNhZVE5qj99mhgntkFf8kNzdrIz8h8NGzB7mQYyzXo4b2FiAi+EOXYWtyLGlfQ=
X-Received: by 2002:a05:6123:2c3:b0:575:ad04:4b90 with SMTP id 71dfb90a1353d-58427bae9aemr678221e0c.7.1779350457387;
        Thu, 21 May 2026 01:00:57 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760fa9699fsm13890368e0c.13.2026.05.21.01.00.56
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 01:00:56 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6314c3818baso4496136137.1
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 01:00:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/T/YTlddYXGsJmkxvtNmbAkkHeKDUb3/F6Mv88+TepieFcXUZ1v99uw1DajxTWxcDxqG1SBgEGZg==@vger.kernel.org
X-Received: by 2002:a05:6102:952:b0:660:cba2:b6a5 with SMTP id
 ada2fe7eead31-6738d46a2c9mr965451137.7.1779350455953; Thu, 21 May 2026
 01:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776793163.git.geert+renesas@glider.be> <72e2a0e7a5abda02fe36b3f5851842f7a77b2593.1776793163.git.geert+renesas@glider.be>
 <aekXUvIPb8nkhdKu@pluto> <CAMuHMdX8b9C3D8fV5th6GCgs6JAq7HZbF_SrOKz_gDy2H8ksow@mail.gmail.com>
 <agor5HJ0JFBoX3sZ@pluto>
In-Reply-To: <agor5HJ0JFBoX3sZ@pluto>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 May 2026 10:00:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWJrXcp7_S-KTKQJ8NuVhywiCWEHXMVvWkTFZwnmQayyA@mail.gmail.com>
X-Gm-Features: AVHnY4LKAf9GYj9Cj8Ma9x6mjosVr-AC-oJEzWQ_9yBj7Yua2eAsFSXzEFT0UeE
Message-ID: <CAMuHMdWJrXcp7_S-KTKQJ8NuVhywiCWEHXMVvWkTFZwnmQayyA@mail.gmail.com>
Subject: Re: [PATCH/RFC 05/14] firmware: arm_scmi: Add scmi_get_base_info()
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
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

On Sun, 17 May 2026 at 22:58, Cristian Marussi <cristian.marussi@arm.com> wrote:
> On Fri, May 15, 2026 at 05:39:45PM +0200, Geert Uytterhoeven wrote:
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
> >
> > [...]
> >
> > > I watched a bit of the LPC discussions around this (from Marek I think)
> > > but sincerely most of those problems had one (not necessarily simple)
> > > solution: fix your firmwares AND/OR apply quirks in the meantime...
> >
> > So let's forward to the future, where the firmware is fixed, is fully
> > compliant with the SCMI spec, and all IDs are stable, so no quirks are
> > needed.
> >
> > Where do we specify the SCMI IDs to use?  Unless when using the
> > remapping driver proposed in this patch series, they must end up in the
> > DTB.  Existing upstream users put them either in the SoC-specific .dtsi,
> > or in board-specific .dts.
> >
> > The SCMI server is supposed to expose to an agent (e.g. Linux) a
> > sequential and contiguous list of IDs that represent only resources that
> > the agent is allowed to use.
> >   - We cannot put the SCMI IDs in the SoC-specific .dtsi, as that
> >     describes all hardware in the SoC, which is typically much more than
> >     Linux can or even wants to use when running on a specific board.
> >   - You would think we could put the SCMI IDs in the board-specific
> >     .dts.  However, that would limit actual use cases later, which do
> >     not necessarily depend on the board solely.
> >       - E.g. when moving control of the CAN-FD controller from Linux to
> >         the Realtime OS, the CAN-FD node must be disabled in the DTB (by
> >         overriding status to "reserved", or by just deleting the CAN-FD
> >         node, both of which can be done by the boot loader). However,
> >         with SCMI, the IDs corresponding to CAN-FD resources must be
> >         removed from the ID space, causing a full renumbering. Who is
> >         supposed to update the IDs in the DTB?
>
> As per my previous email, after such a breaking change I would expect a
> new DTB describing the new HW to be needed anyway.

The underlying hardware would still be the same...

> >       - E.g. when partitioning a single Linux system in multiple VMs,
> >         and distributing hardware across these VMs, all VMs need
> >         different DTBs, each describing a subset of the hardware.  With
> >         SCMI, each VM needs different SCMI ID spaces, causing not a
> >         simple partitioning of the devices in the DTB, but also a
> >         renumbering of all IDs.
>
> Ok now I am lost..why do you need a distinct IDs space for each VM ?

Aren't the different VMs different SCMI agents?  If not, how do you
prevent them from stepping on each other's resources?

> In a virtualized env, I would expect to leverage the SCMI stack to
> realize the exact opposite: same set of IDs advertised to each VM (and
> so same DTB potentially) by the server which in turn can decide to
> assign the same device (and handle the sharing) to some ID or assign
> different devices to the same or different IDs on each VM: i.e. you
> have a set of virtual_IDs that is what the server exposes to each VM
> SCMI agent, and then a bunch of real physical IDs, without any contraint
> on their numbering, that the server uses in the backstage to refer to
> the real resources and that it properly remaps to each per-VM set of
> exposed virtual_IDs during the build and/or boot board configuration
> phase....i.e. when the FW adapts and reconfigures to the specific
> board that is finally running on.

Again[1], how would that work?  Clock, resets, and power domains are
not the final resources that are used by the OS.  They are merely
resources for devices that are described in DTB with other resources
(MMIO register ranges, interrupt numbers, ...) which are not handled
by SCMI.  If the server remaps e.g. a clock to a different clock,
it will no longer work with the corresponding device described in DT.

[1] https://lore.kernel.org/all/CAMuHMdVunEehM01pLa3t5a6o0NmMOCQRwh7n5J+OkDk2YR9kUA@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
