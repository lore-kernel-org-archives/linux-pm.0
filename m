From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: arm: atmel: add new sam9x60 reset
 controller binding
Date: Tue, 22 Jan 2019 07:40:26 -0600
Message-ID: <CAL_JsqLb3W=UG5VRFheGd2CfS+8rb5pJpHmHNq2bb1zrR3mEwA@mail.gmail.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <ed46005be5beff6efc47d40cea304185efa2bcc0.1547629763.git.nicolas.ferre@microchip.com>
 <20190122010733.GA21139@bogus> <24a53365-1a8c-51cd-dcd4-db4a69d5256a@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <24a53365-1a8c-51cd-dcd4-db4a69d5256a@microchip.com>
Sender: netdev-owner@vger.kernel.org
To: Nicolas Ferre <Nicolas.Ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <Ludovic.Desroches@microchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Linux USB List <linux-usb@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 22, 2019 at 3:00 AM <Nicolas.Ferre@microchip.com> wrote:
>
> Hi Rob,
>
> On 22/01/2019 at 02:07, Rob Herring wrote:
> > On Wed, Jan 16, 2019 at 10:57:38AM +0100, Nicolas Ferre wrote:
> >> Update the Reset Controller's binding to add new SoC compatibility string.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >> ---
> >>   Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> >> index 36952cc39993..badce6ef3ab3 100644
> >> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> >> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> >> @@ -22,6 +22,7 @@ Its subnodes can be:
> >>   RSTC Reset Controller required properties:
> >>   - compatible: Should be "atmel,<chip>-rstc".
> >>     <chip> can be "at91sam9260", "at91sam9g45", "sama5d3" or "samx7"
> >> +  it also can be "microchip,sam9x60-rstc"
> >
> > How is this related to at91sam9260-rstc?
>
> at91sam9260 and sam9x60 are completely different products (they share
> the same core though...). I know the naming could be misleading but it
> is like it is...
>
> > The 'x' is a wildcard? We generally avoid wildcards.
>
> Here, the 'x' is definitively not a wildcard nor a kind of "family"
> name, it's included in the (upcoming) single product's name.
>
> I hope it clarifies.

Yes, thanks.

Reviewed-by: Rob Herring <robh@kernel.org>
