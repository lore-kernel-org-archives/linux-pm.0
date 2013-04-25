From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: thermal: exynos4: Add documentation
 for Exynos SoC thermal bindings
Date: Thu, 25 Apr 2013 11:46:56 -0400
Message-ID: <51794FF0.2050406@ti.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com> <1366893045-31586-1-git-send-email-l.majewski@samsung.com> <1366893045-31586-4-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1366893045-31586-4-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, t.figa@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

On 25-04-2013 08:30, Lukasz Majewski wrote:
> Proper description for Exynos4 bindings added to Documentation/devicetree/
> bindings
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

I am fine with this one too.

Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
> Changes for v2:
> - Documentation extension according to ML feedback
> ---
>   .../devicetree/bindings/thermal/exynos-thermal.txt |   25 ++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> new file mode 100644
> index 0000000..535fd0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> @@ -0,0 +1,25 @@
> +* Exynos Thermal Management Unit (TMU)
> +
> +** Required properties:
> +
> +- compatible : One of the following:
> +	       "samsung,exynos4412-tmu"
> +	       "samsung,exynos4210-tmu"
> +	       "samsung,exynos5250-tmu"
> +- interrupt-parent : The phandle for the interrupt controller
> +- reg : Address range of the thermal registers
> +- interrupts : Should contain interrupt for thermal system
> +- clocks : The main clock for TMU device
> +- clock-names : Thermal system clock name
> +
> +Example:
> +
> +	tmu@100C0000 {
> +		compatible = "samsung,exynos4412-tmu";
> +		interrupt-parent = <&combiner>;
> +		reg = <0x100C0000 0x100>;
> +		interrupts = <2 4>;
> +		clocks = <&clock 383>;
> +		clock-names = "tmu_apbif";
> +		status = "disabled";
> +	};
>
