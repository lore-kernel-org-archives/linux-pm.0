From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/8] net/macb: bindings doc/trivial: fix documentation for
 sama5d3 10/100 interface
Date: Tue, 22 Jan 2019 07:41:02 -0600
Message-ID: <CAL_Jsq+31C2KXNy_GeVU9g7mZ_aSw3yqdjU-V5mV2Xdc200TuA@mail.gmail.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <0005c2ef28b985c663e0cd058bbc6d3856e05ec2.1547629763.git.nicolas.ferre@microchip.com>
 <20190122011014.GA25211@bogus> <be8ba0bf-993e-d38c-61e8-af422ff3c636@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be8ba0bf-993e-d38c-61e8-af422ff3c636@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <Nicolas.Ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <Ludovic.Desroches@microchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Linux USB List <linux-usb@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 22, 2019 at 3:09 AM <Nicolas.Ferre@microchip.com> wrote:
>
> Hi Rob,
>
> On 22/01/2019 at 02:10, Rob Herring wrote:
> > On Wed, Jan 16, 2019 at 10:57:40AM +0100, Nicolas Ferre wrote:
> >> This removes a line left while adding the correct compatibility string for
> >> sama5d3 10/100 interface. Now use the "atmel,sama5d3-macb" string.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >> ---
> >>   Documentation/devicetree/bindings/net/macb.txt | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
> >> index 3e17ac1d5d58..f5c414b10e27 100644
> >> --- a/Documentation/devicetree/bindings/net/macb.txt
> >> +++ b/Documentation/devicetree/bindings/net/macb.txt
> >> @@ -3,8 +3,7 @@
> >>   Required properties:
> >>   - compatible: Should be "cdns,[<chip>-]{macb|gem}"
> >>     Use "cdns,at91rm9200-emac" Atmel at91rm9200 SoC.
> >> -  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs or the 10/100Mbit IP
> >> -  available on sama5d3 SoCs.
> >> +  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs.
> >
> > Where is "atmel,sama5d3-macb"?
>
> It's actually a couple of line below: line 13 of the resulting macb.txt
> file. It was already in the file when I removed the leftovers.
>
> Do you advice to try to better sort entries in this file? Is there a
> common pattern?

Okay, it's fine.

Reviewed-by: Rob Herring <robh@kernel.org>
