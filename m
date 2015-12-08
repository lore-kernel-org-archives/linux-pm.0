From: Markus Reichl <m.reichl@fivetechno.de>
Subject: Re: [PATCH v4 1/8] ARM: dts: Exynos542x/5800: add cluster regulator
 supply properties
Date: Tue, 8 Dec 2015 11:16:58 +0100
Message-ID: <5666AE1A.7070506@fivetechno.de>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
 <1449512300-17230-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449512300-17230-2-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Doug Anderson <dianders@chromium.org>, Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Javier Martinez Canillas <javier@osg.samsung.com>, Anand Moon <linux.amoon@gmail.com>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-arm-kernel@lists.infradead.org, Andreas Faerber <afaerber@suse.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

tested the patch successfully on Odroid-XU4.

Thanks
--
Markus

Am 07.12.2015 um 19:18 schrieb Bartlomiej Zolnierkiewicz:
> Add cluster regulator supply properties as a preparation to
> adding generic cpufreq-dt driver support for Exynos542x and
> Exynos5800 based boards.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts   | 8 ++++++++
>  arch/arm/boot/dts/exynos5420-peach-pit.dts      | 8 ++++++++
>  arch/arm/boot/dts/exynos5420-smdk5420.dts       | 8 ++++++++
>  arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts | 8 ++++++++
>  arch/arm/boot/dts/exynos5422-odroidxu3.dts      | 8 ++++++++
>  arch/arm/boot/dts/exynos5422-odroidxu4.dts      | 8 ++++++++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts       | 8 ++++++++
>  7 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> index 4ecef69..4229641 100644
> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> @@ -52,6 +52,14 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&cpu4 {
> +	cpu-supply = <&buck6_reg>;
> +};
> +
>  &usbdrd_dwc3_1 {
>  	dr_mode = "host";
>  };
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 35cfb07..30f146b 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -676,6 +676,14 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&cpu4 {
> +	cpu-supply = <&buck6_reg>;
> +};
> +
>  &i2c_2 {
>  	status = "okay";
>  	samsung,i2c-sda-delay = <100>;
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> index ac35aef..fdfe4e6 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -423,3 +423,11 @@
>  &usbdrd_phy1 {
>  	vbus-supply = <&usb301_vbus_reg>;
>  };
> +
> +&cpu0 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&cpu4 {
> +	cpu-supply = <&buck6_reg>;
> +};
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
> index 2ae1cf4..0bfd981 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
> @@ -54,6 +54,14 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&buck6_reg>;
> +};
> +
> +&cpu4 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
>  &pwm {
>  	/*
>  	 * PWM 0 -- fan
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> index 432406d..b19561c 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> @@ -53,6 +53,14 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&buck6_reg>;
> +};
> +
> +&cpu4 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
>  &i2c_0 {
>  	status = "okay";
>  
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
> index 2faf886..bdc7106 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
> @@ -32,6 +32,14 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&buck6_reg>;
> +};
> +
> +&cpu4 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
>  &pwm {
>  	/*
>  	 * PWM 0 -- fan
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 7b018e4..03ff1ceb 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -638,6 +638,14 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&cpu4 {
> +	cpu-supply = <&buck6_reg>;
> +};
> +
>  &i2c_2 {
>  	status = "okay";
>  	samsung,i2c-sda-delay = <100>;
> 


-- 
Markus Reichl
