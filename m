From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v1 02/16] dt-bindings: rtc: mediatek: add bindings for
 PMIC RTC
Date: Fri, 23 Mar 2018 11:15:05 +0100
Message-ID: <20180323101505.GF3417@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
 <5846e8be319c4836808c8127d5bb51b7e999e896.1521794177.git.sean.wang@mediatek.com>
 <20180323094118.GC3417@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180323094118.GC3417-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 23/03/2018 at 10:41:18 +0100, Alexandre Belloni wrote:
> Hi,
> 
> On 23/03/2018 at 17:14:59 +0800, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 
> > Add device-tree binding for MediaTek PMIC based RTC.
> > 
> > Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  .../devicetree/bindings/rtc/rtc-mt6397.txt         | 39 ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> > new file mode 100644
> > index 0000000..83ff6be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> > @@ -0,0 +1,39 @@
> > +Device-Tree bindings for MediaTek PMIC based RTC
> > +
> > +MediaTek PMIC based RTC is an independent function of MediaTek PMIC which
> > +is working as a multi-function device (MFD). And the RTC can be configured and
> > +set up via PMIC wrapper bus. Which is also common resource shared among the
> > +other functions present on the PMIC.
> > +
> > +For MediaTek PMIC wrapper bus bindings, see:
> > +Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> > +
> > +Required parent node:
> > +- pmic
> > +  For MediaTek PMIC MFD bindings, see:
> > +  Documentation/devicetree/bindings/mfd/mt6397.txt
> > +
> > +Required properties:
> > +- compatible: Should be one of follows
> > +	"mediatek,mt6323-rtc": for MT6323 PMIC
> > +	"mediatek,mt6397-rtc": for MT6397 PMIC
> > +
> > +Optional child node:
> > +- power-off
> > +  For Power-Off Device for MediaTek PMIC RTC bindings, see:
> > +  Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
> > +
> > +Example:
> > +
> > +	pmic {
> > +		compatible = "mediatek,mt6323";
> > +
> > +		...
> > +		rtc {
> > +			compatible = "mediatek,mt6323-rtc";
> > +
> > +			power-off {
> > +				compatible = "mediatek,mt6323-rtc-poweroff";
> > +			};
> 
> I'm pretty sure the whole point of mfd is to avoid having the poweroff
> controller under the rtc
> 

BTW, I think it is enough to have that documented in only one file (the
MFD one is enough)

> 
> -- 
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
