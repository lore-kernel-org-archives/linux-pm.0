From: Inderpal Singh <inderpal.singh@linaro.org>
Subject: Re: [PATCH 3/3] dts: Add cpufreq controller node for Exynos5440 SoC
Date: Thu, 7 Feb 2013 10:19:16 +0530
Message-ID: <CAG17yqTSxjoTDcGg+6rt+gnDyJBO7j3MBP_g5B=vYZqa1qaD+g@mail.gmail.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
	<1360179562-19950-3-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1360179562-19950-3-git-send-email-amit.daniel@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 7 February 2013 01:09, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
> Add cpufreq controller device node for Exynos5440 SoC for passing
> parameters like controller base address, interrupt and cpufreq
> table.
>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5440.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> index 024269d..b20b517 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -63,6 +63,15 @@
>
>         };
>
> +       cpufreq@160000 {
> +               compatible = "samsung,exynos5440-cpufreq";
> +               reg = <0x160000 0x1000>;
> +               interrupts = <0 57 0>;
> +               cpufreq_tbl = < 1200000 1025000
> +                               1000000 975000
> +                               800000  925000 >;
> +       };
> +

I think cpufreq_tbl should be part of the cpu node as it's the
property of the cpu.
Please refer cpufreq-cpu0 and spear-cpufreq.

>         serial@B0000 {
>                 compatible = "samsung,exynos4210-uart";
>                 reg = <0xB0000 0x1000>;
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
