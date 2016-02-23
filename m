From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH/RFC v2 01/11] PM / Domains: Add DT bindings for the R-Car
 System Controller
Date: Tue, 23 Feb 2016 14:08:51 -0600
Message-ID: <20160223200851.GA468@rob-hp-laptop>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
 <1455571020-18968-2-git-send-email-geert+renesas@glider.be>
 <20160218143826.GB9654@rob-hp-laptop>
 <CAMuHMdXqVL6_P6Lnea6z8jFtR2v4NFnzn=ibZVyauZ8-ODb6dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXqVL6_P6Lnea6z8jFtR2v4NFnzn=ibZVyauZ8-ODb6dg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 18, 2016 at 06:18:56PM +0100, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Thu, Feb 18, 2016 at 3:38 PM, Rob Herring <robh@kernel.org> wrote:
> > On Mon, Feb 15, 2016 at 10:16:50PM +0100, Geert Uytterhoeven wrote:
> >> The Renesas R-Car System Controller provides power management for the
> >> CPU cores and various coprocessors, following the generic PM domain
> >> bindings in Documentation/devicetree/bindings/power/power_domain.txt.
> >>
> >> This supports R-Car Gen1, Gen2, and Gen3.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---

> >>   - Keeping the power register block offset and the bit number as separate
> >>     "reg" cells, increasing "#address-cells" from 2 to 3,
> >>
> >>   - Merging the interrupt bit (which needs only 5 bits) in the other "reg"
> >>     cell, decreasing "#address-cells" from 2 to 1.
> >
> > I think I'd move to not encoding mulitple things into reg. This seems
> > like a bit of abuse of reg. Otherwise, I don't have much to comment on.
> 
> Thanks!
> 
> (quoting the encoding of the reg properties)
> > +== PM Domain Nodes ==
> > +
> > +Each of the PM domain nodes represents a PM domain, as documented by the
> > +generic PM domain bindings in
> > +Documentation/devicetree/bindings/power/power_domain.txt.
> > +
> > +Required properties:
> > +  - #power-domain-cells: Must be 0.
> > +  - reg: This property must contain 2 values:
> > +          - The first value is the number of the interrupt bit representing
> > +            the power area in the various Interrupt Registers (e.g. SYSCISR,
> > +            Interrupt Status Register),
> > +          - The second value encodes the power register block offset (which is
> > +            a multiple of 64), and the number of the bit representing the
> > +            power area in the various Power Control Registers (e.g. PWROFFSR,
> > +            Power Shutoff Status Register). This value is created by ORing
> > +            these two numbers.
> 
> Not encoding multiple things into reg means adding more properties to provide
> that information, iff we want to describe the PM Domain Nodes in DT.
> I considered the reg property a two-dimensional address space.
> 
> Taking the lessons from CCF and the new CPG/MSSR bindings into account
> (which was BTW designed after the SYSC DT bindings), perhaps the PM Domain
> hierarchy should be moved from DT to C, in the driver, too?
> 
> That would mean we have in DT:
>   1) "#power-domain-cells = <1>"
>   2) defines for the various domains, e.g. "#define R8A7791_PD_CA15_SCU      12"
>   3) e.g. "power-domains = <&sysc R8A7791_PD_CA15_SCU>"
>   4) and we can get rid of the fallback compatibility strings again.
> 
> Thoughts?

Seems fine to me.

Rob
