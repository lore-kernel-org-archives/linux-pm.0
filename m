From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 3/6] thermal:exynos4: TMU device tree support for
 Exynos4412 targets
Date: Tue, 23 Apr 2013 08:19:14 +0200
Message-ID: <20130423081914.3a5d669d@amdc308.digital.local>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
 <1366389493-8239-4-git-send-email-l.majewski@samsung.com>
 <CAK9yfHyD3KxO1J-Au8wxibjnUoLk+3MjSB_OvY2r44cHBiropg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30339 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab3DWGT3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 02:19:29 -0400
In-reply-to: <CAK9yfHyD3KxO1J-Au8wxibjnUoLk+3MjSB_OvY2r44cHBiropg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Sachin,

> Hi Lukasz,
> 
> On 19 April 2013 22:08, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> > Device tree support for TMU at Exynos4x12 targets.
> >
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> nit: Subject for these kind of patches should start with "ARM:
> dts: ..."
> 
Ok, I will correct that.

> Otherwise looks good to me.

Good :-)

> > ---
> >  arch/arm/boot/dts/exynos4x12.dtsi |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos4x12.dtsi
> > b/arch/arm/boot/dts/exynos4x12.dtsi index e3380a7..ee920b3 100644
> > --- a/arch/arm/boot/dts/exynos4x12.dtsi
> > +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> > @@ -79,4 +79,14 @@
> >                 interrupts = <0 89 0>;
> >                 status = "disabled";
> >         };
> > +
> > +       tmu@100C0000 {
> > +               compatible = "samsung,exynos4412-tmu";
> > +               interrupt-parent = <&combiner>;
> > +               reg = <0x100C0000 0x100>;
> > +               interrupts = <2 4>;
> > +               clocks = <&clock 383>;
> > +               clock-names = "tmu_apbif";
> > +               status = "disabled";
> > +       };
> >  };
> > --
> > 1.7.10.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-samsung-soc" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> 
> 
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Poland (SRPOL) | Linux Platform Group
