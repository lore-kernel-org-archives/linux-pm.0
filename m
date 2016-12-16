From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] ARM: dts: Add missing CPU frequencies for
 Exynos5422/5800
Date: Thu, 15 Dec 2016 16:54:30 -0800
Message-ID: <CAD=FV=Wo273T20fe8D2v5Pn1HYR==7PHtr7WZGwzFPRspAYPzg@mail.gmail.com>
References: <10512254.nyUcL0zgTP@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <10512254.nyUcL0zgTP@amdc3058>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thomas Abraham <thomas.ab@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ben Gamari <ben@smart-cactus.org>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Arjun K V <arjun.kv@samsung.com>, Andreas Faerber <afaerber@suse.de>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Dec 15, 2016 at 3:55 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Add missing 2000MHz & 1900MHz OPPs (for A15 cores) and 1400MHz OPP
> (for A7 cores).  Also update common Odroid-XU3 Lite/XU3/XU4 thermal
> cooling maps to account for new OPPs.
>
> Since new OPPs are not available on all Exynos5422/5800 boards modify
> dts files for Odroid-XU3 Lite (limited to 1.8 GHz / 1.3 GHz) & Peach
> Pi (limited to 2.0 GHz / 1.3 GHz) accordingly.
>
> Tested on Odroid-XU3 and XU3 Lite.
>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Ben Gamari <ben@smart-cactus.org>
> Cc: Arjun K V <arjun.kv@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2:
> - added comments about limitations of SoC revisions used by Odroid-XU3 Lite and
>   Peach Pi boards (suggested by Javier)
> - removed redundant opp_a7_14 label
> - added Arjun to Cc:
>
> Javier, could you test it on Peach Pi board?
>
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   14 ++++++-------
>  arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   22 +++++++++++++++++++++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |    9 ++++++++
>  arch/arm/boot/dts/exynos5800.dtsi                  |   15 ++++++++++++++
>  4 files changed, 53 insertions(+), 7 deletions(-)
>
> Index: b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> ===================================================================
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi        2016-12-15 12:43:54.365955950 +0100
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi        2016-12-15 12:43:54.361955949 +0100
> @@ -118,7 +118,7 @@
>                                 /*
>                                  * When reaching cpu_alert3, reduce CPU
>                                  * by 2 steps. On Exynos5422/5800 that would
> -                                * be: 1600 MHz and 1100 MHz.
> +                                * (usually) be: 1800 MHz and 1200 MHz.
>                                  */
>                                 map3 {
>                                         trip = <&cpu_alert3>;
> @@ -131,16 +131,16 @@
>
>                                 /*
>                                  * When reaching cpu_alert4, reduce CPU
> -                                * further, down to 600 MHz (11 steps for big,
> -                                * 7 steps for LITTLE).
> +                                * further, down to 600 MHz (13 steps for big,
> +                                * 8 steps for LITTLE).
>                                  */
> -                               map5 {
> +                               cooling_map5: map5 {
>                                         trip = <&cpu_alert4>;
> -                                       cooling-device = <&cpu0 3 7>;
> +                                       cooling-device = <&cpu0 3 8>;
>                                 };
> -                               map6 {
> +                               cooling_map6: map6 {
>                                         trip = <&cpu_alert4>;
> -                                       cooling-device = <&cpu4 3 11>;
> +                                       cooling-device = <&cpu4 3 13>;
>                                 };
>                         };
>                 };
> Index: b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
> ===================================================================
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts   2016-12-15 12:43:54.365955950 +0100
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts   2016-12-15 12:43:54.361955949 +0100
> @@ -21,6 +21,28 @@
>         compatible = "hardkernel,odroid-xu3-lite", "samsung,exynos5800", "samsung,exynos5";
>  };
>
> +/*
> + * Odroid XU3-Lite board uses SoC revision with lower maximum frequencies
> + * than Odroid XU3/XU4 boards: 1.8 GHz for A15 cores & 1.3 GHz for A7 cores.
> + * Therefore we need to update OPPs tables and thermal maps accordingly.
> + */
> +&cluster_a15_opp_table {
> +       /delete-node/opp@2000000000;
> +       /delete-node/opp@1900000000;
> +};
> +
> +&cluster_a7_opp_table {
> +       /delete-node/opp@1400000000;
> +};
> +
> +&cooling_map5 {
> +       cooling-device = <&cpu0 3 7>;
> +};
> +
> +&cooling_map6 {
> +       cooling-device = <&cpu4 3 11>;
> +};
> +
>  &pwm {
>         /*
>          * PWM 0 -- fan
> Index: b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> ===================================================================
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts 2016-12-15 12:43:54.365955950 +0100
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts 2016-12-15 12:43:54.361955949 +0100
> @@ -146,6 +146,15 @@
>         vdd-supply = <&ldo9_reg>;
>  };
>
> +/*
> + * Peach Pi board uses SoC revision with lower maximum frequency for A7 cores
> + * (1.3 GHz instead of 1.4 GHz) than Odroid XU3/XU4 boards.  Thus we need to
> + * update A7 OPPs table accordingly.
> + */
> +&cluster_a7_opp_table {
> +       /delete-property/opp@1400000000;
> +};
> +
>  &cpu0 {
>         cpu-supply = <&buck2_reg>;
>  };
> Index: b/arch/arm/boot/dts/exynos5800.dtsi
> ===================================================================
> --- a/arch/arm/boot/dts/exynos5800.dtsi 2016-12-15 12:43:54.365955950 +0100
> +++ b/arch/arm/boot/dts/exynos5800.dtsi 2016-12-15 12:43:54.361955949 +0100
> @@ -24,6 +24,16 @@
>  };
>
>  &cluster_a15_opp_table {
> +       opp@2000000000 {
> +               opp-hz = /bits/ 64 <2000000000>;
> +               opp-microvolt = <1250000>;
> +               clock-latency-ns = <140000>;
> +       };
> +       opp@1900000000 {
> +               opp-hz = /bits/ 64 <1900000000>;
> +               opp-microvolt = <1250000>;
> +               clock-latency-ns = <140000>;
> +       };

I don't think the voltages you listed are high enough for all peach pi
boards for A15 at 1.9 GHz and 2.0 GHz, at least based on the research
I did.  See my response to v1.
