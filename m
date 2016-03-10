From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 7/7] soc: renesas: Add r8a7795 SYSC PM Domain Binding Definitions
Date: Thu, 10 Mar 2016 10:54:21 +0200
Message-ID: <1579605.LMd6ZIAa80@avalon>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be> <1636171.nVxheqdHqq@avalon> <CAMuHMdUyFy427ydtojd_4uDUuxUs0Erf-KDJR1y-dMzy3o_vgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:54888 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbcCJIyV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2016 03:54:21 -0500
In-Reply-To: <CAMuHMdUyFy427ydtojd_4uDUuxUs0Erf-KDJR1y-dMzy3o_vgA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org

Hi Geert,

On Thursday 10 March 2016 09:17:40 Geert Uytterhoeven wrote:
> On Thu, Mar 10, 2016 at 3:32 AM, Laurent Pinchart wrote:
> > On Wednesday 09 March 2016 20:18:42 Geert Uytterhoeven wrote:
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> 
> >> --- /dev/null
> >> +++ b/include/dt-bindings/power/r8a7795-sysc.h
> >> @@ -0,0 +1,42 @@
> >> 
> >> +/* Always-on power area */
> >> +#define R8A7795_PD_ALWAYS_ON         32
> > 
> > Shouldn't we also define the always-on power domain for the other SoCs
> > (patches 2/7 to 6/7 in this series) ? I know they're already covered by
> > the cpg power domain, but going forward I believe that standardizing on
> > the SYSC power domains would be beneficial. We of course have to keep
> > backward compatibility in the implementation.
> 
> Yes, that's the plan. I didn't want to make that change now, as someone
> may object against the always-on power domain. On r8a7795 it feels more
> natural, as it also has I/O devices in SYSC power areas, unlike R-Car Gen2
> and H1.

That's fine with me.

> Note that it also complicates the rcar-sysc core driver: it has to choose
> between the cpg_mssr_*() or cpg_mstp_*() callbacks, depending on SoC, and
> also depending on DTS if we migrate the older SoCs to CPG/MSSR and want to
> maintain backwards-compatibility.
> 
> Time to finish the "renesas,apmu" enable-method work, and celebrate one big
> flag day for all the new DT evolutions?

I'll bring champagne ;-)

-- 
Regards,

Laurent Pinchart

