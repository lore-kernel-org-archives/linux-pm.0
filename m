From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 08/12] clk: qcom: Add KPSS ACC/GCC driver
Date: Tue, 12 Dec 2017 14:38:13 -0600
Message-ID: <20171212203813.f3fkjw4uvxm43yok@rob-hp-laptop>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-9-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1512726150-7204-9-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 08, 2017 at 03:12:26PM +0530, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> The ACC and GCC regions present in KPSSv1 contain registers to
> control clocks and power to each Krait CPU and L2. For CPUfreq
> purposes probe these devices and expose a mux clock that chooses
> between PXO and PLL8.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |  7 ++
>  .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  | 28 +++++++

Please make bindings a separate patch.

>  drivers/clk/qcom/Kconfig                           |  8 ++
>  drivers/clk/qcom/Makefile                          |  1 +
>  drivers/clk/qcom/kpss-xcc.c                        | 96 ++++++++++++++++++++++
>  5 files changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 drivers/clk/qcom/kpss-xcc.c
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> index 1333db9..382a574 100644
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> @@ -21,10 +21,17 @@ PROPERTIES
>  		    the register region. An optional second element specifies
>  		    the base address and size of the alias register region.
>  
> +- clock-output-names:
> +	Usage: optional
> +	Value type: <string>
> +	Definition: Name of the output clock. Typically acpuX_aux where X is a
> +		    CPU number starting at 0.
> +
>  Example:
>  
>  	clock-controller@2088000 {
>  		compatible = "qcom,kpss-acc-v2";
>  		reg = <0x02088000 0x1000>,
>  		      <0x02008000 0x1000>;
> +		clock-output-names = "acpu0_aux";
>  	};
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> new file mode 100644
> index 0000000..d1e12f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> @@ -0,0 +1,28 @@
> +Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
> +
> +PROPERTIES
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: should be one of:
> +			"qcom,kpss-gcc"

Only one implementation?

> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: base address and size of the register region
> +
> +- clock-output-names:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Name of the output clock. Typically acpu_l2_aux indicating
> +		    an L2 cache auxiliary clock.
> +
> +Example:
> +
> +	l2cc: clock-controller@2011000 {
> +		compatible = "qcom,kpss-gcc";
> +		reg = <0x2011000 0x1000>;
> +		clock-output-names = "acpu_l2_aux";
> +	};
