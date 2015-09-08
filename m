From: dawei chien <dawei.chien@mediatek.com>
Subject: Re: [PATCH 2/2] arm64: dts: mt8173: Add thermal zone node for
 mt8173.
Date: Tue, 8 Sep 2015 23:50:12 +0800
Message-ID: <1441727412.20470.43.camel@mtksdaap41>
References: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
	 <1441357309-61669-3-git-send-email-dawei.chien@mediatek.com>
	 <CAGS+omAxWDj+fHsJQhJ-KhFdWPZ-ymcVr63v5Q7ho2bAL_7PBQ@mail.gmail.com>
	 <CAGS+omDne19U+BzCQ8o9Hte=cDXNF3SL7zLE33UEFgWgMsPpOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:35672 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755139AbbIHPuP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 11:50:15 -0400
In-Reply-To: <CAGS+omDne19U+BzCQ8o9Hte=cDXNF3SL7zLE33UEFgWgMsPpOQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Eddie Huang <eddie.huang@mediatek.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Howard Chen <howard.chen@linaro.org>, Yingjoe Chen <yingjoe.chen@mediatek.com>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstr

Hi Daniel,
On Mon, 2015-09-07 at 12:05 +0800, Daniel Kurtz wrote:
> On Mon, Sep 7, 2015 at 12:00 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> > Hi Dawei,
> >
> > On Fri, Sep 4, 2015 at 5:01 PM, Dawei Chien <dawei.chien@mediatek.com> wrote:
> >> Add thermal zone node to mt8173.dtsi.
> >>
> >> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> >> ---
> >> This patch is base on following patches
> >> https://patchwork.kernel.org/patch/6969581/
> >> https://patchwork.kernel.org/patch/6969571/
> >> https://patchwork.kernel.org/patch/6969381/
> >> ---
> >>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   44 ++++++++++++++++++++++++++++++
> >>  1 file changed, 44 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >> index 208051a..6493bfd 100644
> >> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >> @@ -17,6 +17,7 @@
> >>  #include <dt-bindings/power/mt8173-power.h>
> >>  #include <dt-bindings/reset-controller/mt8173-resets.h>
> >>  #include "mt8173-pinfunc.h"
> >> +#include <dt-bindings/thermal/thermal.h>
> 
> Also, as a nit, (#include <dt-bindings/thermal/mt8173.h>) should be
> above '#include "mt8173-pinfunc.h"'
Thank you, I will resend this patch with mt8171.h and sort header file.

> -djk


