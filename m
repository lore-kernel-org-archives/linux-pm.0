From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v5 3/6] dt-bindings: arm: Document the RZN1D-DB board
Date: Mon, 23 Apr 2018 12:02:52 +0200
Message-ID: <20180423100248.et7lsq25fmmxdhrn@verge.net.au>
References: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523963101-56725-4-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdU4upXcYZ_yD2a_=J5VAUE28fni7_NotmchjpYUqCxV=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU4upXcYZ_yD2a_=J5VAUE28fni7_NotmchjpYUqCxV=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michel Pollet <michel.pollet@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phil Edworthy <phil.edworthy@renesas.com>, Michel Pollet <buserror+upstream@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 17, 2018 at 05:49:25PM +0200, Geert Uytterhoeven wrote:
> Hi Michel,
> 
> On Tue, Apr 17, 2018 at 1:04 PM, Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
> > This documents the RZ/N1 bindings for the RZN1D-DB board.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/arm/shmobile.txt | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> > index 61b486f..6efb3f1 100644
> > --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> > +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> > @@ -51,7 +51,8 @@ SoCs:
> >      compatible = "renesas,r8a77990"
> >    - R-Car D3 (R8A77995)
> >      compatible = "renesas,r8a77995"
> > -
> > +  - RZ/N1D (R9A06G032)
> > +    compatible = "renesas,r9a06g032", "renesas,rzn1"
> 
> Why do you need a family-specific compatible value ("renesas,rzn1",
> which is a marketing name)?

Thanks Michel, Thanks Geert,

it looks like this extra compatible value should be dropped.
Its not consistent with the way other Renesas SoC families are handled
and past experience has not lead us to want family-specific compatible
values.
