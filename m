Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5385271A6D;
	Sun, 17 May 2026 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779051503; cv=none; b=YCRG8yNXABoYYVHa7wNNUpcb6pgr8K1Qgq4PwHV5udiX3vUh+XYGLEEfVfCz1ekdd8dI1YL+ZqWGpH+4URphs9/fNsJXlNcYPRuznOjwi6bX/LdHcGf9udm355ku99lpUXbJCutlhQNA05iQvqDbl2NvOGIFOgZd+PcgbmlLDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779051503; c=relaxed/simple;
	bh=8YdDtosc2yuBrzAdShLNX5Aura5/QzNzsydkW/hbS2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To7zqGtw9qA2xaAEEt5zEVjFZGlH0qTV9SMs7gaDQfcwrPc69O5oTqs2TEeMifzq5U0yf8VUapTnWMAtNrLr87XzZn+dvPhPz7JPNCw0/xzItc0oSeqxkM/DpbLHF2ima065E4ENYfmsLEifL454omrQlDhaMFiO+aIzNraSG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FeT4EohV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FeT4EohV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96A1F19F0;
	Sun, 17 May 2026 13:58:14 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA24E3F632;
	Sun, 17 May 2026 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779051499; bh=8YdDtosc2yuBrzAdShLNX5Aura5/QzNzsydkW/hbS2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FeT4EohVSdz0//AGj/+rybSIAktQFGsZBGx+b2XCfQ2fy4e0lQGswwBNToLuCEbRH
	 fL+pIcQYwVjShNYdxaFGLRo9FGopvFEV0yggvFZyd2UCOGu+uHALw+dejaixXxB1Fh
	 l59MX3c3/vu+4oE8sBj7+q0p9sMB92tUZlrBNv4k=
Date: Sun, 17 May 2026 21:58:12 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ulf Hansson <ulfh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC 05/14] firmware: arm_scmi: Add scmi_get_base_info()
Message-ID: <agor5HJ0JFBoX3sZ@pluto>
References: <cover.1776793163.git.geert+renesas@glider.be>
 <72e2a0e7a5abda02fe36b3f5851842f7a77b2593.1776793163.git.geert+renesas@glider.be>
 <aekXUvIPb8nkhdKu@pluto>
 <CAMuHMdX8b9C3D8fV5th6GCgs6JAq7HZbF_SrOKz_gDy2H8ksow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX8b9C3D8fV5th6GCgs6JAq7HZbF_SrOKz_gDy2H8ksow@mail.gmail.com>

On Fri, May 15, 2026 at 05:39:45PM +0200, Geert Uytterhoeven wrote:
> Hi Christian,
> 
> On Wed, 22 Apr 2026 at 20:45, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > On Tue, Apr 21, 2026 at 08:11:38PM +0200, Geert Uytterhoeven wrote:
> > > Currently non-SCMI drivers cannot find out what the specific versions of
> > > each SCMI provider implementation on the running system are.
> >
> > Thanks for your patches....this is not a proper full review of the series,
> > BUT this patch catched my eye..
> >
> > Indeed, yes, it is deliberate that the SCMI version information is NOT
> > exposed out of the SCMI world, since being the SCMI an attempt to
> > standardize a common FW interface (as in [1] of course), you should not
> > know what runs inside the black-box, it should be irrelevant...
> >
> > ...indeed the versioning is used inside the SCMI stack to deal properly
> > with different protocol versions implemented by the server OR to apply
> > proper quirks when needed, but all the rest should be standard....
> 
> [...]
> 
> > I watched a bit of the LPC discussions around this (from Marek I think)
> > but sincerely most of those problems had one (not necessarily simple)
> > solution: fix your firmwares AND/OR apply quirks in the meantime...
> 
> So let's forward to the future, where the firmware is fixed, is fully
> compliant with the SCMI spec, and all IDs are stable, so no quirks are
> needed.
> 
> Where do we specify the SCMI IDs to use?  Unless when using the
> remapping driver proposed in this patch series, they must end up in the
> DTB.  Existing upstream users put them either in the SoC-specific .dtsi,
> or in board-specific .dts.
> 
> The SCMI server is supposed to expose to an agent (e.g. Linux) a
> sequential and contiguous list of IDs that represent only resources that
> the agent is allowed to use.
>   - We cannot put the SCMI IDs in the SoC-specific .dtsi, as that
>     describes all hardware in the SoC, which is typically much more than
>     Linux can or even wants to use when running on a specific board.
>   - You would think we could put the SCMI IDs in the board-specific
>     .dts.  However, that would limit actual use cases later, which do
>     not necessarily depend on the board solely.
>       - E.g. when moving control of the CAN-FD controller from Linux to
>         the Realtime OS, the CAN-FD node must be disabled in the DTB (by
>         overriding status to "reserved", or by just deleting the CAN-FD
>         node, both of which can be done by the boot loader). However,
>         with SCMI, the IDs corresponding to CAN-FD resources must be
>         removed from the ID space, causing a full renumbering. Who is
>         supposed to update the IDs in the DTB?

As per my previous email, after such a breaking change I would expect a
new DTB describing the new HW to be needed anyway.

>       - E.g. when partitioning a single Linux system in multiple VMs,
>         and distributing hardware across these VMs, all VMs need
>         different DTBs, each describing a subset of the hardware.  With
>         SCMI, each VM needs different SCMI ID spaces, causing not a
>         simple partitioning of the devices in the DTB, but also a
>         renumbering of all IDs.

Ok now I am lost..why do you need a distinct IDs space for each VM ?

In a virtualized env, I would expect to leverage the SCMI stack to
realize the exact opposite: same set of IDs advertised to each VM (and
so same DTB potentially) by the server which in turn can decide to
assign the same device (and handle the sharing) to some ID or assign
different devices to the same or different IDs on each VM: i.e. you
have a set of virtual_IDs that is what the server exposes to each VM
SCMI agent, and then a bunch of real physical IDs, without any contraint
on their numbering, that the server uses in the backstage to refer to
the real resources and that it properly remaps to each per-VM set of
exposed virtual_IDs during the build and/or boot board configuration
phase....i.e. when the FW adapts and reconfigures to the specific
board that is finally running on.

Thanks,
Cristian
