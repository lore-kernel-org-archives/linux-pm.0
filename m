From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: Add missing CPU frequencies for
 Exynos5422/5800
Date: Thu, 29 Dec 2016 16:17:07 +0200
Message-ID: <20161229141707.qjrtjz7dik6a7l5s@kozik-lap>
References: <10512254.nyUcL0zgTP@amdc3058>
 <CAD=FV=Wo273T20fe8D2v5Pn1HYR==7PHtr7WZGwzFPRspAYPzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36123 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752668AbcL2ORQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2016 09:17:16 -0500
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wo273T20fe8D2v5Pn1HYR==7PHtr7WZGwzFPRspAYPzg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Andreas Faerber <afaerber@suse.de>, Thomas Abraham <thomas.ab@samsung.com>, Ben Gamari <ben@smart-cactus.org>, Arjun K V <arjun.kv@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Dec 15, 2016 at 04:54:30PM -0800, Doug Anderson wrote:
> > Index: b/arch/arm/boot/dts/exynos5800.dtsi
> > ===================================================================
> > --- a/arch/arm/boot/dts/exynos5800.dtsi 2016-12-15 12:43:54.365955950 +0100
> > +++ b/arch/arm/boot/dts/exynos5800.dtsi 2016-12-15 12:43:54.361955949 +0100
> > @@ -24,6 +24,16 @@
> >  };
> >
> >  &cluster_a15_opp_table {
> > +       opp@2000000000 {
> > +               opp-hz = /bits/ 64 <2000000000>;
> > +               opp-microvolt = <1250000>;
> > +               clock-latency-ns = <140000>;
> > +       };
> > +       opp@1900000000 {
> > +               opp-hz = /bits/ 64 <1900000000>;
> > +               opp-microvolt = <1250000>;
> > +               clock-latency-ns = <140000>;
> > +       };
> 
> I don't think the voltages you listed are high enough for all peach pi
> boards for A15 at 1.9 GHz and 2.0 GHz, at least based on the research
> I did.  See my response to v1.

I wanted to apply this but saw this remaining issue. Javier tested it
on Peach Pi so is this concern still valid?

Bartlomiej,
When sending dts patches please stick to the common subsystem prefix
(git log --oneline arch/arm/boot/dts/exynos*).

Best regards,
Krzysztof
