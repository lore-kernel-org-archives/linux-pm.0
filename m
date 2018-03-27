From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v1 01/16] dt-bindings: power: reset: mediatek: add
 bindings for power device
Date: Tue, 27 Mar 2018 11:21:46 +0800
Message-ID: <1522120906.18424.21.camel@mtkswgap22>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <c5527464207b02d40f1c2682feb97ebf5dd443be.1521794176.git.sean.wang@mediatek.com>
         <20180326222455.6kou2rdn76k6p6ct@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180326222455.6kou2rdn76k6p6ct@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, eddie.huang@mediatek.com, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-03-26 at 17:24 -0500, Rob Herring wrote:
> On Fri, Mar 23, 2018 at 05:14:58PM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Add device-tree binding for the power device responsible for shutdown a
> > remote SoC, which is a tiny circuit block present on MediaTek PMIC based
> > RTC.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  .../bindings/power/reset/mt6397-rtc-poweroff.txt   | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt b/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
> > new file mode 100644
> > index 0000000..75a9d7d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
> > @@ -0,0 +1,24 @@
> > +Device-Tree bindings for Power Device on MediaTek PMIC RTC
> > +
> > +The power device is responsible for externally power off or on the remote
> > +MediaTek SoC through the a tiny circuit block BBPU inside PMIC RTC.
> > +
> > +Required parent node:
> > +- rtc
> > +	For MediaTek PMIC RTC bindings, see:
> > +	Documentation/devicetree/bindings/mfd/mt6397.txt
> > +
> > +Required properties:
> > +- compatible: Should be one of follows
> > +	"mediatek,mt6323-rtc-poweroff": for MT6323 PMIC
> > +	"mediatek,mt6397-rtc-poweroff": for MT6397 PMIC
> > +
> > +Example:
> > +
> > +	rtc {
> > +		compatible = "mediatek,mt6323-rtc";
> > +
> > +		power-off {
> > +			compatible = "mediatek,mt6323-rtc-poweroff";
> > +		};
> 
> There's no need for this node. The OS can register a device in the rtc 
> driver.
> 

It seems a good way.

I will remove the really simple dt-binding and use a
platform_device_register_simple api embedded in rtc driver to
register the power-off device.

Hope I do not misconception your points addressed here.

> > +	};
> > -- 
> > 2.7.4
> > 
