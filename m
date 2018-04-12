From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: Introduce interconnect provider
 bindings
Date: Thu, 12 Apr 2018 15:15:01 +0200
Message-ID: <7723f351-2460-7378-411a-cfcdf4138d8f@baylibre.com>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-3-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309210958.16672-3-georgi.djakov@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, skannan@codeaurora.org, seansw@qti.qualcomm.com, khilman@baylibre.com, mturquette@baylibre.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, bjorn.andersson@linaro.org, robh+dt@kernel.org, linux-arm-msm@vger.kernel.org, davidai@quicinc.com, vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 09/03/2018 22:09, Georgi Djakov wrote:
> This binding is intended to represent the interconnect hardware present
> in some of the modern SoCs. Currently it consists only of a binding for
> the interconnect hardware devices (provider).
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt         | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..70612bb201e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -0,0 +1,47 @@
> +Interconnect Provider Device Tree Bindings
> +=========================================
> +
> +The purpose of this document is to define a common set of generic interconnect
> +providers/consumers properties.
> +
> +
> += interconnect providers =
> +
> +The interconnect provider binding is intended to represent the interconnect
> +controllers in the system. Each provider registers a set of interconnect
> +nodes, which expose the interconnect related capabilities of the interconnect
> +to consumer drivers. These capabilities can be throughput, latency, priority
> +etc. The consumer drivers set constraints on interconnect path (or endpoints)
> +depending on the usecase. Interconnect providers can also be interconnect
> +consumers, such as in the case where two network-on-chip fabrics interface
> +directly

Hi,

Can't we specify the number of cells for the phandle ? It should be aligned with other consumer/provider bindings.

Neil

> +
> +Required properties:
> +- compatible : contains the interconnect provider vendor specific compatible
> +	       string
> +- reg : register space of the interconnect controller hardware
> +
> +Examples:
> +
> +		snoc: snoc@580000 {
> +			compatible = "qcom,msm8916-snoc";
> +			reg = <0x580000 0x14000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +			status = "okay";
> +		};
> +		bimc: bimc@400000 {
> +			compatible = "qcom,msm8916-bimc";
> +			reg = <0x400000 0x62000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>, <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +			status = "okay";
> +		};
> +		pnoc: pnoc@500000 {
> +			compatible = "qcom,msm8916-pnoc";
> +			reg = <0x500000 0x11000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>, <&rpmcc RPM_SMD_PCNOC_A_CLK>;
> +			status = "okay";
> +		};
> +
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
