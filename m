From: Michel Pollet <michel.pollet@bp.renesas.com>
Subject: RE: [PATCH v3 2/8] DT: reset: renesas,rzn1-reboot: document RZ/N1
 reboot driver
Date: Tue, 10 Apr 2018 07:08:45 +0000
Message-ID: <OSBPR01MB2054DA948D0301F20AB9F1EDD2BE0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-3-git-send-email-michel.pollet@bp.renesas.com>
 <20180409201027.ydlvyx72mrt5fphh@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409201027.ydlvyx72mrt5fphh@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Phil Edworthy <phil.edworthy@renesas.com>, Michel Pollet <buserror+upstream@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 09 April 2018 21:10,  Rob Herring wrote:
> On Thu, Mar 29, 2018 at 08:46:58AM +0100, Michel Pollet wrote:
> > The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver as part
> > of the sysctrl MFD to handle rebooting the CA7 cores.
> > This documents the driver bindings.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > ---
> >  .../bindings/power/renesas,rzn1-reboot.txt           | 20
> ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> > b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> > new file mode 100644
> > index 0000000..f592769
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/renesas,rzn1-
> reboot.txt
> > @@ -0,0 +1,20 @@
> > +DT bindings for the Renesas RZ/N1 Reboot Driver
> > +
> > +=3D=3D Reboot Driver Node =3D=3D
> > +
> > +The reboot driver is always a subnode of the system controller node,
> > +see renesas,rzn1-sysctrl.txt for details.
> > +
> > +Bindings:
> > ++ Required:
> > +compatible =3D "renesas,rzn1-reboot";
> > +
> > +Example:
> > +sysctrl: sysctrl@4000c000 {
> > +compatible =3D "renesas,rzn1-sysctrl", "syscon", "simple-mfd";
>
> Are there other functions for this block? If so, please define a complete
> binding for the block.

There are indeed multiple functions for this particular IP block. It's pret=
ty much a
kitchen sink of clocks, pinmux, reboot, watchdog, SMP and probably a couple
more I forgot about!

We've discussed this MFD structure with Geert, we picked that because if I
were to add all these callbacks/drivers to a 'sysctrl' driver, it'd end up =
looking
like ... a mach-xx.c file in the end!
So the current version is just a placeholder for a single driver for now, b=
ut it
won't last, there's already a SMP core enable driver lined up next...

>
> > +reg =3D <0x4000c000 0x1000>;
> > +
> > +reboot {
> > +compatible =3D "renesas,rzn1-reboot";
>
> Why is this node needed? The driver for "renesas,rzn1-sysctrl" should be
> able to register as a reboot handler/driver/provider.

Please see above...

>
> Rob

Thanks for your input!
Michel




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
