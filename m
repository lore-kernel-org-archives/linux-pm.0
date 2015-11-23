From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 5/5] ARM: dts: exynos4412: Rename OPP nodes as opp@<opp-hz>
Date: Tue, 24 Nov 2015 00:10:05 +0100
Message-ID: <1527236.7CQ8yZPfHx@vostro.rjw.lan>
References: <cover.1447209519.git.viresh.kumar@linaro.org> <af18ab62fc9c52e082380ce5989ea287304c9bde.1447209519.git.viresh.kumar@linaro.org> <2407684.GgMbGa6LFq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61095 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753268AbbKWWk1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 17:40:27 -0500
In-Reply-To: <2407684.GgMbGa6LFq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On Tuesday, November 24, 2015 12:04:00 AM Rafael J. Wysocki wrote:
> On Wednesday, November 11, 2015 08:10:58 AM Viresh Kumar wrote:
> > OPP bindings got updated to name OPP nodes this way, make changes
> > according to that.
> > 
> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm/boot/dts/exynos4412.dtsi | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> > index 294cfe40388d..40beede46e55 100644
> > --- a/arch/arm/boot/dts/exynos4412.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412.dtsi
> > @@ -64,73 +64,73 @@
> >  		compatible = "operating-points-v2";
> >  		opp-shared;
> >  
> > -		opp00 {
> > +		opp@200000000 {
> >  			opp-hz = /bits/ 64 <200000000>;
> >  			opp-microvolt = <900000>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp01 {
> > +		opp@300000000 {
> >  			opp-hz = /bits/ 64 <300000000>;
> >  			opp-microvolt = <900000>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp02 {
> > +		opp@400000000 {
> >  			opp-hz = /bits/ 64 <400000000>;
> >  			opp-microvolt = <925000>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp03 {
> > +		opp@500000000 {
> >  			opp-hz = /bits/ 64 <500000000>;
> >  			opp-microvolt = <950000>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp04 {
> > +		opp@600000000 {
> >  			opp-hz = /bits/ 64 <600000000>;
> >  			opp-microvolt = <975000>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp05 {
> > +		opp@700000000 {
> >  			opp-hz = /bits/ 64 <700000000>;
> >  			opp-microvolt = <987500>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp06 {
> > +		opp@800000000 {
> >  			opp-hz = /bits/ 64 <800000000>;
> >  			opp-microvolt = <1000000>;
> >  			clock-latency-ns = <200000>;
> >  			opp-suspend;
> >  		};
> > -		opp07 {
> > +		opp@900000000 {
> >  			opp-hz = /bits/ 64 <900000000>;
> >  			opp-microvolt = <1037500>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp08 {
> > +		opp@1000000000 {
> >  			opp-hz = /bits/ 64 <1000000000>;
> >  			opp-microvolt = <1087500>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp09 {
> > +		opp@1100000000 {
> >  			opp-hz = /bits/ 64 <1100000000>;
> >  			opp-microvolt = <1137500>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp10 {
> > +		opp@1200000000 {
> >  			opp-hz = /bits/ 64 <1200000000>;
> >  			opp-microvolt = <1187500>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp11 {
> > +		opp@1300000000 {
> >  			opp-hz = /bits/ 64 <1300000000>;
> >  			opp-microvolt = <1250000>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp12 {
> > +		opp@1400000000 {
> >  			opp-hz = /bits/ 64 <1400000000>;
> >  			opp-microvolt = <1287500>;
> >  			clock-latency-ns = <200000>;
> >  		};
> > -		opp13 {
> > +		opp@1500000000 {
> >  			opp-hz = /bits/ 64 <1500000000>;
> >  			opp-microvolt = <1350000>;
> >  			clock-latency-ns = <200000>;
> > 
> 
> This one doesn't apply for me on top of the current Linus' tree, so please
> update.

Scratch that, my bad.  Sorry.

Thanks,
Rafael

