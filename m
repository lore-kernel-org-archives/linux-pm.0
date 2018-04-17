From: Michel Pollet <michel.pollet@bp.renesas.com>
Subject: RE: [PATCH v4 3/8] dt-bindings: mfd: renesas,rzn1-sysctrl: document
 RZ/N1 sysctrl node
Date: Tue, 17 Apr 2018 07:56:40 +0000
Message-ID: <OSBPR01MB20548CE7A728549EFA2B9ADBD2B70@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523349015-37985-4-git-send-email-michel.pollet@bp.renesas.com>
 <20180413180549.yjzkl2yf7osz7myt@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180413180549.yjzkl2yf7osz7myt@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Phil Edworthy <phil.edworthy@renesas.com>, "buserror+upstream@gmail.com" <buserror+upstream@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 13 April 2018 19:06, Rob Herring:
> On Tue, Apr 10, 2018 at 09:30:03AM +0100, Michel Pollet wrote:
> > The Renesas RZ/N1 Family (Part #R9A06G0xx) has a multi-function system
> > controller. This documents the node used to encapsulate it's sub
> > drivers.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > ---
> >  .../bindings/mfd/renesas,rzn1-sysctrl.txt          | 23
> ++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> > b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> > new file mode 100644
> > index 0000000..9897f8f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> > @@ -0,0 +1,23 @@
> > +DT bindings for the Renesas RZ/N1 System Controller
> > +
> > +=3D=3D System Controller Node =3D=3D
> > +
> > +The system controller node currently only hosts a single sub-node to
> > +handle the rebooting of the CPU. Eventually it will host the clock
> > +driver, SMP start handler, watchdog etc.
>
> Please submit a complete binding for the h/w block.
>
> Again, if the only reason you have sub nodes is to define compatible stri=
ngs
> and in turn enumerate drivers, then you don't need the nodes in DT. DT is
> not the only way to instantiate drivers.

I can't document it before I have the code. There is 0.000% chance of my cl=
ock
driver for example to be upstreamed the way I would imagine making it -- in
fact pretty much any other driver will have to be reworked to fit, so docum=
enting
bindings first is impossible.

So, if I understand correctly, you are telling me to make a 'sysctrl' drive=
r and use
platform_device to instantiate my sub-drivers? Isn't that what machine file=
s used
to do? And they are now banned?

Geert, any guidance here?

>
> Rob

Thanks!
Michel




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
