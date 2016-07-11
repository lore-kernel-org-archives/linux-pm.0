From: dawei chien <dawei.chien@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for
 Mediatek thermal controller
Date: Mon, 11 Jul 2016 16:52:04 +0800
Message-ID: <1468227124.15776.29.camel@mtksdaap41>
References: <1467882386-40544-1-git-send-email-dawei.chien@mediatek.com>
	 <1467882386-40544-2-git-send-email-dawei.chien@mediatek.com>
	 <577E385C.9080501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <577E385C.9080501@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Erin Lo <erin.lo@mediatek.com>
List-Id: linux-pm@vger.kernel.org

Dear Keerthy,

On Thu, 2016-07-07 at 16:39 +0530, Keerthy wrote:
> 
> On Thursday 07 July 2016 02:36 PM, Dawei Chien wrote:
> > This adds the device tree binding documentation for the mediatek thermal
> > controller found on Mediatek MT2701.
> >
> > Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> > ---
> >   .../bindings/thermal/mediatek-thermal.txt          |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > index 81f9a51..bb55e79 100644
> > --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > @@ -8,7 +8,7 @@ apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
> >   is also needed.
> >
> >   Required properties:
> > -- compatible: "mediatek,mt8173-thermal"
> > +- compatible: "mediatek,mt8173-thermal" or "mediatek,mt2701-thermal"
> 
> - compatible :
>   - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
>   - "mediatek,mt2701-thermal" : For MT2701 family of SoCs

Thank you, I will update it on next version.

> 
> >   - reg: Address range of the thermal controller
> >   - interrupts: IRQ for the thermal controller
> >   - clocks, clock-names: Clocks needed for the thermal controller. required
> >
