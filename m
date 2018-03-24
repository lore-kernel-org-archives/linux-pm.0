From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v1 02/16] dt-bindings: rtc: mediatek: add bindings for
 PMIC RTC
Date: Sun, 25 Mar 2018 03:36:28 +0800
Message-ID: <1521920188.31197.13.camel@mtkswgap22>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <5846e8be319c4836808c8127d5bb51b7e999e896.1521794177.git.sean.wang@mediatek.com>
         <20180323094118.GC3417@piout.net> <20180323101505.GF3417@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323101505.GF3417@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it, eddie.huang@mediatek.com, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2018-03-23 at 11:15 +0100, Alexandre Belloni wrote:
> On 23/03/2018 at 10:41:18 +0100, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 23/03/2018 at 17:14:59 +0800, sean.wang@mediatek.com wrote:
> > > From: Sean Wang <sean.wang@mediatek.com>
> > > 
> > > Add device-tree binding for MediaTek PMIC based RTC.
> > > 
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/rtc/rtc-mt6397.txt         | 39 ++++++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> > > new file mode 100644
> > > index 0000000..83ff6be
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> > > @@ -0,0 +1,39 @@
> > > +Device-Tree bindings for MediaTek PMIC based RTC
> > > +
> > > +MediaTek PMIC based RTC is an independent function of MediaTek PMIC which
> > > +is working as a multi-function device (MFD). And the RTC can be configured and
> > > +set up via PMIC wrapper bus. Which is also common resource shared among the
> > > +other functions present on the PMIC.
> > > +
> > > +For MediaTek PMIC wrapper bus bindings, see:
> > > +Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> > > +
> > > +Required parent node:
> > > +- pmic
> > > +  For MediaTek PMIC MFD bindings, see:
> > > +  Documentation/devicetree/bindings/mfd/mt6397.txt
> > > +
> > > +Required properties:
> > > +- compatible: Should be one of follows
> > > +	"mediatek,mt6323-rtc": for MT6323 PMIC
> > > +	"mediatek,mt6397-rtc": for MT6397 PMIC
> > > +
> > > +Optional child node:
> > > +- power-off
> > > +  For Power-Off Device for MediaTek PMIC RTC bindings, see:
> > > +  Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
> > > +
> > > +Example:
> > > +
> > > +	pmic {
> > > +		compatible = "mediatek,mt6323";
> > > +
> > > +		...
> > > +		rtc {
> > > +			compatible = "mediatek,mt6323-rtc";
> > > +
> > > +			power-off {
> > > +				compatible = "mediatek,mt6323-rtc-poweroff";
> > > +			};
> > 
> > I'm pretty sure the whole point of mfd is to avoid having the poweroff
> > controller under the rtc
> > 
> 
> BTW, I think it is enough to have that documented in only one file (the
> MFD one is enough)
> 

just reply both replies in the same mail

1.) the power-off device is a part of rtc, use the same registers rtc
has and thus it is put as child nodes under the node rtc to reflect the
reality of characteristics the rtc has.

Or am I wrong for a certain aspect in these opinions?

2) the other sub-functions for the same pmic already created its own
dt-binding document belonged to its corresponding subsystem. Don't we
really want to follow it them all?

> > 
> > -- 
> > Alexandre Belloni, Bootlin (formerly Free Electrons)
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> 
