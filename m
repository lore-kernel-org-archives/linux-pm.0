From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/8] cpufreq: add generic cpufreq driver support for
 Exynos5250/5800 platforms
Date: Tue, 21 Apr 2015 17:34:16 +0200
Message-ID: <1679462.DpWxpX0JY5@amdc1032>
References: <1429622278-12216-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1429622278-12216-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 21, 2015 03:17:50 PM Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds generic arm_big_little_dt cpufreq driver
> support for Exynos5420/5800 (using the new CPU clock type which
> allows it).  It also:
> - enhances arm_big_little[_dt] driver with CPU cluster regulator
>   support
> - fixes CPU clock configuration data and CPU operating points
>   setup for Exynos5800
> - adds CPU cluster regulator supplies for ODROID-XU3 board
> 
> This patch series has been tested on Exynos5800 based ODROID-XU3
> board.
> 
> Depends on:
> - next-20150330 branch of linux-next kernel tree
> - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4210
>   platform" [1]
> - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
>   platform" [2]
> - "[PATCH] cpufreq: exynos: remove dead ->need_apll_change method" [3]
> - "[PATCH 0/4] cpufreq: use generic cpufreq drivers for Exynos5250
>   platform" [4]
> 
> [1] http://www.kernelhub.org/?msg=721136&p=2
> [2] http://marc.info/?l=linux-pm&m=142868881101873&w=2
> [3] https://lkml.org/lkml/2015/3/27/574
> [4] https://lkml.org/lkml/2015/4/13/611
> 
> Changes over Thomas' original v12 code:
> - split Exynos5420 and Exynos5800 support
> - moved E5420_[EGL,KFC]_DIV0() macros to clk-exynos5420.c
> - disabled cpufreq if big.LITTLE switcher support is enabled
> - enhanced arm_big_little[_dt] driver with CPU cluster regulator
>   support
> - fixed CPU clock configuration data for Exynos5800
> - fixed CPU operating points setup for Exynos5800
> - added CPU cluster regulator supplies for ODROID-XU3 board
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (4):
>   cpufreq: arm_big_little: add cluster regulator support
>   ARM: dts: add cluster regulator supply properties for
>     exynos5422-odroidxu3
>   clk: samsung: exynos5800: fix cpu clock configuration data
>   ARM: dts: Exynos5800: fix CPU OPP
> 
> Thomas Abraham (4):
>   clk: samsung: exynos5420: add cpu clock configuration data and
>     instantiate cpu clock
>   ARM: dts: Exynos5420: add CPU OPP and regulator supply property
>   ARM: Exynos: use generic cpufreq driver for Exynos5420
>   ARM: Exynos: use generic cpufreq driver for Exynos5800
> 
>  .../bindings/cpufreq/arm_big_little_dt.txt         |    4 +
>  arch/arm/boot/dts/exynos5420.dtsi                  |   38 +++++
>  arch/arm/boot/dts/exynos5422-odroidxu3.dts         |    8 +
>  arch/arm/boot/dts/exynos5800.dtsi                  |   39 +++++
>  arch/arm/mach-exynos/exynos.c                      |    8 +
>  drivers/clk/samsung/clk-exynos5420.c               |   88 ++++++++++-
>  drivers/cpufreq/arm_big_little.c                   |  153 +++++++++++++++++---
>  include/dt-bindings/clock/exynos5420.h             |    2 +
>  8 files changed, 320 insertions(+), 20 deletions(-)

If you are using exynos5420-arndale-octa.dts, exynos5420-peach-pit.dts,
exynos5420-smdk5420.dts or exynos5800-peach-pi.dts please use the attached
patch instead of patch #2/8.  Sorry for the inconvenience.

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 2/8] ARM: dts: Exynos5420/5800: add cluster regulator supply properties

Add cluster regulator supply properties as a preparation to
adding generic arm_big_little_dt cpufreq driver support for
Exynos5420 and Exynos5800 based boards.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |    8 ++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |    8 ++++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts     |    8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts    |    8 ++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |    8 ++++++++
 5 files changed, 40 insertions(+)

Index: b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
===================================================================
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts	2015-04-21 16:26:53.022509881 +0200
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts	2015-04-21 17:25:30.250396715 +0200
@@ -369,6 +369,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 };
Index: b/arch/arm/boot/dts/exynos5420-peach-pit.dts
===================================================================
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts	2015-04-21 16:26:53.022509881 +0200
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts	2015-04-21 17:26:32.034394727 +0200
@@ -676,6 +676,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &i2c_2 {
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
Index: b/arch/arm/boot/dts/exynos5420-smdk5420.dts
===================================================================
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts	2015-04-21 16:26:53.022509881 +0200
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts	2015-04-21 17:27:04.338393689 +0200
@@ -420,3 +420,11 @@
 		};
 	};
 };
+
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
Index: b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
===================================================================
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts	2015-04-21 17:23:44.334400124 +0200
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts	2015-04-21 17:24:05.454399445 +0200
@@ -355,6 +355,14 @@
 	dr_mode = "otg";
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &i2c_0 {
 	status = "okay";
 
Index: b/arch/arm/boot/dts/exynos5800-peach-pi.dts
===================================================================
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts	2015-04-21 16:26:53.030509881 +0200
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts	2015-04-21 17:27:47.674392295 +0200
@@ -638,6 +638,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &i2c_2 {
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
