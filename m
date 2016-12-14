From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ARM: dts: Add missing CPU frequencies for Exynos5422/5800
Date: Wed, 14 Dec 2016 14:28:06 +0100
Message-ID: <2340115.HEG9AYUCMD@amdc3058>
References: <5220084.l31t5oJbsy@amdc3058>
 <CGME20161213191823epcas5p346582b73ad9b401d9e773a1b076f1f61@epcas5p3.samsung.com>
 <26ffeee4-ff43-b3d3-3267-5fcbc50e2974@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <26ffeee4-ff43-b3d3-3267-5fcbc50e2974@osg.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, Arjun K V <arjun.kv@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Thomas Abraham <thomas.ab@samsung.com>, Ben Gamari <ben@smart-cactus.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On Tuesday, December 13, 2016 04:18:05 PM Javier Martinez Canillas wrote:
> Hello Bartlomiej,

Hi,

> On 12/13/2016 01:52 PM, Bartlomiej Zolnierkiewicz wrote:
> > Add missing 2000MHz & 1900MHz OPPs (for A15 cores) and 1400MHz OPP
> > (for A7 cores).  Also update common Odroid-XU3 Lite/XU3/XU4 thermal
> > cooling maps to account for new OPPs.
> > 
> > Since new OPPs are not available on all Exynos5422/5800 boards modify
> > dts files for Odroid-XU3 Lite (limited to 1.8 GHz / 1.3 GHz) & Peach
> > Pi (limited to 2.0 GHz / 1.3 GHz) accordingly.
> > 
> > Tested on Odroid-XU3 and XU3 Lite.
> > 
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> > Cc: Andreas Faerber <afaerber@suse.de>
> > Cc: Thomas Abraham <thomas.ab@samsung.com>
> > Cc: Ben Gamari <ben@smart-cactus.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   14 +++++++-------
> >  arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   17 +++++++++++++++++
> >  arch/arm/boot/dts/exynos5800-peach-pi.dts          |    4 ++++
> >  arch/arm/boot/dts/exynos5800.dtsi                  |   15 +++++++++++++++
> >  4 files changed, 43 insertions(+), 7 deletions(-)
> > 
> > Index: b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > ===================================================================
> > --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi	2016-12-13 15:59:33.779763261 +0100
> > +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi	2016-12-13 15:59:33.775763261 +0100
> > @@ -118,7 +118,7 @@
> >  				/*
> >  				 * When reaching cpu_alert3, reduce CPU
> >  				 * by 2 steps. On Exynos5422/5800 that would
> > -				 * be: 1600 MHz and 1100 MHz.
> > +				 * (usually) be: 1800 MHz and 1200 MHz.
> >  				 */
> >  				map3 {
> >  					trip = <&cpu_alert3>;
> > @@ -131,16 +131,16 @@
> >  
> >  				/*
> >  				 * When reaching cpu_alert4, reduce CPU
> > -				 * further, down to 600 MHz (11 steps for big,
> > -				 * 7 steps for LITTLE).
> > +				 * further, down to 600 MHz (13 steps for big,
> > +				 * 8 steps for LITTLE).
> >  				 */
> > -				map5 {
> > +				cooling_map5: map5 {
> >  					trip = <&cpu_alert4>;
> > -					cooling-device = <&cpu0 3 7>;
> > +					cooling-device = <&cpu0 3 8>;
> >  				};
> > -				map6 {
> > +				cooling_map6: map6 {
> >  					trip = <&cpu_alert4>;
> > -					cooling-device = <&cpu4 3 11>;
> > +					cooling-device = <&cpu4 3 13>;
> >  				};
> >  			};
> >  		};
> > Index: b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
> > ===================================================================
> > --- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts	2016-12-13 15:59:33.779763261 +0100
> > +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts	2016-12-13 15:59:33.775763261 +0100
> > @@ -21,6 +21,23 @@
> >  	compatible = "hardkernel,odroid-xu3-lite", "samsung,exynos5800", "samsung,exynos5";
> >  };
> >  
> > +&cluster_a15_opp_table {
> > +	/delete-node/opp@2000000000;
> > +	/delete-node/opp@1900000000;
> > +};
> > +
> > +&cluster_a7_opp_table {
> > +	/delete-node/opp@1400000000;
> > +};
> > +
> 
> I think that a comment in the DTS why these operating points aren't available
> in this board will make more clear why the nodes are being deleted.

Ok, I will add these comments in the next patch revision.

> > +&cooling_map5 {
> > +	cooling-device = <&cpu0 3 7>;
> > +};
> > +
> > +&cooling_map6 {
> > +	cooling-device = <&cpu4 3 11>;
> > +};
> > +
> >  &pwm {
> >  	/*
> >  	 * PWM 0 -- fan
> > Index: b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> > ===================================================================
> > --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts	2016-12-13 15:59:33.779763261 +0100
> > +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts	2016-12-13 15:59:33.779763261 +0100
> > @@ -146,6 +146,10 @@
> >  	vdd-supply = <&ldo9_reg>;
> >  };
> >  
> > +&cluster_a7_opp_table {
> > +	/delete-property/opp@1400000000;
> > +};
> > +
> >  &cpu0 {
> >  	cpu-supply = <&buck2_reg>;
> >  };
> > Index: b/arch/arm/boot/dts/exynos5800.dtsi
> > ===================================================================
> > --- a/arch/arm/boot/dts/exynos5800.dtsi	2016-12-13 15:59:33.779763261 +0100
> > +++ b/arch/arm/boot/dts/exynos5800.dtsi	2016-12-13 15:59:33.779763261 +0100
> > @@ -24,6 +24,16 @@
> >  };
> >  
> >  &cluster_a15_opp_table {
> > +	opp@2000000000 {
> > +		opp-hz = /bits/ 64 <2000000000>;
> > +		opp-microvolt = <1250000>;
> > +		clock-latency-ns = <140000>;
> > +	};
> > +	opp@1900000000 {
> > +		opp-hz = /bits/ 64 <1900000000>;
> > +		opp-microvolt = <1250000>;
> > +		clock-latency-ns = <140000>;
> > +	};
> >  	opp@1700000000 {
> >  		opp-microvolt = <1250000>;
> >  	};
> > @@ -85,6 +95,11 @@
> >  };
> >
> 
> AFAIK Thomas restricted the maximum OPP, because for A15 freqs > 1.8GHz the
> INT rail would need to be scaled up as well since there's a maximum voltage
> difference between the ARM and INT rails before the system becomes unstable:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/276766.html
> https://lkml.org/lkml/2014/5/2/419
> 
> The ChromiumOS vendor tree uses a virtual regulator driver that makes sure
> the maximum voltage skew is between a limit. But that never made to mainline:
> 
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/arch/arm/boot/dts/exynos5420-peach-pit.dtsi#90
> https://lkml.org/lkml/2014/4/29/28
> 
> Did that change and there's infrastructure in mainline now to cope with that?
> If that's the case, I think it would be good to mention in the commit message.

I was not aware of this limitation and AFAIK mainline has currently
no code to handle it.  I also cannot find any code to handle this in
Hardkernel's vendor kernel for Odroid-XU3 board.

Do you know whether this problem exists also on Exynos5422/5800
SoCs or only on Exynos5420 one?  I see that ChromiumOS uses virtual
regulator code also on Exynos5800 SoC based Peach Pi board but was
the problem actually present on this board?

[ I added Arjun to Cc:, maybe he can help in explaining this issue
  (unfortunately Inderpal's email is no longer working). ]

Please also note that on Exynos5422/5800 SoCs the same ARM rail
voltage is used for 1.9 GHz & 2.0 GHz OPPs as for the 1.8 GHz one.
IOW if the problem exists it is already present in the mainline
kernel.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
