From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC v2 01/11] PM / Domains: Add DT bindings for the R-Car System Controller
Date: Tue, 16 Feb 2016 01:33:30 +0200
Message-ID: <5091338.oFBh65VqCT@avalon>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be> <1455571020-18968-2-git-send-email-geert+renesas@glider.be> <1720075.YOPnCQ3mE1@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1720075.YOPnCQ3mE1@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 16 February 2016 01:08:18 Laurent Pinchart wrote:
> On Monday 15 February 2016 22:16:50 Geert Uytterhoeven wrote:
> > The Renesas R-Car System Controller provides power management for the
> > CPU cores and various coprocessors, following the generic PM domain
> > bindings in Documentation/devicetree/bindings/power/power_domain.txt.
> > 
> > This supports R-Car Gen1, Gen2, and Gen3.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---

[snip]
> > 
> >  .../bindings/power/renesas,sysc-rcar.txt           | 87 +++++++++++++++++
> >  1 file changed, 87 insertions(+) create mode 100644
> > 
> > Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt
> > b/Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt new file
> > mode 100644
> > index 0000000000000000..92ddc0da7b755215
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt
> > @@ -0,0 +1,87 @@

[snip]

> > +  - pm-domains: This node contains a hierarchy of PM Domain Nodes.
> 
> Can't it be an issue that the node happens to have the same name as the
> standard pm-domains property ?

Scratch this, it's power-domains, not pm-domains, mybad.

> > +    Dependencies (e.g. parent SCUs should not be powered off while child
> > CPUs
> > +    are on) should be reflected using subnodes.

-- 
Regards,

Laurent Pinchart
